// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, avoid_print, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jsonekleme/anadetail.dart';
import 'package:jsonekleme/main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theme_provider/theme_provider.dart';

class Grup extends StatefulWidget {
  String veri1, veri2;
  Grup({
    required this.veri1,
    required this.veri2,
  });

  @override
  State<Grup> createState() => _GrupState();
}

class _GrupState extends State<Grup> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var gelen = await http.get(
      Uri.parse(grupdetail),
    );
    datagrup = jsonDecode(gelen.body);
    setState(() {
      print(grupdetail);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    Future<void> _refresh() {
      return fetchData();
    }

    // final items = List<String>.generate(15, (i) => "Item $i");
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.veri1),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Container(
            child: datagrup != null
                ? ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (dataanasayfa[index]["paylasimfoto"] != null) {
                        gonderifotolar = dataanasayfa[index]["paylasimfoto"];
                        print(datagrup[index]["benbegendim"]);
                        visible = true;
                      } else {
                        visible = false;
                      }
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnaDetail(
                                veri1: datagrup[index]["sahipavatar"],
                                veri2: datagrup[index]["sahipad"],
                                veri3: datagrup[index]["sosyalicerik"],
                                veri4: datagrup[index]["paylasimzaman"],
                                veri5: datagrup[index]["begenisay"],
                                veri6: datagrup[index]["yorumsay"],
                                veri7: datagrup[index]["repostsay"],
                                veri8: datagrup[index]["sikayetsay"],
                                veri9: datagrup[index]["benbegendim"],
                                veri10: dataanasayfa[index]["postID"],
                                veri11: dataanasayfa[index]["sahipID"],
                                veri12: dataanasayfa[index]["paylasimnereden"],
                                // veri12: dataanasayfa[index]["paylasimfoto"],

                                // veri9: gonderifotolar[index]["fotourl"] != null
                                //     ? gonderifotolar[index]["fotourl"]
                                //     : "https://aramizdakioyuncu.com/galeri/ana-yapi/armoyu64.png",
                              ),
                            ),
                          );
                          print(datagrup[index]["benbegendim"]);
                        },
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: screenwidth / 12,
                                backgroundImage: NetworkImage(
                                  datagrup[index]["sahipavatar"],
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(width: screenwidth / 35),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          datagrup[index]["sahipad"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "  -  " +
                                              datagrup[index]
                                                  ["paylasimzamangecen"],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.more_vert,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenheight / 90),
                                    Text(
                                      datagrup[index]["sosyalicerik"],
                                    ),
                                    SizedBox(height: screenheight / 50),
                                    // Visibility(
                                    //   visible: visible,
                                    //   child: Container(
                                    //     child: gonderifotocek(),
                                    //   ),
                                    // ),

                                    // Fotograflara basınca hata veriyordu şimdilik çözüm için böyle yaptım.

                                    // InkWell(
                                    //   onTap: () {
                                    //     print(
                                    //       "***************************************" +
                                    //           gonderifotolar[index]["fotourl"],
                                    //     );
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) => FotoIcerik(
                                    //           veri5: dataanasayfa[index]
                                    //               ["begenisay"],
                                    //           veri6: dataanasayfa[index]
                                    //               ["yorumsay"],
                                    //           veri7: dataanasayfa[index]
                                    //               ["repostsay"],
                                    //           veri8: dataanasayfa[index]
                                    //               ["sikayetsay"],
                                    //           veri9: gonderifotolar[index]
                                    //               ["fotourl"],
                                    //         ),
                                    //       ),
                                    //     );
                                    //   },
                                    //   child: Visibility(
                                    //     visible: visible,
                                    //     child: Container(
                                    //       // burası fotografların gozuktugu yer

                                    //       child: gonderifotocek(),

                                    //       // child: Flexible(
                                    //       //   child: Image.network(
                                    //       //     gonderifotolar[index]["fotourl"],
                                    //       //     fit: BoxFit.cover,
                                    //       //     filterQuality: FilterQuality.high,
                                    //       //   ),
                                    //       // ),
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(height: screenheight / 65),
                                    Container(
                                      color: Colors.transparent,
                                      width: screenwidth,
                                      height: screenheight / 20,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  (datagrup[index]
                                                              ["benbegendim"] !=
                                                          0)
                                                      ? Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        )
                                                      : Icon(
                                                          Icons.favorite_border,
                                                          color: Colors.grey,
                                                        ),
                                                  SizedBox(width: 10),
                                                  (datagrup[index]
                                                              ["begenisay"] !=
                                                          "0")
                                                      ? Text(
                                                          datagrup[index]
                                                              ["begenisay"],
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
                                                children: [
                                                  Icon(
                                                    Icons.chat_bubble_outline,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  (datagrup[index]
                                                              ["yorumsay"] !=
                                                          "0")
                                                      ? Text(
                                                          datagrup[index]
                                                              ["yorumsay"],
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
                                                children: [
                                                  Icon(
                                                    Icons.repeat,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  (datagrup[index]
                                                              ["repostsay"] !=
                                                          "0")
                                                      ? Text(
                                                          dataanasayfa[index]
                                                              ["repostsay"],
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
                                                datagrup[index]["sosyalicerik"],
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
                                          SizedBox(
                                            width: screenwidth / 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: datagrup.length,
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                  )
                : ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 150),
                        Text(
                          "Henüz grubunuzda hiç\npaylaşım yapılmamış...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 5),
                    itemCount: 1,
                  ),
          ),
        ),
      ),
    );
  }
}
