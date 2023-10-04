import 'package:subspace/data/models/blog_model.dart';

abstract class BlogState {}

class BlogLoadingState extends BlogState {
}

class BlogLoadedState extends BlogState {
  final List<BlogModel> blogs;

  BlogLoadedState(this.blogs);
}

class BlogErrorState extends BlogState {
  final String error;
  BlogErrorState(this.error);
}