import 'package:intl/intl.dart';

class Formatter {
  // currency formatter
  static final formatter = NumberFormat.currency(
    locale: 'en_PK',
    decimalDigits: 2,
    symbol: 'Rs',
  );
}

