import 'package:flutter/material.dart';
import 'list.dart';

class CurrencyList extends StatefulWidget {

  const CurrencyList({super.key});

  @override
  State<CurrencyList> createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  List<String> items = listOfCurrencies;

  @override
  Widget build(BuildContext context) {
    const title = 'Mixed List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 8, 51, 82),), label: Text('Back', style: TextStyle(color: Color.fromARGB(255, 8, 51, 82)),)),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      maxCrossAxisExtent: 80,
                      childAspectRatio: 2,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context2, index) {
                      final String item = items[index];
                      return OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(8)
                        ),
                        child: Text(item, style: TextStyle(color: Color.fromARGB(255, 8, 51, 82)),),
                          onPressed: (){
                            Navigator.of(context).pop(item);
                          },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}