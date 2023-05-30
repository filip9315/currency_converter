import 'package:currency_converter/currency_list.dart';
import 'package:currency_converter/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Provider.value(
    builder: (context, child) => MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        '/currencyList': (context) => CurrencyList(),
      },
    ), value: null,
  ));
}