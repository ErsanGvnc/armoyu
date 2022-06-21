// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, unused_import, must_be_immutable, avoid_print, library_private_types_in_public_api, unrelated_type_equality_checks, unused_element, unnecessary_null_comparison, prefer_if_null_operators, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jsonekleme/login.dart';
import 'package:jsonekleme/resiminceleme.dart';
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
    required this.veri12,
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
    }
    // print("detaylar: ");
    // print(detaylar);

    // print("resimler: ");
    // print(resimler);

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

  postyorum() {
    http.post(
      Uri.parse(
        "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/yorum/0/0/",
      ),
      // Uri.parse(
      //   "https://jsonplaceholder.typicode.com/posts",
      // ),
      body: {
        "yorumicerik": yorum.text,
        // "postID": postID,               emin değilim.
      },
    ).then((cevap) {
      print(cevap.statusCode);
      print(cevap.body);
      setState(() {
        yorumgonderdengelen = cevap.body;
      });
    });
    print("yorum");
    print(widget.veri10);
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Stack(
            children: [
              ListView(
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
                                  // color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                                  padding: EdgeInsets.symmetric(
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
                                                          girisdata["oyuncuID"]
                                                      ? true
                                                      : false,
                                                  child: InkWell(
                                                    onTap: () {
                                                      postID = widget.veri10;
                                                      // postsil();
                                                      Navigator.pop(context);
                                                    },
                                                    child: ListTile(
                                                      leading:
                                                          Icon(Icons.edit_note),
                                                      title: Text(
                                                          "Postu düzenle."),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: widget.veri11 ==
                                                          girisdata["oyuncuID"]
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
                                                      title:
                                                          Text("Postu kaldır."),
                                                    ),
                                                  ),
                                                ),
                                                Divider(),
                                                InkWell(
                                                  onTap: () {
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
                          child: Text(
                            widget.veri3,
                            style: TextStyle(
                              // color: Colors.white,
                              fontSize: 16,
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

                        for (int i = 0; i < resimler.length; i++)
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                resimler[i] != null
                                    ? resimler[i]
                                    : "https://aramizdakioyuncu.com/galeri/images/11orijinal11654971338.png",
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ),

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
                        //               veri1: resimler[0],
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
                        //                     veri1: resimler[0],
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
                        //                     veri1: resimler[0],
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
                        //               print(resimler.toString());
                        //               Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (context) => Resiminceleme(
                        //                     veri1: resimler[0],
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
                        //                     veri1: resimler[0],
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
                                widget.veri12 == "" ? "For Web" : "For Mobile",
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
                                onPressed: () {
                                  print("");
                                },
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
                        for (int i = 0; i < yorumlar.length; i++)
                          Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  radius: screenwidth / 12,
                                  backgroundImage: NetworkImage(
                                    yorumlar[i]["yorumcuminnakavatar"],
                                  ),
                                  backgroundColor: Colors.transparent,
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
                                subtitle: Text(
                                  yorumlar[i]["yorumcuicerik"],
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

              // Positioned(
              //   bottom: 0,
              //   width: screenwidth,
              //   child: Container(
              //     color: Colors.grey[850],
              //     child: Padding(
              //       padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
              //       child: TextField(
              //         controller: yorum,
              //         maxLength: 150,
              //         keyboardType: TextInputType.text,
              //         textInputAction: TextInputAction.next,
              //         inputFormatters: [
              //           FilteringTextInputFormatter.allow(
              //             RegExp(
              //               r"[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQXZÇŞĞÜÖİçşğüöı0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)* ]",
              //               //r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
              //               caseSensitive: true,
              //               unicode: true,
              //               dotAll: true,
              //             ),
              //           ),
              //         ],
              //         decoration: InputDecoration(
              //           border: UnderlineInputBorder(),
              //           counterText: "",
              //           hintText: "Yorum Yap",
              //           suffixIcon: IconButton(
              //             onPressed: () {
              //               if (yorum.text.isNotEmpty) {
              //                 // postyorum();
              //                 yorum.clear();
              //                 print("Yorum yapıldı !");
              //                 // ScaffoldMessenger.of(context).showSnackBar(
              //                 //   SnackBar(
              //                 //     content: Text("Yorum yapıldı ! " +
              //                 //         "${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
              //                 //   ),
              //                 // );
              //               } else {
              //                 print("Yorum boş olamaz !");
              //                 // ScaffoldMessenger.of(context).showSnackBar(
              //                 //   SnackBar(
              //                 //     content: Text("Yorum boş olamaz !"),
              //                 //   ),
              //                 // );
              //               }
              //             },
              //             icon: Icon(Icons.send),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
