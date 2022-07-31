// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, unused_import, must_be_immutable, avoid_print, library_private_types_in_public_api, unrelated_type_equality_checks, unused_element, unnecessary_null_comparison, prefer_if_null_operators, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, unnecessary_string_interpolations, unused_local_variable, prefer_adjacent_string_concatenation, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
// import 'package:better_player/better_player.dart';
import 'package:animations/animations.dart';
import 'package:armoyu/myProfile.dart';
import 'package:armoyu/youProfile.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:armoyu/login.dart';
import 'package:armoyu/resiminceleme.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'anasayfa.dart';
import 'main.dart';

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
      veri12;

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
  });

  @override
  _AnaDetailState createState() => _AnaDetailState();
}

class _AnaDetailState extends State<AnaDetail> {
  @override
  void initState() {
    detaycek();
    yorumcek();
    super.initState();
  }

  final yorum = TextEditingController();
  var yorumgonderdengelen;

  List resimler = [];
  List yorumlar = [];
  String paylasimtip = "";

  // post bildirme için like butonu gibi yap:
  // https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/bildirim/0/0/

  detaycek() async {
    var gelen = await http.get(
      Uri.parse(detaylink),
    );
    detaylar = jsonDecode(gelen.body);

    if (detaylar[0]["paylasimfoto"] != null) {
      for (var i = 0; i < detaylar[0]["paylasimfoto"].length; i++) {
        resimler.add(detaylar[0]["paylasimfoto"][i]["fotoufakurl"]);

        // print(detaylar[0]["paylasimfoto"][i]["fotoufakurl"]);
      }
      paylasimtip = detaylar[0]["paylasimfoto"][0]["paylasimkategori"];
      // print("paylasimtip: ");
      // print(paylasimtip);
    }
    // print("detaylar: ");
    // print(detaylar);

    // print("resimler: ");
    // print(resimler);

    // print("paylasimkategori: ");
    // devam edilecek.
    // if (detaylar[0]["paylasimfoto"] != null) if (detaylar[0]["paylasimfoto"][0]
    //             ["paylasimkategori"] ==
    //         "image/png" ||
    //     detaylar[0]["paylasimfoto"][0]["paylasimkategori"] == "image/jpeg")
    //   print("foto");
    // else if (detaylar[0]["paylasimfoto"] != null) if (detaylar[0]
    //         ["paylasimfoto"][0]["paylasimkategori"] ==
    //     "video/x-matroska") {
    //   print("video");
    // } else {
    //   print("boş");
    // }
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

        // print(detaylar[0]["yorumlar"][i]);
      }
    }
    // print("detaylar: ");
    // print(detaylar);

    // print("yorumlar: ");
    // print(yorumlar);

    setState(() {});
  }

  postsil() {
    http.post(
      Uri.parse(
        "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/sil/0/0/",
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
    //     "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/sil/0/0/");
  }

  postlike() {
    http.post(
      Uri.parse(
        "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/begen/0/0/",
      ),
      body: {
        "postID": postID,
      },
    ).then((cevap) {
      // print(cevap.statusCode);
      // print(cevap.body);
      setState(() {
        postsildengiden = cevap.body;
        print(cevap.body);
      });
    });
    print("post");
    print("like: " + postID.toString());
  }

  postyorum() {
    http.post(
      Uri.parse(
        "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/yorum/0/0/",
      ),
      body: {
        "yorumicerik": yorum.text,
        "postID": postID,
      },
    ).then((cevap) {
      // print(cevap.statusCode);
      // print(cevap.body);
      setState(() {
        yorumgonderdengelen = cevap.body;
        print(cevap.body);
      });
    });
    print("post");
    print("yorum: " + postID.toString());
  }

  postbildir() async {
    var bildirildimi;
    http.post(
      Uri.parse(postbildirlink),
      body: {
        "postID": postID,
      },
    ).then((cevap) {
      setState(() {
        try {
          bildirildimi = jsonDecode(cevap.body);
        } catch (e) {
          print('Unknown exception: $e');
        }
        print(bildirildimi.toString());
      });
    });
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

    // Linkte body kısmında postID yok hata veriyor.
    // body: {
    //   "postID": postID,
    // },
    // postID olmasına gerek olmayabilir sonucta post işlemi.
    // body kısmını açınca hata veriyor.

    postlike();

    return isLike;
  }

  Future<bool> onCommentButtonTapped(bool isComment) async {
    setState(() {
      widget.veri13 = widget.veri13 == 0 ? 1 : 0;

      isComment = !isComment;

      if (isComment == true) {
        widget.veri6 = (int.parse(widget.veri6) + 1).toString();
      } else {
        widget.veri6 = (int.parse(widget.veri6) - 1).toString();
      }
    });
    print(isComment);
    postID = widget.veri10;
    print("onCommentButtonTapped");

    postyorum();

    return isComment;
  }

  galeriresim() {
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

        // child: InkWell(
        //   onTap: () {
        //     print("1 resim");
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => Resiminceleme(
        //           veri1: resimler,
        //         ),
        //       ),
        //     );
        //   },
        //   child: Row(
        //     children: [
        //       Flexible(
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.circular(10),
        //           child: Image.network(
        //             resimler[0],
        //             fit: BoxFit.cover,
        //             filterQuality: FilterQuality.high,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      );
    if (resimler.length == 2)
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Row(
          children: [
            Flexible(
              child: InkWell(
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

  // galerivideo() {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(10),
  //       child: BetterPlayer.network(
  //         // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
  //         resimler[0],
  //         betterPlayerConfiguration: BetterPlayerConfiguration(
  //           aspectRatio: 19 / 9,
  //           fit: BoxFit.contain,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    // ScrollController? yorumController;
    Future<void> _refresh() async {
      postID = widget.veri10;
      yorumlar.clear();
      yorumcek();
    }

    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Container(
            child: Stack(
              children: [
                ListView(
                  scrollDirection: Axis.vertical,
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
                                          child: MyProfile(
                                            veri1: widget.veri11,
                                            // veri2: widget.veri1,
                                            // // veri2: "parkaresimufak",
                                            // veri3: widget.veri1,
                                            // veri4: "kullaniciadi",
                                            // veri5: "hakkimda",
                                            // veri6: "ulkesi",
                                            // veri7: "kayittarihikısa",
                                            // veri8: girisdata["oyuncuID"],
                                          ),
                                          // child: ProfileDeneme(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: screenwidth / 12,
                                    backgroundImage: NetworkImage(
                                      widget.veri1,
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                SizedBox(width: screenwidth / 35),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ThemeConsumer(
                                          child: MyProfile(
                                            veri1: widget.veri11,
                                            // veri2: widget.veri1,
                                            // // veri2: "parkaresimufak",
                                            // veri3: widget.veri1,
                                            // veri4: "kullaniciadi",
                                            // veri5: "hakkimda",
                                            // veri6: "ulkesi",
                                            // veri7: "kayittarihikısa",
                                            // veri8: girisdata["oyuncuID"],
                                          ),
                                          // child: ProfileDeneme(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    widget.veri2,
                                    style: TextStyle(
                                      // color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    print("bottom sheet");
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Wrap(
                                          children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[900],
                                                        borderRadius:
                                                            BorderRadius.all(
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
                                                    child: ListTile(
                                                      leading:
                                                          Icon(Icons.post_add),
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
                                                        postID = widget.veri10;
                                                        // postsil();
                                                        Navigator.pop(context);
                                                      },
                                                      child: ListTile(
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
                                                        postID = widget.veri10;
                                                        postsil();

                                                        Navigator.pop(context);
                                                      },
                                                      child: ListTile(
                                                        leading: Icon(Icons
                                                            .delete_sweep_outlined),
                                                        title: Text(
                                                            "Postu kaldır."),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(),
                                                  InkWell(
                                                    onTap: () {
                                                      postID = widget.veri10;
                                                      postbildir();
                                                      Navigator.pop(context);
                                                    },
                                                    child: ListTile(
                                                      leading: Icon(
                                                          Icons.flag_outlined),
                                                      title:
                                                          Text("Postu bildir."),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.more_vert,
                                    size: 20,
                                    // color: Colors.grey,
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
                            child: DetectableText(
                              detectionRegExp: RegExp(r"@(\w+)|#(\w+)"),
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
                          SizedBox(height: screenheight / 35),

                          // FutureBuilder(
                          //   future: detaycek(),
                          //   builder:
                          //       (BuildContext context, AsyncSnapshot<Image> image) {
                          //     if (image.hasData) {
                          //       return Image.network(
                          //         detaylar[0]["paylasimfoto"][0]["fotoufakurl"],
                          //         fit: BoxFit.cover,
                          //         filterQuality: FilterQuality.high,
                          //       );
                          //       ; // image is ready
                          //     } else {
                          //       return CircularProgressIndicator();
                          //     }
                          //   },
                          // ),

                          // FutureBuilder<String>(
                          //   future: callAsyncFetch(),
                          //   builder: (context, AsyncSnapshot<String> snapshot) {
                          //     return Image.network(
                          //       "https://aramizdakioyuncu.com/galeri/images/11orijinal11640118395.jpg",
                          //       fit: BoxFit.cover,
                          //       filterQuality: FilterQuality.high,
                          //     );
                          //   },
                          // ),

                          // buraya 1x1 transparent foto koyulacak. / yapıldı.

                          // burası normal for dongusu ile çalısan yer.

                          // for (int i = 0; i < resimler.length; i++)
                          //   Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 10, right: 10, top: 10, bottom: 10),
                          //     child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(10),
                          //       child: Image.network(
                          //         resimler[i] != null
                          //             ? resimler[i]
                          //             : "https://aramizdakioyuncu.com/galeri/images/11orijinal11654971338.png",
                          //         fit: BoxFit.cover,
                          //         filterQuality: FilterQuality.high,
                          //       ),
                          //     ),
                          //   ),

                          // burası yeni resim görünümünün denendigi yer.

                          // if (resimler.length == 1)
                          //   Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 10, right: 10, top: 10, bottom: 10),
                          //     child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(10),
                          //       child: Image.network(
                          //         resimler[0] != null
                          //             ? resimler[0]
                          //             : "https://aramizdakioyuncu.com/galeri/images/11orijinal11654971338.png",
                          //         fit: BoxFit.cover,
                          //         filterQuality: FilterQuality.high,
                          //       ),
                          //     ),
                          //   ),
                          // if (resimler.length == 2)
                          //   Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 10, right: 10, top: 10, bottom: 10),
                          //     child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(10),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //         children: [
                          //           Flexible(
                          //             child: Image.network(
                          //               resimler[0] != null
                          //                   ? resimler[0]
                          //                   : "https://aramizdakioyuncu.com/galeri/images/11orijinal11654971338.png",
                          //               fit: BoxFit.cover,
                          //               filterQuality: FilterQuality.high,
                          //             ),
                          //           ),
                          //           Flexible(
                          //             child: Image.network(
                          //               resimler[1] != null
                          //                   ? resimler[1]
                          //                   : "https://aramizdakioyuncu.com/galeri/images/11orijinal11654971338.png",
                          //               fit: BoxFit.cover,
                          //               filterQuality: FilterQuality.high,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // if (resimler.length == 3)
                          //   Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 10, right: 10, top: 10, bottom: 10),
                          //     child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(10),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //         children: [
                          //           Flexible(
                          //             child: Image.network(
                          //               resimler[0] != null
                          //                   ? resimler[0]
                          //                   : "https://aramizdakioyuncu.com/galeri/images/11orijinal11654971338.png",
                          //               fit: BoxFit.cover,
                          //               filterQuality: FilterQuality.high,
                          //             ),
                          //           ),
                          //           Flexible(
                          //             child: Image.network(
                          //               resimler[1] != null
                          //                   ? resimler[1]
                          //                   : "https://aramizdakioyuncu.com/galeri/images/11orijinal11654971338.png",
                          //               fit: BoxFit.cover,
                          //               filterQuality: FilterQuality.high,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),

                          // burası yeni resim görünümünün denendigi yer (2).

                          // resimler dier sayfaya anasayfadaki gorunum şeklinde gidiyorlar
                          // fakat orada resimin üzerine basınca açılan yeni sayfada sadece
                          // ilk index li resim gözüküyor onu çöz.
                          // ilk index li resim in gozukmesinin nedeni ise
                          // "veri1" e sürekli 0. indexli fotografı gönderiyorum.
                          // örn: resimler[0]
                          // liste (resimler) olarak yolladım çözüldü.

                          // if (resimler.length == 1)
                          //   Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 10, right: 10, top: 10, bottom: 10),
                          //     child: InkWell(
                          //       onTap: () {
                          //         print("1 resim");
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => Resiminceleme(
                          //               veri1: resimler,
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //       child: Row(
                          //         children: [
                          //           Flexible(
                          //             child: ClipRRect(
                          //               borderRadius: BorderRadius.circular(10),
                          //               child: Image.network(
                          //                 resimler[0],
                          //                 fit: BoxFit.cover,
                          //                 filterQuality: FilterQuality.high,
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // if (resimler.length == 2)
                          //   Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 10, right: 10, top: 10, bottom: 10),
                          //     child: Row(
                          //       children: [
                          //         Flexible(
                          //           child: InkWell(
                          //             onTap: () {
                          //               print("2 resim");
                          //               Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => Resiminceleme(
                          //                     veri1: resimler,
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //             child: ClipRRect(
                          //               borderRadius: BorderRadius.circular(10),
                          //               child: Image.network(
                          //                 resimler[0],
                          //                 fit: BoxFit.cover,
                          //                 filterQuality: FilterQuality.high,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         SizedBox(width: screenwidth / 35),
                          //         Flexible(
                          //           child: InkWell(
                          //             onTap: () {
                          //               print("2 resim");
                          //               Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => Resiminceleme(
                          //                     veri1: resimler,
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //             child: ClipRRect(
                          //               borderRadius: BorderRadius.circular(10),
                          //               child: Image.network(
                          //                 resimler[1],
                          //                 fit: BoxFit.cover,
                          //                 filterQuality: FilterQuality.high,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // if (resimler.length > 2)
                          //   Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 10, right: 10, top: 10, bottom: 10),
                          //     child: Row(
                          //       children: [
                          //         Flexible(
                          //           child: InkWell(
                          //             onTap: () {
                          //               print("3 ve üstü resim");
                          //               Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => Resiminceleme(
                          //                     veri1: resimler,
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //             child: ClipRRect(
                          //               borderRadius: BorderRadius.circular(10),
                          //               child: Image.network(
                          //                 resimler[0],
                          //                 fit: BoxFit.cover,
                          //                 filterQuality: FilterQuality.high,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         SizedBox(width: screenwidth / 35),
                          //         Flexible(
                          //           child: InkWell(
                          //             onTap: () {
                          //               print("3 ve üstü resim");
                          //               Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => Resiminceleme(
                          //                     veri1: resimler,
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //             child: ClipRRect(
                          //               borderRadius: BorderRadius.circular(10),
                          //               child: Stack(
                          //                 alignment: Alignment.center,
                          //                 children: [
                          //                   ColorFiltered(
                          //                     colorFilter:
                          //                         ColorFilter.srgbToLinearGamma(),
                          //                     child: Image.network(
                          //                       resimler[1],
                          //                       fit: BoxFit.cover,
                          //                       filterQuality: FilterQuality.high,
                          //                     ),
                          //                   ),
                          //                   Text(
                          //                     "+ ${resimler.length - 1}",
                          //                     style: TextStyle(
                          //                       color: Colors.white,
                          //                       fontSize: 20,
                          //                       fontWeight: FontWeight.bold,
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),

                          // burası videolu görünümünün denendigi yer.

                          // ilk if de sıkıntı yok sorun ilk if i okuduktan sonra
                          // diger if ide okumaya çalısıyor boylece video yu
                          // Image'in (Image.network) içine koymaya çalışıyor ve
                          // hata alıyoruz. fonksiyon ile çözüldü.

                          // fonksiyon içinde deneme. // burası çalışıyor.
                          // uygulama bazen kendi kendine kapanıyor.
                          // video işlemleri ile alakalı.

                          if (paylasimtip == "video/x-matroska")
                            Text("-- Video --"),

                          // if (paylasimtip == "video/x-matroska") galerivideo(),

                          if (paylasimtip == "image/jpeg" ||
                              paylasimtip == "image/png")
                            galeriresim(),

                          // if (paylasimtip == "video/x-matroska")
                          //   Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 10, right: 10, top: 10, bottom: 10),
                          //     child: BetterPlayer.network(
                          //       "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                          //       betterPlayerConfiguration:
                          //           BetterPlayerConfiguration(
                          //         aspectRatio: 19 / 9,
                          //         fit: BoxFit.contain,
                          //       ),
                          //     ),
                          //   ),

                          // if (resimler.length == 1)
                          //   Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 10, right: 10, top: 10, bottom: 10),
                          //     child: InkWell(
                          //       onTap: () {
                          //         print("1 resim");
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => Resiminceleme(
                          //               veri1: resimler,
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //       child: Row(
                          //         children: [
                          //           Flexible(
                          //             child: ClipRRect(
                          //               borderRadius: BorderRadius.circular(10),
                          //               child: Image.network(
                          //                 resimler[0],
                          //                 fit: BoxFit.cover,
                          //                 filterQuality: FilterQuality.high,
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // if (resimler.length == 2)
                          //   Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 10, right: 10, top: 10, bottom: 10),
                          //     child: Row(
                          //       children: [
                          //         Flexible(
                          //           child: InkWell(
                          //             onTap: () {
                          //               print("2 resim");
                          //               Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => Resiminceleme(
                          //                     veri1: resimler,
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //             child: ClipRRect(
                          //               borderRadius: BorderRadius.circular(10),
                          //               child: Image.network(
                          //                 resimler[0],
                          //                 fit: BoxFit.cover,
                          //                 filterQuality: FilterQuality.high,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         SizedBox(width: screenwidth / 35),
                          //         Flexible(
                          //           child: InkWell(
                          //             onTap: () {
                          //               print("2 resim");
                          //               Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => Resiminceleme(
                          //                     veri1: resimler,
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //             child: ClipRRect(
                          //               borderRadius: BorderRadius.circular(10),
                          //               child: Image.network(
                          //                 resimler[1],
                          //                 fit: BoxFit.cover,
                          //                 filterQuality: FilterQuality.high,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // if (resimler.length > 2)
                          //   Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 10, right: 10, top: 10, bottom: 10),
                          //     child: Row(
                          //       children: [
                          //         Flexible(
                          //           child: InkWell(
                          //             onTap: () {
                          //               print("3 ve üstü resim");
                          //               Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => Resiminceleme(
                          //                     veri1: resimler,
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //             child: ClipRRect(
                          //               borderRadius: BorderRadius.circular(10),
                          //               child: Image.network(
                          //                 resimler[0],
                          //                 fit: BoxFit.cover,
                          //                 filterQuality: FilterQuality.high,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         SizedBox(width: screenwidth / 35),
                          //         Flexible(
                          //           child: InkWell(
                          //             onTap: () {
                          //               print("3 ve üstü resim");
                          //               Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => Resiminceleme(
                          //                     veri1: resimler,
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //             child: ClipRRect(
                          //               borderRadius: BorderRadius.circular(10),
                          //               child: Stack(
                          //                 alignment: Alignment.center,
                          //                 children: [
                          //                   ColorFiltered(
                          //                     colorFilter:
                          //                         ColorFilter.srgbToLinearGamma(),
                          //                     child: Image.network(
                          //                       resimler[1],
                          //                       fit: BoxFit.cover,
                          //                       filterQuality: FilterQuality.high,
                          //                     ),
                          //                   ),
                          //                   Text(
                          //                     "+ ${resimler.length - 1}",
                          //                     style: TextStyle(
                          //                       color: Colors.white,
                          //                       fontSize: 20,
                          //                       fontWeight: FontWeight.bold,
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),

                          // if (detaylar[0]["paylasimfoto"] != null)
                          //   if (detaylar[0]["paylasimfoto"][0]
                          //           ["paylasimkategori"] ==
                          //       "video/x-matroska")
                          //     Text(gonderifotolar[0]["paylasimkategori"]),

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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Row(children: [
                                    Text(widget.veri5),
                                    Text(
                                      "  Beğeni",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ]),
                                ),
                                Container(
                                  child: Row(children: [
                                    Text(widget.veri6),
                                    Text(
                                      "  Yorum",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ]),
                                ),
                                Container(
                                  child: Row(children: [
                                    Text(widget.veri7),
                                    Text(
                                      "  Repost",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ]),
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
                                    print(widget.veri13);
                                    print(widget.veri13.runtimeType);
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
                                // LikeButton(
                                //   onTap: (bool isComment) {
                                //     return onCommentButtonTapped(isComment);
                                //   },
                                //   countPostion: CountPostion.right,
                                //   isLiked: widget.veri13 != 0 ? true : false,
                                //   // likeCount: int.parse(widget.veri6),
                                //   likeBuilder: (bool isComment) {
                                //     return isComment
                                //         ? Icon(
                                //             Icons.chat_bubble,
                                //             color: Colors.blue,
                                //           )
                                //         : Icon(
                                //             Icons.chat_bubble_outline,
                                //             color: Colors.grey,
                                //           );
                                //   },
                                //   bubblesColor: BubblesColor(
                                //     dotPrimaryColor: Colors.red,
                                //     dotSecondaryColor: Colors.blue,
                                //   ),
                                // ),
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
                          // Yorum
                          Divider(),

                          // Container(
                          //   child: yorumlar != null
                          //       ? ListView.separated(
                          //           controller: yorumController,
                          //           padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          //           shrinkWrap: true,
                          //           scrollDirection: Axis.vertical,
                          //           itemBuilder: (context, index) {
                          //             return Column(
                          //               children: [
                          //                 ListTile(
                          //                   leading: CircleAvatar(
                          //                     radius: screenwidth / 12,
                          //                     backgroundImage: NetworkImage(
                          //                       yorumlar[index]
                          //                           ["yorumcuminnakavatar"],
                          //                     ),
                          //                     backgroundColor: Colors.transparent,
                          //                   ),
                          //                   title: Row(
                          //                     children: [
                          //                       Text(yorumlar[index]
                          //                           ["yorumcuadsoyad"]),
                          //                       Text(
                          //                         "  -  " +
                          //                             yorumlar[index]
                          //                                 ["yorumcuzaman"],
                          //                         style: TextStyle(fontSize: 12),
                          //                       ),
                          //                       Spacer(),
                          //                       InkWell(
                          //                         onTap: () {
                          //                           showModalBottomSheet<void>(
                          //                             context: context,
                          //                             builder:
                          //                                 (BuildContext context) {
                          //                               return Wrap(
                          //                                 children: [
                          //                                   Container(
                          //                                     child: Column(
                          //                                       children: [
                          //                                         Padding(
                          //                                           padding: EdgeInsets
                          //                                               .symmetric(
                          //                                                   vertical:
                          //                                                       10),
                          //                                           child:
                          //                                               Container(
                          //                                             decoration:
                          //                                                 BoxDecoration(
                          //                                               color: Colors
                          //                                                       .grey[
                          //                                                   900],
                          //                                               borderRadius:
                          //                                                   BorderRadius
                          //                                                       .all(
                          //                                                 Radius.circular(
                          //                                                     30),
                          //                                               ),
                          //                                             ),
                          //                                             width:
                          //                                                 screenwidth /
                          //                                                     4,
                          //                                             height: 5,
                          //                                           ),
                          //                                         ),
                          //                                         InkWell(
                          //                                           onTap: () {
                          //                                             Navigator.pop(
                          //                                                 context);
                          //                                           },
                          //                                           child:
                          //                                               ListTile(
                          //                                             leading: Icon(
                          //                                                 Icons
                          //                                                     .post_add),
                          //                                             title: Text(
                          //                                                 "Yorumu favorilere ekle."),
                          //                                           ),
                          //                                         ),
                          //                                         Visibility(
                          //                                           visible: widget
                          //                                                       .veri11 ==
                          //                                                   girisdata[
                          //                                                       "oyuncuID"]
                          //                                               ? true
                          //                                               : false,
                          //                                           child:
                          //                                               InkWell(
                          //                                             onTap: () {
                          //                                               postID =
                          //                                                   widget
                          //                                                       .veri10;
                          //                                               // postsil();
                          //                                               Navigator.pop(
                          //                                                   context);
                          //                                             },
                          //                                             child:
                          //                                                 ListTile(
                          //                                               leading: Icon(
                          //                                                   Icons
                          //                                                       .edit_note),
                          //                                               title: Text(
                          //                                                   "Yorumu düzenle."),
                          //                                             ),
                          //                                           ),
                          //                                         ),
                          //                                         Visibility(
                          //                                           visible: widget
                          //                                                       .veri11 ==
                          //                                                   girisdata[
                          //                                                       "oyuncuID"]
                          //                                               ? true
                          //                                               : false,
                          //                                           child:
                          //                                               InkWell(
                          //                                             onTap: () {
                          //                                               // postID = widget.veri10;
                          //                                               // postsil();
                          //                                               Navigator.pop(
                          //                                                   context);
                          //                                             },
                          //                                             child:
                          //                                                 ListTile(
                          //                                               leading: Icon(
                          //                                                   Icons
                          //                                                       .delete_sweep_outlined),
                          //                                               title: Text(
                          //                                                   "Yorumu kaldır."),
                          //                                             ),
                          //                                           ),
                          //                                         ),
                          //                                         Divider(),
                          //                                         InkWell(
                          //                                           onTap: () {
                          //                                             Navigator.pop(
                          //                                                 context);
                          //                                           },
                          //                                           child:
                          //                                               ListTile(
                          //                                             leading: Icon(
                          //                                                 Icons
                          //                                                     .flag_outlined),
                          //                                             title: Text(
                          //                                                 "Yorumu bildir."),
                          //                                           ),
                          //                                         ),
                          //                                         SizedBox(
                          //                                             height: 10),
                          //                                       ],
                          //                                     ),
                          //                                   ),
                          //                                 ],
                          //                               );
                          //                             },
                          //                           );
                          //                         },
                          //                         child: Icon(
                          //                           Icons.more_vert,
                          //                           size: 15,
                          //                           // color: Colors.grey,
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                   subtitle: Text(
                          //                     yorumlar[index]["yorumcuicerik"],
                          //                   ),
                          //                   // contentPadding: EdgeInsets.symmetric(vertical: 10),
                          //                 ),
                          //                 Container(
                          //                   color: Colors.transparent,
                          //                   width: screenwidth,
                          //                   height: screenheight / 20,
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.spaceEvenly,
                          //                     children: [
                          //                       Row(
                          //                         children: [
                          //                           IconButton(
                          //                             onPressed: () {},
                          //                             icon: Icon(
                          //                               Icons.favorite_border,
                          //                               color: Colors.grey,
                          //                               size: 19,
                          //                             ),
                          //                             // icon: widget.veri9 != 0
                          //                             //     ? Icon(
                          //                             //         Icons.favorite,
                          //                             //         color: Colors.red,
                          //                             //       )
                          //                             //     : Icon(
                          //                             //         Icons.favorite_border,
                          //                             //         color: Colors.grey,
                          //                             //       ),
                          //                           ),
                          //                           Text(
                          //                             yorumlar[index][
                          //                                         "yorumbegenisayi"] !=
                          //                                     "0"
                          //                                 ? yorumlar[index]
                          //                                     ["yorumbegenisayi"]
                          //                                 : "",
                          //                             style: TextStyle(
                          //                               fontSize: 12,
                          //                               color: Colors.grey,
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                       IconButton(
                          //                         onPressed: () {
                          //                           print("");
                          //                         },
                          //                         icon: Icon(
                          //                           Icons.chat_bubble_outline,
                          //                           color: Colors.grey,
                          //                           size: 19,
                          //                         ),
                          //                       ),
                          //                       IconButton(
                          //                         onPressed: () {
                          //                           Share.share(
                          //                             yorumlar[index]
                          //                                 ["yorumcuicerik"],
                          //                           );
                          //                         },
                          //                         icon: Icon(
                          //                           Icons.share_outlined,
                          //                           color: Colors.grey,
                          //                           size: 19,
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ],
                          //             );
                          //           },
                          //           separatorBuilder: (context, index) {
                          //             return Divider();
                          //           },
                          //           itemCount: yorumlar.length,
                          //         )
                          //       : Center(
                          //           child: Text(
                          //             "Henüz Yorum Yapılmamış !",
                          //             textAlign: TextAlign.center,
                          //             style: TextStyle(
                          //               fontSize: 24,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           ),
                          //         ),
                          // ),

                          // FutureBuilder(
                          //   initialData: CircularProgressIndicator(),
                          //   future: yorumcek(),
                          //   builder: (BuildContext context,
                          //       AsyncSnapshot<dynamic> snapshot) {
                          //     return Container(
                          //       child: yorumlar != null
                          //           ? ListView.separated(
                          //               controller: yorumController,
                          //               padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          //               shrinkWrap: true,
                          //               scrollDirection: Axis.vertical,
                          //               itemBuilder: (context, index) {
                          //                 return Column(
                          //                   children: [
                          //                     ListTile(
                          //                       leading: CircleAvatar(
                          //                         radius: screenwidth / 12,
                          //                         backgroundImage: NetworkImage(
                          //                           yorumlar[index]
                          //                               ["yorumcuminnakavatar"],
                          //                         ),
                          //                         backgroundColor:
                          //                             Colors.transparent,
                          //                       ),
                          //                       title: Row(
                          //                         children: [
                          //                           Text(yorumlar[index]
                          //                               ["yorumcuadsoyad"]),
                          //                           Text(
                          //                             "  -  " +
                          //                                 yorumlar[index]
                          //                                     ["yorumcuzaman"],
                          //                             style:
                          //                                 TextStyle(fontSize: 12),
                          //                           ),
                          //                           Spacer(),
                          //                           InkWell(
                          //                             onTap: () {
                          //                               showModalBottomSheet<
                          //                                   void>(
                          //                                 context: context,
                          //                                 builder: (BuildContext
                          //                                     context) {
                          //                                   return Wrap(
                          //                                     children: [
                          //                                       Container(
                          //                                         child: Column(
                          //                                           children: [
                          //                                             Padding(
                          //                                               padding: EdgeInsets.symmetric(
                          //                                                   vertical:
                          //                                                       10),
                          //                                               child:
                          //                                                   Container(
                          //                                                 decoration:
                          //                                                     BoxDecoration(
                          //                                                   color:
                          //                                                       Colors.grey[900],
                          //                                                   borderRadius:
                          //                                                       BorderRadius.all(
                          //                                                     Radius.circular(30),
                          //                                                   ),
                          //                                                 ),
                          //                                                 width:
                          //                                                     screenwidth /
                          //                                                         4,
                          //                                                 height:
                          //                                                     5,
                          //                                               ),
                          //                                             ),
                          //                                             InkWell(
                          //                                               onTap:
                          //                                                   () {
                          //                                                 Navigator.pop(
                          //                                                     context);
                          //                                               },
                          //                                               child:
                          //                                                   ListTile(
                          //                                                 leading:
                          //                                                     Icon(Icons.post_add),
                          //                                                 title: Text(
                          //                                                     "Yorumu favorilere ekle."),
                          //                                               ),
                          //                                             ),
                          //                                             Visibility(
                          //                                               visible: widget.veri11 ==
                          //                                                       girisdata["oyuncuID"]
                          //                                                   ? true
                          //                                                   : false,
                          //                                               child:
                          //                                                   InkWell(
                          //                                                 onTap:
                          //                                                     () {
                          //                                                   postID =
                          //                                                       widget.veri10;
                          //                                                   // postsil();
                          //                                                   Navigator.pop(
                          //                                                       context);
                          //                                                 },
                          //                                                 child:
                          //                                                     ListTile(
                          //                                                   leading:
                          //                                                       Icon(Icons.edit_note),
                          //                                                   title:
                          //                                                       Text("Yorumu düzenle."),
                          //                                                 ),
                          //                                               ),
                          //                                             ),
                          //                                             Visibility(
                          //                                               visible: widget.veri11 ==
                          //                                                       girisdata["oyuncuID"]
                          //                                                   ? true
                          //                                                   : false,
                          //                                               child:
                          //                                                   InkWell(
                          //                                                 onTap:
                          //                                                     () {
                          //                                                   // postID = widget.veri10;
                          //                                                   // postsil();
                          //                                                   Navigator.pop(
                          //                                                       context);
                          //                                                 },
                          //                                                 child:
                          //                                                     ListTile(
                          //                                                   leading:
                          //                                                       Icon(Icons.delete_sweep_outlined),
                          //                                                   title:
                          //                                                       Text("Yorumu kaldır."),
                          //                                                 ),
                          //                                               ),
                          //                                             ),
                          //                                             Divider(),
                          //                                             InkWell(
                          //                                               onTap:
                          //                                                   () {
                          //                                                 Navigator.pop(
                          //                                                     context);
                          //                                               },
                          //                                               child:
                          //                                                   ListTile(
                          //                                                 leading:
                          //                                                     Icon(Icons.flag_outlined),
                          //                                                 title: Text(
                          //                                                     "Yorumu bildir."),
                          //                                               ),
                          //                                             ),
                          //                                             SizedBox(
                          //                                                 height:
                          //                                                     10),
                          //                                           ],
                          //                                         ),
                          //                                       ),
                          //                                     ],
                          //                                   );
                          //                                 },
                          //                               );
                          //                             },
                          //                             child: Icon(
                          //                               Icons.more_vert,
                          //                               size: 15,
                          //                               // color: Colors.grey,
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                       subtitle: Text(
                          //                         yorumlar[index]
                          //                             ["yorumcuicerik"],
                          //                       ),
                          //                       // contentPadding: EdgeInsets.symmetric(vertical: 10),
                          //                     ),
                          //                     Container(
                          //                       color: Colors.transparent,
                          //                       width: screenwidth,
                          //                       height: screenheight / 20,
                          //                       child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment
                          //                                 .spaceEvenly,
                          //                         children: [
                          //                           Row(
                          //                             children: [
                          //                               IconButton(
                          //                                 onPressed: () {},
                          //                                 icon: Icon(
                          //                                   Icons.favorite_border,
                          //                                   color: Colors.grey,
                          //                                   size: 19,
                          //                                 ),
                          //                                 // icon: widget.veri9 != 0
                          //                                 //     ? Icon(
                          //                                 //         Icons.favorite,
                          //                                 //         color: Colors.red,
                          //                                 //       )
                          //                                 //     : Icon(
                          //                                 //         Icons.favorite_border,
                          //                                 //         color: Colors.grey,
                          //                                 //       ),
                          //                               ),
                          //                               Text(
                          //                                 yorumlar[index][
                          //                                             "yorumbegenisayi"] !=
                          //                                         "0"
                          //                                     ? yorumlar[index][
                          //                                         "yorumbegenisayi"]
                          //                                     : "",
                          //                                 style: TextStyle(
                          //                                   fontSize: 12,
                          //                                   color: Colors.grey,
                          //                                 ),
                          //                               ),
                          //                             ],
                          //                           ),
                          //                           IconButton(
                          //                             onPressed: () {
                          //                               print("");
                          //                             },
                          //                             icon: Icon(
                          //                               Icons.chat_bubble_outline,
                          //                               color: Colors.grey,
                          //                               size: 19,
                          //                             ),
                          //                           ),
                          //                           IconButton(
                          //                             onPressed: () {
                          //                               Share.share(
                          //                                 yorumlar[index]
                          //                                     ["yorumcuicerik"],
                          //                               );
                          //                             },
                          //                             icon: Icon(
                          //                               Icons.share_outlined,
                          //                               color: Colors.grey,
                          //                               size: 19,
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 );
                          //               },
                          //               separatorBuilder: (context, index) {
                          //                 return Divider();
                          //               },
                          //               itemCount: yorumlar.length,
                          //             )
                          //           : Center(
                          //               child: Text(
                          //                 "Henüz Yorum Yapılmamış !",
                          //                 textAlign: TextAlign.center,
                          //                 style: TextStyle(
                          //                   fontSize: 24,
                          //                   fontWeight: FontWeight.bold,
                          //                 ),
                          //               ),
                          //             ),
                          //     );
                          //   },
                          // ),

                          // FutureBuilder<String>(
                          //   future:
                          //       _calculation, // a previously-obtained Future<String> or null
                          //   builder: (BuildContext context,
                          //       AsyncSnapshot<String> snapshot) {
                          //     List<Widget> children;
                          //     if (snapshot.hasData) {
                          //       children = <Widget>[
                          //         const Icon(
                          //           Icons.check_circle_outline,
                          //           color: Colors.green,
                          //           size: 60,
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(top: 16),
                          //           child: Text('Result: ${snapshot.data}'),
                          //         )
                          //       ];
                          //     } else if (snapshot.hasError) {
                          //       children = <Widget>[
                          //         const Icon(
                          //           Icons.error_outline,
                          //           color: Colors.red,
                          //           size: 60,
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(top: 16),
                          //           child: Text('Error: ${snapshot.error}'),
                          //         )
                          //       ];
                          //     } else {
                          //       children = const <Widget>[
                          //         SizedBox(
                          //           width: 60,
                          //           height: 60,
                          //           child: CircularProgressIndicator(),
                          //         ),
                          //         Padding(
                          //           padding: EdgeInsets.only(top: 16),
                          //           child: Text('Awaiting result...'),
                          //         )
                          //       ];
                          //     }
                          //     return Center(
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: children,
                          //       ),
                          //     );
                          //   },
                          // ),

                          for (int i = 0; i < yorumlar.length; i++)
                            Column(
                              children: [
                                ListTile(
                                  leading: InkWell(
                                    borderRadius:
                                        BorderRadius.circular(screenwidth / 12),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ThemeConsumer(
                                            child: MyProfile(
                                              veri1: yorumlar[i]["yorumcuid"],
                                              // veri2: widget.veri1,
                                              // // veri2: "parkaresimufak",
                                              // veri3: widget.veri1,
                                              // veri4: "kullaniciadi",
                                              // veri5: "hakkimda",
                                              // veri6: "ulkesi",
                                              // veri7: "kayittarihikısa",
                                              // veri8: girisdata["oyuncuID"],
                                            ),
                                            // child: ProfileDeneme(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: screenwidth / 12,
                                      backgroundImage: NetworkImage(
                                        yorumlar[i]["yorumcuminnakavatar"],
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(yorumlar[i]["yorumcuadsoyad"]),
                                      Text(
                                        "  -  " + yorumlar[i]["yorumcuzaman"],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Wrap(
                                                children: [
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[900],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    30),
                                                              ),
                                                            ),
                                                            width:
                                                                screenwidth / 4,
                                                            height: 5,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: ListTile(
                                                            leading: Icon(
                                                                Icons.post_add),
                                                            title: Text(
                                                                "Yorumu favorilere ekle."),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: widget
                                                                      .veri11 ==
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
                                                            child: ListTile(
                                                              leading: Icon(Icons
                                                                  .edit_note),
                                                              title: Text(
                                                                  "Yorumu düzenle."),
                                                            ),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: widget
                                                                      .veri11 ==
                                                                  girisdata[
                                                                      "oyuncuID"]
                                                              ? true
                                                              : false,
                                                          child: InkWell(
                                                            onTap: () {
                                                              // postID = widget.veri10;
                                                              // postsil();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: ListTile(
                                                              leading: Icon(Icons
                                                                  .delete_sweep_outlined),
                                                              title: Text(
                                                                  "Yorumu kaldır."),
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: ListTile(
                                                            leading: Icon(Icons
                                                                .flag_outlined),
                                                            title: Text(
                                                                "Yorumu bildir."),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(
                                          Icons.more_vert,
                                          size: 15,
                                          // color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // subtitle: Text(
                                  //   yorumlar[i]["yorumcuicerik"],
                                  // ),
                                  subtitle: DetectableText(
                                    detectionRegExp: RegExp(r"@(\w+)|#(\w+)"),
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
                                  // contentPadding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  width: screenwidth,
                                  height: screenheight / 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.favorite_border,
                                              color: Colors.grey,
                                              size: 19,
                                            ),
                                            // icon: widget.veri9 != 0
                                            //     ? Icon(
                                            //         Icons.favorite,
                                            //         color: Colors.red,
                                            //       )
                                            //     : Icon(
                                            //         Icons.favorite_border,
                                            //         color: Colors.grey,
                                            //       ),
                                          ),
                                          Text(
                                            yorumlar[i]["yorumbegenisayi"] !=
                                                    "0"
                                                ? yorumlar[i]["yorumbegenisayi"]
                                                : "",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          print("");
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
                              Icon(
                                Icons.radio_button_checked,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(height: 100),

                          // yorumcuzaman: "2022-06-13 22:52:29",
                          // Text(
                          //   yorumlar[i] != null ? yorumlar[i] : "",
                          // ),
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
                    // color: Colors.grey[850],
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                      child: DetectableTextField(
                        detectionRegExp: RegExp(r"@(\w+)|#(\w+)"),
                        controller: yorum,
                        maxLength: 150,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(
                              r"[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQXZÇŞĞÜÖİçşğüöı0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*# ]",
                              //r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
                              caseSensitive: true,
                              unicode: true,
                              dotAll: true,
                            ),
                          ),
                        ],
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          counterText: "",
                          hintText: "Yorum Yap",
                          suffixIcon: IconButton(
                            onPressed: () {
                              postID = widget.veri10;

                              if (yorum.text.isNotEmpty) {
                                postyorum();
                                yorum.clear();
                                yorumlar.clear();
                                Future.delayed(Duration(milliseconds: 100), () {
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
                                  ),
                                );
                              }
                            },
                            icon: Icon(Icons.send),
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
    );
  }
}
