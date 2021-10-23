import 'package:exhange_rates_flutter/models/cotacaoModel.dart';
import 'package:exhange_rates_flutter/models/modelMoeda.dart';
import 'package:http/http.dart' as http;

const String key = 'coloqueSuaChaveAqui';
Future<RatesModel> buscarCota() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/latest.json?base=USD&app_id=' + key));
  final result = ratesModelFromJson(response.body);
  return result;
}

Future<Map> buscarMoeda() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/currencies.json?app_id=' + key));
  final allCurrencies = todasCotacoes(response.body);
  return allCurrencies;
}


String converter(Map exchangeRates, String amount, String currencybase,
    String currencyfinal) {
  String saida = (double.parse(amount) /
          exchangeRates[currencybase] *
          exchangeRates[currencyfinal])
      .toStringAsFixed(2)
      .toString();

  return saida;
}
