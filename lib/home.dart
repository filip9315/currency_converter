import 'package:currency_converter/currency_list.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'api/api_key.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<double> fetchRate(String c) async{
  if(c=='EUR') return 1;
  final response = await http.get(Uri.parse('http://api.exchangeratesapi.io/v1/latest?access_key=' + apiKey + '&symbols=' + c));
  return Rates.fromJson(jsonDecode(response.body)).rate[c];
}

class Rates{
  final Map<String, dynamic> rate;
  final bool success;
  final String date;

  const Rates({
    required this.date,
    required this.rate,
    required this.success,
  });

  factory Rates.fromJson(Map<String, dynamic> json){
    return Rates(
      rate: json['rates'],
      success: json['success'],
      date: json['date'],
    );
  }
}



class _HomePageState extends State<HomePage> {
  double y=0, z=0, r1=0, r2=0, n=0;

  String c1='USD', c2 = 'EUR';


  @override
  void initState() {
    super.initState();
    getinitRate();
  }

  Future<void> getinitRate() async {
    r1 = await fetchRate('USD');
    r2 = await fetchRate('EUR');
    n=10;
    setState(() {});
  }


  Future<void> getRate1(String c)async {
    z = await fetchRate(c);
    setState(() {
      r1 = z;
    });
  }

  Future<void> getRate2(String c)async {
    z = await fetchRate(c);
    setState(() {
      r2 = z;
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container(), flex: 1,),
                Text(
                  'Currency',
                  style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 8, 51, 82)),
                ),
                Text(
                  'Converter',
                  style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 8, 51, 82)),
                ),
                Expanded(child: Container(), flex: 2,),
                Container(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 160,
                        child: TextFormField(
                          initialValue: '10',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 8, 51, 82)
                          ),
                          cursorColor: Color.fromARGB(255, 8, 51, 82),
                          obscureText: false,
                          decoration: InputDecoration(
                            focusColor: Color.fromARGB(255, 8, 51, 82),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 8, 51, 82)),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            setState(() {
                              n = double.parse(val);
                            });
                          }
                        ),
                      ),
                      OutlinedButton(
                        child: Text(
                            c1,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 8, 51, 82)
                          ),
                        ),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CurrencyList()),
                          );
                          setState(() {
                            c1=result;
                          });
                          getRate1(c1);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(flex:1, child: Container()),
                Container(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        double.parse((r2/r1*n).toStringAsFixed(2)).toString(),
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 8, 51, 82)
                        ),
                      ),
                      OutlinedButton(
                        child: Text(
                            c2,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 8, 51, 82)
                          ),
                        ),
                        onPressed: () async {
                          final result2 = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CurrencyList()),
                          );
                          setState(() {
                            c2=result2;
                          });
                          getRate2(c2);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(flex:4, child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
