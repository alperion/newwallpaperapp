import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String message =
      "Bu uygulama Dr öğretim üyesi Ahmet Cevahir Çınar tarafından yürütülen 3301456 kodlu MOBİL PROGRAMLAMA dersi kapsamında 193301005 numaralı öğrenci tarafından 25 haziran 2021 günü yapılmıştır";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          title: Text("About"),
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
        body: Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.grey),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(message),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
