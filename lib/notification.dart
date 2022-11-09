// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields, unused_local_variable, avoid_print, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_element, unused_import

import 'dart:convert';
import 'package:armoyu/anasayfa.dart';
import 'package:armoyu/news.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skeletons/skeletons.dart';
import 'package:theme_provider/theme_provider.dart';
import 'Utilities/links.dart';
import 'Variables/variables.dart';
import 'Controllers/controllers.dart';
import 'anadetail.dart';
import 'profile.dart';

class Notif extends StatefulWidget {
  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  Future bildirimcek() async {
    final gelen = await http.get(
      Uri.parse(bildirimlink),
    );

    try {
      bildirimler = jsonDecode(gelen.body);
    } catch (e) {
      print('Unknown exception: $e');
    }
    setState(() {});
  }

  Future<void> _refresh() async {
    bildirimcek();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    // return Center(
    //   child: Container(
    //     child: Text(
    //       "Çok Yakında...\nComing Soon...",
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         fontSize: 24,
    //         fontWeight: FontWeight.w600,
    //       ),
    //     ),
    //   ),
    // );

    return FutureBuilder(
      initialData: bildirimcek(),
      future: bildirimcek(),
      builder: (context, snapshot) => RefreshIndicator(
        onRefresh: _refresh,
        child: bildirimler.isNotEmpty
            ? ListView.separated(
                controller: notificationScrollController,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: bildirimler.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThemeConsumer(
                            child: Profile(
                              veri1: bildirimler[index]["bildirimkimID"],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Badge(
                      badgeColor: Colors.blue,
                      position: BadgePosition.topStart(),
                      showBadge: bildirimler[index]["bildirimdurum"] == "1"
                          ? true
                          : false,
                      ignorePointer: true,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    bildirimler[index]["bildirimkimavatar"] ??
                                        "https://aramizdakioyuncu.com/galeri/ana-yapi/armoyu64.png",
                                  ),
                                ),
                              ),
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: Container(
                                // color: Colors.amber,
                                width: screenwidth,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            bildirimler[index]
                                                    ["bildirimkimadsoyad"] ??
                                                "",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            bildirimler[index]
                                                ["bildirimzamandetay"],
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      DetectableText(
                                        detectionRegExp:
                                            RegExp(r"@(\w+)|#(\w+)"),
                                        text: bildirimler[index]
                                            ["bildirimicerik"],
                                        detectedStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Visibility(
                                        visible: bildirimler[index]
                                                        ["bildirimkategori"] ==
                                                    "istek" ||
                                                bildirimler[index]
                                                        ["bildirimkategori"] ==
                                                    "davet"
                                            ? true
                                            : false,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      // color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          bildirimler[index][
                                                                      "bildirimkategori"] ==
                                                                  "istek"
                                                              ? "Kabul Et"
                                                              : "Katıl",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      // color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          bildirimler[index][
                                                                      "bildirimkategori"] ==
                                                                  "istek"
                                                              ? "Reddet"
                                                              : "Yoksay",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                padding: EdgeInsets.only(
                  top: 10,
                  left: 15,
                  right: 10,
                  bottom: 10,
                ),
                separatorBuilder: (context, index) => Divider(),
              )
            : SkeletonListView(
                scrollable: true,
                itemCount: 20,
              ),
      ),
    );
  }
}
