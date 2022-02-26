import 'package:cryptocurrency/components.dart';
import 'package:flutter/material.dart';
import 'networking.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Cryptocurrency'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _pullPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? crypto = prefs.getStringList('cryptoPrices');
    final List<String>? currency = prefs.getStringList('currencyPrices');
    final String? last = prefs.getString('lastUpdated');
    setState(() {
      if (crypto != null) cryptoPrices = crypto;
      if (currency != null) currencyPrices = currency;
      if (last != null) lastUpdated = last;
    });
  }

  Future<void> _refresh() async {
    var helper = ApiHelper();
    const int decimalPlace = 2;
    try {
      http.Response prices = await helper.getAllPrices();
      double usd = helper.extractCurrencyFrom(prices, 'BUSDTRY').price;
      double eur = helper.extractCurrencyFrom(prices, 'EURUSDT').price * usd;
      double gbp = helper.extractCurrencyFrom(prices, 'GBPUSDT').price * usd;
      double btcusd = helper.extractCurrencyFrom(prices, 'BTCUSDT').price;
      double ethusd = helper.extractCurrencyFrom(prices, 'ETHUSDT').price;
      double dogeusd = helper.extractCurrencyFrom(prices, 'DOGEUSDT').price;
      double btctry = double.parse((btcusd * usd).toStringAsFixed(decimalPlace));
      double ethtry = double.parse((ethusd * usd).toStringAsFixed(decimalPlace));
      double dogetry = double.parse((dogeusd * usd).toStringAsFixed(decimalPlace));
      usd = double.parse((usd).toStringAsFixed(decimalPlace));
      eur = double.parse((eur).toStringAsFixed(decimalPlace));
      gbp = double.parse((gbp).toStringAsFixed(decimalPlace));
      const String pattern = 'dd/MM/yyyy kk:mm:ss';
      setState(() {
        currencyPrices[0] = '$usd ₺';
        currencyPrices[1] = '$eur ₺';
        currencyPrices[2] = '$gbp ₺';
        cryptoPrices[0] = '$btcusd \$\n$btctry ₺';
        cryptoPrices[1] = '$ethusd \$\n$ethtry ₺';
        cryptoPrices[2] = '$dogeusd \$\n$dogetry ₺';
        final String dateTime = DateFormat(pattern).format(DateTime.now());
        lastUpdated = 'Last updated: $dateTime';
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('lastUpdated', lastUpdated);
      prefs.setStringList('currencyPrices', currencyPrices);
      prefs.setStringList('cryptoPrices', cryptoPrices);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to fetch data.');
    }
  }

  List<String> currencyPrices = ['?', '?', '?'];
  List<String> cryptoPrices = ['?', '?', '?'];
  String lastUpdated = '';

  @override
  void initState() {
    super.initState();
    _pullPreferences();
    DateTime timenow = DateTime.now();
    print(timenow);
    Timer timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SvgPicture.asset(
                'images/background.svg',
              ),
            ),
          ),
          RefreshIndicator(
            backgroundColor: backgroundColor,
            onRefresh: _refresh,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 16),
                    constraints: const BoxConstraints(maxHeight: double.infinity),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good afternoon, Emir.',
                          style: greetingTextStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          lastUpdated,
                          style: lastUpdatedTextStyle,
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(24),
                          bottomLeft: Radius.circular(24),
                        ),
                        color: primaryColor),
                  ),
                  ReusableSection(
                    title: 'Exchange Rates',
                    cardNumber: 3,
                    titles: const ['American Dollar (USD)', 'Euro (EUR)', 'English Pound (GBP)'],
                    prices: currencyPrices,
                    iconPaths: const ['images/usd_icon.svg', 'images/usd_icon.svg', 'images/usd_icon.svg'],
                  ),
                  ReusableSection(
                    title: 'Crypto Currencies',
                    cardNumber: 3,
                    titles: const ['Bitcoin (BTC)', 'Ethereum (ETH)', 'Dogecoin (DOGE)'],
                    prices: cryptoPrices,
                    iconPaths: const ['images/usd_icon.svg', 'images/usd_icon.svg', 'images/usd_icon.svg'],
                  ),
                  const ReusableSection(
                    title: 'Stocks',
                    cardNumber: 2,
                    titles: ['ABC', 'DFG'],
                    prices: ['ABC', 'DFG'],
                    iconPaths: ['images/usd_icon.svg', 'images/usd_icon.svg'],
                  ),
                  const ReusableSection(
                    title: 'Gold',
                    cardNumber: 2,
                    titles: ['ABC', 'DFG'],
                    prices: ['ABC', 'DFG'],
                    iconPaths: ['images/usd_icon.svg', 'images/usd_icon.svg'],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
