class SongNew {
  final int id;
  final String genre;
  final String name;
  final String album;
  final String songUri;
  final String songShiftedUri;
  final String notesUri;
  final String songImageUri;
  final String tags;
  final String originalFileName;
  final String metadata;
  final bool hasProfanity;
  final bool isInUserFavorites;
  final String songText; // For song text

  SongNew({
    required this.id,
    required this.genre,
    required this.name,
    required this.album,
    required this.songUri,
    required this.songShiftedUri,
    required this.notesUri,
    required this.songImageUri,
    required this.tags,
    required this.originalFileName,
    required this.metadata,
    required this.hasProfanity,
    required this.isInUserFavorites,
    required this.songText, // Initialize song text
  });

  // Factory method to create a Song from JSON
  factory SongNew.fromJsonWithText(Map<String, dynamic> json, String songText) {
    return SongNew(
      id: json['id'],
      genre: json['genre'],
      name: json['name'],
      album: json['album'],
      songUri: json['songUri'],
      songShiftedUri: json['songShiftedUri'],
      notesUri: json['notesUri'],
      songImageUri: json['songImageUri'],
      tags: json['tags'],
      originalFileName: json['originalFileName'],
      metadata: json['metadata'],
      hasProfanity: json['hasProfanity'],
      isInUserFavorites: json['songIsHasInUserFavoritesList'],
      songText: songText, // Assign song text
    );
  }

  // Method to convert Song to JSON
  factory SongNew.fromJson(Map<String, dynamic> json) {
    return SongNew(
      id: json['id'],
      genre: json['genre'],
      name: json['name'],
      album: json['album'],
      songUri: json['songUri'],
      songShiftedUri: json['songShiftedUri'],
      notesUri: json['notesUri'],
      songImageUri: json['songImageUri'],
      tags: json['tags'],
      originalFileName: json['originalFileName'],
      metadata: json['metadata'],
      hasProfanity: json['hasProfanity'],
      isInUserFavorites: json['songIsHasInUserFavoritesList'],
      songText: '', // Initially empty until fetched
    );
  }
}