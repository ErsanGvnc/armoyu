// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, unused_import, must_be_immutable, avoid_print, library_private_types_in_public_api, unrelated_type_equality_checks, unused_element

import 'package:flutter/material.dart';
import 'package:jsonekleme/login.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'anasayfa.dart';
import 'main.dart';

class AnaDetail extends StatefulWidget {
  String veri1, veri2, veri3, veri4, veri5, veri6, veri7, veri8, veri10, veri11;
  int veri9;
  AnaDetail({
    required this.veri1,
    required this.veri2,
    required this.veri3,
    required this.veri4,
    required this.veri5,
    required this.veri6,
    required this.veri7,
    required this.veri8,
    required this.veri9,
    required this.veri10,
    required this.veri11,
  });
  @override
  _AnaDetailState createState() => _AnaDetailState();
}

class _AnaDetailState extends State<AnaDetail> {
  // @override
  // void initState() {
  //   List gonderidengelenfotolar = [widget.veri9];
  //   print("gelince: $gonderidengelenfotolar");
  //   String a = dataanasayfa[0] = gonderifotolar[0]["fotourl"];
  //   print("bune: $a");
  //   super.initState();
  // }

  postsil() {
    http.post(
      Uri.parse(
        "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/sil/0/0/",
      ),
      body: {
        "postID": postID,
      },
    ).then((cevap) {
      // print(cevap.statusCode);
      // print(cevap.body);
      setState(() {
        postsildengiden = cevap.body;
      });
    });
    // print("post");
    // print(
    //     "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/sil/0/0/");
  }

  postlike() {
    http.post(
      Uri.parse(
        "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/begen/0/0/",
      ),
      body: {
        "postID": postID,
      },
    ).then((cevap) {
      // print(cevap.statusCode);
      // print(cevap.body);
      setState(() {
        postsildengiden = cevap.body;
      });
    });
    print("post");
    // print(
    //     "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/begen/0/0/");
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Visibility(
              visible: widget.veri11 == girisdata["oyuncuID"] ? true : false,
              child: InkWell(
                onTap: () {
                  postID = widget.veri10;
                  postsil();
                },
                child: Icon(
                  Icons.more_vert,
                  size: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenheight / 60),
                    //Divider(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: screenwidth / 12,
                            backgroundImage: NetworkImage(
                              widget.veri1,
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(width: screenwidth / 35),
                          Text(
                            widget.veri2,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenheight / 35),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        widget.veri3,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: screenheight / 35),
                    // IconButton(
                    //   onPressed: () {
                    //     print(widget.veri9);
                    //   },
                    //   icon: Icon(Icons.ac_unit),
                    // ),

                    // detail sayfasında resimin gözükeceği yer.
                    ////////////////////////////////////////////////////////////

                    // Visibility(
                    //   visible: visible,
                    //   child: Container(
                    //     child: Image.network(
                    //       widget.veri9,
                    //       fit: BoxFit.cover,
                    //       filterQuality: FilterQuality.high,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: screenheight / 35),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        children: [
                          Text(
                            widget.veri4,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            " - ",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "For Mobile",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(endIndent: 10, indent: 10),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        children: [
                          Text(widget.veri5),
                          Text(
                            "  Beğeni",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(endIndent: 10, indent: 10),
                    Container(
                      color: Colors.transparent,
                      width: screenwidth,
                      height: screenheight / 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              postID = widget.veri10;
                              postlike();
                            },
                            icon: widget.veri9 != 0
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                  ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.repeat,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Share.share(
                                widget.veri3,
                              );
                            },
                            icon: Icon(
                              Icons.share_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
