// ignore_for_file: avoid_print, unnecessary_null_comparison, unused_element, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
    searchcek();
    habercek();
    popcek();
    xpcek();
    hashtagcek();
    // _initSpeech();
  }

  List resimler = [];

  searchcek() async {
    final url = Uri.parse(ayinpostulink);

    final gelen = await http.get(url);

    if (gelen.statusCode == 200) {
      ayinpostu = jsonDecode(gelen.body);
      setState(() {});
    }
  }

  habercek() async {
    var gelen = await http.get(
      Uri.parse(haberurl),
    );
    datahaber = jsonDecode(gelen.body);
    setState(() {});
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

  hashtagcek() async {
    final url = Uri.parse(hashtaglink);

    final gelen = await http.get(url);

    if (gelen.statusCode == 200) {
      hashtagler = jsonDecode(gelen.body);
      setState(() {});
    }
    // print(hashtagler.length);
  }

  gonderifotocek() {
    // print(gonderifotolar);

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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<bool> onLikeButtonTapped(bool isLike, int index) async {
    setState(() {
      ayinpostu[index]["benbegendim"] =
          ayinpostu[index]["benbegendim"] == 0 ? 1 : 0;

      isLike = !isLike;

      if (isLike == true) {
        ayinpostu[index]["begenisay"] =
            (int.parse(ayinpostu[index]["begenisay"]) + 1).toString();
      } else {
        ayinpostu[index]["begenisay"] =
            (int.parse(ayinpostu[index]["begenisay"]) - 1).toString();
      }
    });
    print(isLike);
    postID = ayinpostu[index]["postID"];
    print("onLikeButtonTapped");

    postlike();

    return isLike;
  }

  Future<void> _refresh() {
    habercek();
    xpcek();
    hashtagcek();
    popcek();
    setState(() {
      searchler.clear();
    });
    return searchcek();
  }

  @override
  Widget build(BuildContext context) {
    search(id) async {
      http.post(
        Uri.parse(oturumkontrolurl),
        body: {
          "oyuncubakid": id,
        },
      ).then((cevap) {
        setState(() {
          try {
            profiledata = jsonDecode(cevap.body);
            print(profiledata);
          } catch (e) {
            print('Unknown exception: $e');
          }
        });
      });
    }

    medyacek(id) async {
      http.post(
        Uri.parse(medyalink),
        body: {
          "oyuncubakid": id,
        },
      ).then((cevap) {
        setState(() {
          try {
            searchgaleri = jsonDecode(cevap.body);
            // print(searchgaleri);
          } catch (e) {
            print('Unknown exception: $e');
          }
          if (searchgaleri != null) {
            for (var i = 0; i < searchgaleri.length; i++) {
              resimler.add(searchgaleri[i]["medyaufaklik"]);
            }
            // print(resimler);
          } else {
            print("resim yok");
          }
        });
      });
    }

    habercek(id) async {
      http.post(
        Uri.parse(searchaberlink),
        body: {
          "oyuncubakid": id,
        },
      ).then((cevap) {
        setState(() {
          try {
            searchhaber = jsonDecode(cevap.body);
            // print(searchhaber);
          } catch (e) {
            print('Unknown exception: $e');
          }
        });
      });
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          controller: searchMainScrollController,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          children: [
            TextFormField(
              controller: searchtec,
              autofocus: false,
              focusNode: focusNodeSearch,
              onTap: () => FocusManager.instance.primaryFocus?.requestFocus(),
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchtec.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchtec.clear();
                          resimler.clear();
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                hintText: "Ara...",
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (String value) {
                RawAutocomplete.onFieldSubmitted(autocompleteKey);
              },
            ),
            RawAutocomplete<List<String>>(
              key: autocompleteKey,
              focusNode: focusNodeSearch,
              textEditingController: searchtec,
              optionsBuilder: (TextEditingValue textEditingValue) async {
                if (textEditingValue.text.isEmpty ||
                    textEditingValue.text.length < 3) {
                  setState(() {
                    aratildi = 0;
                    resimler.clear();
                    searchgaleri.clear();
                    searchhaber.clear();
                  });
                  return const Iterable.empty();
                }
                var options = kullanicilar.map(
                  (kullanici) => [
                    kullanici["ID"].toString(),
                    kullanici["adsoyad"].toString(),
                  ],
                );
                return options.where((List<String> option) {
                  return option[1]
                      .toString()
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (option) {
                var kulAdSoyad = option[1];
                searchtec.text = kulAdSoyad;
              },
              optionsViewBuilder: (
                BuildContext context,
                AutocompleteOnSelected<List<String>> onSelected,
                Iterable<List> options,
              ) {
                return ThemeConsumer(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    controller: searchSingleChildSVScrollController,
                    child: Wrap(
                      children: [
                        Material(
                          color: Colors.grey[850],
                          elevation: 4.0,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            controller: searchListViewScrollController,
                            children: options
                                .map((dynamic option) => InkWell(
                                      onTap: () {
                                        id = option[0];
                                        kulAdSoyad = option[1];
                                        searchtec.text = kulAdSoyad;

                                        resimler.clear();
                                        searchgaleri.clear();
                                        searchhaber.clear();

                                        search(id);
                                        medyacek(id);
                                        habercek(id);

                                        setState(() {
                                          aratildi = 1;
                                        });
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      child: ListTile(
                                        title: Text(option[1]),
                                        trailing: IconButton(
                                          onPressed: () {
                                            id = option[0];
                                            kulAdSoyad = option[1];
                                            searchtec.text = kulAdSoyad;

                                            resimler.clear();
                                            searchgaleri.clear();
                                            searchhaber.clear();

                                            search(id);
                                            medyacek(id);
                                            habercek(id);

                                            setState(() {
                                              aratildi = 1;
                                            });
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          icon: const Icon(Icons.north_west),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            aratildi == 0
                ? Column(
                    children: [
                      _carouselSlider(),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _xphorizontalListView(),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _chipListView(),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _pophorizontalListView(),
                    ],
                  )
                : searchedildi(),
          ],
        ),
      ),
    );
  }

  searchedildi() {
    return profiledata != null
        ? ListView(
            controller: searchSearchScrollController,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            children: [
              Column(
                children: [
                  ListTile(
                    onTap: () {
                      print(id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThemeConsumer(
                            child: Profile(
                              veri1: id,
                            ),
                          ),
                        ),
                      );
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: screenWidth / 12,
                      backgroundImage: CachedNetworkImageProvider(
                        profiledata["presimminnak"],
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(profiledata["adim"]),
                    subtitle: Text(
                      profiledata["hakkimda"] ?? profiledata["hakkimda"],
                      maxLines: 2,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: searchgaleri.isNotEmpty ? true : false,
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          onTap: () {
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
                              imageUrl: resimler[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      itemCount: resimler.length <= 4 ? resimler.length : 4,
                    ),
                  ),
                  Visibility(
                    visible: searchhaber.isNotEmpty ? true : false,
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detail(
                                  veri1: searchhaber[index]["haberbaslik"],
                                  veri3: searchhaber[index]["resim"],
                                  veri5: searchhaber[index]["resimorijinal"],
                                  veri6: searchhaber[index]["gecenzaman"],
                                  veri7: searchhaber[index]["yazar"],
                                  veri8: searchhaber[index]["ozet"],
                                  veri9: searchhaber[index]["link"],
                                  veri10: searchhaber[index]["kategori"],
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: screenWidth / 3,
                                  height: screenHeight / 6,
                                  child: searchhaber[index]["resim"] != null
                                      ? CachedNetworkImage(
                                          imageUrl: searchhaber[index]["resim"],
                                        )
                                      : null,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: screenHeight / 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: screenHeight / 100),
                                        Text(
                                          searchhaber[index]["yazar"],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: screenWidth / 25,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          searchhaber[index]["haberbaslik"],
                                          maxLines: 2,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Text(
                                              searchhaber[index]["kategori"],
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: screenWidth / 30,
                                              ),
                                            ),
                                            SizedBox(width: screenWidth / 75),
                                            const CircleAvatar(
                                              radius: 3,
                                              backgroundColor: Colors.grey,
                                            ),
                                            SizedBox(width: screenWidth / 75),
                                            Text(
                                              searchhaber[index]["gecenzaman"],
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: screenWidth / 30,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              searchhaber[index]["goruntulen"],
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: screenWidth / 30,
                                              ),
                                            ),
                                            SizedBox(width: screenWidth / 150),
                                            const Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.grey,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount:
                          searchhaber.length <= 2 ? searchhaber.length : 2,
                    ),
                  ),
                ],
              ),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _MainListView(
    BuildContext context,
    int index,
    double screenWidth,
    postsil,
    Future<void> Function() _refresh,
    postbildir,
    double screenHeight,
    Future<bool> Function(bool isLike, int index) onLikeButtonTapped,
  ) {
    return ayinpostu.isNotEmpty
        ? InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThemeConsumer(
                    child: AnaDetail(
                      veri1: ayinpostu[index]["sahipavatarminnak"],
                      veri2: ayinpostu[index]["sahipad"],
                      veri3: ayinpostu[index]["sosyalicerik"],
                      veri4: ayinpostu[index]["paylasimzaman"],
                      veri5: ayinpostu[index]["begenisay"],
                      veri6: ayinpostu[index]["yorumsay"],
                      veri7: ayinpostu[index]["repostsay"],
                      veri8: ayinpostu[index]["sikayetsay"],
                      veri9: ayinpostu[index]["benbegendim"],
                      veri10: ayinpostu[index]["postID"],
                      veri11: ayinpostu[index]["sahipID"],
                      veri12: ayinpostu[index]["paylasimnereden"],
                      veri13: ayinpostu[index]["benyorumladim"],
                      veri14: ayinpostu[index]["oyunculink"],
                    ),
                  ),
                ),
              );
              // sayfaya geri gelince sayfayı yenileme. _refresh yapınca en üste dönüyo
              // setState() calısmadı.
              // stateManagement (Get) ile yapılması mantıklı.
              // ).then((value) {
              //   // _refresh();
              //   setState(() {});
              //   print("refresh");
              // });

              setState(() {
                detayid = ayinpostu[index]["postID"];
                detaylink =
                    "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: screenWidth / 12,
                  backgroundImage: NetworkImage(
                    ayinpostu[index]["sahipavatarminnak"],
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
                            ayinpostu[index]["sahipad"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "  -  " + ayinpostu[index]["paylasimzamangecen"],
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                leading:
                                                    const Icon(Icons.post_add),
                                                title: Text(addFavoritePost),
                                              ),
                                            ),
                                            Visibility(
                                              visible: ayinpostu[index]
                                                          ["sahipID"] ==
                                                      girisdata["oyuncuID"]
                                                  ? true
                                                  : false,
                                              child: InkWell(
                                                onTap: () {
                                                  postID = ayinpostu[index]
                                                      ["postID"];
                                                  // postsil();
                                                  Navigator.pop(context);
                                                },
                                                child: ListTile(
                                                  leading: const Icon(
                                                      Icons.edit_note),
                                                  title: Text(editPost),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: ayinpostu[index]
                                                          ["sahipID"] ==
                                                      girisdata["oyuncuID"]
                                                  ? true
                                                  : false,
                                              child: InkWell(
                                                onTap: () {
                                                  postID = ayinpostu[index]
                                                      ["postID"];
                                                  postsil();
                                                  Navigator.pop(context);
                                                  Future.delayed(
                                                      const Duration(
                                                        milliseconds: 100,
                                                      ), () {
                                                    _refresh();
                                                  });
                                                },
                                                child: ListTile(
                                                  leading: const Icon(Icons
                                                      .delete_sweep_outlined),
                                                  title: Text(removePost),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                leading: const Icon(
                                                    Icons.share_outlined),
                                                title: Text(shareUser),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Clipboard.setData(
                                                  ClipboardData(
                                                    text: ayinpostu[index]
                                                        ["sahipID"],
                                                  ),
                                                );
                                                Navigator.pop(context);

                                                Fluttertoast.showToast(
                                                  msg: "Kopyalandı !",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                );
                                              },
                                              child: ListTile(
                                                leading: const Icon(
                                                    Icons.content_copy),
                                                title:
                                                    Text(shareUserProfileLink),
                                              ),
                                            ),
                                            Visibility(
                                              visible: ayinpostu[index]
                                                          ["sahipID"] ==
                                                      girisdata["oyuncuID"]
                                                  ? false
                                                  : true,
                                              child: const Divider(),
                                            ),
                                            Visibility(
                                              visible: ayinpostu[index]
                                                          ["sahipID"] ==
                                                      girisdata["oyuncuID"]
                                                  ? false
                                                  : true,
                                              child: InkWell(
                                                onTap: () {
                                                  postID = ayinpostu[index]
                                                      ["postID"];
                                                  postbildir();
                                                  Navigator.pop(context);

                                                  Fluttertoast.showToast(
                                                    msg: "Bildirildi !",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
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
                                              visible: ayinpostu[index]
                                                          ["sahipID"] ==
                                                      girisdata["oyuncuID"]
                                                  ? false
                                                  : true,
                                              child: InkWell(
                                                onTap: () {
                                                  postID = ayinpostu[index]
                                                      ["postID"];
                                                  postbildir();
                                                  Navigator.pop(context);

                                                  Fluttertoast.showToast(
                                                    msg: "Bildirildi !",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
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
                        text: ayinpostu[index]["sosyalicerik"],
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
                              isLiked: ayinpostu[index]["benbegendim"] != 0
                                  ? true
                                  : false,
                              likeCount: ayinpostu[index]["begenisay"] != "0"
                                  ? int.parse(ayinpostu[index]["begenisay"])
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
                                    builder: (context) => AnaDetail(
                                      veri1: ayinpostu[index]
                                          ["sahipavatarminnak"],
                                      veri2: ayinpostu[index]["sahipad"],
                                      veri3: ayinpostu[index]["sosyalicerik"],
                                      veri4: ayinpostu[index]["paylasimzaman"],
                                      veri5: ayinpostu[index]["begenisay"],
                                      veri6: ayinpostu[index]["yorumsay"],
                                      veri7: ayinpostu[index]["repostsay"],
                                      veri8: ayinpostu[index]["sikayetsay"],
                                      veri9: ayinpostu[index]["benbegendim"],
                                      veri10: ayinpostu[index]["postID"],
                                      veri11: ayinpostu[index]["sahipID"],
                                      veri12: ayinpostu[index]
                                          ["paylasimnereden"],
                                      veri13: ayinpostu[index]["benyorumladim"],
                                      veri14: ayinpostu[index]["oyunculink"],
                                    ),
                                  ),
                                );

                                setState(() {
                                  detayid = ayinpostu[index]["postID"];
                                  // print(detaylink);
                                  detaylink =
                                      "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ayinpostu[index]["benyorumladim"] == 0
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
                                    (ayinpostu[index]["yorumsay"] != "0")
                                        ? Text(
                                            ayinpostu[index]["yorumsay"],
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
                                    (ayinpostu[index]["repostsay"] != "0")
                                        ? Text(
                                            ayinpostu[index]["repostsay"],
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
                                  ayinpostu[index]["sosyalicerik"],
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
          )
        : const CircularProgressIndicator();
  }

  Widget _carouselSlider() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Haberler",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ThemeConsumer(
                      child: News(),
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            autoPlay: true,
            enableInfiniteScroll: true,
            pauseAutoPlayOnTouch: true,
            viewportFraction: 0.8,
            autoPlayInterval: const Duration(seconds: 5),
            scrollDirection: Axis.horizontal,
            enlargeFactor: 0.2,
            enlargeCenterPage: true,
          ),
          itemCount: 5,
          itemBuilder: (context, index, realIndex) {
            // print(datahaber);
            return datahaber != null
                ? InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(
                            veri1: datahaber[index]["haberbaslik"],
                            veri3: datahaber[index]["resimminnak"],
                            veri5: datahaber[index]["resim"],
                            veri6: datahaber[index]["gecenzaman"],
                            veri7: datahaber[index]["yazar"],
                            veri8: datahaber[index]["ozet"],
                            veri9: datahaber[index]["link"],
                            veri10: datahaber[index]["kategori"],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          image: CachedNetworkImageProvider(
                            datahaber[index]["resimminnak"],
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
                            stops: const [0.0, 0.8],
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        datahaber[index]["yazaravatar"],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      datahaber[index]["yazar"],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.visibility),
                                        const SizedBox(width: 3),
                                        Text(
                                          datahaber[index]["goruntulen"],
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  datahaber[index]["ozet"],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                  )
                : Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[700],
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
          },
        ),
      ],
    );
  }

  Widget _xphorizontalListView() {
    return xpsiralama.isEmpty
        ? const CircularProgressIndicator()
        : SizedBox(
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

  Widget _chipListView() {
    get_chip(name) {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: FilterChip(
          selectedColor: Colors.blue.shade800,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          label: Text("#${name["etiketadi"]}"),
          onSelected: (bool value) async {
            print("$name");
            Fluttertoast.showToast(
              msg: comingSoon,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
            );
          },
        ),
      );
    }

    generate_tags() {
      return hashtagler.map((tag) => get_chip(tag));
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Konular",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () async {
                Fluttertoast.showToast(
                  msg: comingSoon,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                );
              },
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        hashtagler.isNotEmpty
            ? SizedBox(
                child: Wrap(
                  // spacing: 8, // gap between adjacent chips
                  runSpacing: 4, // gap between lines
                  direction: Axis.horizontal,
                  verticalDirection: VerticalDirection.down,
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: <Widget>[...generate_tags()],
                ),
              )
            : const CircularProgressIndicator(),
      ],
    );
  }

  Widget _pophorizontalListView() {
    return popsiralama.isEmpty
        ? const CircularProgressIndicator()
        : SizedBox(
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
