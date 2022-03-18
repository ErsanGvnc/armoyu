// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Sabit extends StatefulWidget {
  String veri5, veri6, veri7, veri8, veri9;
  Sabit({
    required this.veri5,
    required this.veri6,
    required this.veri7,
    required this.veri8,
    required this.veri9,
  });

  @override
  _SabitState createState() => _SabitState();
}

class _SabitState extends State<Sabit> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    List<int> list = [1, 2, 3, 4, 5];
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        // body: Dismissible(
        //   key: Key("asd"),
        //   onDismissed: (_) {
        //     Navigator.pop(context);
        //   },
        //   movementDuration: Duration(seconds: 1),
        //   direction: DismissDirection.vertical,
        //   child: Center(
        //     child: Hero(
        //       tag: 'imageHero',
        //       child: Image.network(
        //         'https://picsum.photos/250?image=9',
        //       ),
        //     ),
        //   ),
        // ),
        // body: Dismissible(
        //   key: Key("asd"),
        //   onDismissed: (_) {
        //     Navigator.pop(context);
        //   },
        //   movementDuration: Duration(seconds: 1),
        //   direction: DismissDirection.vertical,
        //   child: Center(
        //     child: Hero(
        //       tag: 'imageHero',
        //       child: CarouselSlider(
        //         options: CarouselOptions(
        //           disableCenter: true,
        //           enableInfiniteScroll: false,
        //         ),
        //         items: list
        //             .map((item) => Container(
        //                   child: Text(item.toString()),
        //                   color: Colors.green,
        //                 ))
        //             .toList(),
        //       ),
        //     ),
        //   ),
        // ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Dismissible(
              key: Key("asd"),
              onDismissed: (_) {
                Navigator.pop(context);
              },
              movementDuration: Duration(seconds: 1),
              direction: DismissDirection.vertical,
              child: InkWell(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Center(
                  child: InkWell(
                    onTap: () {
                      print("object");
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Hero(
                      tag: 'imageHero',
                      child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1,
                          disableCenter: true,
                          enableInfiniteScroll: false,
                        ),
                        items: list
                            .map(
                              (item) => Image.network(
                                "https://picsum.photos/250?image=9",
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenheight / 10),
              color: Colors.transparent,
              width: screenwidth,
              height: screenheight / 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10),
                          (widget.veri5 != "0")
                              ? Text(
                                  widget.veri5,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              : Text(""),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          (widget.veri6 != "0")
                              ? Text(
                                  widget.veri6,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              : Text(""),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.repeat,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          (widget.veri7 != "0")
                              ? Text(
                                  widget.veri7,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              : Text(""),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Share.share(
                        widget.veri9,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.share_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  screenwidth / 20, 0, screenwidth / 20, screenheight / 40),
              color: Colors.transparent,
              width: screenwidth,
              height: screenheight / 15,
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: 'Yorum Yap',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
