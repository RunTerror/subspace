import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogDetail extends StatelessWidget {
  final String image;
  final String title;
  const BlogDetail({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: w,
        height: h,
        child: Column(
          children: [
            SizedBox(
              width: Get.width / 1.1,
              child: Card(
                child: CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) {
                      return SizedBox(
                        height: 150,
                        width: Get.width / 1.1,
                      );
                    },
                    fit: BoxFit.cover,
                    imageUrl: image),
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
