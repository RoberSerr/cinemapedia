

import 'package:intl/intl.dart';

class HumanFormats {

  static String number( double number ) {

    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
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