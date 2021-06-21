import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'info.dart';
import 'package:http/http.dart' as http;
import 'categorypage.dart';
import 'largepage.dart';

import 'prevsearch.dart';
import 'searchscreen.dart';
import 'fileoperation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getcategoriespage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CategoriesPage()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            centerTitle: true,
            title: Text("HYPERION"),
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
          drawer: MyDrawer(),
          body: GovdeBir(),
        ),
      ),
    );
  }
}

class GovdeBir extends StatefulWidget {
  @override
  _GovdeBirState createState() => _GovdeBirState();
}

class _GovdeBirState extends State<GovdeBir> {
  List images = [];
  int page = 1;
  TextEditingController searchcontrol = TextEditingController();

  //// ilk sayfaya gelen resimler bununla alınacak
  pexelsapi() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=42"),
        headers: {
          "Authorization":
              "563492ad6f917000010000012009e4b2e6da419094353041d33d4fa2"
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result["photos"];
      });
    });
  }

/////////////////////////// resimler bitince tekrar yüklemek için kullanılacak fonksiyon

  loadmoreimage() async {
    setState(() {
      page = page + 1;
    });
    String newpageurl =
        "https://api.pexels.com/v1/curated?per_page=42&page=" + page.toString();

    await http.get(Uri.parse(newpageurl), headers: {
      "Authorization":
          "563492ad6f917000010000012009e4b2e6da419094353041d33d4fa2"
    }).then((value) {
      Map response = jsonDecode(value.body);

      setState(() {
        images.addAll(response["photos"]);
      });
    });
  }

  @override
  void initState() {
    pexelsapi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 40,
            padding: EdgeInsets.only(right: 15, left: 15),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[400],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchcontrol,
                    decoration: InputDecoration(
                        hintText: "search", border: InputBorder.none),
                  ),
                ),
                GestureDetector(
                    child: Container(child: Icon(Icons.search)),
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage(
                                    searchimage: searchcontrol.text,
                                  )));
                      await FileProcess.saveToFile(searchcontrol.text);
                    }),
              ],
            ),
          ),

////////////////////////////// yukarısı search bar kısmı

          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
            child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    childAspectRatio: 2 / 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(images[index]["src"]["portrait"],
                              fit: BoxFit.cover),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LargeScreen(
                                      imageurls: images[index]["src"]
                                          ["original"],
                                    )));
                      });
                  //
                }),
          )),

/////////////////////////////////////////
          IconButton(
            splashColor: Colors.white,
            color: Colors.grey[50],
            icon: Icon(
              Icons.add,
              color: Colors.grey[800],
            ),
            onPressed: loadmoreimage,
          ),

//////////////////////////////////
        ],
      ),
    );
  }
}
// Icons.info_outline_rounded,Icons.crop_original_outlined,

///////////

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[300],
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.grey[700],
                Colors.grey[900],
                Colors.grey[700]
              ])),
              child: Container(
                child: Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          "fireimage/fire.png",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text("Categories"),
              leading: Icon(Icons.image_rounded),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => CategoriesPage()));
              },
            ),
            ListTile(
              title: Text("About"),
              leading: Icon(Icons.info_outline),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => InfoPage()));
              },
            ),
            ListTile(
              title: Text("Previous Search"),
              leading: Icon(Icons.backup),
              onTap: () async {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => PreviusSearchScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
