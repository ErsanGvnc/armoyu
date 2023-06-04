// ignore_for_file: file_names, unnecessary_null_comparison, avoid_print, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:armoyu/Utilities/Import&Export/export.dart';
// import 'package:extended_image/extended_image.dart';
import 'package:skeletons/skeletons.dart';
import 'package:http/http.dart' as http;

class MainFeed extends StatefulWidget {
  const MainFeed({Key? key}) : super(key: key);

  @override
  AnaSayfaState createState() => AnaSayfaState();
}

class AnaSayfaState extends State<MainFeed> {
  @override
  void initState() {
    super.initState();
    gondericek(0);
    popcek();
    xpcek();
    kullanicicek();

    // subscription = Connectivity().onConnectivityChanged.listen((event) {
    //   print("anasayfa");
    //   print(subscription);
    //   print(Connectivity().checkConnectivity().toString());
    // });

    anaSayfaScrollController.addListener(() {
      if (anaSayfaScrollController.position.pixels ==
              anaSayfaScrollController.position.maxScrollExtent &&
          anaSayfaScrollController.position.pixels > 0) {
        gondericek(mainFeed.length);
        print(mainFeed.length);
      }
    });
  }

  @override
  void dispose() {
    anaSayfaScrollController.dispose();
    // subscription!.cancel();
    super.dispose();
  }

  gondericek(int startPage) async {
    final url = Uri.parse(
        "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/$startPage/0/");

    // print(url);

    final gelen = await http.get(url);

    if (gelen.statusCode == 200) {
      final List newItems = jsonDecode(gelen.body);
      if (mounted) {
        setState(() {
          mainFeed.addAll(newItems);
        });
      }
    }
  }

  popcek() async {
    final url = Uri.parse(poplink);

    final gelen = await http.get(url);

    if (gelen.statusCode == 200) {
      popsiralama = jsonDecode(gelen.body);
      if (mounted) {
        setState(() {});
      }
    }
  }

  xpcek() async {
    final url = Uri.parse(xplink);

    final gelen = await http.get(url);

    if (gelen.statusCode == 200) {
      xpsiralama = jsonDecode(gelen.body);
      if (mounted) {
        setState(() {});
      }
    }
  }

  kullanicicek() async {
    final url = Uri.parse(kullanicilink);

    final gelen = await http.get(url);

    if (gelen.statusCode == 200) {
      if (mounted) {
        setState(() {
          kullanicilar = jsonDecode(gelen.body);
        });
      }
    }

    for (var i = 0; i < kullanicilar.length; i++) {
      userSearchTerms.add(
        [
          [kullanicilar[i]["adsoyad"]].toString(),
          [kullanicilar[i]["ID"]].toString(),
          [kullanicilar[i]["avatar"]].toString(),
        ],
      );
    }
  }

  // videolu fotografların çekildigi yer.

