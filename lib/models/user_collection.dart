import 'package:dauys_remote/models/song.dart';

class UserCollection {
  final int id;
  final String playListName;
  final String dateListened;
  final int playlistSongsCount;
  final List<Song?> songs;

  UserCollection({
    required this.id,
    required this.playListName,
    required this.dateListened,
    required this.playlistSongsCount,
    required this.songs,
  });

  // Factory method to create a Collection from JSON
  factory UserCollection.fromJson(Map<String, dynamic> json) {
    var songsList = (json['songs'] as List)
        .map((songJson) => Song.fromJson(songJson))
        .toList();

    return UserCollection(
      id: json['id'],
      playListName: json['playListName'],
      dateListened: json['dateListened'],
      playlistSongsCount: json['playlistSongsCount'],
      songs: songsList,
    );
  }

  // Method to convert Collection to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playListName': playListName,
      'dateListened': dateListened,
      'playlistSongsCount': playlistSongsCount,
      'songs': songs.map((song) => song?.toJson()).toList(),
    };
  }
}
