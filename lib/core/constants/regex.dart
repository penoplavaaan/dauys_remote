abstract class AppRegExp {
  static final email = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final phone = RegExp(r'^\d{10}$');

  static final digitsOnly = RegExp(r'^\d+$');

  static final password = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
}
