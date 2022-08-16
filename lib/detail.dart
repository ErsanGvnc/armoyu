// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable, unused_import, must_be_immutable, sized_box_for_whitespace, unused_element, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:armoyu/main.dart';
import 'package:armoyu/site.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theme_provider/theme_provider.dart';

class Detail extends StatefulWidget {
  String veri1, veri3, veri5, veri6, veri7, veri8, veri9, veri10;
  Detail({
    required this.veri1,
    required this.veri3,
    required this.veri5,
    required this.veri6,
    required this.veri7,
    required this.veri8,
    required this.veri9,
    required this.veri10,
  });

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    String _content = widget.veri9;
    void _shareContent() {
      Share.share(_content);
    }

    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.veri1),
          actions: [
            IconButton(
              onPressed: () {
                _shareContent();
              },
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: screenwidth,
                  child: CachedNetworkImage(
                    imageUrl: widget.veri5,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              widget.veri7,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: screenwidth / 75),
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.grey,
                            ),
                            SizedBox(width: screenwidth / 75),
                            Text(
                              widget.veri10,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            Spacer(),
                            Text(
                              widget.veri6,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: screenwidth / 75),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        Text(widget.veri8),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                print(widget.veri9);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Site(
                                      verilink: widget.veri9,
                                      veribaslik: widget.veri1,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Haberin devamı",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
