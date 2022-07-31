// ignore_for_file: unused_local_variable, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, prefer_final_fields, sort_child_properties_last, avoid_print, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unnecessary_null_comparison, unused_element, must_be_immutable, file_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:armoyu/anadetail.dart';
import 'package:armoyu/login.dart';
import 'package:armoyu/main.dart';
import 'package:armoyu/resiminceleme.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:skeletons/skeletons.dart';
import 'package:theme_provider/theme_provider.dart';

class MyProfile extends StatefulWidget {
  String veri1;
  // veri2, veri3, veri4, veri5, veri6, veri7, veri8;

  MyProfile({
    required this.veri1,
    // required this.veri2,
    // required this.veri3,
    // required this.veri4,
    // required this.veri5,
    // required this.veri6,
    // required this.veri7,
    // required this.veri8,
  });

  @override
  State<MyProfile> createState() => _ProfileState();
}

class _ProfileState extends State<MyProfile> with TickerProviderStateMixin {
  List resimler = [];
  String paylasimtip = "";

  @override
  initState() {
    super.initState();
    profilcek();
    postcek();
    medyacek();
    // print(widget.veri1);
  }

  profilcek() async {
    http.post(
      Uri.parse(oturumkontrolurl),
      body: {
        "oyuncubakid": widget.veri1,
      },
    ).then((cevap) {
      setState(() {
        try {
          profiledata = jsonDecode(cevap.body);
        } catch (e) {
          print('Unknown exception: $e');
        }
      });
      // print(profiledata);
      // print(profiledata["adim"]);
      // print(profiledata["adim"].runtimeType);
    });
  }

  postcek() async {
    postdata.clear();
    http.post(
      Uri.parse(postlink),
      body: {
        "oyuncubakid": widget.veri1,
      },
    ).then((cevap) {
      setState(() {
        try {
          postdata = jsonDecode(cevap.body);
        } catch (e) {
          print('Unknown exception: $e');
        }
      });
    });
  }

  medyacek() async {
    medyadata.clear();
    http.post(
      Uri.parse(medyalink),
      body: {
        "oyuncubakid": widget.veri1,
      },
    ).then((cevap) {
      setState(() {
        try {
          medyadata = jsonDecode(cevap.body);
        } catch (e) {
          print('Unknown exception: $e');
        }
        if (medyadata != null) {
          for (var i = 0; i < medyadata.length; i++) {
            resimler.add(medyadata[i]["medyaufaklik"]);

            // print(medyadata[0]["medyaufaklik"]);
            // print(medyadata);
          }
        } else {
          print("resim yok");
        }
      });
    });
    // print(medyadata[0]["medyaufaklik"]);

    // if (detaylar[0]["paylasimfoto"] != null) {
    //   for (var i = 0; i < detaylar[0]["paylasimfoto"].length; i++) {
    //     resimler.add(detaylar[0]["paylasimfoto"][i]["fotoufakurl"]);
    //     // print(detaylar[0]["paylasimfoto"][i]["fotoufakurl"]);
    //   }
    //   paylasimtip = detaylar[0]["paylasimfoto"][0]["paylasimkategori"];
    //   // print("paylasimtip: ");
    //   // print(paylasimtip);
    // }
  }

  // reactioncek() async {
  //   var gelen = await http.get(
  //     // linki reactionlink ile değiştir.
  //     Uri.parse(medyalink),
  //   );
  //   try {
  //     reactiondata = jsonDecode(gelen.body);
  //   } catch (e) {
  //     print('Unknown exception: $e');
  //   }
  //   print(reactiondata);
  //   setState(() {});
  // }

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

