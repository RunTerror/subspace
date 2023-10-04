class BlogModel {
  String? id;
  String? title;
  String? imageurl;
  int isfavorite; 

  BlogModel({this.id, this.imageurl, this.title, this.isfavorite = 0});

  factory BlogModel.fromJson(Map<String, dynamic> data) {
    return BlogModel(
      id: data['id'],
      imageurl: data['image_url'],
      title: data['title'],
      isfavorite: data['isfavorite']?? 0, 
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageurl,
      'isfavorite': isfavorite, 
    };
  }
}
