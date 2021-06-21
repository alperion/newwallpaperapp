import 'package:flutter/material.dart';

class WrongSearch extends StatefulWidget {
  @override
  _WrongSearchState createState() => _WrongSearchState();
}

class _WrongSearchState extends State<WrongSearch> {
  double wie = 200;
  double hei = 200;
  Color col = Colors.grey;

  Future<void> degistir() async {
    var sec = Duration(milliseconds: 500);

    setState(() {
      wie = MediaQuery.of(context).size.width;
      hei = MediaQuery.of(context).size.height - 30.0;
      col = Colors.grey[900];
    });
    Future.delayed(sec, () {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0), color: col),
                    width: wie,
                    height: hei,
                    duration: Duration(milliseconds: 500),
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Column(
                        children: [
                          Text("please enter value"),
                          IconButton(
                              icon: Icon(Icons.info_outline),
                              onPressed: () => degistir())
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
