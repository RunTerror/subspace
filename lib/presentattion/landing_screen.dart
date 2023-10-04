import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:subspace/data/database_helper.dart';
import 'package:subspace/logic/cubit/blog_cubit/blog_state.dart';
import 'package:subspace/logic/cubit/internet_cubit.dart/internet_cubit.dart';
import 'package:subspace/presentattion/favorite_screen.dart';
import 'package:subspace/presentattion/offline_blog.dart';
import 'package:subspace/presentattion/online_blog.dart';
import 'package:subspace/utils/utils.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final DatabaseHelper _db = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: BlocConsumer<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state == InternetState.disconnected) {
            return const OfflineBlogs();
          } else if (state == InternetState.connected) {
            return const OnlineBlog();
          } else {
            return const Center(
              child: Text('loading...'),
            );
          }
        },
        listener: (context, state) {
          if (state == InternetState.connected) {
            Utils().showsnackbar(Colors.green, 'Internet Connected!');
          } else {
            Utils().showsnackbar(Colors.red, 'No Internet Connection!');
          }
        },
      ),
    );
  }
}
