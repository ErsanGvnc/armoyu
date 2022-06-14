// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors, avoid_print, unused_import, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, curly_braces_in_flow_control_structures, prefer_if_null_operators, prefer_typing_uninitialized_variables, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:math';
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ],
      );
    } else if (gonderifotolar.length == 2) {
      return Row(
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                gonderifotolar[1]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ],
      );
    } else if (gonderifotolar.length > 2) {
      return Row(
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          SizedBox(width: screenwidth / 35),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.srgbToLinearGamma(),
                    child: Image.network(
                      gonderifotolar[1]["fotoufakurl"],
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    postlike() {
      // like işleminin direk ekranda görünmesi için, http.post işlemi komple setState((){}) içine alınabilir. / denendi olmadı. / butona basınca
      // setstate içinde gondericek(); fonksiyonu çağrılıyor.
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

    // final items = List<int>.generate(10, (i) => i);

    return RefreshIndicator(
      onRefresh: _refresh,
      // child: ConnectivityResult != ConnectivityResult.none
      //     ?
      child: Container(
        child: dataanasayfa != null
            ? ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (dataanasayfa[index]["paylasimfoto"] != null) {
                    gonderifotolar = dataanasayfa[index]["paylasimfoto"];
                    // alttaki printin çıktısına bak orda foto ıd leride var.
                    // print("-----$gonderifotolar");
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
                            veri9: dataanasayfa[index]["benbegendim"],
                            veri10: dataanasayfa[index]["postID"],
                            veri11: dataanasayfa[index]["sahipID"],
                            veri12: dataanasayfa[index]["paylasimnereden"],
                            // veri12: dataanasayfa[index]["paylasimfoto"][0]
                            //     ["fotoufakurl"],

                            // veri9: gonderifotolar[index]["fotourl"] != null
                            //     ? gonderifotolar[index]["fotourl"]
                            //     : "https://aramizdakioyuncu.com/galeri/ana-yapi/armoyu64.png",
                          ),
                        ),
                      );

                      setState(() {
                        yorumid = dataanasayfa[index]["postID"];
                        // print(detaylink);
                        detaylink =
                            "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$yorumid/&postislem=yorumlarim";
                      });
                    },
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: screenwidth / 12,
                            backgroundImage: NetworkImage(
                              dataanasayfa[index]["sahipavatarminnak"],
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
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: Icon(
                                    //     Icons.more_vert,
                                    //     size: 20,
                                    //     color: Colors.grey,
                                    //   ),
                                    // ),
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
                                                              "Postu favorilere ekle."),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: dataanasayfa[
                                                                        index][
                                                                    "sahipID"] ==
                                                                girisdata[
                                                                    "oyuncuID"]
                                                            ? true
                                                            : false,
                                                        child: InkWell(
                                                          onTap: () {
                                                            postID =
                                                                dataanasayfa[
                                                                        index]
                                                                    ["postID"];
                                                            // postsil();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: ListTile(
                                                            leading: Icon(Icons
                                                                .edit_note),
                                                            title: Text(
                                                                "Postu düzenle."),
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: dataanasayfa[
                                                                        index][
                                                                    "sahipID"] ==
                                                                girisdata[
                                                                    "oyuncuID"]
                                                            ? true
                                                            : false,
                                                        child: InkWell(
                                                          onTap: () {
                                                            postID =
                                                                dataanasayfa[
                                                                        index]
                                                                    ["postID"];
                                                            postsil();
                                                            Navigator.pop(
                                                                context);
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
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: ListTile(
                                                          leading: Icon(Icons
                                                              .flag_outlined),
                                                          title: Text(
                                                              "Postu bildir."),
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
                                        size: 20,
                                        // color: Colors.grey,
                                      ),
                                    ),
                                    // Visibility(
                                    //   visible: dataanasayfa[index]["sahipID"] ==
                                    //           girisdata["oyuncuID"]
                                    //       ? true
                                    //       : false,
                                    //   child: InkWell(
                                    //     onTap: () {
                                    //       postID =
                                    //           dataanasayfa[index]["postID"];
                                    //       postsil();
                                    //     },
                                    //     child: Icon(
                                    //       Icons.more_vert,
                                    //       size: 20,
                                    //       color: Colors.grey,
                                    //     ),
                                    //   ),
                                    // ),
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
                                          postID =
                                              dataanasayfa[index]["postID"];
                                          postlike();

                                          setState(() {
                                            gondericek();
                                          });
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
      // : Center(
      //     child: InkWell(
      //       onTap: (() => print(ConnectivityResult)),
      //       child: Text(
      //         "İnternet Bağlantınızı Kontrol Ediniz !",
      //         textAlign: TextAlign.center,
      //         style: TextStyle(
      //           fontSize: 32,
      //         ),
      //       ),
      //     ),
      //   ),

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
