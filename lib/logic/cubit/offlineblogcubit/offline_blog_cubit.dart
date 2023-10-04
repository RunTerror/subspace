import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:subspace/data/database_helper.dart';
import 'package:subspace/data/models/blog_model.dart';

class OfflineBlogCubit extends Cubit<List<BlogModel>> {
  OfflineBlogCubit() : super([]) {
    fetchsqblogs();
  }

  final _db = DatabaseHelper.instance;

  fetchsqblogs() async {
    try {
      final getblogs = await _db.getAllBlogs();
     
      final blogs = getblogs
          .map(
            (blog) => BlogModel.fromJson(blog),
          )
          .toList();
      for(int i=0; i<blogs.length; i++){
        if(blogs[i].isfavorite==1){
        }
      }
      emit(blogs);
    } on DatabaseException catch (e) {
      emit([]);
    }
  }

  Future<void> toggleLike(String blogId) async {
    await _db.toggleFavoriteStatus(blogId);
    fetchsqblogs();
  }
}
