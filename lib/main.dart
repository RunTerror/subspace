import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:subspace/data/database_helper.dart';
import 'package:subspace/logic/cubit/blog_cubit/blog_cubit.dart';
import 'package:subspace/logic/cubit/internet_cubit.dart/internet_cubit.dart';
import 'package:subspace/logic/cubit/offlineblogcubit/offline_blog_cubit.dart';
import 'package:subspace/presentattion/landing_screen.dart';
import 'package:subspace/view_model.dart/like_mapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>BlogCubit()),
          BlocProvider(create: (context)=> InternetCubit()),
          BlocProvider(create: (context)=> OfflineBlogCubit()),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context)=> LikeMapper())
          ],
          child: GetMaterialApp(
            home: LandingScreen(
              key: key,
            ),
          ),
        ));
  }
}
