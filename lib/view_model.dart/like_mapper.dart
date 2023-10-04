import 'package:flutter/widgets.dart';

class LikeMapper extends ChangeNotifier {
  List<int> _likes = [];
  List<int> get likes => _likes;

  addlike(int index) {
    _likes.add(index);
    likes.add(index);
    notifyListeners();
  }

  void removeLike(int index) {
    if (likes.contains(index)) {
      _likes.remove(index);
      likes.remove(index);
    }
    notifyListeners();
  }
}
