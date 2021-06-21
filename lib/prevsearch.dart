import 'package:flutter/material.dart';

import 'fileoperation.dart';

class PreviusSearchScreen extends StatefulWidget {
  @override
  _PreviusSearchScreenState createState() => _PreviusSearchScreenState();
}

class _PreviusSearchScreenState extends State<PreviusSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            title: Text(
              "Previous Search",
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                    Colors.grey[900],
                    Colors.grey[700],
                    Colors.grey,
                  ])),
            ),
          ),
          body: GetSearched(),
        ),
      ),
    );
  }
}

class GetSearched extends StatefulWidget {
  @override
  _GetSearchedState createState() => _GetSearchedState();
}

class _GetSearchedState extends State<GetSearched> {
  static List<String> adder = [];

  getsearch() {
    FileProcess.readFromFile().then((value) {
      setState(() {
        adder.addAll(value);
      });
    });
  }

  @override
  void initState() {
    getsearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: adder.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey[300],
              child: ListTile(
                title: Center(child: Text(adder[index])),
              ),
            );
          }),
    );
  }
}
