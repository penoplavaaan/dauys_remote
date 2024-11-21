import 'package:dauys_remote/models/song.dart';

class Collection {
  final int id;
  final String name;
  final String description;
  final String dateAdd;
  final String collectionImageAwsUuid;
  final int songsCount;
  final List<Song> songs;

  Collection({
    required this.id,
    required this.name,
    required this.description,
    required this.dateAdd,
    required this.collectionImageAwsUuid,
    required this.songsCount,
    required this.songs,
  });

  // Factory method to create a Collection from JSON
  factory Collection.fromJson(Map<String, dynamic> json) {
    var songsList = (json['songs'] as List)
        .map((songJson) => Song.fromJson(songJson))
        .toList();

    return Collection(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      dateAdd: json['dateAdd'],
      collectionImageAwsUuid: json['collectionImageAwsUuid'],
      songsCount: json['songsCount'],
      songs: songsList,
    );
  }

  // Method to convert Collection to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'dateAdd': dateAdd,
      'collectionImageAwsUuid': collectionImageAwsUuid,
      'songsCount': songsCount,
      'songs': songs.map((song) => song.toJson()).toList(),
    };
  }
}
