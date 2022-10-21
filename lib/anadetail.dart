// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, curly_braces_in_flow_control_structures, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, avoid_unnecessary_containers, unnecessary_string_interpolations, prefer_adjacent_string_concatenation

import 'dart:async';
import 'dart:convert';
import 'package:animations/animations.dart';
// import 'package:armoyu/byrdetail.dart';
import 'package:armoyu/profile.dart';
import 'package:armoyu/Utilities/utilities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:armoyu/resiminceleme.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'Controllers/controllers.dart';
import 'Variables/variables.dart';
import 'package:armoyu/Utilities/links.dart';

class AnaDetail extends StatefulWidget {
  String veri1,
      veri2,
      veri3,
      veri4,
      veri5,
      veri6,
      veri7,
      veri8,
      veri10,
      veri11,
      veri12,
      veri14;

  int veri9, veri13;

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
    required this.veri12,
    required this.veri13,
    required this.veri14,
  });

  @override
  _AnaDetailState createState() => _AnaDetailState();
}

class _AnaDetailState extends State<AnaDetail> {
  List resimler = [];
  List yorumlar = [];
  String paylasimtip = "";

  @override
  void initState() {
    detaycek();
    yorumcek();
    super.initState();
  }

  detaycek() async {
    var gelen = await http.get(
      Uri.parse(detaylink),
    );
    detaylar = jsonDecode(gelen.body);

    if (detaylar[0]["paylasimfoto"] != null) {
      for (var i = 0; i < detaylar[0]["paylasimfoto"].length; i++) {
        resimler.add(detaylar[0]["paylasimfoto"][i]["fotoufakurl"]);
      }
      paylasimtip = detaylar[0]["paylasimfoto"][0]["paylasimkategori"];
    }

    setState(() {});
  }

  yorumcek() async {
    var gelen = await http.get(
      Uri.parse(detaylink),
    );
    detaylar = jsonDecode(gelen.body);

    if (detaylar[0]["yorumlar"] != null) {
      for (var i = 0; i < detaylar[0]["yorumlar"].length; i++) {
        yorumlar.add(detaylar[0]["yorumlar"][i]);
      }
    }

    print(yorumlar);

    setState(() {});
  }

  Future<bool> onLikeButtonTapped(bool isLike) async {
    setState(() {
      widget.veri9 = widget.veri9 == 0 ? 1 : 0;

      isLike = !isLike;

      if (isLike == true) {
        widget.veri5 = (int.parse(widget.veri5) + 1).toString();
      } else {
        widget.veri5 = (int.parse(widget.veri5) - 1).toString();
      }
    });
    print(isLike);
    postID = widget.veri10;
    print("onLikeButtonTapped");

    postlike();

    return isLike;
  }

  Future<bool> onCommentLikeButtonTapped(bool isLike, dynamic yorum) async {
    setState(() {
      yorum["benbegendim"] = yorum["benbegendim"] == 0 ? 1 : 0;

      isLike = !isLike;

      if (isLike == true) {
        yorum["yorumbegenisayi"] =
            (int.parse(yorum["yorumbegenisayi"]) + 1).toString();
      } else {
        yorum["yorumbegenisayi"] =
            (int.parse(yorum["yorumbegenisayi"]) - 1).toString();
      }
    });
    print(isLike);

    yorumID = yorum["yorumid"];
    print("onCommentLikeButtonTapped");

    postyorumlike(yorum);

    return isLike;
  }

