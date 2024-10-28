import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Services {
  static String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return ''; // Retorna uma string vazia se a data for nula ou vazia
    }

    try {
      // Converte a string para DateTime no formato 'yyyy-MM-dd HH:mm:ss'
      DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateString);

      // Formata a data e hora no formato brasileiro
      return DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(parsedDate);
    } catch (e) {
      return e.toString(); // Retorna uma mensagem de erro se a conversão falhar
    }
  }
}
