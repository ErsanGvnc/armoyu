// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, avoid_print, unnecessary_null_comparison, curly_braces_in_flow_control_structures, non_constant_identifier_names, use_function_type_syntax_for_parameters, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:armoyu/Utilities/utilities.dart';
import 'package:armoyu/Screens/GeneralScreens/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:armoyu/Screens/GeneralScreens/anadetail.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:skeletons/skeletons.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:armoyu/Utilities/links.dart';
import '../../Controllers/controllers.dart';
import '../../Variables/variables.dart';

class AnaSayfa extends StatefulWidget {
  @override
  AnaSayfaState createState() => AnaSayfaState();
}

class AnaSayfaState extends State<AnaSayfa> {
  @override
  void initState() {
    super.initState();
    gondericek(0);
    popcek();
    xpcek();
    kullanicicek();

    anaSayfaScrollController.addListener(() {
      if (anaSayfaScrollController.position.pixels ==
              anaSayfaScrollController.position.maxScrollExtent &&
          anaSayfaScrollController.position.pixels > 0) {
        gondericek(dataanasayfa.length);
      }
    });
  }

  @override
  void dispose() {
    anaSayfaScrollController.dispose();
    super.dispose();
  }

  gondericek(int startPage) async {
    final url = Uri.parse(
        "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/$startPage/0/");

    // print(url);

    final gelen = await http.get(url);

    if (gelen.statusCode == 200) {
      final List newItems = jsonDecode(gelen.body);

      setState(() {
        dataanasayfa.addAll(newItems);
      });
    }
  }

  popcek() async {
    final url = Uri.parse(poplink);

    final gelen = await http.get(url);

    if (gelen.statusCode == 200) {
      popsiralama = jsonDecode(gelen.body);
      setState(() {});
    }
  }

  xpcek() async {
    final url = Uri.parse(xplink);

    final gelen = await http.get(url);

    if (gelen.statusCode == 200) {
      xpsiralama = jsonDecode(gelen.body);
      setState(() {});
    }
  }

  kullanicicek() async {
    final url = Uri.parse(kullanicilink);

    final gelen = await http.get(url);

    if (gelen.statusCode == 200) {
      setState(() {
        kullanicilar = jsonDecode(gelen.body);
      });
    }
  }

  // videolu fotografların çekildigi yer.

