

class CharacterModel {
 
    final int id ;
    final String name;
    final String status;
    final String species;
    final String type;
    final String gender; 
    final Origin? origin;
    final Location? location;
    final String image;
    final List<String>? episode;
    final String url;
    final String? created;

  CharacterModel({required this.id, required this.name, required this.status, required this.species, required this.type, required this.gender, this.origin, this.location, required this.image, this.episode, required this.url, this.created});

  factory CharacterModel.fromJson(Map<String, dynamic> json)
  {
    return CharacterModel(
    id: json['id'],
    name: json['name'], 
    status: json['status'],
    species: json['species'],
    type: json['type'],
    gender: json['gender'], 
    image: json['image'],
    url: json['url']
    );
  }


}

class Origin {
  final String name;
  final String url;

  Origin({required this.name, required this.url});
}


class Location {
  final String name;
  final String url;

  Location({required this.name, required this.url});
}