  galeriresim() {
    // print(paylasimtip);
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    if (resimler.length == 1)
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: OpenContainer(
          transitionType: ContainerTransitionType.fade,
          openColor: Colors.transparent,
          closedColor: Colors.transparent,
          openElevation: 0,
          closedElevation: 0,
          closedBuilder: (context, openWidget) {
            return InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: openWidget,
              child: Row(
                children: [
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        resimler[0],
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          openBuilder: (context, closeWidget) {
            return Resiminceleme(
              veri1: resimler,
            );
          },
        ),
      );
    if (resimler.length == 2)
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Row(
          children: [
            Flexible(
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  print("2 resim");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Resiminceleme(
                        veri1: resimler,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    resimler[0],
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
            SizedBox(width: screenwidth / 35),
            Flexible(
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  print("2 resim");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Resiminceleme(
                        veri1: resimler,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    resimler[1],
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    if (resimler.length > 2)
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Row(
          children: [
            Flexible(
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  print("3 ve üstü resim");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Resiminceleme(
                        veri1: resimler,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    resimler[0],
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
            SizedBox(width: screenwidth / 35),
            Flexible(
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  print("3 ve üstü resim");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Resiminceleme(
                        veri1: resimler,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.srgbToLinearGamma(),
                        child: Image.network(
                          resimler[1],
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      Text(
                        "+ ${resimler.length - 1}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }

  galerivideo() {
    print(paylasimtip);
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    // return Padding(
    //   padding: EdgeInsets.all(10),
    //   child: Row(
    //     children: [
    //       Flexible(
    //         child: ClipRRect(
    //           borderRadius: BorderRadius.circular(10),
    //           child: BetterPlayer.network(
    //             resimler[0],
    //             betterPlayerConfiguration: BetterPlayerConfiguration(
    //               aspectRatio: 19 / 9,
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    Future<void> _refresh() async {
      postID = widget.veri10;
      yorumlar.clear();
      yorumcek();
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              child: Stack(
                children: [
                  ListView(
                    controller: anaSayfaDetailScrollController,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenheight / 60),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    borderRadius:
                                        BorderRadius.circular(screenwidth / 12),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ThemeConsumer(
                                            child: Profile(
                                              veri1: widget.veri11,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: screenwidth / 12,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        widget.veri1,
                                      ),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(width: screenwidth / 35),
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ThemeConsumer(
                                            child: Profile(
                                              veri1: widget.veri11,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      widget.veri2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10),
                                          ),
                                        ),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SafeArea(
                                            child: Wrap(
                                              children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[900],
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(30),
                                                          ),
                                                        ),
                                                        width: screenwidth / 4,
                                                        height: 5,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const ListTile(
                                                        leading: Icon(
                                                            Icons.post_add),
                                                        title: Text(
                                                            "Postu favorilere ekle."),
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: widget.veri11 ==
                                                              girisdata[
                                                                  "oyuncuID"]
                                                          ? true
                                                          : false,
                                                      child: InkWell(
                                                        onTap: () {
                                                          postID =
                                                              widget.veri10;
                                                          // postsil();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const ListTile(
                                                          leading: Icon(
                                                              Icons.edit_note),
                                                          title: Text(
                                                              "Postu düzenle."),
                                                        ),
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: widget.veri11 ==
                                                              girisdata[
                                                                  "oyuncuID"]
                                                          ? true
                                                          : false,
                                                      child: InkWell(
                                                        onTap: () {
                                                          postID =
                                                              widget.veri10;
                                                          postsil();
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const ListTile(
                                                          leading: Icon(Icons
                                                              .delete_sweep_outlined),
                                                          title: Text(
                                                              "Postu kaldır."),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Share.share(
                                                            widget.veri14);
                                                        Navigator.pop(context);
                                                      },
                                                      child: const ListTile(
                                                        leading: Icon(Icons
                                                            .share_outlined),
                                                        title: Text(
                                                            "Kullanıcıyı paylaş."),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Clipboard.setData(
                                                          ClipboardData(
                                                            text: widget.veri14,
                                                          ),
                                                        );
                                                        Navigator.pop(context);
                                                        // ScaffoldMessenger.of(
                                                        //         context)
                                                        //     .showSnackBar(
                                                        //   SnackBar(
                                                        //     content: Text(
                                                        //         "Kopyalandı !"),
                                                        //     shape:
                                                        //         StadiumBorder(),
                                                        //   ),
                                                        // );
                                                        Fluttertoast.showToast(
                                                          msg: "Kopyalandı !",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                        );
                                                      },
                                                      child: const ListTile(
                                                        leading: Icon(
                                                            Icons.content_copy),
                                                        title: Text(
                                                            "Kullanıcı profil linkini kopyala."),
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: widget.veri11 ==
                                                              girisdata[
                                                                  "oyuncuID"]
                                                          ? false
                                                          : true,
                                                      child: Divider(),
                                                    ),
                                                    Visibility(
                                                      visible: widget.veri11 ==
                                                              girisdata[
                                                                  "oyuncuID"]
                                                          ? false
                                                          : true,
                                                      child: InkWell(
                                                        onTap: () {
                                                          postID =
                                                              widget.veri10;
                                                          postbildir();
                                                          Navigator.pop(
                                                              context);
                                                          // ScaffoldMessenger.of(
                                                          //         context)
                                                          //     .showSnackBar(
                                                          //   const SnackBar(
                                                          //     content: Text(
                                                          //         "Bildirildi !"),
                                                          //     shape:
                                                          //         StadiumBorder(),
                                                          //   ),
                                                          // );
                                                          Fluttertoast
                                                              .showToast(
                                                            msg: "Bildirildi !",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER,
                                                            timeInSecForIosWeb:
                                                                1,
                                                          );
                                                        },
                                                        child: const ListTile(
                                                          textColor: Colors.red,
                                                          leading: Icon(
                                                            Icons.flag_outlined,
                                                            color: Colors.red,
                                                          ),
                                                          title: Text(
                                                              "Postu bildir."),
                                                        ),
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: widget.veri11 ==
                                                              girisdata[
                                                                  "oyuncuID"]
                                                          ? false
                                                          : true,
                                                      child: InkWell(
                                                        onTap: () {
                                                          postID =
                                                              widget.veri10;
                                                          postbildir();
                                                          Navigator.pop(
                                                              context);
                                                          // ScaffoldMessenger.of(
                                                          //         context)
                                                          //     .showSnackBar(
                                                          //   const SnackBar(
                                                          //     content: Text(
                                                          //         "Bildirildi !"),
                                                          //     shape:
                                                          //         StadiumBorder(),
                                                          //   ),
                                                          // );

                                                          Fluttertoast
                                                              .showToast(
                                                            msg: "Bildirildi !",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER,
                                                            timeInSecForIosWeb:
                                                                1,
                                                          );
                                                        },
                                                        child: const ListTile(
                                                          textColor: Colors.red,
                                                          leading: Icon(
                                                            Icons
                                                                .person_outline,
                                                            color: Colors.red,
                                                          ),
                                                          title: Text(
                                                              "Kullanıcıyı bildir."),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenheight / 35),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              // child: Text(
                              //   widget.veri3,
                              //   style: TextStyle(
                              //     // color: Colors.white,
                              //     fontSize: 16,
                              //   ),
                              // ),
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onLongPress: () async {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: widget.veri3,
                                    ),
                                  ).then((_) {
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     content: Text(
                                    //       "Kopyalandı.",
                                    //       style: TextStyle(
                                    //         color: Colors.white,
                                    //       ),
                                    //     ),
                                    //     backgroundColor: Colors.grey[850],
                                    //     shape: const StadiumBorder(),
                                    //   ),
                                    // );
                                    Fluttertoast.showToast(
                                      msg: "Kopyalandı !",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                    );
                                  });
                                },
                                child: DetectableText(
                                  detectionRegExp: RegExp(
                                    "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                                    multiLine: true,
                                  ),
                                  text: widget.veri3,
                                  basicStyle: TextStyle(
                                    fontSize: 16,
                                  ),
                                  detectedStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenheight / 35),

                            if (paylasimtip == "video/x-matroska" ||
                                paylasimtip == "video/mp4")
                              Text("-- Video --"),
                            // galerivideo(),

                            if (paylasimtip == "image/jpeg" ||
                                paylasimtip == "image/png" ||
                                paylasimtip == "image/jpg" ||
                                paylasimtip == "application/octet-stream")
                              galeriresim(),

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
                                    widget.veri12 == ""
                                        ? "For Web"
                                        : "For Mobile",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => ThemeConsumer(
                                      //       child: ByrDetail(
                                      //         veri1: 0,
                                      //         veri2: widget.veri10,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // );
                                      setState(() {
                                        byr = widget.veri10;
                                      });
                                    },
                                    child: Container(
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
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => ThemeConsumer(
                                      //       child: ByrDetail(
                                      //         veri1: 1,
                                      //         veri2: widget.veri10,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // );
                                      setState(() {
                                        byr = widget.veri10;
                                      });
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text(widget.veri6),
                                          Text(
                                            "  Yorum",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => ThemeConsumer(
                                      //       child: ByrDetail(
                                      //         veri1: 2,
                                      //         veri2: widget.veri10,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // );
                                      setState(() {
                                        byr = widget.veri10;
                                      });
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text(widget.veri7),
                                          Text(
                                            "  Repost",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  LikeButton(
                                    onTap: (bool isLike) {
                                      return onLikeButtonTapped(isLike);
                                    },
                                    countPostion: CountPostion.right,
                                    isLiked: widget.veri9 != 0 ? true : false,
                                    // likeCount: int.parse(widget.veri5),
                                    likeBuilder: (bool isLiked) {
                                      return isLiked
                                          ? Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.favorite_outline,
                                              color: Colors.grey,
                                            );
                                    },
                                    bubblesColor: BubblesColor(
                                      dotPrimaryColor: Colors.red,
                                      dotSecondaryColor: Colors.blue,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      focusNodeAnaDetail.requestFocus();
                                      // print(widget.veri13);
                                      // print(widget.veri13.runtimeType);
                                    },
                                    icon: widget.veri13 == 0
                                        ? Icon(
                                            Icons.chat_bubble_outline,
                                            color: Colors.grey,
                                          )
                                        : Icon(
                                            Icons.chat_bubble,
                                            color: Colors.blue,
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
                            // Yorumlar
                            Divider(),

                            for (int i = 0; i < yorumlar.length; i++)
                              Column(
                                children: [
                                  ListTile(
                                    leading: InkWell(
                                      borderRadius: BorderRadius.circular(
                                          screenwidth / 12),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ThemeConsumer(
                                              child: Profile(
                                                veri1: yorumlar[i]["yorumcuid"],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: screenwidth / 12,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          yorumlar[i]["yorumcuminnakavatar"],
                                        ),
                                        backgroundColor: Colors.grey[700],
                                      ),
                                    ),
                                    title: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ThemeConsumer(
                                                  child: Profile(
                                                    veri1: yorumlar[i]
                                                        ["yorumcuid"],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            yorumlar[i]["yorumcuadsoyad"],
                                          ),
                                        ),
                                        Text(
                                          "  -  " + yorumlar[i]["yorumcuzaman"],
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet<void>(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(10),
                                                ),
                                              ),
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SafeArea(
                                                  child: Wrap(
                                                    children: [
                                                      Container(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      900],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            30),
                                                                  ),
                                                                ),
                                                                width:
                                                                    screenwidth /
                                                                        4,
                                                                height: 5,
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: ListTile(
                                                                leading: Icon(Icons
                                                                    .post_add),
                                                                title: Text(
                                                                    "Yorumu favorilere ekle."),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: yorumlar[
                                                                              i]
                                                                          [
                                                                          "yorumcuid"] ==
                                                                      girisdata[
                                                                          "oyuncuID"]
                                                                  ? true
                                                                  : false,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  postID = widget
                                                                      .veri10;
                                                                  // postsil();
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: ListTile(
                                                                  leading: Icon(
                                                                      Icons
                                                                          .delete_sweep_outlined),
                                                                  title: Text(
                                                                      "Yorumu kaldır."),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Share.share(
                                                                    yorumlar[i][
                                                                        "oyunculink"]);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  const ListTile(
                                                                leading: Icon(Icons
                                                                    .share_outlined),
                                                                title: Text(
                                                                    "Kullanıcıyı paylaş."),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Clipboard
                                                                    .setData(
                                                                  ClipboardData(
                                                                    text: yorumlar[
                                                                            i][
                                                                        "oyunculink"],
                                                                  ),
                                                                );
                                                                Navigator.pop(
                                                                    context);
                                                                // ScaffoldMessenger.of(
                                                                //         context)
                                                                //     .showSnackBar(
                                                                //   SnackBar(
                                                                //     content: Text(
                                                                //         "Kopyalandı !"),
                                                                //     shape:
                                                                //         StadiumBorder(),
                                                                //   ),
                                                                // );
                                                                Fluttertoast
                                                                    .showToast(
                                                                  msg:
                                                                      "Kopyalandı !",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .CENTER,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                );
                                                              },
                                                              child:
                                                                  const ListTile(
                                                                leading: Icon(Icons
                                                                    .content_copy),
                                                                title: Text(
                                                                    "Kullanıcı profil linkini kopyala."),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: yorumlar[
                                                                              i]
                                                                          [
                                                                          "yorumcuid"] ==
                                                                      girisdata[
                                                                          "oyuncuID"]
                                                                  ? false
                                                                  : true,
                                                              child: Divider(),
                                                            ),
                                                            Visibility(
                                                              visible: yorumlar[
                                                                              i]
                                                                          [
                                                                          "yorumcuid"] ==
                                                                      girisdata[
                                                                          "oyuncuID"]
                                                                  ? false
                                                                  : true,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: ListTile(
                                                                  textColor:
                                                                      Colors
                                                                          .red,
                                                                  leading: Icon(
                                                                    Icons
                                                                        .flag_outlined,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  title: Text(
                                                                      "Yorumu bildir."),
                                                                ),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: yorumlar[
                                                                              i]
                                                                          [
                                                                          "yorumcuid"] ==
                                                                      girisdata[
                                                                          "oyuncuID"]
                                                                  ? false
                                                                  : true,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const ListTile(
                                                                  textColor:
                                                                      Colors
                                                                          .red,
                                                                  leading: Icon(
                                                                    Icons
                                                                        .person_outline,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  title: Text(
                                                                      "Kullanıcıyı bildir."),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.more_vert,
                                            size: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: DetectableText(
                                      detectionRegExp: RegExp(
                                        "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                                        multiLine: true,
                                      ),
                                      text: yorumlar[i]["yorumcuicerik"],
                                      basicStyle: TextStyle(
                                        fontSize: 14,
                                      ),
                                      detectedStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    // color: Colors.red,
                                    width: screenwidth,
                                    height: screenheight / 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        LikeButton(
                                          onTap: (bool isLike) {
                                            return onCommentLikeButtonTapped(
                                              isLike,
                                              yorumlar[i],
                                            );
                                          },
                                          countPostion: CountPostion.right,
                                          isLiked:
                                              yorumlar[i]["benbegendim"] != 0
                                                  ? true
                                                  : false,
                                          likeCount: yorumlar[i]
                                                      ["yorumbegenisayi"] !=
                                                  "0"
                                              ? int.parse(yorumlar[i]
                                                  ["yorumbegenisayi"])
                                              : null,
                                          likeBuilder: (bool isLiked) {
                                            return isLiked
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : Icon(
                                                    Icons.favorite_outline,
                                                    color: Colors.grey,
                                                  );
                                          },
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor: Colors.red,
                                            dotSecondaryColor: Colors.blue,
                                          ),
                                        ),
                                        // Row(
                                        //   children: [
                                        //     IconButton(
                                        //       onPressed: () {},
                                        //       icon: Icon(
                                        //         Icons.favorite_border,
                                        //         color: Colors.grey,
                                        //         size: 19,
                                        //       ),
                                        //       // icon: widget.veri9 != 0
                                        //       //     ? Icon(
                                        //       //         Icons.favorite,
                                        //       //         color: Colors.red,
                                        //       //       )
                                        //       //     : Icon(
                                        //       //         Icons.favorite_border,
                                        //       //         color: Colors.grey,
                                        //       //       ),
                                        //     ),
                                        //     Text(
                                        //       yorumlar[i]["yorumbegenisayi"] !=
                                        //               "0"
                                        //           ? yorumlar[i]
                                        //               ["yorumbegenisayi"]
                                        //           : "",
                                        //       style: TextStyle(
                                        //         fontSize: 12,
                                        //         color: Colors.grey,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        IconButton(
                                          onPressed: () {
                                            yorum.text =
                                                "${yorumlar[i]["yorumcuetiketad"]} ";
                                            focusNodeAnaDetail.requestFocus();
                                          },
                                          icon: Icon(
                                            Icons.chat_bubble_outline,
                                            color: Colors.grey,
                                            size: 19,
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
                                            size: 19,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                yorumlar.isNotEmpty
                                    ? Icon(
                                        Icons.radio_button_checked,
                                        color: Colors.grey,
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(height: 100),
                                          Text(
                                            "Yorum yapan ilk kişi olun",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 25),
                                          InkWell(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            onTap: () => focusNodeAnaDetail
                                                .requestFocus(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  "Yorum Yap",
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),

                            SizedBox(height: 450),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // yorum yeri

                  Positioned(
                    bottom: 0,
                    width: screenwidth,
                    child: Container(
                      color: Colors.grey[850],
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 5),
                        child: DetectableTextField(
                          focusNode: focusNodeAnaDetail,
                          detectionRegExp: RegExp(
                            "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                            multiLine: true,
                          ),
                          controller: yorum,
                          maxLength: 150,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(
                                r"[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQXZÇŞĞÜÖİçşğüöı0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*# ]",
                                caseSensitive: true,
                                unicode: true,
                                dotAll: true,
                              ),
                            ),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  girisdata["presimufak"],
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            border: UnderlineInputBorder(),
                            counterText: "",
                            hintText: "Yorum Yap",
                            suffixIcon: IconButton(
                              onPressed: () {
                                postID = widget.veri10;
                                FocusManager.instance.primaryFocus?.unfocus();

                                if (yorum.text.isNotEmpty) {
                                  postyorum();
                                  yorum.clear();
                                  yorumlar.clear();
                                  Future.delayed(Duration(milliseconds: 100),
                                      () {
                                    yorumcek();
                                  });

                                  widget.veri6 =
                                      (int.parse(widget.veri6) + 1).toString();
                                  setState(() {});
                                  print("Yorum yapıldı !");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Yorum yapıldı ! " +
                                          "${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
                                      shape: const StadiumBorder(),
                                    ),
                                  );
                                } else {
                                  yorumlar.clear();
                                  yorumcek();
                                  setState(() {});
                                  print("Yorum boş olamaz !");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Yorum boş olamaz !"),
                                      shape: const StadiumBorder(),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
