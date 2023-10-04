import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _database;
  String dbName = 'blog_database.db';

  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbpath = await getDatabasesPath();
    final String path = join(dbpath, dbName);
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE blogs (
        id TEXT PRIMARY KEY,
        title TEXT,
        image_url TEXT,
        isfavorite INTEGER
      )
    ''');
  }

  Future<int> insertBlog(Map<String, dynamic> blog) async {
    final db = await database;
    return await db.insert('blogs', blog);
  }

  Future<List<Map<String, dynamic>>> getAllBlogs() async {
    final db = await database;
    final blogs=await db.query('blogs');
    for(var blog in blogs){
      print(blog);
    }
    return await db.query('blogs');
  }

  Future<void> toggleFavoriteStatus(String id) async {
    final db = await database;
    var blog = await db.query('blogs', where: 'id = ?', whereArgs: [id]);
    print(blog[0]['isfavorite']);
    if (blog.isNotEmpty) {
      var currentIsFavorite = blog[0]['isfavorite'];
      if (currentIsFavorite is int || currentIsFavorite == null) {
        int newIsFavorite = (currentIsFavorite == 1) ? 0 : 1;
        await db.update(
          'blogs',
          {'isfavorite': newIsFavorite},
          where: 'id = ?',
          whereArgs: [id],
        );
        blog = await db.query('blogs', where: 'id = ?', whereArgs: [id]);
        print(blog[0]['isfavorite']);
      } else {
        print('Error: Invalid isfavorite value');
      }
    } else {
      print('Error: Blog not found with ID $id');
    }
  }

  Future<void> deletedatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    try {
      if (await File(path).exists()) {
        await deleteDatabase(path);
      }
    } catch (e) {
      print('Error deleting database: $e');
    }
  }
}
