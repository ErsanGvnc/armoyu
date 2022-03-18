// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, unused_import, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theme_provider/theme_provider.dart';

import 'anasayfa.dart';
import 'main.dart';

class AnaDetail extends StatefulWidget {
  String veri1, veri2, veri3, veri4, veri5, veri6, veri7, veri8, veri9;
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

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: ListView(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
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
                    IconButton(
                      onPressed: () {
                        print(widget.veri9);
                      },
                      icon: Icon(Icons.ac_unit),
                    ),
                    Visibility(
                      visible: visible,
                      child: Container(
                        child: Image.network(
                          widget.veri9,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
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
                          Text(widget.veri6),
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
                            onPressed: () {},
                            icon: Icon(
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
