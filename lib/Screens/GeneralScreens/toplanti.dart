// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Toplanti extends StatefulWidget {
  const Toplanti({Key? key}) : super(key: key);

  @override
  State<Toplanti> createState() => _ToplantiState();
}

class _ToplantiState extends State<Toplanti> {
  @override
  void initState() {
    super.initState();
    toplanticek();
  }

  toplantigonder() async {
    var gelen = await http.post(
      Uri.parse(
        "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/toplantilar/$toplantiid/0/",
      ),
      body: {
        "icerik": toplanti.text,
      },
    );

    try {
      response = jsonDecode(gelen.body);
      // print(response["durum"]);

      if (response["durum"] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Bildirildi ! ${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
          ),
        );
        // print(response["aciklama"]);
        toplanti.clear();
        toplantiid = "";
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          actions: [
            Visibility(
              visible: toplanti.text != "" ? true : false,
              child: IconButton(
                onPressed: () {
                  toplanti.clear();
                  if (mounted) {
                    setState(() {
                      textLength = 0;
                    });
                  }
                },
                icon: const Icon(Icons.clear),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () async {
                  if (toplanti.text.isNotEmpty && toplantiid != "") {
                    await toplantigonder();
                  } else if (toplanti.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Mazeret boş olamaz !"),
                      ),
                    );
                    print("Mazeret boş olamaz !");
                  } else if (toplantiid.toString().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Lütfen toplantı seçin !"),
                      ),
                    );
                    print("Lütfen toplantı seçin !");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: toplanti.text.isNotEmpty ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Center(
                      child: Text(
                        "Gönder",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: CachedNetworkImageProvider(
                        girisdata["presimminnak"],
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      girisdata["adim"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "  -  ${DateFormat('kk:mm , d MMM y').format(DateTime.now())}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: DetectableTextField(
                  detectionRegExp: RegExp(
                    "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                    multiLine: true,
                  ),
                  controller: toplanti,
                  expands: true,
                  autofocus: true,
                  minLines: null,
                  maxLines: null,
                  maxLength: maxLength,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  basicStyle: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                    hintText: 'Mazeretini bildir !',
                    hintStyle: TextStyle(
                      fontSize: 18,
                    ),
                    counterText: "",
                  ),
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        textLength = value.length;
                      });
                    }
                    // print(textLength.toDouble());
                  },
                ),
              ),
              // Visibility(
              //   visible: images.isNotEmpty ? true : false,
              //   child: SizedBox(
              //     width: screenWidth,
              //     height: 150,
              //     child: ListView.separated(
              //       scrollDirection: Axis.horizontal,
              //       shrinkWrap: true,
              //       physics: const BouncingScrollPhysics(),
              //       padding: const EdgeInsets.all(8),
              //       itemBuilder: (context, index) {
              //         return Stack(
              //           children: [
              //             ClipRRect(
              //               borderRadius: BorderRadius.circular(8.0),
              //               child: Image.file(
              //                 File(images[index].path),
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //             Positioned(
              //               top: 5,
              //               right: 5,
              //               child: InkWell(
              //                 onTap: () {
              //                   setState(() {
              //                     images.removeAt(index);
              //                   });
              //                 },
              //                 child: const Icon(
              //                   Icons.clear,
              //                   color: Colors.blue,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         );
              //       },
              //       separatorBuilder: (context, index) =>
              //           const SizedBox(width: 10),
              //       itemCount: images.length,
              //     ),
              //   ),
              // ),

