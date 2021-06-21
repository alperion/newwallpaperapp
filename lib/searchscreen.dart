import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'largepage.dart';
import 'wrongsearchpage.dart';

class SearchPage extends StatefulWidget {
  final String searchimage;

  SearchPage({this.searchimage});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List searchedimage = [];
  int nextpages = 1;

//

  newpexelsapi(String query) async {
    await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=80"),
        headers: {
          "Authorization":
              "563492ad6f917000010000012009e4b2e6da419094353041d33d4fa2"
        }).then((value) {
      Map result = jsonDecode(value.body);
      if (result["photos"] == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WrongSearch()));
      } else {
        setState(() {
          searchedimage = result["photos"];
        });
      }
    });
  }

//

  Future<dynamic> trymore(String query) async {
    setState(() {
      nextpages = nextpages + 1;
    });
    String newnextpageurl =
        "https://api.pexels.com/v1/search?query=$query&per_page=80&page=" +
            nextpages.toString();

    await http.get(Uri.parse(newnextpageurl), headers: {
      "Authorization":
          "563492ad6f917000010000012009e4b2e6da419094353041d33d4fa2"
    }).then((value) {
      Map photoresultss = jsonDecode(value.body);

      setState(() {
        searchedimage.addAll(photoresultss["photos"]);
      });
    });
  }

//

  @override
  void initState() {
    newpexelsapi(widget.searchimage);
    super.initState();
  }

//
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Container(
          child: Column(
            children: [
////

              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                child: GridView.builder(
                    itemCount: searchedimage.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        //
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LargeScreen(
                                        imageurls: searchedimage[index]["src"]
                                            ["original"],
                                      )));
                        },
                        //
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            child: Image.network(
                                searchedimage[index]["src"]["portrait"],
                                fit: BoxFit.cover),
                          ),
                        ),
                      );
                    }),
              )),

////

              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.grey[700],
                ),
                onPressed: () => trymore(widget.searchimage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////
///
