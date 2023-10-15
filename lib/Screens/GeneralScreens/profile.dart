// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_element

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:skeletons/skeletons.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  String veri1;

  Profile({
    Key? key,
    required this.veri1,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  @override
  initState() {
    profiledata = null;
    editeposta.clear();
    edithakkimda.clear();
    editvalidation.clear();
    postdata.clear();
    medyadata.clear();
    resimler.clear();
    profileFriends.clear();
    profilcek();
    postcek();
    medyacek();
    isSocial = false;
    isEditProfileIconShow = false;
    super.initState();
  }

  List resimler = [];

  profilcek() async {
    http.post(
      Uri.parse(oturumkontrolurl),
      body: {
        "oyuncubakid": widget.veri1,
      },
    ).then((cevap) async {
      try {
        profiledata = jsonDecode(cevap.body);
        profileFriends = profiledata["arkadasliste"];
        sosyalLink();
        editeposta.text = profiledata["eposta"];
        edithakkimda.text = profiledata["hakkimda"];
      } catch (e) {
        print('Unknown exception: $e');
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  postcek() async {
    http.post(
      Uri.parse(postlink),
      body: {
        "oyuncubakid": widget.veri1,
      },
    ).then((cevap) {
      if (mounted) {
        setState(() {
          try {
            postdata = jsonDecode(cevap.body);
          } catch (e) {
            print('Unknown exception: $e');
          }
        });
      }
    });
  }

  medyacek() async {
    http.post(
      Uri.parse(medyalink),
      body: {
        "oyuncubakid": widget.veri1,
      },
    ).then((cevap) {
      if (mounted) {
        setState(() {
          try {
            medyadata = jsonDecode(cevap.body);
            // print(medyadata);
          } catch (e) {
            print('Unknown exception: $e');
          }
          if (medyadata.isNotEmpty) {
            for (var i = 0; i < medyadata.length; i++) {
              resimler.add(medyadata[i]["medyaufaklik"]);
            }
          } else {
            print("resim yok");
          }
        });
      }
    });
  }

  medyaSil(content) async {
    var gelen = await http.post(
      Uri.parse(medyaSilLink),
      body: {
        "medyaID": content,
      },
    );
    // print(content);

    try {
      response = jsonDecode(gelen.body);
      print(response["durum"]);

      if (response["durum"] == 1) {
        print(response["aciklama"]);
        medyadata.clear();
        resimler.clear();
        await medyacek();
      } else {
        print(response["aciklama"]);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["aciklama"]),
        ),
      );
    } catch (e) {
      print(e);
    }
    if (mounted) {
      setState(() {});
    }
  }

  gonderifotocek() {
    // anasayfa video kısmı.

    if (gonderifotolar.length == 1 &&
        gonderifotolar[0]["paylasimkategori"] == "video/mp4") {
      // return const Text("-- Video --");

      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: VideoWidget(
          play: false,
          url: gonderifotolar[0]["fotoufakurl"],
        ),
      );

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
      // return const Text("-- Video --");

      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: VideoWidget(
          play: false,
          url: gonderifotolar[0]["fotoufakurl"],
        ),
      );

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
                width: double.infinity,
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
                width: double.infinity,
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
                width: double.infinity,
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
                width: double.infinity,
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
                      width: double.infinity,
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
                width: double.infinity,
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
                width: double.infinity,
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
                width: double.infinity,
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
                width: double.infinity,
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
                      width: double.infinity,
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
                width: double.infinity,
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
                width: double.infinity,
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
                width: double.infinity,
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
                width: double.infinity,
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
                      width: double.infinity,
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
                width: double.infinity,
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
                width: double.infinity,
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
                width: double.infinity,
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
                width: double.infinity,
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
                      width: double.infinity,
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
    if (mounted) {
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
    }
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
    ).then((cevap) async {
      try {
        response = jsonDecode(cevap.body);
        print(response["durum"]);

        if (response["durum"] == 1) {
          await profilcek();
          if (mounted) {
            setState(() {});
          }
        }

        if (response["durum"] != 1) {
          print(response["aciklama"]);
        }
      } catch (e) {
        print(e);
      }
    });
  }

  arkadasCikar() async {
    http.post(
      Uri.parse(arkadascikarlink),
      body: {
        "oyuncubakid": widget.veri1,
      },
    ).then((cevap) async {
      try {
        response = jsonDecode(cevap.body);
        print(response["durum"]);

        if (response["durum"] == 1) {
          await profilcek();
          if (mounted) {
            setState(() {});
          }
        }

        if (response["durum"] != 1) {
          print(response["aciklama"]);
        }
      } catch (e) {
        print(e);
      }
    });
  }

  sosyalLink() async {
    // print(isSocial);
    if (profiledata["github"] != "" ||
        profiledata["linkedin"] != "" ||
        profiledata["reddit"] != "" ||
        profiledata["twitch"] != null ||
        profiledata["youtube"] != null ||
        profiledata["instagram"] != null ||
        profiledata["facebook"] != null) {
      if (mounted) {
        setState(() {
          isSocial = true;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isSocial = false;
        });
      }
    }
    // print(isSocial);
  }

  Widget friendWidget() {
    if (profileFriends.isNotEmpty) {
      if (profileFriends.length == 1) {
        return Row(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                profileFriends[0]["oyuncuminnakavatar"],
              ),
            ),
          ],
        );
      } else if (profileFriends.length == 2) {
        return Stack(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                profileFriends[0]["oyuncuminnakavatar"],
              ),
            ),
            Positioned(
              left: 25,
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  profileFriends[1]["oyuncuminnakavatar"],
                ),
              ),
            ),
          ],
        );
      } else if (profileFriends.length == 3) {
        return Stack(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                profileFriends[0]["oyuncuminnakavatar"],
              ),
            ),
            Positioned(
              left: 25,
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  profileFriends[1]["oyuncuminnakavatar"],
                ),
              ),
            ),
            Positioned(
              left: 50,
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  profileFriends[2]["oyuncuminnakavatar"],
                ),
              ),
            ),
          ],
        );
      }
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    showValidationAlertDialog(BuildContext context) {
      showValidationErrorAlertDialog(BuildContext context) {
        AlertDialog alert = const AlertDialog(
          title: Text(
            "Hatalı parola!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }

      showValidationEmptyAlertDialog(BuildContext context) {
        AlertDialog alert = const AlertDialog(
          title: Text(
            "Parola boş olmamalı!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }

      AlertDialog alert = AlertDialog(
        title: const Text(
          "Parolanızı dogrulayın",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.password],
          controller: editvalidation,
          onEditingComplete: () => TextInput.finishAutofillContext(),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          InkWell(
            onTap: () {
              editvalidation.text.isNotEmpty
                  ? {
                      if (gkontrolSifre == editvalidation.text ||
                          sifre.text == editvalidation.text)
                        {
                          print("başarılı"),
                          // bura
                        }
                      else if (gkontrolSifre != editvalidation.text ||
                          sifre.text != editvalidation.text)
                        {
                          print("hatalı"),
                          showValidationErrorAlertDialog(context),
                        }
                    }
                  : {
                      showValidationEmptyAlertDialog(context),
                    };

              // if (sifre.text == editvalidation.text) {
              //   print("object");
              //   Navigator.of(context).pop();
              // } else if (sifre.text != editvalidation.text) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(
              //       content: Text("Parola yanlış!"),
              //     ),
              //   );
              // }
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: const Padding(
                padding: EdgeInsets.all(13),
                child: Text(
                  "Onayla",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

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
                                              width: screenWidth / 4,
                                              height: 5,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Share.share(
                                                  profiledata["oyunculink"]);
                                              Navigator.pop(context);
                                            },
                                            child: ListTile(
                                              leading: const Icon(
                                                  Icons.share_outlined),
                                              title: Text(shareProfile),
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

                                              Fluttertoast.showToast(
                                                msg: "Kopyalandı !",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                              );
                                            },
                                            child: ListTile(
                                              leading: const Icon(
                                                  Icons.content_copy),
                                              title: Text(copyProfileLink),
                                            ),
                                          ),
                                          Visibility(
                                            visible: profiledata["oyuncuID"] ==
                                                    girisdata["oyuncuID"]
                                                ? true
                                                : false,
                                            child: InkWell(
                                              onTap: () async {
                                                if (mounted) {
                                                  setState(() {
                                                    isEditProfileIconShow =
                                                        true;
                                                  });
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                leading: const Icon(
                                                  Icons.edit_outlined,
                                                ),
                                                title: Text(
                                                    editProfileModalBottomSheet),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: profiledata["oyuncuID"] ==
                                                    girisdata["oyuncuID"]
                                                ? false
                                                : true,
                                            child: const Divider(),
                                          ),
                                          Visibility(
                                            visible: profiledata["oyuncuID"] ==
                                                    girisdata["oyuncuID"]
                                                ? false
                                                : profiledata["arkadasdurum"] ==
                                                        "1"
                                                    ? true
                                                    : false,
                                            child: InkWell(
                                              onTap: () async {
                                                profileID = widget.veri1;
                                                Navigator.pop(context);

                                                await arkadasCikar();
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Arkadaşlardan Çıkarıldı !",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                );
                                              },
                                              child: ListTile(
                                                textColor: Colors.red,
                                                leading: const Icon(
                                                  Icons.person_off_outlined,
                                                  color: Colors.red,
                                                ),
                                                title: Text(removeFriend),
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
                                                // postbildir();
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(
                                                  msg: "Engellendi !",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                );
                                              },
                                              child: ListTile(
                                                textColor: Colors.red,
                                                leading: const Icon(
                                                  Icons.person_off_outlined,
                                                  color: Colors.red,
                                                ),
                                                title: Text(blockUser),
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
                                                // print(profileID);
                                                Navigator.pop(context);
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
                            child: const Icon(Icons.more_vert),
                          ),
                        ),
                        const SizedBox(width: 10),
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
                                      Visibility(
                                        visible: Platform.isIOS ? true : false,
                                        child: const SizedBox(width: 48),
                                      ),
                                      Text(
                                        profiledata["adim"],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Visibility(
                                        visible: profiledata["oyuncuID"] == "11"
                                            ? true
                                            : false,
                                        child: const Icon(
                                          Icons.check_circle,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                            background: FocusedMenuHolder(
                              menuItems: [
                                FocusedMenuItem(
                                  title: const Text("Open"),
                                  trailingIcon: const Icon(Icons.open_in_new),
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
                                  title: const Text("Share"),
                                  trailingIcon: const Icon(Icons.share),
                                  onPressed: () {
                                    Share.share(profiledata["parkaresim"]);
                                  },
                                ),
                                FocusedMenuItem(
                                  title: const Text("Save to Gallery"),
                                  trailingIcon:
                                      const Icon(Icons.file_download_outlined),
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
                                            maxScale: 5.0,
                                            minScale: 0.3,
                                            backgroundDecoration:
                                                const BoxDecoration(
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
                      child: SizedBox(
                        width: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
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
                                        title: const Text("Open"),
                                        trailingIcon:
                                            const Icon(Icons.open_in_new),
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
                                        title: const Text("Share"),
                                        trailingIcon: const Icon(Icons.share),
                                        onPressed: () {
                                          Share.share(profiledata["presim"]);
                                        },
                                      ),
                                      FocusedMenuItem(
                                        title: const Text("Save to Gallery"),
                                        trailingIcon: const Icon(
                                            Icons.file_download_outlined),
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
                                                      ? int.parse(
                                                          "0xFF${profiledata["seviyerenk"]}")
                                                      : 0xFF,
                                                ),
                                                child: CircleAvatar(
                                                  radius: 45,
                                                  backgroundImage: NetworkImage(
                                                    profiledata["presimminnak"],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Visibility(
                                                  visible:
                                                      profiledata["seviye"] != 0
                                                          ? true
                                                          : false,
                                                  child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(
                                                        profiledata["seviyerenk"] !=
                                                                false
                                                            ? int.parse(
                                                                "0xFF${profiledata["seviyerenk"]}")
                                                            : 0xFF,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        profiledata["seviye"],
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
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
                                                child: PhotoView(
                                                  maxScale: 5.0,
                                                  minScale: 0.3,
                                                  backgroundDecoration:
                                                      const BoxDecoration(
                                                          color: Colors
                                                              .transparent),
                                                  imageProvider:
                                                      CachedNetworkImageProvider(
                                                    profiledata["presimufak"],
                                                  ),
                                                  filterQuality:
                                                      FilterQuality.high,
                                                ),
                                                // child: CircleAvatar(
                                                //   radius: 100,
                                                //   backgroundImage: NetworkImage(
                                                //     profiledata["presimufak"],
                                                //   ),
                                                //   backgroundColor:
                                                //       Colors.transparent,
                                                // ),
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
                                      InkWell(
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                          left: Radius.circular(30),
                                          right: Radius.circular(30),
                                        ),
                                        onTap: () async {
                                          profiledata["oyuncuID"] ==
                                                  girisdata["oyuncuID"]
                                              ? {
                                                  editeposta.text =
                                                      profiledata["eposta"],
                                                  edithakkimda.text =
                                                      profiledata["hakkimda"],
                                                  if (mounted)
                                                    {
                                                      setState(() {}),
                                                    },
                                                  showModalBottomSheet<void>(
                                                    isScrollControlled: true,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        top:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return FractionallySizedBox(
                                                        heightFactor: 0.9,
                                                        child: SafeArea(
                                                          child: InkWell(
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            splashColor: Colors
                                                                .transparent,
                                                            onTap: () =>
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus(),
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const SizedBox(
                                                                          width:
                                                                              20),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          editeposta.text =
                                                                              profiledata["eposta"];
                                                                          edithakkimda.text =
                                                                              profiledata["hakkimda"];
                                                                          if (mounted) {
                                                                            setState(() {});
                                                                          }
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "İptal et",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const Spacer(),
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.grey[900],
                                                                          borderRadius:
                                                                              const BorderRadius.all(
                                                                            Radius.circular(30),
                                                                          ),
                                                                        ),
                                                                        width:
                                                                            screenWidth /
                                                                                4,
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      const Spacer(),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          editvalidation
                                                                              .clear();
                                                                          showValidationAlertDialog(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "Kaydet",
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              20),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    CachedNetworkImage(
                                                                      imageUrl:
                                                                          profiledata[
                                                                              "parkaresimufak"],
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      filterQuality:
                                                                          FilterQuality
                                                                              .high,
                                                                      height:
                                                                          screenHeight /
                                                                              5,
                                                                    ),
                                                                    Positioned(
                                                                      right: 15,
                                                                      bottom:
                                                                          15,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {},
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .add_a_photo_outlined,
                                                                          size:
                                                                              48,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          10,
                                                                          15,
                                                                          10,
                                                                          10),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Stack(
                                                                            children: [
                                                                              CircleAvatar(
                                                                                radius: 45,
                                                                                backgroundImage: NetworkImage(
                                                                                  profiledata["presimminnak"],
                                                                                ),
                                                                              ),
                                                                              Positioned(
                                                                                right: 15,
                                                                                bottom: 15,
                                                                                child: InkWell(
                                                                                  onTap: () {},
                                                                                  child: const Icon(
                                                                                    Icons.add_a_photo_outlined,
                                                                                    size: 32,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                Text(
                                                                              "E-mail",
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 16,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child:
                                                                                TextField(
                                                                              controller: editeposta,
                                                                              keyboardType: TextInputType.emailAddress,
                                                                              textInputAction: TextInputAction.next,
                                                                              autofillHints: const [
                                                                                AutofillHints.email
                                                                              ],
                                                                              decoration: const InputDecoration(
                                                                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                                                              ),
                                                                              onEditingComplete: () => TextInput.finishAutofillContext(),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const Divider(),
                                                                      Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                Text(
                                                                              "Hakkımda",
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 16,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child:
                                                                                TextField(
                                                                              controller: edithakkimda,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: const InputDecoration(
                                                                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                                                              ),
                                                                              onEditingComplete: () => TextInput.finishAutofillContext(),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const Divider(),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),

                                                  // if (mounted)
                                                  //   {
                                                  //     setState(() {
                                                  //       isEditProfileIconShow =
                                                  //           true;
                                                  //     }),
                                                  //   }
                                                }
                                              : {
                                                  if (profiledata[
                                                          "arkadasdurumaciklama"] ==
                                                      "Arkadaş ol")
                                                    {
                                                      await arkadasol(),
                                                    }

                                                  // if (profiledata[
                                                  //         "arkadasdurum"] ==
                                                  //     "1")
                                                  //   {
                                                  //     if (mounted)
                                                  //       {
                                                  //         setState(() {
                                                  //           arkadasText =
                                                  //               "Mesaj Gönder";
                                                  //         }),
                                                  //       },
                                                  //     // print("Mesaj Gönder"),
                                                  //     ScaffoldMessenger.of(
                                                  //             context)
                                                  //         .showSnackBar(
                                                  //       const SnackBar(
                                                  //         duration: Duration(
                                                  //             seconds: 1),
                                                  //         content:
                                                  //             Text("Yakında !"),
                                                  //       ),
                                                  //     ),
                                                  //   }
                                                  // else if (profiledata[
                                                  //         "arkadasdurum"] ==
                                                  //     "0")
                                                  //   {
                                                  //     if (mounted)
                                                  //       {
                                                  //         setState(() {
                                                  //           arkadasText =
                                                  //               "Bekleniyor...";
                                                  //         }),
                                                  //       },
                                                  //     // print("Arkadaş Ol"),
                                                  //     await arkadasol(),
                                                  //   }
                                                };
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 150,
                                          decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.horizontal(
                                              left: Radius.circular(30),
                                              right: Radius.circular(30),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              profiledata["oyuncuID"] ==
                                                      girisdata["oyuncuID"]
                                                  ? editProfile
                                                  : profiledata[
                                                      "arkadasdurumaciklama"],
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: 150,
                                        height: 40,
                                        child: Visibility(
                                          visible: profileFriends.isNotEmpty
                                              ? true
                                              : false,
                                          child: InkWell(
                                            onTap: () {},
                                            child: friendWidget(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    profiledata["adim"],
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  profiledata["oyuncuID"] == "11"
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: Colors.blue,
                                          size: 20,
                                        )
                                      : const Text(""),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "@${profiledata["kullaniciadi"]}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    profiledata["yetkisiacikla"],
                                    style: TextStyle(
                                      color: Color(
                                        int.parse(
                                            "0xFF${profiledata["yetkirenk"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: profiledata["hakkimda"] != ""
                                    ? true
                                    : false,
                                child: const SizedBox(height: 15),
                              ),
                              // !isEditProfileIconShow ?
                              Visibility(
                                visible: profiledata["hakkimda"] != ""
                                    ? true
                                    : false,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onLongPress: () async {
                                    Clipboard.setData(
                                      ClipboardData(
                                        text: profiledata["hakkimda"],
                                      ),
                                    ).then((_) {
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
                                    trimExpandedText: " Daha Az",
                                    trimCollapsedText: " Daha Fazla",
                                    lessStyle:
                                        const TextStyle(color: Colors.grey),
                                    moreStyle:
                                        const TextStyle(color: Colors.grey),
                                    trimMode: TrimMode.Line,
                                    basicStyle: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    detectedStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              // : TextField(
                              //     controller: hakkimda,
                              //     decoration: InputDecoration(
                              //       suffixIcon: IconButton(
                              //         onPressed: () async {
                              //           await editProfie(hakkimda.text);
                              //           hakkimda.clear();
                              //           if (mounted) {
                              //             setState(() {
                              //               isEditProfileIconShow = false;
                              //             });
                              //           }
                              //           profilcek();
                              //           if (mounted) {
                              //             setState(() {});
                              //           }
                              //         },
                              //         icon: const Icon(
                              //           Icons.send,
                              //           color: Colors.blue,
                              //         ),
                              //       ),
                              //       enabledBorder: const OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //           width: 3,
                              //           color: Colors.grey,
                              //         ),
                              //       ),
                              //       focusedBorder: const OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //           width: 3,
                              //           color: Colors.grey,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    profiledata["ulkesi"] +
                                        ", " +
                                        profiledata["ili"],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    profiledata["kayittarihikisa"],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Visibility(
                                visible: profiledata["isyeriadi"] != null
                                    ? true
                                    : false,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.school,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 3),
                                    Flexible(
                                      child: Text(
                                        profiledata["isyeriadi"] ?? "",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Visibility(
                                visible: isSocial,
                                child: SizedBox(
                                  height: 50,
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Visibility(
                                        visible:
                                            profiledata["github"] == null ||
                                                    profiledata["github"] == ""
                                                ? false
                                                : true,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Site(
                                                  verilink:
                                                      profiledata["github"],
                                                  veribaslik: "Github",
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            FontAwesomeIcons.github,
                                            color: ThemeProvider.controllerOf(
                                                            context)
                                                        .currentThemeId
                                                        .toString() !=
                                                    "default_dark_theme"
                                                ? Colors.black
                                                : Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: profiledata["linkedin"] ==
                                                    null ||
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
                                            color: ThemeProvider.controllerOf(
                                                            context)
                                                        .currentThemeId
                                                        .toString() !=
                                                    "default_dark_theme"
                                                ? Colors.black
                                                : Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            profiledata["reddit"] == null ||
                                                    profiledata["reddit"] == ""
                                                ? false
                                                : true,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Site(
                                                  verilink:
                                                      profiledata["reddit"],
                                                  veribaslik: "Reddit",
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            FontAwesomeIcons.reddit,
                                            color: ThemeProvider.controllerOf(
                                                            context)
                                                        .currentThemeId
                                                        .toString() !=
                                                    "default_dark_theme"
                                                ? Colors.black
                                                : Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            profiledata["twitch"] == null ||
                                                    profiledata["twitch"] == ""
                                                ? false
                                                : true,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Site(
                                                  verilink:
                                                      profiledata["twitch"],
                                                  veribaslik: "Twitch",
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            FontAwesomeIcons.twitch,
                                            color: ThemeProvider.controllerOf(
                                                            context)
                                                        .currentThemeId
                                                        .toString() !=
                                                    "default_dark_theme"
                                                ? Colors.black
                                                : Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            profiledata["youtube"] == null ||
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
                                            color: ThemeProvider.controllerOf(
                                                            context)
                                                        .currentThemeId
                                                        .toString() !=
                                                    "default_dark_theme"
                                                ? Colors.black
                                                : Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: profiledata["instagram"] ==
                                                    null ||
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
                                            color: ThemeProvider.controllerOf(
                                                            context)
                                                        .currentThemeId
                                                        .toString() !=
                                                    "default_dark_theme"
                                                ? Colors.black
                                                : Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: profiledata["facebook"] ==
                                                    null ||
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
                                            color: ThemeProvider.controllerOf(
                                                            context)
                                                        .currentThemeId
                                                        .toString() !=
                                                    "default_dark_theme"
                                                ? Colors.black
                                                : Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const ACustomSliverHeader(),
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
                  onPressed: openWidget,
                  child: const Icon(
                    Icons.edit_note,
                    color: Colors.black,
                    size: 35,
                  ),
                );
              },
              openBuilder: (context, closeWidget) {
                return ThemeConsumer(
                  child: SharePost(
                    veri1: profiledata["oyuncuID"] == girisdata["oyuncuID"]
                        ? ""
                        : "@" "${profiledata["kullaniciadi"]} ",
                    veri2: "",
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
                    const SliverAppBar(
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
                      child: SizedBox(
                        width: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      shape: BoxShape.circle,
                                      width: 90,
                                      height: 90,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 150,
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(30),
                                            right: Radius.circular(30),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: 150,
                                        height: 40,
                                        child: Stack(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.grey[900],
                                            ),
                                            Positioned(
                                              left: 25,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey[900],
                                              ),
                                            ),
                                            Positioned(
                                              left: 50,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey[900],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SkeletonLine(
                                style:
                                    SkeletonLineStyle(width: screenWidth / 4),
                              ),
                              const SizedBox(height: 10),
                              SkeletonParagraph(
                                style: const SkeletonParagraphStyle(lines: 3),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 3),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width: screenWidth / 10),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 3),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width: screenWidth / 4),
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
                      padding: const EdgeInsets.all(8),
                      scrollable: true,
                      itemCount: 2,
                      item: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: screenWidth / 2.2,
                              height: 250,
                              color: Colors.red,
                            ),
                            Container(
                              width: screenWidth / 2.2,
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
                    screenWidth,
                    screenHeight,
                  );
                  // if (index < 2)
                  //   return _MainListView(
                  //     context,
                  //     index,
                  //     screenWidth,
                  //     screenHeight,
                  //   );
                  // else if (index == 3)
                  //   // return _MainListView(
                  //   //   context,
                  //   //   index,
                  //   //   screenWidth,
                  //   //   screenHeight,
                  //   // );
                  //   return _horizontalArkadasListView();
                  // else if (index == 5)
                  //   // return _MainListView(
                  //   //   context,
                  //   //   index,
                  //   //   screenWidth,
                  //   //   screenHeight,
                  //   // );
                  //   return _horizontalArkadasListView();
                  // else
                  //   return _MainListView(
                  //     context,
                  //     index,
                  //     screenWidth,
                  //     screenHeight,
                  //   );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: postdata.length,
                padding: const EdgeInsets.only(
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
                  style: const TextStyle(
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
      medyadata.clear();
      resimler.clear();
      return medyacek();
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: Container(
        child: medyadata.isNotEmpty
            ? GridView.builder(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, index) {
                  return profiledata["oyuncuID"] == girisdata["oyuncuID"]
                      ? FocusedMenuHolder(
                          menuWidth: MediaQuery.of(context).size.width * 0.50,
                          blurSize: 2,
                          menuItemExtent: 45,
                          menuBoxDecoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          duration: const Duration(milliseconds: 100),
                          animateMenuItems: true,
                          blurBackgroundColor: Colors.black54,
                          bottomOffsetHeight: 100,
                          // openWithTap: true,
                          menuItems: <FocusedMenuItem>[
                            FocusedMenuItem(
                              title: const Text("Tarayıcıda aç"),
                              trailingIcon: const Icon(Icons.open_in_new),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Site(
                                      verilink: medyadata[index]
                                          ["medyaorijinal"],
                                      veribaslik: profiledata["adim"],
                                    ),
                                  ),
                                );
                              },
                            ),
                            FocusedMenuItem(
                              title: const Text("Paylaş"),
                              trailingIcon: const Icon(Icons.share),
                              onPressed: () {
                                Share.share(medyadata[index]["medyaorijinal"]);
                              },
                            ),
                            FocusedMenuItem(
                              title: const Text("Galeriye kaydet"),
                              trailingIcon:
                                  const Icon(Icons.file_download_outlined),
                              onPressed: () {
                                GallerySaver.saveImage(
                                    medyadata[index]["medyaorijinal"]);
                              },
                            ),
                            FocusedMenuItem(
                              title: Text(
                                removeGalleryfromProfile,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              trailingIcon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                await medyaSil(medyadata[index]["medyaID"]);
                              },
                            ),
                          ],
                          onPressed: () {
                            // print(resimler);
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
                        )
                      : FocusedMenuHolder(
                          menuWidth: MediaQuery.of(context).size.width * 0.50,
                          blurSize: 2,
                          menuItemExtent: 45,
                          menuBoxDecoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          duration: const Duration(milliseconds: 100),
                          animateMenuItems: true,
                          blurBackgroundColor: Colors.black54,
                          bottomOffsetHeight: 100,
                          // openWithTap: true,
                          menuItems: <FocusedMenuItem>[
                            FocusedMenuItem(
                              title: const Text("Tarayıcıda aç"),
                              trailingIcon: const Icon(Icons.open_in_new),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Site(
                                      verilink: medyadata[index]
                                          ["medyaorijinal"],
                                      veribaslik: profiledata["adim"],
                                    ),
                                  ),
                                );
                              },
                            ),
                            FocusedMenuItem(
                              title: const Text("Paylaş"),
                              trailingIcon: const Icon(Icons.share),
                              onPressed: () {
                                Share.share(medyadata[index]["medyaorijinal"]);
                              },
                            ),
                            FocusedMenuItem(
                              title: const Text("Galeriye kaydet"),
                              trailingIcon:
                                  const Icon(Icons.file_download_outlined),
                              onPressed: () {
                                GallerySaver.saveImage(
                                    medyadata[index]["medyaorijinal"]);
                              },
                            ),
                          ],
                          onPressed: () {
                            // print(resimler);
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
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }

  MyFavoriteView() {
    Future<void> _refresh() {
      return postcek();
    }

    return const Center(
      child: Text(
        "Çok Yakında...\nComing Soon...",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  MyReactionView() {
    Future<void> _refresh() {
      return postcek();
    }

    return const Center(
      child: Text(
        "Çok Yakında...\nComing Soon...",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _MainListView(
    BuildContext context,
    int index,
    double screenWidth,
    double screenHeight,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThemeConsumer(
              child: PostDetail(
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
        if (mounted) {
          setState(() {
            detayid = postdata[index]["postID"];

            detaylink =
                "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
          });
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: screenWidth / 12,
            backgroundImage: CachedNetworkImageProvider(
              postdata[index]["sahipavatarminnak"],
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
                      postdata[index]["sahipad"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "  -  ${postdata[index]["paylasimzamangecen"]}",
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
                                        child: ListTile(
                                          leading: const Icon(Icons.post_add),
                                          title: Text(addFavoritePost),
                                        ),
                                      ),
                                      Visibility(
                                        visible: postdata[index]["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? true
                                            : false,
                                        child: InkWell(
                                          onTap: () {
                                            postID = postdata[index]["postID"];

                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ThemeConsumer(
                                                  child: SharePost(
                                                    veri1: "",
                                                    veri2: postdata[index]
                                                        ["sosyalicerik"],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: ListTile(
                                            leading:
                                                const Icon(Icons.edit_note),
                                            title: Text(editPost),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: postdata[index]["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? true
                                            : false,
                                        child: InkWell(
                                          onTap: () async {
                                            postID = postdata[index]["postID"];
                                            await postsil();
                                            await postcek();
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            leading: const Icon(
                                                Icons.delete_sweep_outlined),
                                            title: Text(removePost),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: widget.veri1 ==
                                                girisdata["oyuncuID"]
                                            ? false
                                            : true,
                                        child: const Divider(),
                                      ),
                                      Visibility(
                                        visible: widget.veri1 ==
                                                girisdata["oyuncuID"]
                                            ? false
                                            : true,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);

                                            Fluttertoast.showToast(
                                              msg: "Bildirildi !",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                            );
                                          },
                                          child: ListTile(
                                            textColor: Colors.red,
                                            leading: const Icon(
                                              Icons.flag_outlined,
                                              color: Colors.red,
                                            ),
                                            title: Text(reportPost),
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

                                            Fluttertoast.showToast(
                                              msg: "Engellendi !",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                            );
                                          },
                                          child: ListTile(
                                            textColor: Colors.red,
                                            leading: const Icon(
                                              Icons.person_off_outlined,
                                              color: Colors.red,
                                            ),
                                            title: Text(blockUser),
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
                                            Navigator.pop(context);

                                            Fluttertoast.showToast(
                                              msg: "Bildirildi !",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                            );
                                          },
                                          child: ListTile(
                                            textColor: Colors.red,
                                            leading: const Icon(
                                              Icons.person_outline,
                                              color: Colors.red,
                                            ),
                                            title: Text(reportUser),
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
                        color: Colors.grey,
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
                  text: postdata[index]["sosyalicerik"],
                  trimCollapsedText: " devamını oku",
                  trimExpandedText: " daha az göster",
                  lessStyle: const TextStyle(color: Colors.grey),
                  moreStyle: const TextStyle(color: Colors.grey),
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
                  url: mainFeed[index]["sosyalicerik"],
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
                        isLiked:
                            postdata[index]["benbegendim"] != 0 ? true : false,
                        likeCount: postdata[index]["begenisay"] != "0"
                            ? int.parse(postdata[index]["begenisay"])
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
                              builder: (context) => PostDetail(
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
                          if (mounted) {
                            setState(() {
                              detayid = postdata[index]["postID"];

                              detaylink =
                                  "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              postdata[index]["benyorumladim"] == 0
                                  ? const FaIcon(
                                      FontAwesomeIcons.comment,
                                      color: Colors.grey,
                                      size: 22,
                                    )
                                  : const FaIcon(
                                      FontAwesomeIcons.solidComment,
                                      color: Colors.blue,
                                      size: 22,
                                    ),
                              const SizedBox(
                                width: 10,
                              ),
                              (postdata[index]["yorumsay"] != "0")
                                  ? Text(
                                      postdata[index]["yorumsay"],
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
                              const FaIcon(
                                FontAwesomeIcons.retweet,
                                color: Colors.grey,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              (postdata[index]["repostsay"] != "0")
                                  ? Text(
                                      postdata[index]["repostsay"],
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
                            postdata[index]["sosyalicerik"],
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

  Widget _horizontalArkadasListView() {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        controller: profilePageArkadasScrollController,
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        physics: const BouncingScrollPhysics(),
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
                    stops: const [0.0, 0.4],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Text(
                      xpsiralama[index]["oyuncuadsoyad"],
                      style: const TextStyle(
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
        separatorBuilder: (context, index) => const SizedBox(width: 20),
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return PreferredSize(
      preferredSize: Size(screenWidth, 48),
      child: Container(
        decoration: BoxDecoration(
          color:
              ThemeProvider.controllerOf(context).currentThemeId.toString() !=
                      "default_dark_theme"
                  ? null
                  : Colors.grey[850],
          border: const Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        width: screenWidth,
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
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          labelColor:
              ThemeProvider.controllerOf(context).currentThemeId.toString() !=
                      "default_dark_theme"
                  ? Colors.black
                  : Colors.white,
          tabs: const [
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
  const ACustomSliverHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: Delegate(),
    );
  }
}
