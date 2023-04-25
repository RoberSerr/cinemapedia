

import 'package:intl/intl.dart';

class HumanFormats {

  static String number( double number, [ int decimals = 0 ] ) {

    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en',
    ).format(number);

    return formattedNumber;

  }

  static String diaMes ( DateTime date ) {

    final fechaHoy = DateFormat.MMMMEEEEd().format(date);

    return fechaHoy;

  }

}