// ignore_for_file: unused_local_variable, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, prefer_final_fields, sort_child_properties_last, avoid_print, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unnecessary_null_comparison, unused_element, must_be_immutable, file_names, prefer_typing_uninitialized_variables, prefer_if_null_operators, prefer_adjacent_string_concatenation, curly_braces_in_flow_control_structures, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:armoyu/anadetail.dart';
import 'package:armoyu/resiminceleme.dart';
import 'package:armoyu/site.dart';
import 'package:armoyu/Utilities/utilities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:like_button/like_button.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:skeletons/skeletons.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:armoyu/Utilities/links.dart';
import 'Variables/variables.dart';
import 'Controllers/controllers.dart';
import 'post.dart';

class Profile extends StatefulWidget {
  String veri1;

  Profile({
    required this.veri1,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  @override
  initState() {
    super.initState();
    postdata.clear();
    medyadata.clear();
    resimler.clear();
    profilcek();
    postcek();
    medyacek();
  }

  List resimler = [];

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
          // print(profiledata);
          arkadasdurum();
        } catch (e) {
          print('Unknown exception: $e');
        }
      });
    });
  }

  postcek() async {
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
          }
        } else {
          print("resim yok");
        }
      });
    });
  }

  gonderifotocek() {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

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
          SizedBox(width: screenwidth / 35),
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
          SizedBox(width: screenwidth / 35),
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
          SizedBox(width: screenwidth / 35),
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
          SizedBox(width: screenwidth / 35),
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
          SizedBox(width: screenwidth / 35),
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
          SizedBox(width: screenwidth / 35),
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
          SizedBox(width: screenwidth / 35),
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
          SizedBox(width: screenwidth / 35),
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

    postlike();

    return isLike;
  }

  arkadasol() async {
    http.post(
      Uri.parse(arkadasollink),
      body: {
        "oyuncubakid": widget.veri1,
      },
    ).then((cevap) {
      setState(() {
        try {
          arkadas = jsonDecode(cevap.body);
        } catch (e) {
          print('Unknown exception: $e');
        }
        print(arkadas);
      });
    });
  }

  arkadasdurum() async {
    if (profiledata["arkadasdurum"] == "0") {
      setState(() {
        arkadasText = "Arkadaş Ol";
      });
    } else if (profiledata["arkadasdurum"] == "1") {
      setState(() {
        arkadasText = "Mesaj Gönder";
      });
    } else if (profiledata["arkadasdurum"] == "2") {
      setState(() {
        arkadasText = "Bekleniyor...";
      });
    } else if (profiledata["arkadasdurum"] == null) {
      setState(() {
        arkadasText = "";
      });
    } else {
      null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    // final TabController controller =
    //     TabController(length: 4, vsync: this, initialIndex: 0);

    return profiledata != null
        ? Scaffold(
            body: DefaultTabController(
              length: 4,
              initialIndex: 0,
              child: NestedScrollView(
                controller: profileScrollController,
                scrollDirection: Axis.vertical,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      elevation: 0,
                      expandedHeight: 150,
                      pinned: true,
                      actions: [
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
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
                                              width: screenwidth / 4,
                                              height: 5,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Share.share(
                                                  profiledata["oyunculink"]);
                                              Navigator.pop(context);
                                            },
                                            child: const ListTile(
                                              leading:
                                                  Icon(Icons.share_outlined),
                                              title: Text("Profili paylaş."),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Clipboard.setData(
                                                ClipboardData(
                                                  text:
                                                      profiledata["oyunculink"],
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
                                                  "Profil linkini kopyala."),
                                            ),
                                          ),
                                          Visibility(
                                            visible: profiledata["oyuncuID"] ==
                                                    girisdata["oyuncuID"]
                                                ? false
                                                : true,
                                            child: Divider(),
                                          ),
                                          Visibility(
                                            visible: profiledata["oyuncuID"] ==
                                                    girisdata["oyuncuID"]
                                                ? false
                                                : true,
                                            child: InkWell(
                                              onTap: () {
                                                profileID = widget.veri1;
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
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
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
                                                title: Text(
                                                    "Kullanıcıyı engelle."),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: profiledata["oyuncuID"] ==
                                                    girisdata["oyuncuID"]
                                                ? false
                                                : true,
                                            child: InkWell(
                                              onTap: () {
                                                profileID = widget.veri1;
                                                // profilebildir();
                                                print(profileID);
                                                Navigator.pop(context);
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(
                                                //   const SnackBar(
                                                //     content:
                                                //         Text("Bildirildi !"),
                                                //     shape:
                                                //         const StadiumBorder(),
                                                //   ),
                                                // );
                                                Fluttertoast.showToast(
                                                  msg: "Bildirildi !",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
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
                                                title: Text("Profili bildir."),
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
                          child: CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.black.withOpacity(0.7),
                            child: Icon(Icons.more_vert),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) {
                          bool isAppBarExpanded = constraints.maxHeight >
                              kToolbarHeight +
                                  MediaQuery.of(context).padding.top;
                          return FlexibleSpaceBar(
                            title: isAppBarExpanded
                                ? const SizedBox()
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        profiledata["adim"],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      profiledata["oyuncuID"] == "11"
                                          ? Icon(
                                              Icons.check_circle,
                                              color: Colors.blue,
                                              size: 20,
                                            )
                                          : Text(""),
                                    ],
                                  ),
                            background: FocusedMenuHolder(
                              menuItems: [
                                FocusedMenuItem(
                                  title: Text("Open"),
                                  trailingIcon: Icon(Icons.open_in_new),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Site(
                                          verilink: profiledata["parkaresim"],
                                          veribaslik: profiledata["adim"],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                FocusedMenuItem(
                                  title: Text("Share"),
                                  trailingIcon: Icon(Icons.share),
                                  onPressed: () {
                                    Share.share(profiledata["parkaresim"]);
                                  },
                                ),
                                FocusedMenuItem(
                                  title: Text("Save to Gallery"),
                                  trailingIcon:
                                      Icon(Icons.file_download_outlined),
                                  onPressed: () {
                                    GallerySaver.saveImage(
                                        profiledata["parkaresim"]);
                                  },
                                ),
                              ],
                              onPressed: () {},
                              openWithTap: false,
                              child: OpenContainer(
                                openColor: Colors.transparent,
                                closedColor: Colors.transparent,
                                openElevation: 0,
                                closedElevation: 0,
                                closedBuilder: (context, openWidget) {
                                  return InkWell(
                                    onTap: openWidget,
                                    child: CachedNetworkImage(
                                      imageUrl: profiledata["parkaresimufak"],
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  );
                                },
                                openBuilder: (context, closeWidget) {
                                  return ThemeConsumer(
                                    child: Scaffold(
                                      appBar: AppBar(),
                                      body: DismissiblePage(
                                        backgroundColor: Colors.transparent,
                                        direction:
                                            DismissiblePageDismissDirection
                                                .vertical,
                                        onDismissed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Center(
                                          child: PhotoView(
                                            backgroundDecoration: BoxDecoration(
                                                color: Colors.transparent),
                                            imageProvider:
                                                CachedNetworkImageProvider(
                                              profiledata["parkaresimufak"],
                                            ),
                                            filterQuality: FilterQuality.high,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: screenwidth,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FocusedMenuHolder(
                                    menuItems: [
                                      FocusedMenuItem(
                                        title: Text("Open"),
                                        trailingIcon: Icon(Icons.open_in_new),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Site(
                                                verilink: profiledata["presim"],
                                                veribaslik: profiledata["adim"],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      FocusedMenuItem(
                                        title: Text("Share"),
                                        trailingIcon: Icon(Icons.share),
                                        onPressed: () {
                                          Share.share(profiledata["presim"]);
                                        },
                                      ),
                                      FocusedMenuItem(
                                        title: Text("Save to Gallery"),
                                        trailingIcon:
                                            Icon(Icons.file_download_outlined),
                                        onPressed: () {
                                          GallerySaver.saveImage(
                                              profiledata["presim"]);
                                        },
                                      ),
                                    ],
                                    onPressed: () {},
                                    openWithTap: false,
                                    child: OpenContainer(
                                      openColor: Colors.transparent,
                                      closedColor: Colors.transparent,
                                      openElevation: 0,
                                      closedElevation: 0,
                                      closedBuilder: (context, openWidget) {
                                        return InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: openWidget,
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 49,
                                                backgroundColor: Color(
                                                  profiledata["seviyerenk"] !=
                                                          false
                                                      ? int.parse("0xFF" +
                                                          profiledata[
                                                              "seviyerenk"])
                                                      : 0xFF,
                                                ),
                                                child: CircleAvatar(
                                                  radius: 45,
                                                  backgroundImage: NetworkImage(
                                                    profiledata["presimufak"],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(
                                                      profiledata["seviyerenk"] !=
                                                              false
                                                          ? int.parse("0xFF" +
                                                              profiledata[
                                                                  "seviyerenk"])
                                                          : 0xFF,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      profiledata["seviye"],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      openBuilder: (context, closeWidget) {
                                        return ThemeConsumer(
                                          child: Scaffold(
                                            appBar: AppBar(),
                                            body: DismissiblePage(
                                              backgroundColor:
                                                  Colors.transparent,
                                              direction:
                                                  DismissiblePageDismissDirection
                                                      .vertical,
                                              onDismissed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Center(
                                                child: CircleAvatar(
                                                  radius: 100,
                                                  backgroundImage: NetworkImage(
                                                    profiledata["presimufak"],
                                                  ),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: profiledata["oyuncuID"] ==
                                                girisdata["oyuncuID"]
                                            ? false
                                            : true,
                                        child: InkWell(
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(30),
                                            right: Radius.circular(30),
                                          ),
                                          onTap: () {
                                            if (profiledata["arkadasdurum"] ==
                                                "1") {
                                              setState(() {
                                                arkadasText = "Mesaj Gönder";
                                              });
                                              print("Mesaj Gönder");
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Text("Yakında !"),
                                                  shape: StadiumBorder(),
                                                ),
                                              );
                                            } else if (profiledata[
                                                    "arkadasdurum"] ==
                                                "0") {
                                              setState(() {
                                                arkadasText = "Bekleniyor...";
                                              });
                                              print("Arkadaş Ol");
                                              arkadasol();
                                            }
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                left: Radius.circular(30),
                                                right: Radius.circular(30),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                arkadasText,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              // child: Text("${() async {
                                              //   if (profiledata[
                                              //           "arkadasdurum"] ==
                                              //       "0") {
                                              //     setState(() {
                                              //       arkadasText = "Arkadaş Ol";
                                              //     });
                                              //     return Text(arkadasText);
                                              //   } else if (profiledata[
                                              //           "arkadasdurum"] ==
                                              //       "1") {
                                              //     setState(() {
                                              //       arkadasText =
                                              //           "Mesaj Gönder";
                                              //     });
                                              //     return Text(arkadasText);
                                              //   } else if (profiledata[
                                              //           "arkadasdurum"] ==
                                              //       "2") {
                                              //     setState(() {
                                              //       arkadasText =
                                              //           "Bekleniyor...";
                                              //     });
                                              //     return Text(arkadasText);
                                              //   } else {
                                              //     return Text("");
                                              //   }
                                              // }()}"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        profiledata["arkadassayim"] != "0"
                                            ? profiledata["arkadassayim"] +
                                                " arkadaş"
                                            : "",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    profiledata["adim"],
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  profiledata["oyuncuID"] == "11"
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.blue,
                                          size: 20,
                                        )
                                      : Text(""),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "@" + profiledata["kullaniciadi"],
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    profiledata["yetkisiacikla"],
                                    style: TextStyle(
                                      color: Color(
                                        int.parse(
                                            "0xFF" + profiledata["yetkirenk"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onLongPress: () async {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: profiledata["hakkimda"],
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
                                  text: profiledata["hakkimda"],
                                  trimExpandedText: " Daha az",
                                  trimCollapsedText: " Daha Fazla",
                                  trimMode: TrimMode.Line,
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
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    profiledata["ulkesi"] +
                                        ", " +
                                        profiledata["ili"],
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
                              SizedBox(height: 5),
                              Visibility(
                                visible: profiledata["isyeriadi"] != null
                                    ? true
                                    : false,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.school,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      profiledata["isyeriadi"] != null
                                          ? profiledata["isyeriadi"]
                                          : "",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                height: 50,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Visibility(
                                      visible: profiledata["github"] == null ||
                                              profiledata["github"] == ""
                                          ? false
                                          : true,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Site(
                                                verilink: profiledata["github"],
                                                veribaslik: "Github",
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.github,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          profiledata["linkedin"] == null ||
                                                  profiledata["linkedin"] == ""
                                              ? false
                                              : true,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Site(
                                                verilink:
                                                    profiledata["linkedin"],
                                                veribaslik: "LinkedIn",
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.linkedin,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: profiledata["reddit"] == null ||
                                              profiledata["reddit"] == ""
                                          ? false
                                          : true,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Site(
                                                verilink: profiledata["reddit"],
                                                veribaslik: "Reddit",
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.reddit,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: profiledata["twitch"] == null ||
                                              profiledata["twitch"] == ""
                                          ? false
                                          : true,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Site(
                                                verilink: profiledata["twitch"],
                                                veribaslik: "Twitch",
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.twitch,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: profiledata["youtube"] == null ||
                                              profiledata["youtube"] == ""
                                          ? false
                                          : true,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Site(
                                                verilink:
                                                    profiledata["youtube"],
                                                veribaslik: "YouTube",
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.youtube,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          profiledata["instagram"] == null ||
                                                  profiledata["instagram"] == ""
                                              ? false
                                              : true,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Site(
                                                verilink:
                                                    profiledata["instagram"],
                                                veribaslik: "Instagram",
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.instagram,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          profiledata["facebook"] == null ||
                                                  profiledata["facebook"] == ""
                                              ? false
                                              : true,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Site(
                                                verilink:
                                                    profiledata["facebook"],
                                                veribaslik: "Facebook",
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.facebook,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ACustomSliverHeader(),
                  ];
                },
                body: TabBarView(
                  children: [
                    MyPostView(),
                    MyMediaView(),
                    MyFavoriteView(),
                    MyReactionView(),
                  ],
                ),
              ),
            ),
            floatingActionButton: OpenContainer(
              openColor: Colors.transparent,
              closedColor: Colors.transparent,
              openElevation: 0,
              closedElevation: 0,
              closedBuilder: (context, openWidget) {
                return FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.edit_note,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: openWidget,
                );
              },
              openBuilder: (context, closeWidget) {
                return ThemeConsumer(
                  child: Post(
                    veri1: profiledata["oyuncuID"] == girisdata["oyuncuID"]
                        ? ""
                        : "@" + "${profiledata["kullaniciadi"]} ",
                  ),
                );
              },
            ),
          )
        : Scaffold(
            body: DefaultTabController(
              length: 4,
              initialIndex: 0,
              child: NestedScrollView(
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
                        width: screenwidth,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                style:
                                    SkeletonLineStyle(width: screenwidth / 4),
                              ),
                              SizedBox(height: 10),
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
                                    style: SkeletonLineStyle(
                                        width: screenwidth / 4),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  // controller: controller,
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
                    SkeletonListView(
                      scrollable: true,
                      itemCount: 5,
                    ),
                  ],
                ),
              ),
            ),
          );
  }

////////////////////////////////////////////////////////////////////////////////

  MyPostView() {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    Future<void> _refresh() {
      postdata.clear();
      return postcek();
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: Container(
        child: postdata.isNotEmpty
            ? ListView.separated(
                // physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  if (postdata[index]["paylasimfoto"] != null) {
                    gonderifotolar = postdata[index]["paylasimfoto"];
                    visible = true;
                  } else {
                    visible = false;
                  }
                  return _MainListView(
                    context,
                    index,
                    screenwidth,
                    screenheight,
                  );
                  // if (index < 2)
                  //   return _MainListView(
                  //     context,
                  //     index,
                  //     screenwidth,
                  //     screenheight,
                  //   );
                  // else if (index == 3)
                  //   // return _MainListView(
                  //   //   context,
                  //   //   index,
                  //   //   screenwidth,
                  //   //   screenheight,
                  //   // );
                  //   return _horizontalArkadasListView();
                  // else if (index == 5)
                  //   // return _MainListView(
                  //   //   context,
                  //   //   index,
                  //   //   screenwidth,
                  //   //   screenheight,
                  //   // );
                  //   return _horizontalArkadasListView();
                  // else
                  //   return _MainListView(
                  //     context,
                  //     index,
                  //     screenwidth,
                  //     screenheight,
                  //   );
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
                  profiledata["oyuncuID"] == girisdata["oyuncuID"]
                      ? "Henüz Gönderide Bulunmadın !"
                      : "Henüz Gönderide Bulunmamış !",
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
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    Future<void> _refresh() {
      medyadata.clear();
      resimler.clear();
      return medyacek();
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: Container(
        child: medyadata.isNotEmpty
            ? GridView.builder(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                // physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, index) {
                  // return InkWell(
                  //   borderRadius: BorderRadius.all(
                  //     Radius.circular(10),
                  //   ),
                  //   onTap: () {
                  //     print(resimler);
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => Resiminceleme(
                  //           veri1: resimler,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: Image.network(
                  //       medyadata[index]["medyaufaklik"],
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // );

                  return FocusedMenuHolder(
                    menuWidth: MediaQuery.of(context).size.width * 0.50,
                    blurSize: 5.0,
                    menuItemExtent: 45,
                    menuBoxDecoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    duration: Duration(milliseconds: 100),
                    animateMenuItems: true,
                    blurBackgroundColor: Colors.black54,
                    bottomOffsetHeight: 100,
                    // openWithTap: true,
                    menuItems: <FocusedMenuItem>[
                      FocusedMenuItem(
                        title: Text("Open"),
                        trailingIcon: Icon(Icons.open_in_new),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Site(
                                verilink: medyadata[index]["medyaorijinal"],
                                veribaslik: profiledata["adim"],
                              ),
                            ),
                          );
                        },
                      ),
                      FocusedMenuItem(
                        title: Text("Share"),
                        trailingIcon: Icon(Icons.share),
                        onPressed: () {
                          Share.share(medyadata[index]["medyaorijinal"]);
                        },
                      ),
                      FocusedMenuItem(
                        title: Text("Save to Gallery"),
                        trailingIcon: Icon(Icons.file_download_outlined),
                        onPressed: () {
                          GallerySaver.saveImage(
                              medyadata[index]["medyaorijinal"]);
                        },
                      ),
                      // FocusedMenuItem(
                      //   title: Text("Favorite"),
                      //   trailingIcon: Icon(Icons.favorite_border),
                      //   onPressed: () {},
                      // ),
                      // FocusedMenuItem(
                      //   title: Text(
                      //     "Delete",
                      //     style: TextStyle(color: Colors.redAccent),
                      //   ),
                      //   trailingIcon: Icon(
                      //     Icons.delete,
                      //     color: Colors.redAccent,
                      //   ),
                      //   onPressed: () {},
                      // ),
                    ],
                    onPressed: () {
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: medyadata[index]["medyaufaklik"],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: medyadata.length,
              )
            : Center(
                child: Text(
                  profiledata["oyuncuID"] == girisdata["oyuncuID"]
                      ? "Henüz Gönderide Bulunmadın !"
                      : "Henüz Gönderide Bulunmamış !",
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

  MyFavoriteView() {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    Future<void> _refresh() {
      return postcek();
    }

    return Center(
      child: Container(
        child: Text(
          "Çok Yakında...\nComing Soon...",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    // return RefreshIndicator(
    //   onRefresh: _refresh,
    //   child: Container(
    //     child: reactiondata.isNotEmpty
    //         ? ListView.separated(
    //             physics: BouncingScrollPhysics(),
    //             scrollDirection: Axis.vertical,
    //             itemBuilder: (context, index) {
    //               if (reactiondata[index]["paylasimfoto"] != null) {
    //                 gonderifotolar = postdata[index]["paylasimfoto"];
    //                 visible = true;
    //               } else {
    //                 visible = false;
    //               }
    //               return InkWell(
    //                 onTap: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => ThemeConsumer(
    //                         child: AnaDetail(
    //                           veri1: reactiondata[index]["sahipavatarminnak"],
    //                           veri2: reactiondata[index]["sahipad"],
    //                           veri3: reactiondata[index]["sosyalicerik"],
    //                           veri4: reactiondata[index]["paylasimzaman"],
    //                           veri5: reactiondata[index]["begenisay"],
    //                           veri6: reactiondata[index]["yorumsay"],
    //                           veri7: reactiondata[index]["repostsay"],
    //                           veri8: reactiondata[index]["sikayetsay"],
    //                           veri9: reactiondata[index]["benbegendim"],
    //                           veri10: reactiondata[index]["postID"],
    //                           veri11: reactiondata[index]["sahipID"],
    //                           veri12: reactiondata[index]["paylasimnereden"],
    //                           veri13: reactiondata[index]["benyorumladim"],
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                   setState(() {
    //                     detayid = reactiondata[index]["postID"]
    //                     detaylink =
    //                         "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
    //                   });
    //                 },
    //                 child: Container(
    //                   child: Row(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       CircleAvatar(
    //                         radius: screenwidth / 12,
    //                         backgroundImage: NetworkImage(
    //                           reactiondata[index]["sahipavatarminnak"],
    //                         ),
    //                         backgroundColor: Colors.transparent,
    //                       ),
    //                       SizedBox(width: screenwidth / 35),
    //                       Expanded(
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 Text(
    //                                   reactiondata[index]["sahipad"],
    //                                   style: TextStyle(
    //                                     fontWeight: FontWeight.bold,
    //                                   ),
    //                                 ),
    //                                 Text(
    //                                   "  -  " +
    //                                       reactiondata[index]
    //                                           ["paylasimzamangecen"],
    //                                   style: TextStyle(
    //                                     color: Colors.grey,
    //                                     fontWeight: FontWeight.bold,
    //                                   ),
    //                                 ),
    //                                 Spacer(),
    //                                 InkWell(
    //                                   onTap: () {
    //                                     showModalBottomSheet<void>(
    //                                       shape: RoundedRectangleBorder(
    //                                         borderRadius: BorderRadius.vertical(
    //                                           top: Radius.circular(10),
    //                                         ),
    //                                       ),
    //                                       context: context,
    //                                       builder: (BuildContext context) {
    //                                         return Wrap(
    //                                           children: [
    //                                             Container(
    //                                               child: Column(
    //                                                 children: [
    //                                                   Padding(
    //                                                     padding: EdgeInsets
    //                                                         .symmetric(
    //                                                             vertical: 10),
    //                                                     child: Container(
    //                                                       decoration:
    //                                                           BoxDecoration(
    //                                                         color: Colors
    //                                                             .grey[900],
    //                                                         borderRadius:
    //                                                             BorderRadius
    //                                                                 .all(
    //                                                           Radius.circular(
    //                                                               30),
    //                                                         ),
    //                                                       ),
    //                                                       width:
    //                                                           screenwidth / 4,
    //                                                       height: 5,
    //                                                     ),
    //                                                   ),
    //                                                   InkWell(
    //                                                     onTap: () {
    //                                                       Navigator.pop(
    //                                                           context);
    //                                                     },
    //                                                     child: ListTile(
    //                                                       leading: Icon(
    //                                                           Icons.post_add),
    //                                                       title: Text(
    //                                                           "Postu favorilere ekle."),
    //                                                     ),
    //                                                   ),
    //                                                   Visibility(
    //                                                     visible: reactiondata[
    //                                                                     index][
    //                                                                 "sahipID"] ==
    //                                                             girisdata[
    //                                                                 "oyuncuID"]
    //                                                         ? true
    //                                                         : false,
    //                                                     child: InkWell(
    //                                                       onTap: () {
    //                                                         postID =
    //                                                             reactiondata[
    //                                                                     index]
    //                                                                 ["postID"];
    //                                                         // postsil();
    //                                                         Navigator.pop(
    //                                                             context);
    //                                                       },
    //                                                       child: ListTile(
    //                                                         leading: Icon(Icons
    //                                                             .edit_note),
    //                                                         title: Text(
    //                                                             "Postu düzenle."),
    //                                                       ),
    //                                                     ),
    //                                                   ),
    //                                                   Visibility(
    //                                                     visible: reactiondata[
    //                                                                     index][
    //                                                                 "sahipID"] ==
    //                                                             girisdata[
    //                                                                 "oyuncuID"]
    //                                                         ? true
    //                                                         : false,
    //                                                     child: InkWell(
    //                                                       onTap: () {
    //                                                         postID =
    //                                                             reactiondata[
    //                                                                     index]
    //                                                                 ["postID"];
    //                                                         postsil();
    //                                                         postcek();
    //                                                         Navigator.pop(
    //                                                             context);
    //                                                       },
    //                                                       child: ListTile(
    //                                                         leading: Icon(Icons
    //                                                             .delete_sweep_outlined),
    //                                                         title: Text(
    //                                                             "Postu kaldır."),
    //                                                       ),
    //                                                     ),
    //                                                   ),
    //                                                   Divider(),
    //                                                   InkWell(
    //                                                     onTap: () {
    //                                                       Navigator.pop(
    //                                                           context);
    //                                                     },
    //                                                     child: ListTile(
    //                                                       leading: Icon(Icons
    //                                                           .flag_outlined),
    //                                                       title: Text(
    //                                                           "Postu bildir."),
    //                                                     ),
    //                                                   ),
    //                                                   SizedBox(height: 10),
    //                                                 ],
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         );
    //                                       },
    //                                     );
    //                                   },
    //                                   child: Icon(
    //                                     Icons.more_vert,
    //                                     size: 20,
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                             SizedBox(height: screenheight / 90),
    //                             Text(
    //                               reactiondata[index]["sosyalicerik"],
    //                             ),
    //                             SizedBox(height: screenheight / 50),
    //                             Visibility(
    //                               visible: visible,
    //                               child: Container(
    //                                 child: gonderifotocek(),
    //                               ),
    //                             ),
    //                             SizedBox(height: screenheight / 65),
    //                             Container(
    //                               color: Colors.transparent,
    //                               width: screenwidth,
    //                               height: screenheight / 20,
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   LikeButton(
    //                                     onTap: (bool isLike) {
    //                                       return onLikeButtonTapped(
    //                                         isLike,
    //                                         index,
    //                                       );
    //                                     },
    //                                     countPostion: CountPostion.right,
    //                                     isLiked: reactiondata[index]
    //                                                 ["benbegendim"] !=
    //                                             0
    //                                         ? true
    //                                         : false,
    //                                     likeCount: int.parse(
    //                                         reactiondata[index]["begenisay"]),
    //                                     likeBuilder: (bool isLiked) {
    //                                       return isLiked
    //                                           ? Icon(
    //                                               Icons.favorite,
    //                                               color: Colors.red,
    //                                             )
    //                                           : Icon(
    //                                               Icons.favorite_outline,
    //                                               color: Colors.grey,
    //                                             );
    //                                     },
    //                                     bubblesColor: BubblesColor(
    //                                       dotPrimaryColor: Colors.red,
    //                                       dotSecondaryColor: Colors.blue,
    //                                     ),
    //                                   ),
    //                                   InkWell(
    //                                     onTap: () {
    //                                       Navigator.push(
    //                                         context,
    //                                         MaterialPageRoute(
    //                                           builder: (context) => AnaDetail(
    //                                             veri1: reactiondata[index]
    //                                                 ["sahipavatarminnak"],
    //                                             veri2: reactiondata[index]
    //                                                 ["sahipad"],
    //                                             veri3: reactiondata[index]
    //                                                 ["sosyalicerik"],
    //                                             veri4: reactiondata[index]
    //                                                 ["paylasimzaman"],
    //                                             veri5: reactiondata[index]
    //                                                 ["begenisay"],
    //                                             veri6: reactiondata[index]
    //                                                 ["yorumsay"],
    //                                             veri7: reactiondata[index]
    //                                                 ["repostsay"],
    //                                             veri8: reactiondata[index]
    //                                                 ["sikayetsay"],
    //                                             veri9: reactiondata[index]
    //                                                 ["benbegendim"],
    //                                             veri10: reactiondata[index]
    //                                                 ["postID"],
    //                                             veri11: reactiondata[index]
    //                                                 ["sahipID"],
    //                                             veri12: reactiondata[index]
    //                                                 ["paylasimnereden"],
    //                                             veri13: reactiondata[index]
    //                                                 ["benyorumladim"],
    //                                           ),
    //                                         ),
    //                                       );
    //                                       setState(() {
    //                                         detayid =
    //                                             reactiondata[index]["postID"];
    //                                         detaylink =
    //                                             "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
    //                                       });
    //                                     },
    //                                     child: Padding(
    //                                       padding: EdgeInsets.all(8.0),
    //                                       child: Row(
    //                                         children: [
    //                                           reactiondata[index]
    //                                                       ["benyorumladim"] ==
    //                                                   0
    //                                               ? Icon(
    //                                                   Icons.chat_bubble_outline,
    //                                                   color: Colors.grey,
    //                                                 )
    //                                               : Icon(
    //                                                   Icons.chat_bubble,
    //                                                   color: Colors.blue,
    //                                                 ),
    //                                           SizedBox(
    //                                             width: 10,
    //                                           ),
    //                                           (reactiondata[index]
    //                                                       ["yorumsay"] !=
    //                                                   "0")
    //                                               ? Text(
    //                                                   reactiondata[index]
    //                                                       ["yorumsay"],
    //                                                   style: TextStyle(
    //                                                     color: Colors.grey,
    //                                                   ),
    //                                                 )
    //                                               : Text(""),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   InkWell(
    //                                     onTap: () {},
    //                                     child: Padding(
    //                                       padding: EdgeInsets.all(8.0),
    //                                       child: Row(
    //                                         children: [
    //                                           Icon(
    //                                             Icons.repeat,
    //                                             color: Colors.grey,
    //                                           ),
    //                                           SizedBox(
    //                                             width: 5,
    //                                           ),
    //                                           (reactiondata[index]
    //                                                       ["repostsay"] !=
    //                                                   "0")
    //                                               ? Text(
    //                                                   reactiondata[index]
    //                                                       ["repostsay"],
    //                                                   style: TextStyle(
    //                                                     color: Colors.grey,
    //                                                   ),
    //                                                 )
    //                                               : Text(""),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   InkWell(
    //                                     onTap: () {
    //                                       Share.share(
    //                                         reactiondata[index]["sosyalicerik"],
    //                                       );
    //                                     },
    //                                     child: Padding(
    //                                       padding: EdgeInsets.all(8.0),
    //                                       child: Icon(
    //                                         Icons.share_outlined,
    //                                         color: Colors.grey,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   SizedBox(
    //                                     width: screenwidth / 15,
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               );
    //             },
    //             separatorBuilder: (context, index) => Divider(),
    //             itemCount: reactiondata.length,
    //             padding: EdgeInsets.only(
    //               top: 10,
    //               left: 10,
    //               right: 10,
    //               bottom: 10,
    //             ),
    //           )
    //         : Center(
    //             child: Text(
    //               profiledata["oyuncuID"] == girisdata["oyuncuID"]
    //                  ? "Henüz Gönderide Bulunmadın !"
    //                  : "Henüz Gönderide Bulunmamış !",
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 fontSize: 24,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ),
    //   ),
    // );
  }

  MyReactionView() {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    Future<void> _refresh() {
      return postcek();
    }

    return Center(
      child: Container(
        child: Text(
          "Çok Yakında...\nComing Soon...",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    // return RefreshIndicator(
    //   onRefresh: _refresh,
    //   child: Container(
    //     child: reactiondata.isNotEmpty
    //         ? ListView.separated(
    //             physics: BouncingScrollPhysics(),
    //             scrollDirection: Axis.vertical,
    //             itemBuilder: (context, index) {
    //               if (reactiondata[index]["paylasimfoto"] != null) {
    //                 gonderifotolar = postdata[index]["paylasimfoto"];
    //                 visible = true;
    //               } else {
    //                 visible = false;
    //               }
    //               return InkWell(
    //                 onTap: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => ThemeConsumer(
    //                         child: AnaDetail(
    //                           veri1: reactiondata[index]["sahipavatarminnak"],
    //                           veri2: reactiondata[index]["sahipad"],
    //                           veri3: reactiondata[index]["sosyalicerik"],
    //                           veri4: reactiondata[index]["paylasimzaman"],
    //                           veri5: reactiondata[index]["begenisay"],
    //                           veri6: reactiondata[index]["yorumsay"],
    //                           veri7: reactiondata[index]["repostsay"],
    //                           veri8: reactiondata[index]["sikayetsay"],
    //                           veri9: reactiondata[index]["benbegendim"],
    //                           veri10: reactiondata[index]["postID"],
    //                           veri11: reactiondata[index]["sahipID"],
    //                           veri12: reactiondata[index]["paylasimnereden"],
    //                           veri13: reactiondata[index]["benyorumladim"],
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                   setState(() {
    //                     detayid = reactiondata[index]["postID"];
    //                     detaylink =
    //                         "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
    //                   });
    //                 },
    //                 child: Container(
    //                   child: Row(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       CircleAvatar(
    //                         radius: screenwidth / 12,
    //                         backgroundImage: NetworkImage(
    //                           reactiondata[index]["sahipavatarminnak"],
    //                         ),
    //                         backgroundColor: Colors.transparent,
    //                       ),
    //                       SizedBox(width: screenwidth / 35),
    //                       Expanded(
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 Text(
    //                                   reactiondata[index]["sahipad"],
    //                                   style: TextStyle(
    //                                     fontWeight: FontWeight.bold,
    //                                   ),
    //                                 ),
    //                                 Text(
    //                                   "  -  " +
    //                                       reactiondata[index]
    //                                           ["paylasimzamangecen"],
    //                                   style: TextStyle(
    //                                     color: Colors.grey,
    //                                     fontWeight: FontWeight.bold,
    //                                   ),
    //                                 ),
    //                                 Spacer(),
    //                                 InkWell(
    //                                   onTap: () {
    //                                     showModalBottomSheet<void>(
    //                                       shape: RoundedRectangleBorder(
    //                                         borderRadius: BorderRadius.vertical(
    //                                           top: Radius.circular(10),
    //                                         ),
    //                                       ),
    //                                       context: context,
    //                                       builder: (BuildContext context) {
    //                                         return Wrap(
    //                                           children: [
    //                                             Container(
    //                                               child: Column(
    //                                                 children: [
    //                                                   Padding(
    //                                                     padding: EdgeInsets
    //                                                         .symmetric(
    //                                                             vertical: 10),
    //                                                     child: Container(
    //                                                       decoration:
    //                                                           BoxDecoration(
    //                                                         color: Colors
    //                                                             .grey[900],
    //                                                         borderRadius:
    //                                                             BorderRadius
    //                                                                 .all(
    //                                                           Radius.circular(
    //                                                               30),
    //                                                         ),
    //                                                       ),
    //                                                       width:
    //                                                           screenwidth / 4,
    //                                                       height: 5,
    //                                                     ),
    //                                                   ),
    //                                                   InkWell(
    //                                                     onTap: () {
    //                                                       Navigator.pop(
    //                                                           context);
    //                                                     },
    //                                                     child: ListTile(
    //                                                       leading: Icon(
    //                                                           Icons.post_add),
    //                                                       title: Text(
    //                                                           "Postu favorilere ekle."),
    //                                                     ),
    //                                                   ),
    //                                                   Visibility(
    //                                                     visible: reactiondata[
    //                                                                     index][
    //                                                                 "sahipID"] ==
    //                                                             girisdata[
    //                                                                 "oyuncuID"]
    //                                                         ? true
    //                                                         : false,
    //                                                     child: InkWell(
    //                                                       onTap: () {
    //                                                         postID =
    //                                                             reactiondata[
    //                                                                     index]
    //                                                                 ["postID"];
    //                                                         // postsil();
    //                                                         Navigator.pop(
    //                                                             context);
    //                                                       },
    //                                                       child: ListTile(
    //                                                         leading: Icon(Icons
    //                                                             .edit_note),
    //                                                         title: Text(
    //                                                             "Postu düzenle."),
    //                                                       ),
    //                                                     ),
    //                                                   ),
    //                                                   Visibility(
    //                                                     visible: reactiondata[
    //                                                                     index][
    //                                                                 "sahipID"] ==
    //                                                             girisdata[
    //                                                                 "oyuncuID"]
    //                                                         ? true
    //                                                         : false,
    //                                                     child: InkWell(
    //                                                       onTap: () {
    //                                                         postID =
    //                                                             reactiondata[
    //                                                                     index]
    //                                                                 ["postID"];
    //                                                         postsil();
    //                                                         postcek();
    //                                                         Navigator.pop(
    //                                                             context);
    //                                                       },
    //                                                       child: ListTile(
    //                                                         leading: Icon(Icons
    //                                                             .delete_sweep_outlined),
    //                                                         title: Text(
    //                                                             "Postu kaldır."),
    //                                                       ),
    //                                                     ),
    //                                                   ),
    //                                                   Divider(),
    //                                                   InkWell(
    //                                                     onTap: () {
    //                                                       Navigator.pop(
    //                                                           context);
    //                                                     },
    //                                                     child: ListTile(
    //                                                       leading: Icon(Icons
    //                                                           .flag_outlined),
    //                                                       title: Text(
    //                                                           "Postu bildir."),
    //                                                     ),
    //                                                   ),
    //                                                   SizedBox(height: 10),
    //                                                 ],
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         );
    //                                       },
    //                                     );
    //                                   },
    //                                   child: Icon(
    //                                     Icons.more_vert,
    //                                     size: 20,
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                             SizedBox(height: screenheight / 90),
    //                             Text(
    //                               reactiondata[index]["sosyalicerik"],
    //                             ),
    //                             SizedBox(height: screenheight / 50),
    //                             Visibility(
    //                               visible: visible,
    //                               child: Container(
    //                                 child: gonderifotocek(),
    //                               ),
    //                             ),
    //                             SizedBox(height: screenheight / 65),
    //                             Container(
    //                               color: Colors.transparent,
    //                               width: screenwidth,
    //                               height: screenheight / 20,
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   LikeButton(
    //                                     onTap: (bool isLike) {
    //                                       return onLikeButtonTapped(
    //                                         isLike,
    //                                         index,
    //                                       );
    //                                     },
    //                                     countPostion: CountPostion.right,
    //                                     isLiked: reactiondata[index]
    //                                                 ["benbegendim"] !=
    //                                             0
    //                                         ? true
    //                                         : false,
    //                                     likeCount: int.parse(
    //                                         reactiondata[index]["begenisay"]),
    //                                     likeBuilder: (bool isLiked) {
    //                                       return isLiked
    //                                           ? Icon(
    //                                               Icons.favorite,
    //                                               color: Colors.red,
    //                                             )
    //                                           : Icon(
    //                                               Icons.favorite_outline,
    //                                               color: Colors.grey,
    //                                             );
    //                                     },
    //                                     bubblesColor: BubblesColor(
    //                                       dotPrimaryColor: Colors.red,
    //                                       dotSecondaryColor: Colors.blue,
    //                                     ),
    //                                   ),
    //                                   InkWell(
    //                                     onTap: () {
    //                                       Navigator.push(
    //                                         context,
    //                                         MaterialPageRoute(
    //                                           builder: (context) => AnaDetail(
    //                                             veri1: reactiondata[index]
    //                                                 ["sahipavatarminnak"],
    //                                             veri2: reactiondata[index]
    //                                                 ["sahipad"],
    //                                             veri3: reactiondata[index]
    //                                                 ["sosyalicerik"],
    //                                             veri4: reactiondata[index]
    //                                                 ["paylasimzaman"],
    //                                             veri5: reactiondata[index]
    //                                                 ["begenisay"],
    //                                             veri6: reactiondata[index]
    //                                                 ["yorumsay"],
    //                                             veri7: reactiondata[index]
    //                                                 ["repostsay"],
    //                                             veri8: reactiondata[index]
    //                                                 ["sikayetsay"],
    //                                             veri9: reactiondata[index]
    //                                                 ["benbegendim"],
    //                                             veri10: reactiondata[index]
    //                                                 ["postID"],
    //                                             veri11: reactiondata[index]
    //                                                 ["sahipID"],
    //                                             veri12: reactiondata[index]
    //                                                 ["paylasimnereden"],
    //                                             veri13: reactiondata[index]
    //                                                 ["benyorumladim"],
    //                                           ),
    //                                         ),
    //                                       );
    //                                       setState(() {
    //                                         detayid =
    //                                             reactiondata[index]["postID"];
    //                                         detaylink =
    //                                             "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
    //                                       });
    //                                     },
    //                                     child: Padding(
    //                                       padding: EdgeInsets.all(8.0),
    //                                       child: Row(
    //                                         children: [
    //                                           reactiondata[index]
    //                                                       ["benyorumladim"] ==
    //                                                   0
    //                                               ? Icon(
    //                                                   Icons.chat_bubble_outline,
    //                                                   color: Colors.grey,
    //                                                 )
    //                                               : Icon(
    //                                                   Icons.chat_bubble,
    //                                                   color: Colors.blue,
    //                                                 ),
    //                                           SizedBox(
    //                                             width: 10,
    //                                           ),
    //                                           (reactiondata[index]
    //                                                       ["yorumsay"] !=
    //                                                   "0")
    //                                               ? Text(
    //                                                   reactiondata[index]
    //                                                       ["yorumsay"],
    //                                                   style: TextStyle(
    //                                                     color: Colors.grey,
    //                                                   ),
    //                                                 )
    //                                               : Text(""),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   InkWell(
    //                                     onTap: () {},
    //                                     child: Padding(
    //                                       padding: EdgeInsets.all(8.0),
    //                                       child: Row(
    //                                         children: [
    //                                           Icon(
    //                                             Icons.repeat,
    //                                             color: Colors.grey,
    //                                           ),
    //                                           SizedBox(
    //                                             width: 5,
    //                                           ),
    //                                           (reactiondata[index]
    //                                                       ["repostsay"] !=
    //                                                   "0")
    //                                               ? Text(
    //                                                   reactiondata[index]
    //                                                       ["repostsay"],
    //                                                   style: TextStyle(
    //                                                     color: Colors.grey,
    //                                                   ),
    //                                                 )
    //                                               : Text(""),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   InkWell(
    //                                     onTap: () {
    //                                       Share.share(
    //                                         reactiondata[index]["sosyalicerik"],
    //                                       );
    //                                     },
    //                                     child: Padding(
    //                                       padding: EdgeInsets.all(8.0),
    //                                       child: Icon(
    //                                         Icons.share_outlined,
    //                                         color: Colors.grey,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   SizedBox(
    //                                     width: screenwidth / 15,
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               );
    //             },
    //             separatorBuilder: (context, index) => Divider(),
    //             itemCount: reactiondata.length,
    //             padding: EdgeInsets.only(
    //               top: 10,
    //               left: 10,
    //               right: 10,
    //               bottom: 10,
    //             ),
    //           )
    //         : Center(
    //             child: Text(
    //               profiledata["oyuncuID"] == girisdata["oyuncuID"]
    //                  ? "Henüz Gönderide Bulunmadın !"
    //                  : "Henüz Gönderide Bulunmamış !",
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 fontSize: 24,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ),
    //   ),
    // );
  }

  Widget _MainListView(
    BuildContext context,
    int index,
    double screenwidth,
    double screenheight,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThemeConsumer(
              child: AnaDetail(
                veri1: postdata[index]["sahipavatarminnak"],
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
                veri14: postdata[index]["oyunculink"],
              ),
            ),
          ),
        );

        setState(() {
          detayid = postdata[index]["postID"];

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
              backgroundImage: CachedNetworkImageProvider(
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
                        "  -  " + postdata[index]["paylasimzamangecen"],
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[900],
                                                borderRadius: BorderRadius.all(
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
                                              leading: Icon(Icons.post_add),
                                              title: Text(
                                                  "Postu favorilere ekle."),
                                            ),
                                          ),
                                          Visibility(
                                            visible: postdata[index]
                                                        ["sahipID"] ==
                                                    girisdata["oyuncuID"]
                                                ? true
                                                : false,
                                            child: InkWell(
                                              onTap: () {
                                                postID =
                                                    postdata[index]["postID"];
                                                // postsil();
                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                leading: Icon(Icons.edit_note),
                                                title: Text("Postu düzenle."),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: postdata[index]
                                                        ["sahipID"] ==
                                                    girisdata["oyuncuID"]
                                                ? true
                                                : false,
                                            child: InkWell(
                                              onTap: () {
                                                postID =
                                                    postdata[index]["postID"];
                                                postsil();
                                                postcek();

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                leading: Icon(Icons
                                                    .delete_sweep_outlined),
                                                title: Text("Postu kaldır."),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.veri1 ==
                                                    girisdata["oyuncuID"]
                                                ? false
                                                : true,
                                            child: Divider(),
                                          ),
                                          Visibility(
                                            visible: widget.veri1 ==
                                                    girisdata["oyuncuID"]
                                                ? false
                                                : true,
                                            child: InkWell(
                                              onTap: () {
                                                // postID =
                                                //     widget.veri10;
                                                // postbildir();
                                                Navigator.pop(context);
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(
                                                //   const SnackBar(
                                                //     content:
                                                //         Text("Bildirildi !"),
                                                //     shape:
                                                //         const StadiumBorder(),
                                                //   ),
                                                // );
                                                Fluttertoast.showToast(
                                                  msg: "Bildirildi !",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
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
                                            visible: profiledata["oyuncuID"] ==
                                                    girisdata["oyuncuID"]
                                                ? false
                                                : true,
                                            child: InkWell(
                                              onTap: () {
                                                profileID = widget.veri1;
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
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
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
                                                title: Text(
                                                    "Kullanıcıyı engelle."),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.veri1 ==
                                                    girisdata["oyuncuID"]
                                                ? false
                                                : true,
                                            child: InkWell(
                                              onTap: () {
                                                // postID =
                                                //     widget.veri10;
                                                // postbildir();
                                                Navigator.pop(context);
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(
                                                //   const SnackBar(
                                                //     content:
                                                //         Text("Bildirildi !"),
                                                //     shape:
                                                //         const StadiumBorder(),
                                                //   ),
                                                // );
                                                Fluttertoast.showToast(
                                                  msg: "Bildirildi !",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
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
                                                title:
                                                    Text("Kullanıcıyı bildir."),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
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
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenheight / 90),
                  DetectableText(
                    detectionRegExp: RegExp(
                      "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                      multiLine: true,
                    ),
                    text: postdata[index]["sosyalicerik"],
                    basicStyle: TextStyle(
                      fontSize: 16,
                    ),
                    detectedStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: screenheight / 50),
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
                  SizedBox(height: screenheight / 65),
                  Container(
                    color: Colors.transparent,
                    width: screenwidth,
                    height: screenheight / 20,
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
                          isLiked: postdata[index]["benbegendim"] != 0
                              ? true
                              : false,
                          likeCount: postdata[index]["begenisay"] != "0"
                              ? int.parse(postdata[index]["begenisay"])
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
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnaDetail(
                                  veri1: postdata[index]["sahipavatarminnak"],
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
                                  veri14: postdata[index]["oyunculink"],
                                ),
                              ),
                            );

                            setState(() {
                              detayid = postdata[index]["postID"];

                              detaylink =
                                  "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                postdata[index]["benyorumladim"] == 0
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
                                (postdata[index]["yorumsay"] != "0")
                                    ? Text(
                                        postdata[index]["yorumsay"],
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
                                (postdata[index]["repostsay"] != "0")
                                    ? Text(
                                        postdata[index]["repostsay"],
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
  }

  Widget _horizontalArkadasListView() {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        controller: profilePageArkadasScrollController,
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {},
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  image: NetworkImage(xpsiralama[index]["oyuncuavatar"]),
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
                    stops: [0.0, 0.4],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 7),
                    child: Text(
                      xpsiralama[index]["oyuncuadsoyad"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 20),
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return PreferredSize(
      preferredSize: Size(screenwidth, 48),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        width: screenwidth,
        child: TabBar(
          onTap: (value) {
            profileCurrentIndex == value && profileCurrentIndex == 0
                ? profileScrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOut,
                  )
                : null;

            profileCurrentIndex == value && profileCurrentIndex == 1
                ? profileScrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOut,
                  )
                : null;

            profileCurrentIndex == value && profileCurrentIndex == 2
                ? profileScrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOut,
                  )
                : null;

            profileCurrentIndex == value && profileCurrentIndex == 3
                ? profileScrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOut,
                  )
                : null;

            profileCurrentIndex = value;
          },
          isScrollable: true,
          indicatorColor: Colors.blue,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          tabs: [
            Tab(text: "Postlar"),
            Tab(text: "Medya"),
            Tab(text: "Favorilerim"),
            Tab(text: "Tepki Verdiklerim"),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class ACustomSliverHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: Delegate(),
    );
  }
}