  gonderifotocek() {
    // print(gonderifotolar[0]["paylasimkategori"]);

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

      // return Row(
      //   children: [
      //     Flexible(
      //       child: ClipRRect(
      //         borderRadius: BorderRadius.circular(10),
      //         child: FutureBuilder(
      //           future: _initializeVideoPlayer,
      //           builder: (context, snapshot) {
      //             if (snapshot.connectionState == ConnectionState.done) {
      //               return Stack(
      //                 children: [
      //                   InkWell(
      //                     onTap: () {
      //                       _videoPlayerController.value.isPlaying
      //                           ? _videoPlayerController.pause()
      //                           : _videoPlayerController.play();
      //                       setState(() {});
      //                     },
      //                     child: AspectRatio(
      //                       aspectRatio: 16 / 9,
      //                       child: VideoPlayer(
      //                         _videoPlayerController,
      //                       ),
      //                     ),
      //                   ),
      //                   Positioned(
      //                     top: 5,
      //                     right: 5,
      //                     child: Container(
      //                       decoration: BoxDecoration(
      //                         color: Colors.black.withOpacity(0.5),
      //                         borderRadius: BorderRadius.circular(5),
      //                       ),
      //                       padding: const EdgeInsets.all(3),
      //                       child: Lottie.asset(
      //                         "assets/animations/sound.json",
      //                         // controller: _animationController,
      //                         animate: _videoPlayerController.value.isPlaying
      //                             ? true
      //                             : false,
      //                         repeat: true,
      //                       ),
      //                     ),
      //                   ),
      //                   Positioned(
      //                     bottom: 5,
      //                     left: 5,
      //                     right: 5,
      //                     child: Column(
      //                       children: [
      //                         Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Container(
      //                               decoration: BoxDecoration(
      //                                 color: Colors.black.withOpacity(0.5),
      //                                 borderRadius: BorderRadius.circular(5),
      //                               ),
      //                               padding: const EdgeInsets.all(3),
      //                               child: Text(
      //                                 getVideoPosition(),
      //                               ),
      //                             ),
      //                             InkWell(
      //                               onTap: () {
      //                                 setState(() {
      //                                   isMusicOn = !isMusicOn;
      //                                   isMusicOn == false
      //                                       ? _videoPlayerController
      //                                           .setVolume(0)
      //                                       : _videoPlayerController
      //                                           .setVolume(1);
      //                                 });
      //                               },
      //                               child: Container(
      //                                 decoration: BoxDecoration(
      //                                   color: Colors.black.withOpacity(0.5),
      //                                   borderRadius: BorderRadius.circular(30),
      //                                 ),
      //                                 padding: const EdgeInsets.all(3),
      //                                 child: Icon(
      //                                   isMusicOn
      //                                       ? Icons.volume_up
      //                                       : Icons.volume_off,
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                         const SizedBox(height: 5),
      //                         VideoProgressIndicator(
      //                           _videoPlayerController,
      //                           allowScrubbing: true,
      //                           colors: const VideoProgressColors(
      //                             playedColor: Colors.white,
      //                             bufferedColor: Colors.grey,
      //                           ),
      //                         ),
      //                         const SizedBox(height: 5),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               );
      //             } else {
      //               return const Center(
      //                 child: CircularProgressIndicator(),
      //               );
      //             }
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
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

      // return Row(
      //   children: [
      //     Flexible(
      //       child: ClipRRect(
      //         borderRadius: BorderRadius.circular(10),
      //         child: FutureBuilder(
      //           future: _initializeVideoPlayer,
      //           builder: (context, snapshot) {
      //             if (snapshot.connectionState == ConnectionState.done) {
      //               return AspectRatio(
      //                 aspectRatio: 16 / 9,
      //                 child: VideoPlayer(_videoPlayerController),
      //               );
      //             } else {
      //               return const Center(
      //                 child: CircularProgressIndicator(),
      //               );
      //             }
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // );

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
        mainFeed[index]["benbegendim"] =
            mainFeed[index]["benbegendim"] == 0 ? 1 : 0;

        isLike = !isLike;

        if (isLike == true) {
          mainFeed[index]["begenisay"] =
              (int.parse(mainFeed[index]["begenisay"]) + 1).toString();
        } else {
          mainFeed[index]["begenisay"] =
              (int.parse(mainFeed[index]["begenisay"]) - 1).toString();
        }
      });
    }
    print(isLike);
    postID = mainFeed[index]["postID"];
    print("onLikeButtonTapped");

    postlike();

    return isLike;
  }

  Future<void> _refresh() {
    if (mounted) {
      setState(() {
        mainFeed.clear();
        gonderifotolar.clear();
      });
    }
    return gondericek(0);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: mainFeed.isNotEmpty
          ? ListView.separated(
              controller: anaSayfaScrollController,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: mainFeed.length + 1,
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                if (index == mainFeed.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (mainFeed[index]["paylasimfoto"] != null) {
                  gonderifotolar = mainFeed[index]["paylasimfoto"];
                  visible = true;
                } else {
                  visible = false;
                }
                if (index < 2) {
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
                } else if (index == 3) {
                  return Column(
                    children: [
                      _xphorizontalListView(),
                      const Divider(),
                      _MainListView(
                        context,
                        index,
                        screenWidth,
                        postsil,
                        _refresh,
                        postbildir,
                        screenHeight,
                        onLikeButtonTapped,
                      ),
                    ],
                  );
                } else if (index == 10) {
                  return Column(
                    children: [
                      _pophorizontalListView(),
                      const Divider(),
                      _MainListView(
                        context,
                        index,
                        screenWidth,
                        postsil,
                        _refresh,
                        postbildir,
                        screenHeight,
                        onLikeButtonTapped,
                      ),
                    ],
                  );
                } else {
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
                }
              },
              separatorBuilder: (context, index) => const Divider(),
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
                        const Row(
                          children: [
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
                              const FaIcon(
                                FontAwesomeIcons.comment,
                                color: Colors.grey,
                                size: 22,
                              ),
                              const FaIcon(
                                FontAwesomeIcons.retweet,
                                color: Colors.grey,
                                size: 22,
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
      Function() postsil,
      Future<void> Function() _refresh,
      Function() postbildir,
      double screenHeight,
      Future<bool> Function(bool isLike, int index) onLikeButtonTapped) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThemeConsumer(
              child: PostDetail(
                veri1: mainFeed[index]["sahipavatarminnak"],
                veri2: mainFeed[index]["sahipad"],
                veri3: mainFeed[index]["sosyalicerik"],
                veri4: mainFeed[index]["paylasimzaman"],
                veri5: mainFeed[index]["begenisay"],
                veri6: mainFeed[index]["yorumsay"],
                veri7: mainFeed[index]["repostsay"],
                veri8: mainFeed[index]["sikayetsay"],
                veri9: mainFeed[index]["benbegendim"],
                veri10: mainFeed[index]["postID"],
                veri11: mainFeed[index]["sahipID"],
                veri12: mainFeed[index]["paylasimnereden"],
                veri13: mainFeed[index]["benyorumladim"],
                veri14: mainFeed[index]["oyunculink"],
              ),
            ),
          ),
        ).whenComplete(
          () => isMusicOn = false,
        );
        if (mounted) {
          setState(() {
            detayid = mainFeed[index]["postID"];
            detaylink =
                "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
          });
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThemeConsumer(
                    child: Profile(
                      veri1: mainFeed[index]["sahipID"],
                    ),
                  ),
                ),
              );
            },
            child: CircleAvatar(
              radius: screenWidth / 12,
              backgroundImage: CachedNetworkImageProvider(
                mainFeed[index]["sahipavatarminnak"],
              ),
            ),
          ),
          SizedBox(width: screenWidth / 35),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThemeConsumer(
                              child: Profile(
                                veri1: mainFeed[index]["sahipID"],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        mainFeed[index]["sahipad"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "  -  ${mainFeed[index]["paylasimzamangecen"]}",
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
                                        visible: mainFeed[index]["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? true
                                            : false,
                                        child: InkWell(
                                          onTap: () {
                                            postID = mainFeed[index]["postID"];

                                            Navigator.pop(context);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ThemeConsumer(
                                                  child: SharePost(
                                                    veri1: "",
                                                    veri2: mainFeed[index]
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
                                        visible: mainFeed[index]["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? true
                                            : false,
                                        child: InkWell(
                                          onTap: () {
                                            postID = mainFeed[index]["postID"];
                                            postsil();
                                            Navigator.pop(context);
                                            Future.delayed(
                                                const Duration(
                                                  milliseconds: 100,
                                                ), () {
                                              _refresh();
                                            });
                                            Fluttertoast.showToast(
                                              msg: removePostNotification,
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                            );
                                          },
                                          child: ListTile(
                                            leading: const Icon(
                                                Icons.delete_sweep_outlined),
                                            title: Text(removePost),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Share.share(
                                              mainFeed[index]["oyunculink"]);
                                          Navigator.pop(context);
                                        },
                                        child: ListTile(
                                          leading:
                                              const Icon(Icons.share_outlined),
                                          title: Text(shareUser),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text: mainFeed[index]
                                                  ["oyunculink"],
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
                                          leading:
                                              const Icon(Icons.content_copy),
                                          title: Text(shareUserProfileLink),
                                        ),
                                      ),
                                      Visibility(
                                        visible: mainFeed[index]["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? false
                                            : true,
                                        child: const Divider(),
                                      ),
                                      Visibility(
                                        visible: mainFeed[index]["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? false
                                            : true,
                                        child: InkWell(
                                          onTap: () {
                                            postID = mainFeed[index]["postID"];
                                            postbildir();
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
                                        visible: mainFeed[index]["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? false
                                            : true,
                                        child: InkWell(
                                          onTap: () {
                                            postID = mainFeed[index]["postID"];
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
                                        visible: mainFeed[index]["sahipID"] ==
                                                girisdata["oyuncuID"]
                                            ? false
                                            : true,
                                        child: InkWell(
                                          onTap: () {
                                            postID = mainFeed[index]["postID"];
                                            postbildir();
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
                  text: mainFeed[index]["sosyalicerik"],
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
                            mainFeed[index]["benbegendim"] != 0 ? true : false,
                        likeCount: mainFeed[index]["begenisay"] != "0"
                            ? int.parse(mainFeed[index]["begenisay"])
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
                                child: PostDetail(
                                  veri1: mainFeed[index]["sahipavatarminnak"],
                                  veri2: mainFeed[index]["sahipad"],
                                  veri3: mainFeed[index]["sosyalicerik"],
                                  veri4: mainFeed[index]["paylasimzaman"],
                                  veri5: mainFeed[index]["begenisay"],
                                  veri6: mainFeed[index]["yorumsay"],
                                  veri7: mainFeed[index]["repostsay"],
                                  veri8: mainFeed[index]["sikayetsay"],
                                  veri9: mainFeed[index]["benbegendim"],
                                  veri10: mainFeed[index]["postID"],
                                  veri11: mainFeed[index]["sahipID"],
                                  veri12: mainFeed[index]["paylasimnereden"],
                                  veri13: mainFeed[index]["benyorumladim"],
                                  veri14: mainFeed[index]["oyunculink"],
                                ),
                              ),
                            ),
                          ).whenComplete(
                            () => isMusicOn = false,
                          );
                          if (mounted) {
                            setState(() {
                              detayid = mainFeed[index]["postID"];
                              // print(detaylink);
                              detaylink =
                                  "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              mainFeed[index]["benyorumladim"] == 0
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
                              (mainFeed[index]["yorumsay"] != "0")
                                  ? Text(
                                      mainFeed[index]["yorumsay"],
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
                          Fluttertoast.showToast(
                            msg: comingSoon,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                          );
                        },
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
                                width: 10,
                              ),
                              (mainFeed[index]["repostsay"] != "0")
                                  ? Text(
                                      mainFeed[index]["repostsay"],
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
                            mainFeed[index]["sosyalicerik"],
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
    return xpsiralama != null
        ? SizedBox(
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
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _pophorizontalListView() {
    return popsiralama != null
        ? SizedBox(
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
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
