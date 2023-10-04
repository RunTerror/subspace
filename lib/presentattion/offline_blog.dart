import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:subspace/data/models/blog_model.dart';
import 'package:subspace/logic/cubit/offlineblogcubit/offline_blog_cubit.dart';
import 'package:subspace/presentattion/blog_detail.dart';

class OfflineBlogs extends StatefulWidget {
  const OfflineBlogs({super.key});

  @override
  State<OfflineBlogs> createState() => _OfflineBlogsState();
}

class _OfflineBlogsState extends State<OfflineBlogs> {

  void reloadData() {
    context.read<OfflineBlogCubit>().fetchsqblogs();
  }


  
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<OfflineBlogCubit, List<BlogModel>>(
          builder: (context, blogs) {
            if(blogs.isEmpty){
              return const Center(child: Text('Check Internet Connection!'),);
            }
            return  Center(  
            child: Container(
              alignment: Alignment.center,
              width: Get.width / 1.1,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final blog = blogs[index];
                  
                  return GestureDetector(
                    onTap: () {
                      Get.to(BlogDetail(image: blog.imageurl!, title: blog.title!,));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.grey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width / 1.1,
                            child: Card(
                              child: CachedNetworkImage(
                                  progressIndicatorBuilder:
                                      (context, url, progress) {
                                    return SizedBox(
                                      height: 150,
                                      width: Get.width / 1.1,
                                    );
                                  },
                                  fit: BoxFit.cover,
                                  imageUrl: blog.imageurl!),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                blog.title!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 15),
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          IconButton(onPressed: (){
                            context.read<OfflineBlogCubit>().toggleLike(blog.id!);
                          }, icon: Icon(blog.isfavorite==0? Icons.favorite_outline: Icons.favorite))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
          },
    );
  }
}
