import 'package:dauys_remote/models/song.dart';

class SearchResults {
  final int searchCount;
  final List<Song> songs;

  SearchResults({
    required this.searchCount,
    required this.songs,
  });

  // Factory method to create a Collection from JSON
  factory SearchResults.fromJson(Map<String, dynamic> json) {
    var songsList = (json['songs'] as List)
        .map((songJson) => Song.fromJson(songJson))
        .toList();

    return SearchResults(
      searchCount: json['searchCount'],
      songs: songsList,
    );
  }

  // Method to convert Collection to JSON
  Map<String, dynamic> toJson() {
    return {
      'searchCount': searchCount,
      'songs': songs.map((song) => song.toJson()).toList(),
    };
  }
}
