// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable, unused_import, must_be_immutable, sized_box_for_whitespace, unused_element

import 'package:flutter/material.dart';
import 'package:jsonekleme/main.dart';
import 'package:jsonekleme/site.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theme_provider/theme_provider.dart';

class Detail extends StatefulWidget {
  String veri, veri1, veri3, veri5, veri6, veri7, veri8, veri9, veri10;
  Detail({
    required this.veri,
    required this.veri1,
    required this.veri3,
    //required this.veri4,
    required this.veri5,
    required this.veri6,
    required this.veri7,
    required this.veri8,
    required this.veri9,
    required this.veri10,
  });
  //Detail(List<String> items);

  @override
  _DetailState createState() => _DetailState();
}

// gelenitem a gore indexle (veri2) || shared preferences.
bool _secilme = false;

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    //print(widget.veri1);
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
          // title: Text("Yılbaşı Etkinliği"),
          actions: [
            IconButton(
              onPressed: () {
                _shareContent();
              },
              icon: Icon(Icons.more_vert),
            ),
            // IconButton(
            //   onPressed: () {
            //     print("gelen " + widget.veri);
            //     setState(() {
            //       _secilme = !_secilme;
            //       print(_secilme);
            //     });
            //     if (_secilme == false) {
            //       print("eklenmedi");
            //     } else {
            //       print("eklendi");
            //     }
            //     final snackBar = SnackBar(
            //       content: _secilme ? Text("Eklendi") : Text("Eklenmedi"),
            //       action: SnackBarAction(
            //         label: 'Kapat',
            //         onPressed: () {
            //           // Some code to undo the change.
            //         },
            //       ),
            //     );
            //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //   },
            //   icon: Icon(
            //     _secilme ? Icons.bookmark : Icons.bookmark_outline,
            //   ),
            // ),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: screenwidth,
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     fit: BoxFit.contain,
                  //     image: AssetImage(
                  //       "assets/images/googlelogo.png",
                  //     ),
                  //   ),
                  // ),
                  child: Image.network(widget.veri5),
                ),
                Container(
                  //color: Colors.brown,
                  //height: 500,
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
                        //Text(widget.veri4),
                        // Text(
                        //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
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
                        Container(
                          height: 50,
                          width: screenwidth,
                          decoration: BoxDecoration(
                            //color: Colors.grey,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                              width: screenwidth / 11,
                              decoration: BoxDecoration(
                                //color: Colors.amber,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    "assets/images/logo.png",
                                  ),
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: screenwidth / 75),
                            itemCount: 15,
                          ),
                        ),
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
