import 'package:intl/intl.dart';

extension FormatCurrency on int {
  String formatCurrency() {
    int value = this;
    var format = NumberFormat.currency(locale: 'HI', decimalDigits: 0);
    String v = format.format(value).toString();
    // Remove INR before the amount
    v = v.substring(3);
    return v;
  }
}
