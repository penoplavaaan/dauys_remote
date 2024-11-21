extension IntToRussianString on int {
  String toSongString() {
    int number = this;
    if ((number % 10 == 1) && (number % 100 != 11)) {
      return '$number песня';
    } else if ((number % 10 >= 2 && number % 10 <= 4) && !(number % 100 >= 12 && number % 100 <= 14)) {
      return '$number песни';
    } else {
      return '$number песен';
    }
  }
}
