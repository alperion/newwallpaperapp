import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class LargeScreen extends StatefulWidget {
  final String imageurls;

  const LargeScreen({Key key, this.imageurls}) : super(key: key);

  @override
  _LargeScreenState createState() => _LargeScreenState();
}

///
class _LargeScreenState extends State<LargeScreen> {
  ///
  Future<void> sharefoto() async {
    var request = await HttpClient().getUrl(Uri.parse(widget.imageurls));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('ESYS RIAN', 'main.jpg', bytes, 'image/jpg');
  }

  ////
  Future<void> sethomepagewallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurls);
    String result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  //////

  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: FloatingActionButton(
              onPressed: () => sethomepagewallpaper(),
              child: Icon(Icons.wallpaper),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: FloatingActionButton(
              onPressed: () => sharefoto(),
              child: Icon(Icons.share),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: FloatingActionButton(
              onPressed: () async {
                if (await canLaunch(widget.imageurls)) {
                  await launch(widget.imageurls);
                } else {
                  print("could not launched ");
                }
              },
              child: Icon(Icons.link),
            ),
          )
        ],
      ),

      ///
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blueAccent,
              child: Image.network(
                widget.imageurls,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ///////
          IconButton(
              alignment: Alignment.center,
              icon: Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.pop(context))
        ],
      )),
    );
  }
}
