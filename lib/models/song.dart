class Song {
  final int id;
  final String genre;
  final String name;
  final String songUri;
  final String album;
  final String songImageUri;

  Song({
    required this.id,
    required this.genre,
    required this.name,
    required this.songUri,
    required this.album,
    required this.songImageUri,
  });

  // Factory method to create a Song from JSON
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      genre: json['genre'],
      name: json['name'],
      songUri: json['songUri'],
      album: json['album'],
      songImageUri: json['songImageUri'],
    );
  }

  // Method to convert Song to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'genre': genre,
      'name': name,
      'songUri': songUri,
      'album': album,
      'songImageUri': songImageUri,
    };
  }
}
