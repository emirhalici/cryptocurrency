import 'package:cryptocurrency/components.dart';
import 'package:flutter/material.dart';
import 'networking.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
          SingleChildScrollView(
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
                        'Last updated: 22/02/2022 16:28:14',
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
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    'Exchange Rates',
                    style: titleTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const ReusableCard(
                  title: 'American Dollar (USD)',
                  price: '13.86 ₺',
                  iconPath: 'images/usd_icon.svg',
                  bottomLine: true,
                  topLine: true,
                ),
                const ReusableCard(
                  title: 'Euro (EUR)',
                  price: '13.86 ₺',
                  iconPath: 'images/usd_icon.svg',
                  bottomLine: true,
                  topLine: false,
                ),
                const ReusableCard(
                  title: 'English Pound (GBP)',
                  price: '13.86 ₺',
                  iconPath: 'images/usd_icon.svg',
                  bottomLine: true,
                  topLine: false,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ApiHelper apiHelper = ApiHelper();
          apiHelper.getPriceBySymbol('BUSDTRY');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
