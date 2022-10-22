// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors, unused_field, prefer_final_fields, unused_local_variable, prefer_const_literals_to_create_immutables, avoid_print, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_element, use_function_type_syntax_for_parameters, unnecessary_null_comparison

import 'dart:convert';
import 'package:armoyu/resiminceleme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:armoyu/anadetail.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theme_provider/theme_provider.dart';
import 'Controllers/controllers.dart';
import 'Utilities/links.dart';
import 'Utilities/utilities.dart';
import 'Variables/variables.dart';
import 'detail.dart';
import 'profile.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
    searchcek();
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
    // print(hashtagler);
  }

  gonderifotocek() {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

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
    setState(() {
      searchler.clear();
    });
    return searchcek();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

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
            // print(profiledata);
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
            print(searchhaber);
          } catch (e) {
            print('Unknown exception: $e');
          }
        });
      });
    }

    // medyacek() async {
    //   var gelengrup = await http.get(
    //     Uri.parse(medyalink),
    //   );
    //   try {
    //     searchgaleri = jsonDecode(gelengrup.body);
    //     print(searchgaleri);
    //   } catch (e) {
    //     print('Unknown exception: $e');
    //   }
    //   setState(() {});
    // }

    // return Center(
    //   child: Container(
    //     child: Text(
    //       "Çok Yakında...\nComing Soon...",
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         fontSize: 24,
    //         fontWeight: FontWeight.w600,
    //       ),
    //     ),
    //   ),
    // );

    return RefreshIndicator(
      onRefresh: _refresh,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          child: ListView(
            controller: searchMainScrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10,
            ),
            children: [
              TextFormField(
                controller: searchtec,
                autofocus: false,
                focusNode: focusNodeSearch,
                onTap: () => FocusManager.instance.primaryFocus?.requestFocus(),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  prefixIcon: Icon(Icons.search),
                  // suffixIcon: IconButton(
                  //   onPressed: speechToText.isNotListening
                  //       ? _startListening
                  //       : _stopListening,
                  //   icon: Icon(Icons.mic),
                  // ),
                  suffixIcon: searchtec.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            searchtec.clear();
                            resimler.clear();
                          },
                          icon: Icon(Icons.clear),
                        )
                      : null,
                  hintText: "Ara...",
                  hintStyle: TextStyle(
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
                    return Iterable.empty();
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
                  var id = option[0], kulAdSoyad = option[1];
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
                                              searchtec.text = option[1];
                                            },
                                            icon: Icon(Icons.north_west),
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
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              aratildi == 0
                  ? Column(
                      children: [
                        // _MainListView(
                        //   context,
                        //   0,
                        //   screenwidth,
                        //   postsil,
                        //   _refresh,
                        //   postbildir,
                        //   screenheight,
                        //   onLikeButtonTapped,
                        // ),
                        // Divider(
                        //   color: Colors.grey,
                        // ),
                        _xphorizontalListView(),
                        Divider(
                          color: Colors.grey,
                        ),
                        _horizontalChipListView(),
                        Divider(
                          color: Colors.grey,
                        ),
                        _pophorizontalListView(),
                      ],
                    )
                  : searchedildi(),
            ],
          ),
        ),
      ),
    );
  }

  searchedildi() {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    final items = List<String>.generate(15, (i) => "Item $i");
    return profiledata != null
        ? ListView(
            controller: searchSearchScrollController,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            children: [
              Column(
                children: [
                  ListTile(
                    onTap: () {
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
                      radius: screenwidth / 12,
                      backgroundImage: CachedNetworkImageProvider(
                        profiledata["presimminnak"],
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(profiledata["adim"]),
                    subtitle: Text(
                      profiledata["hakkimda"],
                      maxLines: 2,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: searchgaleri.isNotEmpty ? true : false,
                    child: GridView.builder(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          borderRadius: BorderRadius.all(
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
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
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
                                  width: screenwidth / 3,
                                  height: screenheight / 6,
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
                                    height: screenheight / 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: screenheight / 100),
                                        Text(
                                          searchhaber[index]["yazar"],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: screenwidth / 25,
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
                                                fontSize: screenwidth / 30,
                                              ),
                                            ),
                                            SizedBox(width: screenwidth / 75),
                                            const CircleAvatar(
                                              radius: 3,
                                              backgroundColor: Colors.grey,
                                            ),
                                            SizedBox(width: screenwidth / 75),
                                            Text(
                                              searchhaber[index]["gecenzaman"],
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: screenwidth / 30,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              searchhaber[index]["goruntulen"],
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: screenwidth / 30,
                                              ),
                                            ),
                                            SizedBox(width: screenwidth / 150),
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
                      separatorBuilder: (context, index) => Divider(),
                      itemCount:
                          searchhaber.length <= 2 ? searchhaber.length : 2,
                    ),
                  ),

                  // Visibility(
                  //   visible: searchhaber.isNotEmpty ? true : false,
                  //   child: InkWell(
                  //     onTap: () {
                  //       // Navigator.push(
                  //       //   context,
                  //       //   MaterialPageRoute(
                  //       //     builder: (context) => Detail(
                  //       //       veri1: searchhaber[index]["haberbaslik"],
                  //       //       veri3: searchhaber[index]["resim"],
                  //       //       veri5: searchhaber[index]["resimorijinal"],
                  //       //       veri6: searchhaber[index]["gecenzaman"],
                  //       //       veri7: searchhaber[index]["yazar"],
                  //       //       veri8: searchhaber[index]["ozet"],
                  //       //       veri9: searchhaber[index]["link"],
                  //       //       veri10: searchhaber[index]["kategori"],
                  //       //     ),
                  //       //   ),
                  //       // );
                  //     },
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Row(
                  //         children: [
                  //           SizedBox(
                  //             width: screenwidth / 3,
                  //             height: screenheight / 6,
                  //             child: searchhaber[0]["resim"] != null
                  //                 ? CachedNetworkImage(
                  //                     imageUrl: searchhaber[0]["resim"],
                  //                   )
                  //                 : null,
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           Expanded(
                  //             child: SizedBox(
                  //               height: screenheight / 6,
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.start,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   SizedBox(height: screenheight / 100),
                  //                   Text(
                  //                     searchhaber[0]["yazar"],
                  //                     style: TextStyle(
                  //                       color: Colors.grey,
                  //                       fontSize: screenwidth / 25,
                  //                     ),
                  //                   ),
                  //                   const Spacer(),
                  //                   Text(
                  //                     searchhaber[0]["haberbaslik"],
                  //                     maxLines: 2,
                  //                     style: const TextStyle(
                  //                       overflow: TextOverflow.ellipsis,
                  //                       fontSize: 20,
                  //                     ),
                  //                   ),
                  //                   const Spacer(),
                  //                   Row(
                  //                     children: [
                  //                       Text(
                  //                         searchhaber[0]["kategori"],
                  //                         style: TextStyle(
                  //                           color: Colors.blue,
                  //                           fontSize: screenwidth / 30,
                  //                         ),
                  //                       ),
                  //                       SizedBox(width: screenwidth / 75),
                  //                       const CircleAvatar(
                  //                         radius: 3,
                  //                         backgroundColor: Colors.grey,
                  //                       ),
                  //                       SizedBox(width: screenwidth / 75),
                  //                       Text(
                  //                         searchhaber[0]["gecenzaman"],
                  //                         style: TextStyle(
                  //                           color: Colors.grey,
                  //                           fontSize: screenwidth / 30,
                  //                         ),
                  //                       ),
                  //                       const Spacer(),
                  //                       Text(
                  //                         searchhaber[0]["goruntulen"],
                  //                         style: TextStyle(
                  //                           color: Colors.grey,
                  //                           fontSize: screenwidth / 30,
                  //                         ),
                  //                       ),
                  //                       SizedBox(width: screenwidth / 150),
                  //                       const Icon(
                  //                         Icons.remove_red_eye,
                  //                         color: Colors.grey,
                  //                         size: 15,
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   const SizedBox(height: 5),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              // Visibility(
              //   visible: searchgaleri.isNotEmpty ? true : false,
              //   child: Divider(
              //     color: Colors.grey,
              //     thickness: 0.7,
              //   ),
              // ),

              // Visibility(
              //   visible: searchgaleri != null ? true : false,
              //   child: ListView.separated(
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true,
              //     controller: searchPostScrollController,
              //     itemBuilder: (context, index) {
              //       return InkWell(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => ThemeConsumer(
              //                 child: AnaDetail(
              //                   veri1: ayinpostu[index]["sahipavatarminnak"],
              //                   veri2: ayinpostu[index]["sahipad"],
              //                   veri3: ayinpostu[index]["sosyalicerik"],
              //                   veri4: ayinpostu[index]["paylasimzaman"],
              //                   veri5: ayinpostu[index]["begenisay"],
              //                   veri6: ayinpostu[index]["yorumsay"],
              //                   veri7: ayinpostu[index]["repostsay"],
              //                   veri8: ayinpostu[index]["sikayetsay"],
              //                   veri9: ayinpostu[index]["benbegendim"],
              //                   veri10: ayinpostu[index]["postID"],
              //                   veri11: ayinpostu[index]["sahipID"],
              //                   veri12: ayinpostu[index]["paylasimnereden"],
              //                   veri13: ayinpostu[index]["benyorumladim"],
              //                   veri14: ayinpostu[index]["oyunculink"],
              //                 ),
              //               ),
              //             ),
              //           );
              //           setState(() {
              //             detayid = ayinpostu[index]["postID"];
              //             detaylink =
              //                 "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
              //           });
              //         },
              //         child: Container(
              //           child: Row(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               CircleAvatar(
              //                 radius: screenwidth / 12,
              //                 backgroundImage: NetworkImage(
              //                   ayinpostu[index]["sahipavatarminnak"],
              //                 ),
              //                 backgroundColor: Colors.transparent,
              //               ),
              //               SizedBox(width: screenwidth / 35),
              //               Expanded(
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Row(
              //                       children: [
              //                         Text(
              //                           ayinpostu[index]["sahipad"],
              //                           style: TextStyle(
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                         ),
              //                         Text(
              //                           "  -  " +
              //                               ayinpostu[index]
              //                                   ["paylasimzamangecen"],
              //                           style: TextStyle(
              //                             color: Colors.grey,
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                         ),
              //                         Spacer(),
              //                         InkWell(
              //                           onTap: () {
              //                             showModalBottomSheet<void>(
              //                               shape: const RoundedRectangleBorder(
              //                                 borderRadius:
              //                                     BorderRadius.vertical(
              //                                   top: Radius.circular(10),
              //                                 ),
              //                               ),
              //                               context: context,
              //                               builder: (BuildContext context) {
              //                                 return SafeArea(
              //                                   child: Wrap(
              //                                     children: [
              //                                       Column(
              //                                         children: [
              //                                           Padding(
              //                                             padding:
              //                                                 const EdgeInsets
              //                                                         .symmetric(
              //                                                     vertical: 10),
              //                                             child: Container(
              //                                               decoration:
              //                                                   BoxDecoration(
              //                                                 color: Colors
              //                                                     .grey[900],
              //                                                 borderRadius:
              //                                                     const BorderRadius
              //                                                         .all(
              //                                                   Radius.circular(
              //                                                       30),
              //                                                 ),
              //                                               ),
              //                                               width:
              //                                                   screenwidth / 4,
              //                                               height: 5,
              //                                             ),
              //                                           ),
              //                                           InkWell(
              //                                             onTap: () {
              //                                               Navigator.pop(
              //                                                   context);
              //                                             },
              //                                             child: const ListTile(
              //                                               leading: Icon(
              //                                                   Icons.post_add),
              //                                               title: Text(
              //                                                   "Postu favorilere ekle."),
              //                                             ),
              //                                           ),
              //                                           Visibility(
              //                                             visible: ayinpostu[
              //                                                             index]
              //                                                         [
              //                                                         "sahipID"] ==
              //                                                     girisdata[
              //                                                         "oyuncuID"]
              //                                                 ? true
              //                                                 : false,
              //                                             child: InkWell(
              //                                               onTap: () {
              //                                                 postID =
              //                                                     ayinpostu[
              //                                                             index]
              //                                                         [
              //                                                         "postID"];
              //                                                 // postsil();
              //                                                 Navigator.pop(
              //                                                     context);
              //                                               },
              //                                               child:
              //                                                   const ListTile(
              //                                                 leading: Icon(Icons
              //                                                     .edit_note),
              //                                                 title: Text(
              //                                                     "Postu düzenle."),
              //                                               ),
              //                                             ),
              //                                           ),
              //                                           Visibility(
              //                                             visible: ayinpostu[
              //                                                             index]
              //                                                         [
              //                                                         "sahipID"] ==
              //                                                     girisdata[
              //                                                         "oyuncuID"]
              //                                                 ? true
              //                                                 : false,
              //                                             child: InkWell(
              //                                               onTap: () {
              //                                                 postID =
              //                                                     ayinpostu[
              //                                                             index]
              //                                                         [
              //                                                         "postID"];
              //                                                 postsil();
              //                                                 Navigator.pop(
              //                                                     context);
              //                                                 Future.delayed(
              //                                                     const Duration(
              //                                                       milliseconds:
              //                                                           100,
              //                                                     ), () {
              //                                                   _refresh();
              //                                                 });
              //                                               },
              //                                               child:
              //                                                   const ListTile(
              //                                                 leading: Icon(Icons
              //                                                     .delete_sweep_outlined),
              //                                                 title: Text(
              //                                                     "Postu kaldır."),
              //                                               ),
              //                                             ),
              //                                           ),
              //                                           InkWell(
              //                                             onTap: () {
              //                                               // Share.share(ayinpostu[index]["sahipID"]);
              //                                               Navigator.pop(
              //                                                   context);
              //                                             },
              //                                             child: const ListTile(
              //                                               leading: Icon(Icons
              //                                                   .share_outlined),
              //                                               title: Text(
              //                                                   "Kullanıcıyı paylaş."),
              //                                             ),
              //                                           ),
              //                                           InkWell(
              //                                             onTap: () {
              //                                               Clipboard.setData(
              //                                                 ClipboardData(
              //                                                   text: ayinpostu[
              //                                                           index]
              //                                                       ["sahipID"],
              //                                                 ),
              //                                               );
              //                                               Navigator.pop(
              //                                                   context);
              //                                               // ScaffoldMessenger.of(
              //                                               //         context)
              //                                               //     .showSnackBar(
              //                                               //   SnackBar(
              //                                               //     content: Text(
              //                                               //         "Kopyalandı !"),
              //                                               //     shape:
              //                                               //         StadiumBorder(),
              //                                               //   ),
              //                                               // );
              //                                               Fluttertoast
              //                                                   .showToast(
              //                                                 msg:
              //                                                     "Kopyalandı !",
              //                                                 toastLength: Toast
              //                                                     .LENGTH_SHORT,
              //                                                 gravity:
              //                                                     ToastGravity
              //                                                         .CENTER,
              //                                                 timeInSecForIosWeb:
              //                                                     1,
              //                                               );
              //                                             },
              //                                             child: const ListTile(
              //                                               leading: Icon(Icons
              //                                                   .content_copy),
              //                                               title: Text(
              //                                                   "Kullanıcı profil linkini kopyala."),
              //                                             ),
              //                                           ),
              //                                           Visibility(
              //                                             visible: ayinpostu[
              //                                                             index]
              //                                                         [
              //                                                         "sahipID"] ==
              //                                                     girisdata[
              //                                                         "oyuncuID"]
              //                                                 ? false
              //                                                 : true,
              //                                             child: Divider(),
              //                                           ),
              //                                           Visibility(
              //                                             visible: ayinpostu[
              //                                                             index]
              //                                                         [
              //                                                         "sahipID"] ==
              //                                                     girisdata[
              //                                                         "oyuncuID"]
              //                                                 ? false
              //                                                 : true,
              //                                             child: InkWell(
              //                                               onTap: () {
              //                                                 postID =
              //                                                     ayinpostu[
              //                                                             index]
              //                                                         [
              //                                                         "postID"];
              //                                                 postbildir();
              //                                                 Navigator.pop(
              //                                                     context);
              //                                                 // ScaffoldMessenger.of(
              //                                                 //         context)
              //                                                 //     .showSnackBar(
              //                                                 //   const SnackBar(
              //                                                 //     content: Text(
              //                                                 //         "Bildirildi !"),
              //                                                 //     shape:
              //                                                 //         StadiumBorder(),
              //                                                 //   ),
              //                                                 // );
              //                                                 Fluttertoast
              //                                                     .showToast(
              //                                                   msg:
              //                                                       "Bildirildi !",
              //                                                   toastLength: Toast
              //                                                       .LENGTH_SHORT,
              //                                                   gravity:
              //                                                       ToastGravity
              //                                                           .CENTER,
              //                                                   timeInSecForIosWeb:
              //                                                       1,
              //                                                 );
              //                                               },
              //                                               child:
              //                                                   const ListTile(
              //                                                 textColor:
              //                                                     Colors.red,
              //                                                 leading: Icon(
              //                                                   Icons
              //                                                       .flag_outlined,
              //                                                   color:
              //                                                       Colors.red,
              //                                                 ),
              //                                                 title: Text(
              //                                                     "Postu bildir."),
              //                                               ),
              //                                             ),
              //                                           ),
              //                                           Visibility(
              //                                             visible: ayinpostu[
              //                                                             index]
              //                                                         [
              //                                                         "sahipID"] ==
              //                                                     girisdata[
              //                                                         "oyuncuID"]
              //                                                 ? false
              //                                                 : true,
              //                                             child: InkWell(
              //                                               onTap: () {
              //                                                 postID =
              //                                                     ayinpostu[
              //                                                             index]
              //                                                         [
              //                                                         "postID"];
              //                                                 postbildir();
              //                                                 Navigator.pop(
              //                                                     context);
              //                                                 // ScaffoldMessenger.of(
              //                                                 //         context)
              //                                                 //     .showSnackBar(
              //                                                 //   const SnackBar(
              //                                                 //     content: Text(
              //                                                 //         "Bildirildi !"),
              //                                                 //     shape:
              //                                                 //         StadiumBorder(),
              //                                                 //   ),
              //                                                 // );
              //                                                 Fluttertoast
              //                                                     .showToast(
              //                                                   msg:
              //                                                       "Bildirildi !",
              //                                                   toastLength: Toast
              //                                                       .LENGTH_SHORT,
              //                                                   gravity:
              //                                                       ToastGravity
              //                                                           .CENTER,
              //                                                   timeInSecForIosWeb:
              //                                                       1,
              //                                                 );
              //                                               },
              //                                               child:
              //                                                   const ListTile(
              //                                                 textColor:
              //                                                     Colors.red,
              //                                                 leading: Icon(
              //                                                   Icons
              //                                                       .person_outline,
              //                                                   color:
              //                                                       Colors.red,
              //                                                 ),
              //                                                 title: Text(
              //                                                     "Kullanıcıyı bildir."),
              //                                               ),
              //                                             ),
              //                                           ),
              //                                           const SizedBox(
              //                                               height: 10),
              //                                         ],
              //                                       ),
              //                                     ],
              //                                   ),
              //                                 );
              //                               },
              //                             );
              //                           },
              //                           child: Icon(
              //                             Icons.more_vert,
              //                             size: 20,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     SizedBox(height: screenheight / 90),
              //                     DetectableText(
              //                       detectionRegExp: RegExp(
              //                         "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
              //                         multiLine: true,
              //                       ),
              //                       text: ayinpostu[index]["sosyalicerik"],
              //                       basicStyle: TextStyle(
              //                         fontSize: 16,
              //                       ),
              //                       detectedStyle: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.w500,
              //                         color: Colors.blue,
              //                       ),
              //                     ),
              //                     SizedBox(height: screenheight / 50),
              //                     Visibility(
              //                       visible: visible,
              //                       child: Container(
              //                         child: gonderifotocek(),
              //                       ),
              //                     ),
              //                     SizedBox(height: screenheight / 65),
              //                     Container(
              //                       color: Colors.transparent,
              //                       width: screenwidth,
              //                       height: screenheight / 20,
              //                       child: Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.spaceBetween,
              //                         children: [
              //                           LikeButton(
              //                             onTap: (bool isLike) {
              //                               return onLikeButtonTapped(
              //                                 isLike,
              //                                 index,
              //                               );
              //                             },
              //                             countPostion: CountPostion.right,
              //                             isLiked: ayinpostu[index]
              //                                         ["benbegendim"] !=
              //                                     0
              //                                 ? true
              //                                 : false,
              //                             likeCount: ayinpostu[index]
              //                                         ["begenisay"] !=
              //                                     "0"
              //                                 ? int.parse(
              //                                     ayinpostu[index]["begenisay"])
              //                                 : null,
              //                             likeBuilder: (bool isLiked) {
              //                               return isLiked
              //                                   ? Icon(
              //                                       Icons.favorite,
              //                                       color: Colors.red,
              //                                     )
              //                                   : Icon(
              //                                       Icons.favorite_outline,
              //                                       color: Colors.grey,
              //                                     );
              //                             },
              //                             bubblesColor: BubblesColor(
              //                               dotPrimaryColor: Colors.red,
              //                               dotSecondaryColor: Colors.blue,
              //                             ),
              //                           ),
              //                           InkWell(
              //                             onTap: () {
              //                               Navigator.push(
              //                                 context,
              //                                 MaterialPageRoute(
              //                                   builder: (context) => AnaDetail(
              //                                     veri1: ayinpostu[index]
              //                                         ["sahipavatarminnak"],
              //                                     veri2: ayinpostu[index]
              //                                         ["sahipad"],
              //                                     veri3: ayinpostu[index]
              //                                         ["sosyalicerik"],
              //                                     veri4: ayinpostu[index]
              //                                         ["paylasimzaman"],
              //                                     veri5: ayinpostu[index]
              //                                         ["begenisay"],
              //                                     veri6: ayinpostu[index]
              //                                         ["yorumsay"],
              //                                     veri7: ayinpostu[index]
              //                                         ["repostsay"],
              //                                     veri8: ayinpostu[index]
              //                                         ["sikayetsay"],
              //                                     veri9: ayinpostu[index]
              //                                         ["benbegendim"],
              //                                     veri10: ayinpostu[index]
              //                                         ["postID"],
              //                                     veri11: ayinpostu[index]
              //                                         ["sahipID"],
              //                                     veri12: ayinpostu[index]
              //                                         ["paylasimnereden"],
              //                                     veri13: ayinpostu[index]
              //                                         ["benyorumladim"],
              //                                     veri14: ayinpostu[index]
              //                                         ["oyunculink"],
              //                                   ),
              //                                 ),
              //                               );
              //                               setState(() {
              //                                 detayid =
              //                                     ayinpostu[index]["postID"];
              //                                 // print(detaylink);
              //                                 detaylink =
              //                                     "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
              //                               });
              //                             },
              //                             child: Padding(
              //                               padding: EdgeInsets.all(8.0),
              //                               child: Row(
              //                                 children: [
              //                                   ayinpostu[index]
              //                                               ["benyorumladim"] ==
              //                                           0
              //                                       ? Icon(
              //                                           Icons
              //                                               .chat_bubble_outline,
              //                                           color: Colors.grey,
              //                                         )
              //                                       : Icon(
              //                                           Icons.chat_bubble,
              //                                           color: Colors.blue,
              //                                         ),
              //                                   SizedBox(
              //                                     width: 10,
              //                                   ),
              //                                   (ayinpostu[index]["yorumsay"] !=
              //                                           "0")
              //                                       ? Text(
              //                                           ayinpostu[index]
              //                                               ["yorumsay"],
              //                                           style: TextStyle(
              //                                             color: Colors.grey,
              //                                           ),
              //                                         )
              //                                       : Text(""),
              //                                 ],
              //                               ),
              //                             ),
              //                           ),
              //                           InkWell(
              //                             onTap: () {},
              //                             child: Padding(
              //                               padding: EdgeInsets.all(8.0),
              //                               child: Row(
              //                                 children: [
              //                                   Icon(
              //                                     Icons.repeat,
              //                                     color: Colors.grey,
              //                                   ),
              //                                   SizedBox(
              //                                     width: 10,
              //                                   ),
              //                                   (ayinpostu[index]
              //                                               ["repostsay"] !=
              //                                           "0")
              //                                       ? Text(
              //                                           ayinpostu[index]
              //                                               ["repostsay"],
              //                                           style: TextStyle(
              //                                             color: Colors.grey,
              //                                           ),
              //                                         )
              //                                       : Text(""),
              //                                 ],
              //                               ),
              //                             ),
              //                           ),
              //                           InkWell(
              //                             onTap: () {
              //                               Share.share(
              //                                 ayinpostu[index]["sosyalicerik"],
              //                               );
              //                             },
              //                             child: Padding(
              //                               padding: EdgeInsets.all(8.0),
              //                               child: Icon(
              //                                 Icons.share_outlined,
              //                                 color: Colors.grey,
              //                               ),
              //                             ),
              //                           ),
              //                           SizedBox(
              //                             width: screenwidth / 15,
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //     separatorBuilder: (context, index) => Divider(),
              //     itemCount: 1,
              //   ),
              // ),

              // Visibility(
              //   visible: haberler != null ? true : false,
              //   child: Divider(
              //     color: Colors.grey,
              //     thickness: 0.7,
              //   ),
              // ),

              // Visibility(
              //   visible: haberler != null ? true : false,
              //   child: ListView.separated(
              //     physics: BouncingScrollPhysics(),
              //     scrollDirection: Axis.vertical,
              //     controller: searchHaberScrollController,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       return InkWell(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => Detail(
              //                 veri1: searchhaber[index]["haberbaslik"],
              //                 veri3: searchhaber[index]["resim"],
              //                 veri5: searchhaber[index]["resimorijinal"],
              //                 veri6: searchhaber[index]["gecenzaman"],
              //                 veri7: searchhaber[index]["yazar"],
              //                 veri8: searchhaber[index]["ozet"],
              //                 veri9: searchhaber[index]["link"],
              //                 veri10: searchhaber[index]["kategori"],
              //               ),
              //             ),
              //           ).then((value) => print(items[index]));
              //           {
              //             searchhaber[index]["id"];
              //           }
              //           print(searchhaber[index]["haberbaslik"]);
              //         },
              //         child: Container(
              //           child: Padding(
              //             padding: EdgeInsets.all(8.0),
              //             child: Row(
              //               children: [
              //                 SizedBox(
              //                   width: screenwidth / 3,
              //                   height: screenheight / 6,
              //                   child: Image.network(searchhaber[index]["resim"]),
              //                 ),
              //                 SizedBox(
              //                   width: 10,
              //                 ),
              //                 Expanded(
              //                   child: SizedBox(
              //                     height: screenheight / 6,
              //                     child: Column(
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         SizedBox(height: screenheight / 100),
              //                         Text(
              //                           searchhaber[index]["yazar"],
              //                           style: TextStyle(
              //                             color: Colors.grey,
              //                             fontSize: screenwidth / 25,
              //                           ),
              //                         ),
              //                         Spacer(),
              //                         Text(
              //                           searchhaber[index]["haberbaslik"],
              //                           maxLines: 2,
              //                           style: TextStyle(
              //                             overflow: TextOverflow.ellipsis,
              //                             fontSize: 20,
              //                           ),
              //                         ),
              //                         Spacer(),
              //                         Row(
              //                           children: [
              //                             Text(
              //                               searchhaber[index]["kategori"],
              //                               style: TextStyle(
              //                                 color: Colors.blue,
              //                                 fontSize: screenwidth / 30,
              //                               ),
              //                             ),
              //                             SizedBox(width: screenwidth / 75),
              //                             CircleAvatar(
              //                               radius: 3,
              //                               backgroundColor: Colors.grey,
              //                             ),
              //                             SizedBox(width: screenwidth / 75),
              //                             Text(
              //                               searchhaber[index]["gecenzaman"],
              //                               style: TextStyle(
              //                                 color: Colors.grey,
              //                                 fontSize: screenwidth / 30,
              //                               ),
              //                             ),
              //                             Spacer(),
              //                             Text(
              //                               searchhaber[index]["goruntulen"],
              //                               style: TextStyle(
              //                                 color: Colors.grey,
              //                                 fontSize: screenwidth / 30,
              //                               ),
              //                             ),
              //                             SizedBox(width: screenwidth / 150),
              //                             Icon(
              //                               Icons.remove_red_eye,
              //                               color: Colors.grey,
              //                               size: 15,
              //                             ),
              //                           ],
              //                         ),
              //                         SizedBox(height: 5),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //     separatorBuilder: (context, index) => Divider(),
              //     itemCount: haberler.length,
              //   ),
              // ),
            ],
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _MainListView(
    BuildContext context,
    int index,
    double screenwidth,
    postsil,
    Future<void> _refresh(),
    postbildir,
    double screenheight,
    Future<bool> onLikeButtonTapped(bool isLike, int index),
  ) {
    // return Text("_MainListView");
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
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: screenwidth / 12,
                    backgroundImage: NetworkImage(
                      ayinpostu[index]["sahipavatarminnak"],
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
                              ayinpostu[index]["sahipad"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "  -  " + ayinpostu[index]["paylasimzamangecen"],
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
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
                                                  width: screenwidth / 4,
                                                  height: 5,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const ListTile(
                                                  leading: Icon(Icons.post_add),
                                                  title: Text(
                                                      "Postu favorilere ekle."),
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
                                                  child: const ListTile(
                                                    leading:
                                                        Icon(Icons.edit_note),
                                                    title:
                                                        Text("Postu düzenle."),
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
                                                  child: const ListTile(
                                                    leading: Icon(Icons
                                                        .delete_sweep_outlined),
                                                    title:
                                                        Text("Postu kaldır."),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  // Share.share(ayinpostu[index]["sahipID"]);
                                                  Navigator.pop(context);
                                                },
                                                child: const ListTile(
                                                  leading: Icon(
                                                      Icons.share_outlined),
                                                  title: Text(
                                                      "Kullanıcıyı paylaş."),
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
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //   SnackBar(
                                                  //     content:
                                                  //         Text("Kopyalandı !"),
                                                  //     shape:
                                                  //         const StadiumBorder(),
                                                  //   ),
                                                  // );
                                                  Fluttertoast.showToast(
                                                    msg: "Kopyalandı !",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                  );
                                                },
                                                child: const ListTile(
                                                  leading:
                                                      Icon(Icons.content_copy),
                                                  title: Text(
                                                      "Kullanıcı profil linkini kopyala."),
                                                ),
                                              ),
                                              Visibility(
                                                visible: ayinpostu[index]
                                                            ["sahipID"] ==
                                                        girisdata["oyuncuID"]
                                                    ? false
                                                    : true,
                                                child: Divider(),
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
                                                    // ScaffoldMessenger.of(
                                                    //         context)
                                                    //     .showSnackBar(
                                                    //   const SnackBar(
                                                    //     content: Text(
                                                    //         "Bildirildi !"),
                                                    //     shape:
                                                    //         const StadiumBorder(),
                                                    //   ),
                                                    // );
                                                    Fluttertoast.showToast(
                                                      msg: "Bildirildi !",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                    );
                                                  },
                                                  child: const ListTile(
                                                    textColor: Colors.red,
                                                    leading: Icon(
                                                      Icons.flag_outlined,
                                                      color: Colors.red,
                                                    ),
                                                    title:
                                                        Text("Postu bildir."),
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
                                                    // ScaffoldMessenger.of(
                                                    //         context)
                                                    //     .showSnackBar(
                                                    //   const SnackBar(
                                                    //     content: Text(
                                                    //         "Bildirildi !"),
                                                    //     shape:
                                                    //         const StadiumBorder(),
                                                    //   ),
                                                    // );
                                                    Fluttertoast.showToast(
                                                      msg: "Bildirildi !",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                    );
                                                  },
                                                  child: const ListTile(
                                                    textColor: Colors.red,
                                                    leading: Icon(
                                                      Icons.person_outline,
                                                      color: Colors.red,
                                                    ),
                                                    title: Text(
                                                        "Kullanıcıyı bildir."),
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
                          text: ayinpostu[index]["sosyalicerik"],
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
                                isLiked: ayinpostu[index]["benbegendim"] != 0
                                    ? true
                                    : false,
                                likeCount: ayinpostu[index]["begenisay"] != "0"
                                    ? int.parse(ayinpostu[index]["begenisay"])
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
                                        veri1: ayinpostu[index]
                                            ["sahipavatarminnak"],
                                        veri2: ayinpostu[index]["sahipad"],
                                        veri3: ayinpostu[index]["sosyalicerik"],
                                        veri4: ayinpostu[index]
                                            ["paylasimzaman"],
                                        veri5: ayinpostu[index]["begenisay"],
                                        veri6: ayinpostu[index]["yorumsay"],
                                        veri7: ayinpostu[index]["repostsay"],
                                        veri8: ayinpostu[index]["sikayetsay"],
                                        veri9: ayinpostu[index]["benbegendim"],
                                        veri10: ayinpostu[index]["postID"],
                                        veri11: ayinpostu[index]["sahipID"],
                                        veri12: ayinpostu[index]
                                            ["paylasimnereden"],
                                        veri13: ayinpostu[index]
                                            ["benyorumladim"],
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
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ayinpostu[index]["benyorumladim"] == 0
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
                                      (ayinpostu[index]["yorumsay"] != "0")
                                          ? Text(
                                              ayinpostu[index]["yorumsay"],
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
                                        width: 10,
                                      ),
                                      (ayinpostu[index]["repostsay"] != "0")
                                          ? Text(
                                              ayinpostu[index]["repostsay"],
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
                                    ayinpostu[index]["sosyalicerik"],
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
          )
        : CircularProgressIndicator();
  }

  Widget _xphorizontalListView() {
    // return Text("_xphorizontalListView");
    return xpsiralama.isEmpty
        ? CircularProgressIndicator()
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

  Widget _horizontalChipListView() {
    // List popular_tags = ["love", "me", "summer"];

    get_chip(name) {
      return FilterChip(
        // selected: popular_tags.contains(name),
        selectedColor: Colors.blue.shade800,
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        label: Text("#${name["etiketadi"]}"),
        onSelected: (bool value) {
          print("$name");
        },
      );
    }

    generate_tags() {
      return hashtagler.map((tag) => get_chip(tag));
    }

    return SizedBox(
      // height: 200,
      // child: GridView.builder(
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 4,
      //     crossAxisSpacing: 5,
      //     mainAxisSpacing: 10,
      //     // maxCrossAxisExtent: 220,
      //   ),
      //   scrollDirection: Axis.horizontal,
      //   physics: BouncingScrollPhysics(),
      //   controller: searchHorizontalChipScrollController,
      //   shrinkWrap: true,
      //   itemBuilder: (BuildContext context, index) {
      //     // return ActionChip(
      //     //   onPressed: () {
      //     //     print("ActionChip");
      //     //   },
      //     //   label: Text('asd'),
      //     // );
      //     // return Chip(
      //     //   label: Text("datadata"),
      //     // );
      //     // return Center(
      //     //   child: ActionChip(
      //     //     onPressed: () {
      //     //       print("ActionChip");
      //     //     },
      //     //     label: Text('asddd'),
      //     //   ),
      //     // );
      //     // return Wrap(
      //     //   children: [
      //     //     Text("datadatadatadata"),
      //     //   ],
      //     // );
      //     return Wrap(
      //       spacing: 8.0, // gap between adjacent chips
      //       runSpacing: 4.0, // gap between lines
      //       children: <Widget>[...generate_tags()],
      //     );
      //   },
      //   itemCount: 35,
      // ),
      child: Wrap(
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 4.0, // gap between lines
        direction: Axis.horizontal,
        verticalDirection: VerticalDirection.down,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,

        children: <Widget>[...generate_tags()],
      ),
    );
  }

  Widget _pophorizontalListView() {
    return popsiralama.isEmpty
        ? CircularProgressIndicator()
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
                                    style: TextStyle(
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

////////////////////////////////////////////////////////////////////////////////

  // void _initSpeech() async {
  //   speechEnabled = await speechToText.initialize();
  //   setState(() {});
  // }

  // void _startListening() async {
  //   print("_startListening");
  //   await speechToText.listen(
  //     onResult: _onSpeechResult,
  //     localeId: "TR",
  //   );
  //   setState(() {});
  // }

  // void _stopListening() async {
  //   print("_stopListening");
  //   await speechToText.stop();
  //   setState(() {});
  // }

  // void _onSpeechResult(SpeechRecognitionResult result) {
  //   setState(() {
  //     lastWords = result.recognizedWords;
  //     searchtec.text = lastWords;
  //   });
  // }
}
