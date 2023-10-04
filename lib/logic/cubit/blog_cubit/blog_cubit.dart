import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subspace/data/database_helper.dart';
import 'package:subspace/data/models/blog_model.dart';
import 'package:subspace/data/repositries/blog_repositry.dart';
import 'package:subspace/logic/cubit/blog_cubit/blog_state.dart';
import 'package:subspace/view_model.dart/like_mapper.dart';

class BlogCubit extends Cubit<BlogState> {
  final c=Get.context!;
  BlogCubit() : super(BlogLoadingState()){
    loadBlogs(c);
  }
  final BlogRepositry _repository=BlogRepositry();
  List<BlogModel> onlineblogs=[];


  Future<bool> isofflineavailable()async{
    final sp=await SharedPreferences.getInstance();
    final value=sp.getBool('apicalled')?? false;
    return value;
  }

  final _db=DatabaseHelper.instance;

  void tooglelike(String blogid, int index, int isfav){
    _db.toggleFavoriteStatus(blogid);
    isfav==0? onlineblogs[index].isfavorite=1: onlineblogs[index].isfavorite=0;
    emit(BlogLoadedState(onlineblogs));
  }


  void loadBlogs(BuildContext context) async {
    final mapper=Provider.of<LikeMapper>(context);
    try {
      final blogs = await _repository.fetchpost();
      for(var blog in blogs){
        onlineblogs.add(blog);
      }
      var ans=await isofflineavailable();
      print(ans);
      if(ans==false){
        emit(BlogLoadedState(onlineblogs));
        return;
      }

     var dblogs=await _db.getAllBlogs();
     var sqblogs= dblogs.map((e) => BlogModel.fromJson(e)).toList();
      for(int i=0; i<blogs.length; i++){
        if(sqblogs[i].isfavorite==1){
            mapper.addlike(i);
        }
        onlineblogs[i].isfavorite=sqblogs[i].isfavorite;
      }
      emit(BlogLoadedState(onlineblogs));
    } catch (e) {
      emit(BlogErrorState(e.toString()));
    }
  }
}