  gonderifotocek() {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    // anasayfa video kısmı.

    if (gonderifotolar.length == 1 &&
        gonderifotolar[0]["paylasimkategori"] == "video/x-matroska") {
      return Text("-- Video --");
      // return Row(
      //   children: [
      //     Flexible(
      //       child: ClipRRect(
      //         borderRadius: BorderRadius.circular(10),
      //         child: BetterPlayer.network(
      //           gonderifotolar[0]["fotoufakurl"],
      //           betterPlayerConfiguration: BetterPlayerConfiguration(
      //             aspectRatio: 19 / 9,
      //             fit: BoxFit.contain,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // );
    }

    // jpeg ve png kontrolu ayrı if'ler ile yapılacak yoksa hata veriyor.
    // gonderifotolar[0]["paylasimkategori"] == "image/jpeg"
    // gonderifotolar[0]["paylasimkategori"] == "image/png"

    if (gonderifotolar.length == 1 &&
        gonderifotolar[0]["paylasimkategori"] == "image/jpeg") {
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
          SizedBox(width: screenwidth / 35),
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

    if (gonderifotolar.length == 1 &&
        gonderifotolar[0]["paylasimkategori"] == "image/png") {
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
          SizedBox(width: screenwidth / 35),
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
    print("asdsadas: " + postID.toString());
    // print(
    //     "https://aramizdakioyuncu.com/botlar/botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/begen/0/0/");
  }

  Future<bool> onLikeButtonTapped(bool isLike, int index) async {
    setState(() {
      postdata[index]["benbegendim"] =
          postdata[index]["benbegendim"] == 0 ? 1 : 0;

      isLike = !isLike;

      if (isLike == true) {
        postdata[index]["begenisay"] =
            (int.parse(postdata[index]["begenisay"]) + 1).toString();
      } else {
        postdata[index]["begenisay"] =
            (int.parse(postdata[index]["begenisay"]) - 1).toString();
      }
    });
    print(isLike);
    postID = postdata[index]["postID"];
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

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    final TabController controller = TabController(length: 3, vsync: this);

    return profiledata != null
        ? Scaffold(
            body: NestedScrollView(
              scrollDirection: Axis.vertical,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 200.0,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(profiledata["adim"]),
                      background: Image.network(
                        profiledata["parkaresimufak"],
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      // color: Colors.red,
                      width: screenwidth,
                      // height: 200,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 45,
                                  backgroundImage: NetworkImage(
                                    profiledata["presimufak"],
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                                Visibility(
                                  visible: profiledata["oyuncuID"] ==
                                          girisdata["oyuncuID"]
                                      ? false
                                      : true,
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(30),
                                        right: Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Arkadaş Ol",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              "@" + profiledata["kullaniciadi"],
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 10),
                            // Text(profiledata["hakkimda"]),
                            DetectableText(
                              detectionRegExp: RegExp(r"@(\w+)|#(\w+)"),
                              text: profiledata["hakkimda"],
                              basicStyle: TextStyle(
                                fontSize: 16,
                              ),
                              detectedStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  profiledata["ulkesi"],
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  profiledata["kayittarihikisa"],
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverAppBar(
                    leading: SizedBox(),
                    toolbarHeight: 0,
                    expandedHeight: 0,
                    collapsedHeight: 0,
                    elevation: 0,
                    backgroundColor: Colors.grey[850],
                    pinned: true,
                    bottom: PreferredSize(
                      preferredSize: Size(screenwidth, 50),
                      child: Container(
                        width: screenwidth,
                        color: Colors.grey[850],
                        child: TabBar(
                          isScrollable: true,
                          indicatorColor: Colors.blue,
                          controller: controller,
                          tabs: [
                            Tab(child: Text("Postlar")),
                            Tab(child: Text("Medya")),
                            Tab(child: Text("Tepki Verdiklerim")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: controller,
                children: [
                  MyPostView(),
                  MyMediaView(),
                  MyReactionView(),
                ],
              ),
            ),
          )
        : Scaffold(
            body: NestedScrollView(
              scrollDirection: Axis.vertical,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 200.0,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: null,
                      background: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      // color: Colors.red,
                      width: screenwidth,
                      // height: 200,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                    shape: BoxShape.circle,
                                    width: 90,
                                    height: 90,
                                  ),
                                ),
                                Visibility(
                                  // visible: "kullanıcı id" == girisdata["oyuncuID"]
                                  //     ? true
                                  //     : false,
                                  visible: true,
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(30),
                                        right: Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Arkadaş Ol",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            SkeletonLine(
                              style: SkeletonLineStyle(width: screenwidth / 4),
                            ),
                            SizedBox(height: 10),
                            // Text(profiledata["hakkimda"]),
                            SkeletonParagraph(
                              style: SkeletonParagraphStyle(lines: 3),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                SizedBox(width: 3),
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                      width: screenwidth / 10),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                SizedBox(width: 3),
                                SkeletonLine(
                                  style:
                                      SkeletonLineStyle(width: screenwidth / 4),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverAppBar(
                    leading: SizedBox(),
                    toolbarHeight: 0,
                    expandedHeight: 0,
                    collapsedHeight: 0,
                    elevation: 0,
                    backgroundColor: Colors.grey[850],
                    pinned: true,
                    bottom: PreferredSize(
                      preferredSize: Size(screenwidth, 50),
                      child: Container(
                        width: screenwidth,
                        color: Colors.grey[850],
                        child: TabBar(
                          isScrollable: true,
                          indicatorColor: Colors.blue,
                          controller: controller,
                          tabs: [
                            Tab(child: Text("Postlar")),
                            Tab(child: Text("Medya")),
                            Tab(child: Text("Tepki Verdiklerim")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: controller,
                children: [
                  SkeletonListView(
                    scrollable: true,
                    itemCount: 5,
                  ),
                  SkeletonListView(
                    padding: EdgeInsets.all(8),
                    scrollable: true,
                    itemCount: 2,
                    item: Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: screenwidth / 2.2,
                            height: 250,
                            color: Colors.red,
                          ),
                          Container(
                            width: screenwidth / 2.2,
                            height: 250,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SkeletonListView(
                    scrollable: true,
                    itemCount: 5,
                  ),
                ],
              ),
            ),
          );
  }

  MyPostView() {
    Future<void> _refresh() {
      return postcek();
    }

    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: _refresh,
      // child: ConnectivityResult != ConnectivityResult.none
      //     ?
      child: Container(
        child: postdata != null
            ? ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (postdata[index]["paylasimfoto"] != null) {
                    gonderifotolar = postdata[index]["paylasimfoto"];
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
                          builder: (context) => ThemeConsumer(
                            child: AnaDetail(
                              veri1: postdata[index]["sahipavatar"],
                              veri2: postdata[index]["sahipad"],
                              veri3: postdata[index]["sosyalicerik"],
                              veri4: postdata[index]["paylasimzaman"],
                              veri5: postdata[index]["begenisay"],
                              veri6: postdata[index]["yorumsay"],
                              veri7: postdata[index]["repostsay"],
                              veri8: postdata[index]["sikayetsay"],
                              veri9: postdata[index]["benbegendim"],
                              veri10: postdata[index]["postID"],
                              veri11: postdata[index]["sahipID"],
                              veri12: postdata[index]["paylasimnereden"],
                              veri13: postdata[index]["benyorumladim"],
                            ),
                          ),
                        ),
                      );

                      setState(() {
                        detayid = postdata[index]["postID"];
                        // print(detaylink);
                        detaylink =
                            "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
                      });
                    },
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: screenwidth / 12,
                            backgroundImage: NetworkImage(
                              postdata[index]["sahipavatarminnak"],
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
                                      postdata[index]["sahipad"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "  -  " +
                                          postdata[index]["paylasimzamangecen"],
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
                                                        visible: postdata[index]
                                                                    [
                                                                    "sahipID"] ==
                                                                girisdata[
                                                                    "oyuncuID"]
                                                            ? true
                                                            : false,
                                                        child: InkWell(
                                                          onTap: () {
                                                            postID =
                                                                postdata[index]
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
                                                        visible: postdata[index]
                                                                    [
                                                                    "sahipID"] ==
                                                                girisdata[
                                                                    "oyuncuID"]
                                                            ? true
                                                            : false,
                                                        child: InkWell(
                                                          onTap: () {
                                                            postID =
                                                                postdata[index]
                                                                    ["postID"];
                                                            postsil();
                                                            postcek();

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
                                    //   visible: medyadata[index]["sahipID"] ==
                                    //           girisdata["oyuncuID"]
                                    //       ? true
                                    //       : false,
                                    //   child: InkWell(
                                    //     onTap: () {
                                    //       postID =
                                    //           medyadata[index]["postID"];
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
                                  postdata[index]["sosyalicerik"],
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
                                //           veri5: medyadata[index]
                                //               ["begenisay"],
                                //           veri6: medyadata[index]
                                //               ["yorumsay"],
                                //           veri7: medyadata[index]
                                //               ["repostsay"],
                                //           veri8: medyadata[index]
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
                                      LikeButton(
                                        onTap: (bool isLike) {
                                          return onLikeButtonTapped(
                                            isLike,
                                            index,
                                          );
                                        },
                                        countPostion: CountPostion.right,
                                        isLiked:
                                            postdata[index]["benbegendim"] != 0
                                                ? true
                                                : false,
                                        likeCount: int.parse(
                                            postdata[index]["begenisay"]),
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
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AnaDetail(
                                                veri1: postdata[index]
                                                    ["sahipavatar"],
                                                veri2: postdata[index]
                                                    ["sahipad"],
                                                veri3: postdata[index]
                                                    ["sosyalicerik"],
                                                veri4: postdata[index]
                                                    ["paylasimzaman"],
                                                veri5: postdata[index]
                                                    ["begenisay"],
                                                veri6: postdata[index]
                                                    ["yorumsay"],
                                                veri7: postdata[index]
                                                    ["repostsay"],
                                                veri8: postdata[index]
                                                    ["sikayetsay"],
                                                veri9: postdata[index]
                                                    ["benbegendim"],
                                                veri10: postdata[index]
                                                    ["postID"],
                                                veri11: postdata[index]
                                                    ["sahipID"],
                                                veri12: postdata[index]
                                                    ["paylasimnereden"],
                                                veri13: postdata[index]
                                                    ["benyorumladim"],

                                                // veri12: medyadata[index]["paylasimfoto"][0]
                                                //     ["fotoufakurl"],

                                                // veri9: gonderifotolar[index]["fotourl"] != null
                                                //     ? gonderifotolar[index]["fotourl"]
                                                //     : "https://aramizdakioyuncu.com/galeri/ana-yapi/armoyu64.png",
                                              ),
                                            ),
                                          );

                                          setState(() {
                                            detayid = postdata[index]["postID"];
                                            // print(detaylink);
                                            detaylink =
                                                "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              postdata[index]
                                                          ["benyorumladim"] ==
                                                      0
                                                  ? Icon(
                                                      Icons.chat_bubble_outline,
                                                      color: Colors.grey,
                                                    )
                                                  : Icon(
                                                      Icons.chat_bubble,
                                                      color: Colors.blue,
                                                    ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              (postdata[index]["yorumsay"] !=
                                                      "0")
                                                  ? Text(
                                                      postdata[index]
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
                                              (postdata[index]["repostsay"] !=
                                                      "0")
                                                  ? Text(
                                                      postdata[index]
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
                                            postdata[index]["sosyalicerik"],
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
                itemCount: postdata.length,
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
              )
            : Center(
                child: Text(
                  "Henüz Gönderide Bulunmadın !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }

  MyMediaView() {
    Future<void> _refresh() {
      return medyacek();
    }

    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Container(
        child: medyadata != null
            ? GridView.builder(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    onTap: () {
                      // resimler.add(medyadata[index]["medyaufaklik"]);
                      print(resimler);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Resiminceleme(
                            veri1: resimler,
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      medyadata[index]["medyaufaklik"],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                itemCount: medyadata.length,
              )
            : Text("Geleri Boş"),
      ),
    );
  }

  MyReactionView() {
    Future<void> _refresh() {
      return postcek();
    }

    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: _refresh,
      child: Container(
        child: reactiondata != null
            ? ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (reactiondata[index]["paylasimfoto"] != null) {
                    gonderifotolar = postdata[index]["paylasimfoto"];
                    visible = true;
                  } else {
                    visible = false;
                  }
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThemeConsumer(
                            child: AnaDetail(
                              veri1: reactiondata[index]["sahipavatar"],
                              veri2: reactiondata[index]["sahipad"],
                              veri3: reactiondata[index]["sosyalicerik"],
                              veri4: reactiondata[index]["paylasimzaman"],
                              veri5: reactiondata[index]["begenisay"],
                              veri6: reactiondata[index]["yorumsay"],
                              veri7: reactiondata[index]["repostsay"],
                              veri8: reactiondata[index]["sikayetsay"],
                              veri9: reactiondata[index]["benbegendim"],
                              veri10: reactiondata[index]["postID"],
                              veri11: reactiondata[index]["sahipID"],
                              veri12: reactiondata[index]["paylasimnereden"],
                              veri13: reactiondata[index]["benyorumladim"],
                            ),
                          ),
                        ),
                      );

                      setState(() {
                        detayid = reactiondata[index]["postID"];
                        // print(detaylink);
                        detaylink =
                            "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
                      });
                    },
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: screenwidth / 12,
                            backgroundImage: NetworkImage(
                              reactiondata[index]["sahipavatarminnak"],
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
                                      reactiondata[index]["sahipad"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "  -  " +
                                          reactiondata[index]
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
                                                        visible: reactiondata[
                                                                        index][
                                                                    "sahipID"] ==
                                                                girisdata[
                                                                    "oyuncuID"]
                                                            ? true
                                                            : false,
                                                        child: InkWell(
                                                          onTap: () {
                                                            postID =
                                                                reactiondata[
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
                                                        visible: reactiondata[
                                                                        index][
                                                                    "sahipID"] ==
                                                                girisdata[
                                                                    "oyuncuID"]
                                                            ? true
                                                            : false,
                                                        child: InkWell(
                                                          onTap: () {
                                                            postID =
                                                                reactiondata[
                                                                        index]
                                                                    ["postID"];
                                                            postsil();
                                                            postcek();

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
                                    //   visible: medyadata[index]["sahipID"] ==
                                    //           girisdata["oyuncuID"]
                                    //       ? true
                                    //       : false,
                                    //   child: InkWell(
                                    //     onTap: () {
                                    //       postID =
                                    //           medyadata[index]["postID"];
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
                                  reactiondata[index]["sosyalicerik"],
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
                                //           veri5: medyadata[index]
                                //               ["begenisay"],
                                //           veri6: medyadata[index]
                                //               ["yorumsay"],
                                //           veri7: medyadata[index]
                                //               ["repostsay"],
                                //           veri8: medyadata[index]
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
                                      LikeButton(
                                        onTap: (bool isLike) {
                                          return onLikeButtonTapped(
                                            isLike,
                                            index,
                                          );
                                        },
                                        countPostion: CountPostion.right,
                                        isLiked: reactiondata[index]
                                                    ["benbegendim"] !=
                                                0
                                            ? true
                                            : false,
                                        likeCount: int.parse(
                                            reactiondata[index]["begenisay"]),
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
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AnaDetail(
                                                veri1: reactiondata[index]
                                                    ["sahipavatar"],
                                                veri2: reactiondata[index]
                                                    ["sahipad"],
                                                veri3: reactiondata[index]
                                                    ["sosyalicerik"],
                                                veri4: reactiondata[index]
                                                    ["paylasimzaman"],
                                                veri5: reactiondata[index]
                                                    ["begenisay"],
                                                veri6: reactiondata[index]
                                                    ["yorumsay"],
                                                veri7: reactiondata[index]
                                                    ["repostsay"],
                                                veri8: reactiondata[index]
                                                    ["sikayetsay"],
                                                veri9: reactiondata[index]
                                                    ["benbegendim"],
                                                veri10: reactiondata[index]
                                                    ["postID"],
                                                veri11: reactiondata[index]
                                                    ["sahipID"],
                                                veri12: reactiondata[index]
                                                    ["paylasimnereden"],
                                                veri13: reactiondata[index]
                                                    ["benyorumladim"],

                                                // veri12: medyadata[index]["paylasimfoto"][0]
                                                //     ["fotoufakurl"],

                                                // veri9: gonderifotolar[index]["fotourl"] != null
                                                //     ? gonderifotolar[index]["fotourl"]
                                                //     : "https://aramizdakioyuncu.com/galeri/ana-yapi/armoyu64.png",
                                              ),
                                            ),
                                          );

                                          setState(() {
                                            detayid =
                                                reactiondata[index]["postID"];
                                            // print(detaylink);
                                            detaylink =
                                                "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              reactiondata[index]
                                                          ["benyorumladim"] ==
                                                      0
                                                  ? Icon(
                                                      Icons.chat_bubble_outline,
                                                      color: Colors.grey,
                                                    )
                                                  : Icon(
                                                      Icons.chat_bubble,
                                                      color: Colors.blue,
                                                    ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              (reactiondata[index]
                                                          ["yorumsay"] !=
                                                      "0")
                                                  ? Text(
                                                      reactiondata[index]
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
                                              (reactiondata[index]
                                                          ["repostsay"] !=
                                                      "0")
                                                  ? Text(
                                                      reactiondata[index]
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
                                            reactiondata[index]["sosyalicerik"],
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
                itemCount: reactiondata.length,
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
              )
            : Center(
                child: Text(
                  "Henüz Tepki Vermediniz !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
