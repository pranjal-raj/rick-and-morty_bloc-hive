import 'package:movie_bloc/src/features/common/data/models/character_model.dart';

class Response {
  Info info;
  List<CharacterModel> results;

  Response({
    required this.info,
    required this.results,
  });
}

class Info {
  int count;
  int pages;
  String next;
  dynamic prev;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });
}
