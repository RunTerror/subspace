import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:subspace/data/models/blog_model.dart';
import 'package:subspace/logic/cubit/blog_cubit/blog_cubit.dart';
import 'package:subspace/logic/cubit/blog_cubit/blog_state.dart';
import 'package:subspace/utils/utils.dart';
import 'package:subspace/view_model.dart/like_mapper.dart';

class OnlineBlog extends StatefulWidget {
  const OnlineBlog({super.key});

  @override
  State<OnlineBlog> createState() => _OnlineBlogState();
}

class _OnlineBlogState extends State<OnlineBlog> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogCubit, BlogState>(
        listener: (context, state) {
          if (state is BlogErrorState) {
            Utils().showsnackbar(Colors.red, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (state is BlogLoadedState) {
            
            return Center(
              child: Container(
                alignment: Alignment.center,
                width: Get.width/1.1,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  
                    return Container(
                      margin:const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.grey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width/1.1,
                                child: Card(
                                  child: CachedNetworkImage(
                                    progressIndicatorBuilder: (context, url, progress) {
                                      return  SizedBox(height: 150,width: Get.width/1.1,);
                                    },
                                    fit: BoxFit.cover,
                                      imageUrl: blog.imageurl!),
                                ),
                              ),
                              const SizedBox(height: 2,),
                              Row(children: [
                                const SizedBox(width: 10,),
                                Expanded(child: Text(blog.title!,overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 15),))
                              ],),
                              const SizedBox(height: 2,),
                              IconButton(onPressed: (){
                                // blog.isfavorite==0? likemapper.addlike(index): likemapper.removeLike(index);
                                context.read<BlogCubit>().tooglelike(blog.id!, index, blog.isfavorite);
                              }, icon: Icon(blog.isfavorite==0?Icons.favorite_outline: Icons.favorite),)
                            ],
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return const Center(child: Text('An error occured'));
        },
      );
  }
}