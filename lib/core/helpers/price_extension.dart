import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String toNicePrice() {
    final formatter = NumberFormat('###,###,###', 'en_US');
    return formatter.format(this);
  }
}
