
import '../../api/api.dart';

class ImageAWS {

  static String getImageURI(String? path, {String? text = '...'}) {
    const baseURI = Api.baseUrl;

    if(path == null){
      print('path == null');
      return 'https://placehold.co/400x400.png?text=$text';
    }

    if(path.contains('/')){
      return '$baseURI$path';
    }

    return '$baseURI/api/v1/media/$path';
  }
}