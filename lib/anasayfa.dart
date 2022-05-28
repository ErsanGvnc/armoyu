// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors, avoid_print, unused_import, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, curly_braces_in_flow_control_structures, prefer_if_null_operators

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jsonekleme/anadetail.dart';
import 'package:jsonekleme/detail.dart';
import 'package:jsonekleme/fotoicerik.dart';
import 'package:jsonekleme/login.dart';
import 'package:jsonekleme/main.dart';
import 'package:jsonekleme/sabit.dart';
import 'package:share_plus/share_plus.dart';

class AnaSayfa extends StatefulWidget {
  @override
  AnaSayfaState createState() => AnaSayfaState();
}

class AnaSayfaState extends State<AnaSayfa> {
  @override
  void initState() {
    super.initState();
    gondericek();
  }

  gondericek() async {
    var gelen = await http.get(
      Uri.parse(gonderiurl),
    );
    dataanasayfa = jsonDecode(gelen.body);
    setState(() {});
  }

  gonderifotocek() {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    if (gonderifotolar.length == 1) {
      return Row(
        children: [
          Flexible(
            child: Image.network(
              gonderifotolar[0]["fotourl"],
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
        ],
      );
    } else if (gonderifotolar.length == 2) {
      return Row(
        children: [
          Flexible(
            child: Image.network(
              gonderifotolar[0]["fotourl"],
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Flexible(
            child: Image.network(
              gonderifotolar[1]["fotourl"],
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
        ],
      );
    } else if (gonderifotolar.length > 2) {
      return Row(
        children: [
          Flexible(
            child: Image.network(
              gonderifotolar[0]["fotourl"],
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          SizedBox(width: screenwidth / 35),
          Flexible(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.srgbToLinearGamma(),
                  child: Image.network(
                    gonderifotolar[1]["fotourl"],
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Text(
                  "+ ${gonderifotolar.length - 1}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    Future<void> _refresh() {
      return gondericek();
    }

    var postsildengiden;

    var postID;

    postsil() {
      http.post(
        Uri.parse(
          "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/sil/0/0/",
        ),
        body: {
          "postID": postID,
        },
      ).then((cevap) {
        print(cevap.statusCode);
        print(cevap.body);
        setState(() {
          postsildengiden = cevap.body;
        });
      });
      print("post");
      print(
          "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/sil/0/0/");
    }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    postlike() {
      http.post(
        Uri.parse(
          "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/begen/0/0/",
        ),
        body: {
          "postID": postID,
        },
      ).then((cevap) {
        print(cevap.statusCode);
        print(cevap.body);
        setState(() {
          postsildengiden = cevap.body;
        });
      });
      print("post");
      print(
          "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/begen/0/0/");
    }

    // final items = List<int>.generate(10, (i) => i);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Container(
        child: dataanasayfa != null
            ? ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (dataanasayfa[index]["paylasimfoto"] != null) {
                    gonderifotolar = dataanasayfa[index]["paylasimfoto"];
                    // alttaki printin çıktısına bak orda foto ıd leride var.
                    print("-----$gonderifotolar");
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
                            veri1: dataanasayfa[index]["sahipavatar"],
                            veri2: dataanasayfa[index]["sahipad"],
                            veri3: dataanasayfa[index]["sosyalicerik"],
                            veri4: dataanasayfa[index]["paylasimzaman"],
                            veri5: dataanasayfa[index]["begenisay"],
                            veri6: dataanasayfa[index]["yorumsay"],
                            veri7: dataanasayfa[index]["repostsay"],
                            veri8: dataanasayfa[index]["sikayetsay"],
                            // veri9: gonderifotolar[index]["fotourl"] != null
                            //     ? gonderifotolar[index]["fotourl"]
                            //     : "https://aramizdakioyuncu.com/galeri/ana-yapi/armoyu64.png",
                          ),
                        ),
                      );
                      print("gelmeden: $gonderifotolar");
                    },
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: screenwidth / 12,
                            backgroundImage: NetworkImage(
                              dataanasayfa[index]["sahipavatar"],
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
                                      dataanasayfa[index]["sahipad"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "  -  " +
                                          dataanasayfa[index]
                                              ["paylasimzamangecen"],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Visibility(
                                      visible: dataanasayfa[index]["sahipID"] ==
                                              girisdata["oyuncuID"]
                                          ? true
                                          : false,
                                      child: InkWell(
                                        onTap: () {
                                          print(dataanasayfa[index]["sahipID"]);
                                          print(girisdata["oyuncuID"]);
                                          postID =
                                              dataanasayfa[index]["postID"];
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
                                SizedBox(height: screenheight / 90),
                                Text(
                                  dataanasayfa[index]["sosyalicerik"],
                                ),
                                SizedBox(height: screenheight / 50),
                                Visibility(
                                  visible: visible,
                                  child: Container(
                                    child: gonderifotocek(),
                                  ),
                                ),

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
                                        onTap: () {
                                          // burası beğeni için yapılcak yer postid nin index ine başka bir yerden ulaşamadık.
                                          // print(gonderibegeni);
                                          // String gonderibegeniyollananic =
                                          //     dataanasayfa[index]["postID"];
                                          // print(dataanasayfa[index]["postID"]);

                                          postID =
                                              dataanasayfa[index]["postID"];
                                          postlike();
                                          print(
                                              "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/begen/0/0/");
                                          print(
                                              "--------------------------------" +
                                                  dataanasayfa[index]
                                                          ["benbegendim"]
                                                      .toString());
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              (dataanasayfa[index]
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
                                              (dataanasayfa[index]
                                                          ["begenisay"] !=
                                                      "0")
                                                  ? Text(
                                                      dataanasayfa[index]
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
                                              (dataanasayfa[index]
                                                          ["yorumsay"] !=
                                                      "0")
                                                  ? Text(
                                                      dataanasayfa[index]
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
                                              (dataanasayfa[index]
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
                                            dataanasayfa[index]["sosyalicerik"],
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
                itemCount: dataanasayfa.length,
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
                itemBuilder: (context, index) => NewsCardSkelton(),
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: 10,
              ),
      ),
      // child: Container(
      //   child: dataanasayfa != null
      //       ? ListView.separated(
      //           physics: BouncingScrollPhysics(),
      //           scrollDirection: Axis.vertical,
      //           itemBuilder: (context, index) {
      //             //return NewsCardSkelton();
      //             return InkWell(
      //               onTap: () {},
      //               child: Container(),
      //             );
      //           },
      //           separatorBuilder: (context, index) =>
      //               SizedBox(height: screenheight / 100),
      //           itemCount: 15,
      //         )
      //       : ListView.separated(
      //           physics: BouncingScrollPhysics(),
      //           scrollDirection: Axis.vertical,
      //           itemBuilder: (context, index) => NewsCardSkelton(),
      //           separatorBuilder: (context, index) => SizedBox(height: 5),
      //           itemCount: 10,
      //         ),
      // ),
    );
  }
}
