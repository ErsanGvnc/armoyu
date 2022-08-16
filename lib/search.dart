// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors, unused_field, prefer_final_fields, unused_local_variable, prefer_const_literals_to_create_immutables, avoid_print, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_element, use_function_type_syntax_for_parameters, unnecessary_null_comparison

import 'dart:convert';
import 'package:armoyu/detail.dart';
import 'package:armoyu/resiminceleme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:flutter/services.dart';
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

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
    searchcek();
    // _initSpeech();
  }

  List resimler = [];

  searchcek() {}

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
      // return const Text("-- Video --");

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
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
    // setState(() {
    //   searchler.clear();
    // });
    return searchcek();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    search() async {
      final url = Uri.parse(searchlink);

      final gelen = await http.get(url);

      if (gelen.statusCode == 200) {
        searchler = jsonDecode(gelen.body);
        setState(() {});
      }
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
    //   child: InkWell(
    //     highlightColor: Colors.transparent,
    //     splashColor: Colors.transparent,
    //     onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    //     child: Container(
    //       child: ListView(
    //         controller: searchMainScrollController,
    //         scrollDirection: Axis.vertical,
    //         shrinkWrap: true,
    //         padding: EdgeInsets.only(
    //           top: 10,
    //           left: 10,
    //           right: 10,
    //           bottom: 10,
    //         ),
    //         children: [
    //           TextFormField(
    //             controller: searchtec,
    //             autofocus: false,
    //             focusNode: focusNode,
    //             decoration: InputDecoration(
    //               enabledBorder: OutlineInputBorder(
    //                 borderRadius: BorderRadius.all(
    //                   Radius.circular(30),
    //                 ),
    //                 borderSide: BorderSide(
    //                   color: Colors.grey,
    //                   width: 1,
    //                 ),
    //               ),
    //               focusedBorder: OutlineInputBorder(
    //                 borderRadius: BorderRadius.all(
    //                   Radius.circular(30),
    //                 ),
    //                 borderSide: BorderSide(
    //                   color: Colors.grey,
    //                   width: 1,
    //                 ),
    //               ),
    //               prefixIcon: Icon(Icons.search),
    //               // suffixIcon: IconButton(
    //               //   onPressed: speechToText.isNotListening
    //               //       ? _startListening
    //               //       : _stopListening,
    //               //   icon: Icon(Icons.mic),
    //               // ),
    //               hintText: "Ara...",
    //               hintStyle: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //               ),
    //               border: InputBorder.none,
    //             ),
    //             textInputAction: TextInputAction.search,
    //             onFieldSubmitted: (String value) {
    //               RawAutocomplete.onFieldSubmitted(autocompleteKey);
    //             },
    //           ),
    //           RawAutocomplete<List<String>>(
    //             key: autocompleteKey,
    //             focusNode: focusNode,
    //             textEditingController: searchtec,
    //             optionsBuilder: (TextEditingValue textEditingValue) async {
    //               if (textEditingValue.text.isEmpty ||
    //                   textEditingValue.text.length < 3) {
    //                 setState(() {
    //                   aratildi = 0;
    //                 });
    //                 return Iterable.empty();
    //               }
    //               var options = kullanicilar.map(
    //                 (kullanici) => [
    //                   kullanici["ID"].toString(),
    //                   kullanici["adsoyad"].toString(),
    //                 ],
    //               );
    //               return options.where((List<String> option) {
    //                 return option[1]
    //                     .toString()
    //                     .toLowerCase()
    //                     .contains(textEditingValue.text.toLowerCase());
    //               });
    //             },
    //             onSelected: (option) {
    //               var id = option[0], kulAdSoyad = option[1];
    //               searchtec.text = kulAdSoyad;
    //             },
    //             optionsViewBuilder: (
    //               BuildContext context,
    //               AutocompleteOnSelected<List<String>> onSelected,
    //               Iterable<List> options,
    //             ) {
    //               return ThemeConsumer(
    //                 child: SingleChildScrollView(
    //                   scrollDirection: Axis.vertical,
    //                   controller: searchSingleChildSVScrollController,
    //                   child: Wrap(
    //                     children: [
    //                       Material(
    //                         elevation: 4.0,
    //                         child: ListView(
    //                           scrollDirection: Axis.vertical,
    //                           padding: EdgeInsets.zero,
    //                           shrinkWrap: true,
    //                           controller: searchListViewScrollController,
    //                           children: options
    //                               .map((dynamic option) => InkWell(
    //                                     onTap: () {
    //                                       var id = option[0];
    //                                       var kulAdSoyad = option[1];
    //                                       searchtec.text = kulAdSoyad;
    //                                       // search();
    //                                       setState(() {
    //                                         aratildi = 1;
    //                                       });
    //                                       FocusManager.instance.primaryFocus
    //                                           ?.unfocus();
    //                                     },
    //                                     child: ListTile(
    //                                       title: Text(option[1]),
    //                                     ),
    //                                   ))
    //                               .toList(),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               );
    //             },
    //           ),
    //           Divider(
    //             color: Colors.grey,
    //             thickness: 1,
    //           ),
    //           aratildi == 0
    //               ? Column(
    //                   children: [
    //                     // index hata veriyor.
    //                     _MainListView(
    //                       context,
    //                       0,
    //                       screenwidth,
    //                       postsil,
    //                       _refresh,
    //                       postbildir,
    //                       screenheight,
    //                       onLikeButtonTapped,
    //                     ),
    //                     Divider(
    //                       color: Colors.grey,
    //                       // thickness: 1,
    //                     ),
    //                     // _horizontalListView(),
    //                     Divider(
    //                       color: Colors.grey,
    //                       // thickness: 1,
    //                     ),
    //                     _horizontalChipListView(),
    //                     Divider(
    //                       color: Colors.grey,
    //                       // thickness: 1,
    //                     ),
    //                     // _horizontalListView(),
    //                   ],
    //                 )
    //               : searchedildi(),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  searchedildi() {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    final items = List<String>.generate(15, (i) => "Item $i");
    return ListView(
      controller: searchSearchScrollController,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      children: [
        Column(
          children: [
            ListTile(
              onTap: () {},
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: screenwidth / 12,
                backgroundImage: NetworkImage(
                  "https://aramizdakioyuncu.com/galeri/profilresimleri/11profilresimminnak1655290338.jpg",
                ),
                backgroundColor: Colors.transparent,
              ),
              title: Text("Ersan Güvenç"),
              subtitle: Text(
                  "HakkımdaHakkımdaHakkımdaHakkımdaHakkımdaHakkımdaHakkımda"),
            ),
            Visibility(
              visible: searchgaleri != null ? true : false,
              child: GridView.builder(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
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
                      child: Image.network(
                        searchgaleri[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                itemCount: 4,
              ),
            ),
          ],
        ),
        Visibility(
          visible: searchgaleri != null ? true : false,
          child: Divider(
            color: Colors.grey,
            thickness: 0.7,
          ),
        ),
        Visibility(
          visible: searchgaleri != null ? true : false,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            controller: searchPostScrollController,
            itemBuilder: (context, index) {
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

                  setState(() {
                    detayid = dataanasayfa[index]["postID"];
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
                                      dataanasayfa[index]["paylasimzamangecen"],
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
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[900],
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
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
                                                      leading:
                                                          Icon(Icons.post_add),
                                                      title: Text(
                                                          "Postu favorilere ekle."),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: dataanasayfa[index]
                                                                ["sahipID"] ==
                                                            girisdata[
                                                                "oyuncuID"]
                                                        ? true
                                                        : false,
                                                    child: InkWell(
                                                      onTap: () {
                                                        postID =
                                                            dataanasayfa[index]
                                                                ["postID"];
                                                        // postsil();
                                                        Navigator.pop(context);
                                                      },
                                                      child: const ListTile(
                                                        leading: Icon(
                                                            Icons.edit_note),
                                                        title: Text(
                                                            "Postu düzenle."),
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: dataanasayfa[index]
                                                                ["sahipID"] ==
                                                            girisdata[
                                                                "oyuncuID"]
                                                        ? true
                                                        : false,
                                                    child: InkWell(
                                                      onTap: () {
                                                        postID =
                                                            dataanasayfa[index]
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
                                                        title: Text(
                                                            "Postu kaldır."),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      // Share.share(dataanasayfa[index]["sahipID"]);
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
                                                          text: dataanasayfa[
                                                              index]["sahipID"],
                                                        ),
                                                      );
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "Kopyalandı !"),
                                                        ),
                                                      );
                                                    },
                                                    child: const ListTile(
                                                      leading: Icon(
                                                          Icons.content_copy),
                                                      title: Text(
                                                          "Kullanıcı profil linkini kopyala."),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: dataanasayfa[index]
                                                                ["sahipID"] ==
                                                            girisdata[
                                                                "oyuncuID"]
                                                        ? false
                                                        : true,
                                                    child: Divider(),
                                                  ),
                                                  Visibility(
                                                    visible: dataanasayfa[index]
                                                                ["sahipID"] ==
                                                            girisdata[
                                                                "oyuncuID"]
                                                        ? false
                                                        : true,
                                                    child: InkWell(
                                                      onTap: () {
                                                        postID =
                                                            dataanasayfa[index]
                                                                ["postID"];
                                                        postbildir();
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                                "Bildirildi !"),
                                                          ),
                                                        );
                                                      },
                                                      child: const ListTile(
                                                        textColor: Colors.red,
                                                        leading: Icon(
                                                          Icons.flag_outlined,
                                                          color: Colors.red,
                                                        ),
                                                        title: Text(
                                                            "Postu bildir."),
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: dataanasayfa[index]
                                                                ["sahipID"] ==
                                                            girisdata[
                                                                "oyuncuID"]
                                                        ? false
                                                        : true,
                                                    child: InkWell(
                                                      onTap: () {
                                                        postID =
                                                            dataanasayfa[index]
                                                                ["postID"];
                                                        postbildir();
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                                "Bildirildi !"),
                                                          ),
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
                              text: dataanasayfa[index]["sosyalicerik"],
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
                                        dataanasayfa[index]["benbegendim"] != 0
                                            ? true
                                            : false,
                                    likeCount: dataanasayfa[index]
                                                ["begenisay"] !=
                                            "0"
                                        ? int.parse(
                                            dataanasayfa[index]["begenisay"])
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
                                            veri1: dataanasayfa[index]
                                                ["sahipavatarminnak"],
                                            veri2: dataanasayfa[index]
                                                ["sahipad"],
                                            veri3: dataanasayfa[index]
                                                ["sosyalicerik"],
                                            veri4: dataanasayfa[index]
                                                ["paylasimzaman"],
                                            veri5: dataanasayfa[index]
                                                ["begenisay"],
                                            veri6: dataanasayfa[index]
                                                ["yorumsay"],
                                            veri7: dataanasayfa[index]
                                                ["repostsay"],
                                            veri8: dataanasayfa[index]
                                                ["sikayetsay"],
                                            veri9: dataanasayfa[index]
                                                ["benbegendim"],
                                            veri10: dataanasayfa[index]
                                                ["postID"],
                                            veri11: dataanasayfa[index]
                                                ["sahipID"],
                                            veri12: dataanasayfa[index]
                                                ["paylasimnereden"],
                                            veri13: dataanasayfa[index]
                                                ["benyorumladim"],
                                            veri14: dataanasayfa[index]
                                                ["oyunculink"],
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
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          dataanasayfa[index]
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
                                          (dataanasayfa[index]["yorumsay"] !=
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
                                            width: 10,
                                          ),
                                          (dataanasayfa[index]["repostsay"] !=
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
            itemCount: 1,
          ),
        ),
        Visibility(
          visible: haberler != null ? true : false,
          child: Divider(
            color: Colors.grey,
            thickness: 0.7,
          ),
        ),
        Visibility(
            visible: haberler != null ? true : false,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: searchHaberScrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(
                          veri1: datahaber[index]["haberbaslik"],
                          veri3: datahaber[index]["resim"],
                          veri5: datahaber[index]["resimorijinal"],
                          veri6: datahaber[index]["gecenzaman"],
                          veri7: datahaber[index]["yazar"],
                          veri8: datahaber[index]["ozet"],
                          veri9: datahaber[index]["link"],
                          veri10: datahaber[index]["kategori"],
                        ),
                      ),
                    ).then((value) => print(items[index]));
                    {
                      datahaber[index]["id"];
                    }

                    print(datahaber[index]["haberbaslik"]);
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: screenwidth / 3,
                            height: screenheight / 6,
                            child: Image.network(datahaber[index]["resim"]),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: screenheight / 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: screenheight / 100),
                                  Text(
                                    datahaber[index]["yazar"],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: screenwidth / 25,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    datahaber[index]["haberbaslik"],
                                    maxLines: 2,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        datahaber[index]["kategori"],
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: screenwidth / 30,
                                        ),
                                      ),
                                      SizedBox(width: screenwidth / 75),
                                      CircleAvatar(
                                        radius: 3,
                                        backgroundColor: Colors.grey,
                                      ),
                                      SizedBox(width: screenwidth / 75),
                                      Text(
                                        datahaber[index]["gecenzaman"],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: screenwidth / 30,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        datahaber[index]["goruntulen"],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: screenwidth / 30,
                                        ),
                                      ),
                                      SizedBox(width: screenwidth / 150),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: haberler.length,
            )),
      ],
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
    //return Text("data");
    return dataanasayfa.isNotEmpty
        ? InkWell(
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
              // sayfaya geri gelince sayfayı yenileme. _refresh yapınca en üste dönüyo
              // setState() calısmadı.
              // stateManagement (Get) ile yapılması mantıklı.
              // ).then((value) {
              //   // _refresh();
              //   setState(() {});
              //   print("refresh");
              // });

              setState(() {
                detayid = dataanasayfa[index]["postID"];
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
                                  dataanasayfa[index]["paylasimzamangecen"],
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
                                                visible: dataanasayfa[index]
                                                            ["sahipID"] ==
                                                        girisdata["oyuncuID"]
                                                    ? true
                                                    : false,
                                                child: InkWell(
                                                  onTap: () {
                                                    postID = dataanasayfa[index]
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
                                                visible: dataanasayfa[index]
                                                            ["sahipID"] ==
                                                        girisdata["oyuncuID"]
                                                    ? true
                                                    : false,
                                                child: InkWell(
                                                  onTap: () {
                                                    postID = dataanasayfa[index]
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
                                                  // Share.share(dataanasayfa[index]["sahipID"]);
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
                                                      text: dataanasayfa[index]
                                                          ["sahipID"],
                                                    ),
                                                  );
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content:
                                                          Text("Kopyalandı !"),
                                                    ),
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
                                                visible: dataanasayfa[index]
                                                            ["sahipID"] ==
                                                        girisdata["oyuncuID"]
                                                    ? false
                                                    : true,
                                                child: Divider(),
                                              ),
                                              Visibility(
                                                visible: dataanasayfa[index]
                                                            ["sahipID"] ==
                                                        girisdata["oyuncuID"]
                                                    ? false
                                                    : true,
                                                child: InkWell(
                                                  onTap: () {
                                                    postID = dataanasayfa[index]
                                                        ["postID"];
                                                    postbildir();
                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            "Bildirildi !"),
                                                      ),
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
                                                visible: dataanasayfa[index]
                                                            ["sahipID"] ==
                                                        girisdata["oyuncuID"]
                                                    ? false
                                                    : true,
                                                child: InkWell(
                                                  onTap: () {
                                                    postID = dataanasayfa[index]
                                                        ["postID"];
                                                    postbildir();
                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            "Bildirildi !"),
                                                      ),
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
                          text: dataanasayfa[index]["sosyalicerik"],
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
                                isLiked: dataanasayfa[index]["benbegendim"] != 0
                                    ? true
                                    : false,
                                likeCount:
                                    dataanasayfa[index]["begenisay"] != "0"
                                        ? int.parse(
                                            dataanasayfa[index]["begenisay"])
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
                                        veri1: dataanasayfa[index]
                                            ["sahipavatarminnak"],
                                        veri2: dataanasayfa[index]["sahipad"],
                                        veri3: dataanasayfa[index]
                                            ["sosyalicerik"],
                                        veri4: dataanasayfa[index]
                                            ["paylasimzaman"],
                                        veri5: dataanasayfa[index]["begenisay"],
                                        veri6: dataanasayfa[index]["yorumsay"],
                                        veri7: dataanasayfa[index]["repostsay"],
                                        veri8: dataanasayfa[index]
                                            ["sikayetsay"],
                                        veri9: dataanasayfa[index]
                                            ["benbegendim"],
                                        veri10: dataanasayfa[index]["postID"],
                                        veri11: dataanasayfa[index]["sahipID"],
                                        veri12: dataanasayfa[index]
                                            ["paylasimnereden"],
                                        veri13: dataanasayfa[index]
                                            ["benyorumladim"],
                                        veri14: dataanasayfa[index]
                                            ["oyunculink"],
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
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      dataanasayfa[index]["benyorumladim"] == 0
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
                                      (dataanasayfa[index]["yorumsay"] != "0")
                                          ? Text(
                                              dataanasayfa[index]["yorumsay"],
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
                                      (dataanasayfa[index]["repostsay"] != "0")
                                          ? Text(
                                              dataanasayfa[index]["repostsay"],
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
          )
        : CircularProgressIndicator();
  }

  Widget _horizontalListView() {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        controller: searchHorizontalScrollController,
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
                  image: AssetImage("assets/images/gta.jpg"),
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

  Widget _horizontalChipListView() {
    var tags = [
      "love",
      "instagood",
      "photooftheday",
      "beautiful",
      "fashion",
      "happy",
      "tbt",
      "cute",
      "followme",
      "like4like",
      "follow",
      "picoftheday",
      "me",
      "selfie",
      "summer",
      "instadaily",
    ];

    var popular_tags = ["love", "me", "summer"];

    get_chip(name) {
      return FilterChip(
        selected: popular_tags.contains(name),
        selectedColor: Colors.blue.shade800,
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        label: Text("#$name"),
        onSelected: (bool value) {
          print("$name");
        },
      );
    }

    generate_tags() {
      return tags.map((tag) => get_chip(tag)).toList();
    }

    return SizedBox(
      // height: 220,
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
        children: <Widget>[...generate_tags()],
      ),
    );
  }

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
