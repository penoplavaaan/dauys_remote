import 'package:flutter/material.dart';

import '../../api/api.dart';

class ImageAWS {

  static String getImageURI(String? path){
    const baseURI = Api.baseUrl;

    if(path == null){
      return 'https://placehold.co/100x100?text=Not+Found';
    }

    if(path.contains('/')){
      return '$baseURI$path';
    }

    return '$baseURI/api/v1/media/$path';
  }
}