              SizedBox(
                width: screenWidth,
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey,
                      width: screenWidth,
                      height: 0.5,
                    ),
                    SafeArea(
                      child: SizedBox(
                        width: screenWidth,
                        child: ExpansionTile(
                          leading: const Icon(Icons.groups),
                          title: const Text("Toplantılar"),
                          children: [
                            for (int i = 0; i < toplantilar.length; i++)
                              ListTile(
                                title: Text(toplantilar[i]["toplantiadi"]),
                                subtitle: Text(
                                  toplantilar[i]["toplantizaman"],
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                onTap: () {
                                  toplantiid = toplantilar[i]["toplantiID"];
                                  print(toplantiid);
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // SizedBox(
              //   width: screenWidth,
              //   child: Column(
              //     children: [
              //       Visibility(
              //         visible: toplanti.text.isNotEmpty ? true : false,
              //         child: Container(
              //           color: textLength == 250 ? Colors.red : Colors.blue,
              //           width: min(screenWidth, textLength.toDouble() * 1.65),
              //           height: 1,
              //         ),
              //       ),
              //       Visibility(
              //         visible: toplanti.text.isEmpty ? true : false,
              //         child: Container(
              //           color: Colors.grey,
              //           width: screenWidth,
              //           height: 0.5,
              //         ),
              //       ),
              //       SafeArea(
              //         child: SizedBox(
              //           width: screenWidth,
              //           height: 50,
              //           child: ListView(
              //             scrollDirection: Axis.horizontal,
              //             shrinkWrap: true,
              //             physics: const BouncingScrollPhysics(),
              //             children: [
              //               IconButton(
              //                 onPressed: () {},
              //                 icon: const Icon(
              //                   Icons.image_outlined,
              //                   color: Colors.blue,
              //                 ),
              //               ),
              //               IconButton(
              //                 onPressed: () {
              //                   ScaffoldMessenger.of(context).showSnackBar(
              //                     const SnackBar(
              //                       duration: Duration(seconds: 1),
              //                       content: Text("Yakında !"),
              //                       shape: StadiumBorder(),
              //                     ),
              //                   );
              //                 },
              //                 icon: const Icon(
              //                   Icons.photo_camera_outlined,
              //                   color: Colors.blue,
              //                 ),
              //               ),
              //               IconButton(
              //                 onPressed: () {
              //                   ScaffoldMessenger.of(context).showSnackBar(
              //                     const SnackBar(
              //                       duration: Duration(seconds: 1),
              //                       content: Text("Yakında !"),
              //                       shape: StadiumBorder(),
              //                     ),
              //                   );
              //                   // _videoFromGallery();
              //                 },
              //                 icon: const Icon(
              //                   Icons.video_camera_back_outlined,
              //                   color: Colors.blue,
              //                 ),
              //               ),
              //               IconButton(
              //                 onPressed: () {
              //                   ScaffoldMessenger.of(context).showSnackBar(
              //                     const SnackBar(
              //                       duration: Duration(seconds: 1),
              //                       content: Text("Yakında !"),
              //                       shape: StadiumBorder(),
              //                     ),
              //                   );
              //                 },
              //                 icon: const Icon(
              //                   Icons.gif_box_outlined,
              //                   color: Colors.blue,
              //                 ),
              //               ),
              //               IconButton(
              //                 onPressed: () {
              //                   ScaffoldMessenger.of(context).showSnackBar(
              //                     const SnackBar(
              //                       duration: Duration(seconds: 1),
              //                       content: Text("Yakında !"),
              //                       shape: StadiumBorder(),
              //                     ),
              //                   );
              //                 },
              //                 icon: const Icon(
              //                   Icons.mic_outlined,
              //                   color: Colors.blue,
              //                 ),
              //               ),
              //               IconButton(
              //                 onPressed: () {
              //                   ScaffoldMessenger.of(context).showSnackBar(
              //                     const SnackBar(
              //                       duration: Duration(seconds: 1),
              //                       content: Text("Yakında !"),
              //                       shape: StadiumBorder(),
              //                     ),
              //                   );
              //                 },
              //                 icon: const Icon(
              //                   Icons.location_on_outlined,
              //                   color: Colors.blue,
              //                 ),
              //               ),
              //               const SizedBox(width: 25),
              //               Visibility(
              //                 visible: isUpload,
              //                 child: const Padding(
              //                   padding: EdgeInsets.all(5),
              //                   child: CircularProgressIndicator(),
              //                 ),
              //               ),
              //               const SizedBox(width: 10),
              //               Visibility(
              //                 visible: images.isNotEmpty ? true : false,
              //                 child: Row(
              //                   children: [
              //                     Text(
              //                       "${images.length} images",
              //                       style: const TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 16,
              //                       ),
              //                     ),
              //                     IconButton(
              //                       onPressed: () {
              //                         images.clear();
              //                         setState(() {});
              //                       },
              //                       icon: const Icon(Icons.clear),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );

    // return ThemeConsumer(
    //   child: Scaffold(
    //     resizeToAvoidBottomInset: false,
    //     appBar: AppBar(
    //       title: Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         children: [
    //           Text(toplantiadi.toString()),
    //           const SizedBox(width: 15),
    //           Text(
    //             toplantitarih.toString(),
    //             style: const TextStyle(fontSize: 12),
    //           ),
    //         ],
    //       ),
    //       actions: [
    //         IconButton(
    //           onPressed: () {
    //             print(toplantiid);
    //             print(toplantitarih);
    //             print(toplantiadi);
    //             toplantiid = "";
    //             toplantitarih = "";
    //             toplantiadi = "";
    //             print("temizlendi");
    //             setState(() {});
    //             print(toplantiid);
    //             print(toplantitarih);
    //             print(toplantiadi);
    //           },
    //           icon: const Icon(Icons.close),
    //         ),
    //         IconButton(
    //           onPressed: () {
    //             toplanticek();
    //             print("yenilendi");
    //             setState(() {});
    //           },
    //           icon: const Icon(Icons.refresh),
    //         ),
    //       ],
    //     ),
    //     body: InkWell(
    //       highlightColor: Colors.transparent,
    //       splashColor: Colors.transparent,
    //       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    //       child: Padding(
    //         padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
    //         child: Column(
    //           children: [
    //             Row(
    //               children: [
    //                 CircleAvatar(
    //                   radius: screenWidth / 12,
    //                   backgroundImage: CachedNetworkImageProvider(
    //                     girisdata["presimminnak"],
    //                   ),
    //                   backgroundColor: Colors.transparent,
    //                 ),
    //                 const SizedBox(width: 15),
    //                 Text(
    //                   girisdata["adim"],
    //                   style: const TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 Text(
    //                   "  -  ${DateFormat('kk:mm , d MMM y').format(DateTime.now())}",
    //                   style: const TextStyle(
    //                     color: Colors.grey,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 15),
    //             Flexible(
    //               child: TextField(
    //                 controller: toplanti,
    //                 maxLines: 10,
    //                 maxLength: maxLength,
    //                 maxLengthEnforcement: MaxLengthEnforcement.enforced,
    //                 inputFormatters: [
    //                   FilteringTextInputFormatter.allow(
    //                     RegExp(
    //                       r"[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQXZÇŞĞÜÖİçşğüöı0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)* ]",
    //                       caseSensitive: true,
    //                       unicode: true,
    //                       dotAll: true,
    //                     ),
    //                   ),
    //                 ],
    //                 keyboardType: TextInputType.text,
    //                 textInputAction: TextInputAction.next,
    //                 decoration: InputDecoration(
    //                   counterText: "",
    //                   suffixText:
    //                       "${textLength.toString()}/${maxLength.toString()}",
    //                   suffixIcon: IconButton(
    //                     onPressed: toplanti.clear,
    //                     icon: const Icon(Icons.clear),
    //                   ),
    //                   border: const OutlineInputBorder(),
    //                   hintText: 'Mazeretini bildir!',
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 15),
    //             Flexible(
    //               child: Padding(
    //                 padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
    //                 child: InkWell(
    //                   onTap: () {
    //                     if (toplanti.text.isNotEmpty &&
    //                         toplantiid.toString().isNotEmpty) {
    //                       ScaffoldMessenger.of(context).showSnackBar(
    //                         SnackBar(
    //                           content: Text(
    //                               "Gönderildi ! ${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
    //                           shape: const StadiumBorder(),
    //                         ),
    //                       );
    //                       toplantigonder();
    //                       toplanti.clear();
    //                       toplantiid = "";
    //                       toplantitarih = "";
    //                       toplantiadi = "";
    //                       print("Gönderildi !");
    //                     } else if (toplanti.text.isEmpty) {
    //                       ScaffoldMessenger.of(context).showSnackBar(
    //                         SnackBar(
    //                           content: Text(
    //                               "İçerik boş olamaz ! ${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
    //                           shape: const StadiumBorder(),
    //                         ),
    //                       );
    //                       print("İçerik boş olamaz !");
    //                     } else if (toplantiid.toString().isEmpty) {
    //                       ScaffoldMessenger.of(context).showSnackBar(
    //                         SnackBar(
    //                           content: Text(
    //                               "Lütfen toplantı seçin ! ${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
    //                           shape: const StadiumBorder(),
    //                         ),
    //                       );
    //                       print("Lütfen toplantı seçin !");
    //                     }
    //                   },
    //                   child: Container(
    //                     width: screenWidth,
    //                     height: screenHeight / 12,
    //                     color: Colors.blue,
    //                     child: const Center(
    //                       child: Text(
    //                         "Gönder",
    //                         style: TextStyle(
    //                           color: Colors.white,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 18,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 15),
    //             Flexible(
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   border: Border.all(),
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //                 child: Scrollbar(
    //                   thumbVisibility: true,
    //                   child: ListView.builder(
    //                     shrinkWrap: true,
    //                     itemCount: toplantilar.length,
    //                     itemBuilder: ((context, index) {
    //                       return ListTile(
    //                         horizontalTitleGap: 5,
    //                         contentPadding: const EdgeInsets.only(left: 5),
    //                         leading: Padding(
    //                           padding: const EdgeInsets.all(10),
    //                           child: Image.asset(
    //                             "assets/images/yenilogo.png",
    //                             fit: BoxFit.contain,
    //                           ),
    //                         ),
    //                         title: Text(toplantilar[index]["toplantiadi"]),
    //                         subtitle: Text(toplantilar[index]["toplantizaman"]),
    //                         onTap: () {
    //                           toplantiid = toplantilar[index]["toplantiID"];
    //                           toplantitarih =
    //                               toplantilar[index]["toplantizaman"];
    //                           toplantiadi = toplantilar[index]["toplantiadi"];
    //                           print(toplantiid);
    //                           setState(() {});
    //                         },
    //                       );
    //                     }),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
