import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiHelper {
  Future<Object> getAllPrices() async {
    var url = Uri.parse('https://api.binance.com/api/v3/ticker/price');
    http.Response response = await http.get(url);
    //print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data.');
    }
  }

  Future<Object> getPriceBySymbol(String symbol) async {
    var url =
        Uri.parse("https://api.binance.com/api/v3/ticker/price?symbol=$symbol");
    http.Response response = await http.get(url);
    //print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      Currency currency = Currency.fromJSON(jsonDecode(response.body));
      //String symbol = currency.symbol;
      //double price = currency.price;
      return currency;
    } else {
      throw Exception('Failed to fetch data.');
    }
  }
}

class Currency {
  final String symbol;
  final double price;

  const Currency({required this.symbol, required this.price});

  factory Currency.fromJSON(Map<String, dynamic> json) {
    return Currency(symbol: json['symbol'], price: double.parse(json['price']));
  }
}