  gonderifotocek() {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    // anasayfa video kısmı.

    if (gonderifotolar.length == 1 &&
        gonderifotolar[0]["paylasimkategori"] == "video/mp4") {
      return const Text("-- Video --");

      // return Padding(
      //   padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      //   child: Row(
      //     children: [
      //       Flexible(
      //         child: ClipRRect(
      //           borderRadius: BorderRadius.circular(10),
      //           child: BetterPlayer.network(
      //             gonderifotolar[0]["fotoufakurl"],
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

    if (gonderifotolar.length == 1 &&
        gonderifotolar[0]["paylasimkategori"] == "video/x-matroska") {
      return const Text("-- Video --");

      // return Padding(
      //   padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      //   child: Row(
      //     children: [
      //       Flexible(
      //         child: ClipRRect(
      //           borderRadius: BorderRadius.circular(10),
      //           child: BetterPlayer.network(
      //             gonderifotolar[0]["fotoufakurl"],
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
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
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
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth / 35),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[1]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
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
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth / 35),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.srgbToLinearGamma(),
                    child: CachedNetworkImage(
                      imageUrl: gonderifotolar[1]["fotoufakurl"],
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Text(
                    "+ ${gonderifotolar.length - 1}",
                    style: const TextStyle(
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
        gonderifotolar[0]["paylasimkategori"] == "image/jpg") {
      return Row(
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
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
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth / 35),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[1]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
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
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth / 35),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.srgbToLinearGamma(),
                    child: CachedNetworkImage(
                      imageUrl: gonderifotolar[1]["fotoufakurl"],
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Text(
                    "+ ${gonderifotolar.length - 1}",
                    style: const TextStyle(
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
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
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
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth / 35),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[1]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
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
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth / 35),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.srgbToLinearGamma(),
                    child: CachedNetworkImage(
                      imageUrl: gonderifotolar[1]["fotoufakurl"],
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Text(
                    "+ ${gonderifotolar.length - 1}",
                    style: const TextStyle(
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
        gonderifotolar[0]["paylasimkategori"] == "application/octet-stream") {
      return Row(
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
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
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth / 35),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[1]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
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
              child: CachedNetworkImage(
                imageUrl: gonderifotolar[0]["fotoufakurl"],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) => Container(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth / 35),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.srgbToLinearGamma(),
                    child: CachedNetworkImage(
                      imageUrl: gonderifotolar[1]["fotoufakurl"],
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Text(
                    "+ ${gonderifotolar.length - 1}",
                    style: const TextStyle(
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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    Future<bool> onLikeButtonTapped(bool isLike, int index) async {
      setState(() {
        dataanasayfa[index]["benbegendim"] =
            dataanasayfa[index]["benbegendim"] == 0 ? 1 : 0;

        isLike = !isLike;

        if (isLike == true) {
          dataanasayfa[index]["begenisay"] =
              (int.parse(dataanasayfa[index]["begenisay"]) + 1).toString();
        } else {
          dataanasayfa[index]["begenisay"] =
              (int.parse(dataanasayfa[index]["begenisay"]) - 1).toString();
        }
      });
      print(isLike);
      postID = dataanasayfa[index]["postID"];
      print("onLikeButtonTapped");

      postlike();

      return isLike;
    }

    Future<void> _refresh() {
      setState(() {
        dataanasayfa.clear();
        gonderifotolar.clear();
      });
      return gondericek(0);
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: dataanasayfa.isNotEmpty
          ? ListView.separated(
              controller: anaSayfaScrollController,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                if (dataanasayfa[index]["paylasimfoto"] != null) {
                  gonderifotolar = dataanasayfa[index]["paylasimfoto"];
                  visible = true;
                } else {
                  visible = false;
                }
                if (index < 2)
                  return _MainListView(
                    context,
                    index,
                    screenWidth,
                    postsil,
                    _refresh,
                    postbildir,
                    screenHeight,
                    onLikeButtonTapped,
                  );
                else if (index == 3)
                  return _xphorizontalListView();
                else if (index == 10)
                  return _pophorizontalListView();
                else
                  return _MainListView(
                    context,
                    index,
                    screenWidth,
                    postsil,
                    _refresh,
                    postbildir,
                    screenHeight,
                    onLikeButtonTapped,
                  );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: dataanasayfa.length,
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 10,
              ),
            )
          : SkeletonListView(
              padding: const EdgeInsets.all(10),
              item: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: screenWidth / 12,
                  ),
                  SizedBox(width: screenWidth / 35),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Expanded(
                              child: SkeletonLine(),
                            ),
                            Spacer(),
                            Icon(
                              Icons.more_vert,
                              size: 20,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 90),
                        SkeletonParagraph(
                          style: const SkeletonParagraphStyle(
                            lines: 2,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        SizedBox(height: screenHeight / 50),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          width: screenWidth,
                          height: 250,
                        ),
                        SizedBox(height: screenHeight / 65),
                        Container(
                          color: Colors.transparent,
                          width: screenWidth,
                          height: screenHeight / 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.favorite_outline,
                                color: Colors.grey,
                              ),
                              const Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.grey,
                              ),
                              const Icon(
                                Icons.repeat,
                                color: Colors.grey,
                              ),
                              const Icon(
                                Icons.share_outlined,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: screenWidth / 15,
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ],
              ),
              scrollable: true,
              itemCount: 20,
            ),
    );
  }

  Widget _MainListView(
      BuildContext context,
      int index,
      double screenWidth,
      postsil(),
      Future<void> _refresh(),
      postbildir(),
      double screenHeight,
      Future<bool> onLikeButtonTapped(bool isLike, int index)) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThemeConsumer(
              child: AnaDetail(
                veri1: dataanasayfa[index]["sahipavatarminnak"],
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
                veri13: dataanasayfa[index]["benyorumladim"],
                veri14: dataanasayfa[index]["oyunculink"],
              ),
            ),
          ),
        );
        // .whenComplete(
        //   () => _refresh(),
        // );

        setState(() {
          detayid = dataanasayfa[index]["postID"];
          detaylink =
              "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: screenWidth / 12,
            backgroundImage: CachedNetworkImageProvider(
              dataanasayfa[index]["sahipavatarminnak"],
            ),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: screenWidth / 35),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      dataanasayfa[index]["sahipad"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "  -  " + dataanasayfa[index]["paylasimzamangecen"],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[900],
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(30),
                                            ),
                                          ),
                                          width: screenWidth / 4,
                                          height: 5,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const ListTile(
                                          leading: Icon(Icons.post_add),
                                          title: Text("Postu favorilere ekle."),
                                        ),
                                      ),
                                      Visibility(
                                        visible: dataanasayfa[index]
                                                    ["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? true
                                            : false,
                                        child: InkWell(
                                          onTap: () {
                                            postID =
                                                dataanasayfa[index]["postID"];
                                            // postsil();
                                            Navigator.pop(context);
                                          },
                                          child: const ListTile(
                                            leading: Icon(Icons.edit_note),
                                            title: Text("Postu düzenle."),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: dataanasayfa[index]
                                                    ["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? true
                                            : false,
                                        child: InkWell(
                                          onTap: () {
                                            postID =
                                                dataanasayfa[index]["postID"];
                                            postsil();
                                            Navigator.pop(context);
                                            Future.delayed(
                                                const Duration(
                                                  milliseconds: 100,
                                                ), () {
                                              _refresh();
                                            });
                                          },
                                          child: const ListTile(
                                            leading: Icon(
                                                Icons.delete_sweep_outlined),
                                            title: Text("Postu kaldır."),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Share.share(dataanasayfa[index]
                                              ["oyunculink"]);
                                          Navigator.pop(context);
                                        },
                                        child: const ListTile(
                                          leading: Icon(Icons.share_outlined),
                                          title: Text("Kullanıcıyı paylaş."),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text: dataanasayfa[index]
                                                  ["oyunculink"],
                                            ),
                                          );
                                          Navigator.pop(context);
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(
                                          //   SnackBar(
                                          //     content: Text("Kopyalandı !"),
                                          //     shape: const StadiumBorder(),
                                          //   ),
                                          // );
                                          Fluttertoast.showToast(
                                            msg: "Kopyalandı !",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                          );
                                        },
                                        child: const ListTile(
                                          leading: Icon(Icons.content_copy),
                                          title: Text(
                                              "Kullanıcı profil linkini kopyala."),
                                        ),
                                      ),
                                      Visibility(
                                        visible: dataanasayfa[index]
                                                    ["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? false
                                            : true,
                                        child: const Divider(),
                                      ),
                                      Visibility(
                                        visible: dataanasayfa[index]
                                                    ["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? false
                                            : true,
                                        child: InkWell(
                                          onTap: () {
                                            postID =
                                                dataanasayfa[index]["postID"];
                                            postbildir();
                                            Navigator.pop(context);
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(
                                            //   const SnackBar(
                                            //     content: Text("Bildirildi !"),
                                            //     shape: StadiumBorder(),
                                            //   ),
                                            // );
                                            Fluttertoast.showToast(
                                              msg: "Bildirildi !",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                            );
                                          },
                                          child: const ListTile(
                                            textColor: Colors.red,
                                            leading: Icon(
                                              Icons.flag_outlined,
                                              color: Colors.red,
                                            ),
                                            title: Text("Postu bildir."),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: dataanasayfa[index]
                                                    ["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? false
                                            : true,
                                        child: InkWell(
                                          onTap: () {
                                            postID =
                                                dataanasayfa[index]["postID"];
                                            postbildir();
                                            Navigator.pop(context);
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(
                                            //   const SnackBar(
                                            //     content: Text("Bildirildi !"),
                                            //     shape: StadiumBorder(),
                                            //   ),
                                            // );
                                            Fluttertoast.showToast(
                                              msg: "Engellendi !",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                            );
                                          },
                                          child: const ListTile(
                                            textColor: Colors.red,
                                            leading: Icon(
                                              Icons.person_off_outlined,
                                              color: Colors.red,
                                            ),
                                            title: Text("Kullanıcıyı engelle."),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: dataanasayfa[index]
                                                    ["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? false
                                            : true,
                                        child: InkWell(
                                          onTap: () {
                                            postID =
                                                dataanasayfa[index]["postID"];
                                            postbildir();
                                            Navigator.pop(context);
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(
                                            //   const SnackBar(
                                            //     content: Text("Bildirildi !"),
                                            //     shape: StadiumBorder(),
                                            //   ),
                                            // );
                                            Fluttertoast.showToast(
                                              msg: "Bildirildi !",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                            );
                                          },
                                          child: const ListTile(
                                            textColor: Colors.red,
                                            leading: Icon(
                                              Icons.person_outline,
                                              color: Colors.red,
                                            ),
                                            title: Text("Kullanıcıyı bildir."),
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
                      child: const Icon(
                        Icons.more_vert,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight / 90),
                DetectableText(
                  detectionRegExp: RegExp(
                    "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                    multiLine: true,
                  ),
                  text: dataanasayfa[index]["sosyalicerik"],
                  basicStyle: const TextStyle(
                    fontSize: 16,
                  ),
                  detectedStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: screenHeight / 50),
                Visibility(
                  visible: visible,
                  child: Container(
                    child: gonderifotocek(),
                  ),
                ),
                SimpleUrlPreview(
                  url: dataanasayfa[index]["sosyalicerik"],
                  isClosable: true,
                  imageLoaderColor: Colors.blue,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  descriptionStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  siteNameStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight / 65),
                Container(
                  color: Colors.transparent,
                  width: screenWidth,
                  height: screenHeight / 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LikeButton(
                        onTap: (bool isLike) {
                          return onLikeButtonTapped(
                            isLike,
                            index,
                          );
                        },
                        countPostion: CountPostion.right,
                        isLiked: dataanasayfa[index]["benbegendim"] != 0
                            ? true
                            : false,
                        likeCount: dataanasayfa[index]["begenisay"] != "0"
                            ? int.parse(dataanasayfa[index]["begenisay"])
                            : null,
                        likeBuilder: (bool isLiked) {
                          return isLiked
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.grey,
                                );
                        },
                        bubblesColor: const BubblesColor(
                          dotPrimaryColor: Colors.red,
                          dotSecondaryColor: Colors.blue,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ThemeConsumer(
                                child: AnaDetail(
                                  veri1: dataanasayfa[index]
                                      ["sahipavatarminnak"],
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
                                  veri12: dataanasayfa[index]
                                      ["paylasimnereden"],
                                  veri13: dataanasayfa[index]["benyorumladim"],
                                  veri14: dataanasayfa[index]["oyunculink"],
                                ),
                              ),
                            ),
                          );

                          setState(() {
                            detayid = dataanasayfa[index]["postID"];
                            // print(detaylink);
                            detaylink =
                                "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              dataanasayfa[index]["benyorumladim"] == 0
                                  ? const Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.grey,
                                    )
                                  : const Icon(
                                      Icons.chat_bubble,
                                      color: Colors.blue,
                                    ),
                              const SizedBox(
                                width: 10,
                              ),
                              (dataanasayfa[index]["yorumsay"] != "0")
                                  ? Text(
                                      dataanasayfa[index]["yorumsay"],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  : const Text(""),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.repeat,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              (dataanasayfa[index]["repostsay"] != "0")
                                  ? Text(
                                      dataanasayfa[index]["repostsay"],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  : const Text(""),
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
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.share_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _xphorizontalListView() {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        controller: xpHorizontalScrollController,
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThemeConsumer(
                    child: Profile(
                      veri1: xpsiralama[index]["oyuncuID"],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  image: CachedNetworkImageProvider(
                    xpsiralama[index]["oyuncuavatar"],
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.4],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(7, 0, 7, 7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          xpsiralama[index]["oyuncuadsoyad"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          xpsiralama[index]["oyuncuseviyexp"] + " XP",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 20),
      ),
    );
  }

  Widget _pophorizontalListView() {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        controller: popHorizontalScrollController,
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThemeConsumer(
                    child: Profile(
                      veri1: popsiralama[index]["oyuncuID"],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  image: CachedNetworkImageProvider(
                    popsiralama[index]["oyuncuavatar"],
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.4],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(7, 0, 7, 7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          popsiralama[index]["oyuncuadsoyad"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.remove_red_eye_outlined,
                              size: 15,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              popsiralama[index]["oyuncupop"],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 20),
      ),
    );
  }
}
