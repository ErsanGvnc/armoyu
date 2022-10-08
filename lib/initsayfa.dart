// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:armoyu/login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import 'Variables/variables.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
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

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    // main 308 & splash 41; InitPage ile deiş.

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(73, 144, 226, 1),
            Color.fromARGB(255, 7, 50, 99)
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "İçerde Neler Olup\nBittiğini Keşfet",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Flexible(
                  child: Container(
                    color: Colors.red,
                    width: screenwidth,
                    child: _InitPagePost(),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: InkWell(
                            onTap: () async {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "Devam Et",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
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
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _InitPagePost() {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: screenwidth / 12,
          backgroundImage: CachedNetworkImageProvider(
            dataanasayfa[0]["sahipavatarminnak"],
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
                    dataanasayfa[0]["sahipad"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "  -  " + dataanasayfa[0]["paylasimzamangecen"],
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
                                          borderRadius: const BorderRadius.all(
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
                                            dataanasayfa[0]["oyunculink"]);
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
                                            text: dataanasayfa[0]["oyunculink"],
                                          ),
                                        );
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("Kopyalandı !"),
                                            shape: const StadiumBorder(),
                                          ),
                                        );
                                      },
                                      child: const ListTile(
                                        leading: Icon(Icons.content_copy),
                                        title: Text(
                                            "Kullanıcı profil linkini kopyala."),
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
              SizedBox(height: screenheight / 90),
              DetectableText(
                detectionRegExp: RegExp(
                  "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                  multiLine: true,
                ),
                text: dataanasayfa[0]["sosyalicerik"],
                basicStyle: const TextStyle(
                  fontSize: 16,
                ),
                detectedStyle: const TextStyle(
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
              SizedBox(height: screenheight / 65),
              Container(
                color: Colors.transparent,
                width: screenwidth,
                height: screenheight / 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.favorite_outline,
                      color: Colors.grey,
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            (dataanasayfa[10]["yorumsay"] != "0")
                                ? Text(
                                    dataanasayfa[0]["yorumsay"],
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
                            (dataanasayfa[0]["repostsay"] != "0")
                                ? Text(
                                    dataanasayfa[0]["repostsay"],
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
                          dataanasayfa[0]["sosyalicerik"],
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
                      width: screenwidth / 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
