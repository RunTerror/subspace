import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subspace/data/database_helper.dart';
import 'package:subspace/data/models/blog_model.dart';
import 'package:subspace/data/repositries/api/api.dart';

class BlogRepositry {
   final DatabaseHelper _dbhelper=DatabaseHelper.instance;

   final _api = Api();
  Future<List<BlogModel>> fetchpost() async {
    final sp=await SharedPreferences.getInstance();
    final isavailable=sp.getBool('apicalled')?? false;
    final header = {
          'x-hasura-admin-secret': '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6'
    };
    final options = Options(headers: header);
    try {
      final response=await _api.sendrequest.get("/blogs",
        options: options);
        List<dynamic> blogs=response.data['blogs'];
        final blogmodles= blogs.map((blog) => BlogModel.fromJson(blog)).toList();
        if(!isavailable){
           for(final blogmodel in blogmodles){
          final blog=blogmodel.tojson();
         await _dbhelper.insertBlog(blog);
        }
        sp.setBool('apicalled', true);
        }
        return blogmodles;
    }on DioException catch (e) {
      rethrow;
    }
   
  }
}

