import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

extension IntToRussianString on int {
  String toSongString(BuildContext context) {
    Locale locale = FlutterI18n.currentLocale(context) ?? Locale('ru');
    int number = this;

    switch (locale.languageCode) {
      case 'en':
        return _getEnglishForm(number);
      case 'kk':
        return _getKazakhForm(number);
      case 'ru':
      default:
        return _getRussianForm(number);
    }
  }

  String _getRussianForm(int number) {
    if ((number % 10 == 1) && (number % 100 != 11)) {
      return '$number песня';
    } else if ((number % 10 >= 2 && number % 10 <= 4) && !(number % 100 >= 12 && number % 100 <= 14)) {
      return '$number песни';
    } else {
      return '$number песен';
    }
  }

  String _getEnglishForm(int number) {
    return '$number song${number != 1 ? 's' : ''}';
  }

  String _getKazakhForm(int number) {
    if ((number % 10 == 1) && (number % 100 != 11)) {
      return '$number ән';
    } else if ((number % 10 >= 2 && number % 10 <= 4) && !(number % 100 >= 12 && number % 100 <= 14)) {
      return '$number әндер';
    } else {
      return '$number әндер';
    }
  }
}
