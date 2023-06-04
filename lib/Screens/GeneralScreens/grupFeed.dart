// ignore_for_file: must_be_immutable, file_names, avoid_print, no_leading_underscores_for_local_identifiers

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:http/http.dart' as http;

class GrupFeed extends StatefulWidget {
  String veri1, veri2;
  GrupFeed({
    Key? key,
    required this.veri1,
    required this.veri2,
  }) : super(key: key);

  @override
  State<GrupFeed> createState() => _GrupState();
}

class _GrupState extends State<GrupFeed> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var gelen = await http.get(
      Uri.parse(grupdetail),
    );
    grupFeed = jsonDecode(gelen.body);
    if (mounted) {
      setState(() {
        // print(grupFeed);
        // print(grupdetail);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _refresh() {
      return fetchData();
    }

    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.veri1),
        ),

        body: RefreshIndicator(
          onRefresh: _refresh,
          child: grupFeed.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  itemCount: grupFeed.length,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(10),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
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
                                    veri1: grupFeed[index]["sahipID"],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: screenWidth / 12,
                            backgroundImage: CachedNetworkImageProvider(
                              grupFeed[index]["sahipavatarminnak"],
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
                                              veri1: grupFeed[index]["sahipID"],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      grupFeed[index]["sahipad"],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "  -  ${grupFeed[index]["paylasimzamangecen"]}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  // InkWell(
                                  //   onTap: () {
                                  //     showModalBottomSheet<void>(
                                  //       shape: const RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.vertical(
                                  //           top: Radius.circular(10),
                                  //         ),
                                  //       ),
                                  //       context: context,
                                  //       builder: (BuildContext context) {
                                  //         return SafeArea(
                                  //           child: Wrap(
                                  //             children: [
                                  //               Column(
                                  //                 children: [
                                  //                   Padding(
                                  //                     padding: const EdgeInsets
                                  //                             .symmetric(
                                  //                         vertical: 10),
                                  //                     child: Container(
                                  //                       decoration:
                                  //                           BoxDecoration(
                                  //                         color:
                                  //                             Colors.grey[900],
                                  //                         borderRadius:
                                  //                             const BorderRadius
                                  //                                 .all(
                                  //                           Radius.circular(30),
                                  //                         ),
                                  //                       ),
                                  //                       width: screenWidth / 4,
                                  //                       height: 5,
                                  //                     ),
                                  //                   ),
                                  //                   InkWell(
                                  //                     onTap: () {
                                  //                       Navigator.pop(context);
                                  //                     },
                                  //                     child: ListTile(
                                  //                       leading: const Icon(
                                  //                           Icons.post_add),
                                  //                       title: Text(
                                  //                           addFavoritePost),
                                  //                     ),
                                  //                   ),
                                  //                   Visibility(
                                  //                     visible: mainFeed[index]
                                  //                                 ["sahipID"] ==
                                  //                             girisdata[
                                  //                                 "oyuncuID"]
                                  //                         ? true
                                  //                         : false,
                                  //                     child: InkWell(
                                  //                       onTap: () {
                                  //                         postID =
                                  //                             mainFeed[index]
                                  //                                 ["postID"];
                                  //                         Navigator.pop(
                                  //                             context);
                                  //                         Navigator.push(
                                  //                           context,
                                  //                           MaterialPageRoute(
                                  //                             builder: (context) =>
                                  //                                 ThemeConsumer(
                                  //                               child:
                                  //                                   SharePost(
                                  //                                 veri1: "",
                                  //                                 veri2: mainFeed[
                                  //                                         index]
                                  //                                     [
                                  //                                     "sosyalicerik"],
                                  //                               ),
                                  //                             ),
                                  //                           ),
                                  //                         );
                                  //                       },
                                  //                       child: ListTile(
                                  //                         leading: const Icon(
                                  //                             Icons.edit_note),
                                  //                         title: Text(editPost),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   Visibility(
                                  //                     visible: mainFeed[index]
                                  //                                 ["sahipID"] ==
                                  //                             girisdata[
                                  //                                 "oyuncuID"]
                                  //                         ? true
                                  //                         : false,
                                  //                     child: InkWell(
                                  //                       onTap: () {
                                  //                         postID =
                                  //                             mainFeed[index]
                                  //                                 ["postID"];
                                  //                         postsil();
                                  //                         Navigator.pop(
                                  //                             context);
                                  //                         Future.delayed(
                                  //                             const Duration(
                                  //                               milliseconds:
                                  //                                   100,
                                  //                             ), () {
                                  //                           _refresh();
                                  //                         });
                                  //                         Fluttertoast
                                  //                             .showToast(
                                  //                           msg:
                                  //                               removePostNotification,
                                  //                           toastLength: Toast
                                  //                               .LENGTH_SHORT,
                                  //                           gravity:
                                  //                               ToastGravity
                                  //                                   .CENTER,
                                  //                           timeInSecForIosWeb:
                                  //                               1,
                                  //                         );
                                  //                       },
                                  //                       child: ListTile(
                                  //                         leading: const Icon(Icons
                                  //                             .delete_sweep_outlined),
                                  //                         title:
                                  //                             Text(removePost),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   InkWell(
                                  //                     onTap: () {
                                  //                       Share.share(
                                  //                           mainFeed[index]
                                  //                               ["oyunculink"]);
                                  //                       Navigator.pop(context);
                                  //                     },
                                  //                     child: ListTile(
                                  //                       leading: const Icon(Icons
                                  //                           .share_outlined),
                                  //                       title: Text(shareUser),
                                  //                     ),
                                  //                   ),
                                  //                   InkWell(
                                  //                     onTap: () {
                                  //                       Clipboard.setData(
                                  //                         ClipboardData(
                                  //                           text: mainFeed[
                                  //                                   index]
                                  //                               ["oyunculink"],
                                  //                         ),
                                  //                       );
                                  //                       Navigator.pop(context);
                                  //                       Fluttertoast.showToast(
                                  //                         msg: "Kopyalandı !",
                                  //                         toastLength: Toast
                                  //                             .LENGTH_SHORT,
                                  //                         gravity: ToastGravity
                                  //                             .CENTER,
                                  //                         timeInSecForIosWeb: 1,
                                  //                       );
                                  //                     },
                                  //                     child: ListTile(
                                  //                       leading: const Icon(
                                  //                           Icons.content_copy),
                                  //                       title: Text(
                                  //                           shareUserProfileLink),
                                  //                     ),
                                  //                   ),
                                  //                   Visibility(
                                  //                     visible: mainFeed[index]
                                  //                                 ["sahipID"] ==
                                  //                             girisdata[
                                  //                                 "oyuncuID"]
                                  //                         ? false
                                  //                         : true,
                                  //                     child: const Divider(),
                                  //                   ),
                                  //                   Visibility(
                                  //                     visible: mainFeed[index]
                                  //                                 ["sahipID"] ==
                                  //                             girisdata[
                                  //                                 "oyuncuID"]
                                  //                         ? false
                                  //                         : true,
                                  //                     child: InkWell(
                                  //                       onTap: () {
                                  //                         postID =
                                  //                             mainFeed[index]
                                  //                                 ["postID"];
                                  //                         postbildir();
                                  //                         Navigator.pop(
                                  //                             context);
                                  //                         Fluttertoast
                                  //                             .showToast(
                                  //                           msg: "Bildirildi !",
                                  //                           toastLength: Toast
                                  //                               .LENGTH_SHORT,
                                  //                           gravity:
                                  //                               ToastGravity
                                  //                                   .CENTER,
                                  //                           timeInSecForIosWeb:
                                  //                               1,
                                  //                         );
                                  //                       },
                                  //                       child: ListTile(
                                  //                         textColor: Colors.red,
                                  //                         leading: const Icon(
                                  //                           Icons.flag_outlined,
                                  //                           color: Colors.red,
                                  //                         ),
                                  //                         title:
                                  //                             Text(reportPost),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   Visibility(
                                  //                     visible: mainFeed[index]
                                  //                                 ["sahipID"] ==
                                  //                             girisdata[
                                  //                                 "oyuncuID"]
                                  //                         ? false
                                  //                         : true,
                                  //                     child: InkWell(
                                  //                       onTap: () {
                                  //                         postID =
                                  //                             mainFeed[index]
                                  //                                 ["postID"];
                                  //                         postbildir();
                                  //                         Navigator.pop(
                                  //                             context);
                                  //                         Fluttertoast
                                  //                             .showToast(
                                  //                           msg: "Engellendi !",
                                  //                           toastLength: Toast
                                  //                               .LENGTH_SHORT,
                                  //                           gravity:
                                  //                               ToastGravity
                                  //                                   .CENTER,
                                  //                           timeInSecForIosWeb:
                                  //                               1,
                                  //                         );
                                  //                       },
                                  //                       child: ListTile(
                                  //                         textColor: Colors.red,
                                  //                         leading: const Icon(
                                  //                           Icons
                                  //                               .person_off_outlined,
                                  //                           color: Colors.red,
                                  //                         ),
                                  //                         title:
                                  //                             Text(blockUser),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   Visibility(
                                  //                     visible: mainFeed[index]
                                  //                                 ["sahipID"] ==
                                  //                             girisdata[
                                  //                                 "oyuncuID"]
                                  //                         ? false
                                  //                         : true,
                                  //                     child: InkWell(
                                  //                       onTap: () {
                                  //                         postID =
                                  //                             mainFeed[index]
                                  //                                 ["postID"];
                                  //                         postbildir();
                                  //                         Navigator.pop(
                                  //                             context);
                                  //                         Fluttertoast
                                  //                             .showToast(
                                  //                           msg: "Bildirildi !",
                                  //                           toastLength: Toast
                                  //                               .LENGTH_SHORT,
                                  //                           gravity:
                                  //                               ToastGravity
                                  //                                   .CENTER,
                                  //                           timeInSecForIosWeb:
                                  //                               1,
                                  //                         );
                                  //                       },
                                  //                       child: ListTile(
                                  //                         textColor: Colors.red,
                                  //                         leading: const Icon(
                                  //                           Icons
                                  //                               .person_outline,
                                  //                           color: Colors.red,
                                  //                         ),
                                  //                         title:
                                  //                             Text(reportUser),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   const SizedBox(height: 10),
                                  //                 ],
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         );
                                  //       },
                                  //     );
                                  //   },
                                  //   child: const Icon(
                                  //     Icons.more_vert,
                                  //     size: 20,
                                  //     color: Colors.grey,
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(height: screenHeight / 90),
                              DetectableText(
                                detectionRegExp: RegExp(
                                  "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                                  multiLine: true,
                                ),
                                text: grupFeed[index]["sosyalicerik"],
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
                              // Visibility(
                              //   visible: visible,
                              //   child: Container(
                              //     child: gonderifotocek(),
                              //   ),
                              // ),
                              // SimpleUrlPreview(
                              //   url: grupFeed[index]["sosyalicerik"],
                              //   isClosable: true,
                              //   imageLoaderColor: Colors.blue,
                              //   titleStyle: const TextStyle(
                              //     color: Colors.white,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              //   descriptionStyle: const TextStyle(
                              //     color: Colors.white,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              //   siteNameStyle: const TextStyle(
                              //     color: Colors.white,
                              //   ),
                              // ),
                              SizedBox(height: screenHeight / 65),

                              // Container(
                              //   color: Colors.transparent,
                              //   width: screenWidth,
                              //   height: screenHeight / 20,
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       LikeButton(
                              //         onTap: (bool isLike) {
                              //           return onLikeButtonTapped(
                              //             isLike,
                              //             index,
                              //           );
                              //         },
                              //         countPostion: CountPostion.right,
                              //         isLiked:
                              //             mainFeed[index]["benbegendim"] != 0
                              //                 ? true
                              //                 : false,
                              //         likeCount:
                              //             mainFeed[index]["begenisay"] != "0"
                              //                 ? int.parse(
                              //                     mainFeed[index]["begenisay"])
                              //                 : null,
                              //         likeBuilder: (bool isLiked) {
                              //           return isLiked
                              //               ? const Icon(
                              //                   Icons.favorite,
                              //                   color: Colors.red,
                              //                 )
                              //               : const Icon(
                              //                   Icons.favorite_outline,
                              //                   color: Colors.grey,
                              //                 );
                              //         },
                              //         bubblesColor: const BubblesColor(
                              //           dotPrimaryColor: Colors.red,
                              //           dotSecondaryColor: Colors.blue,
                              //         ),
                              //       ),
                              //       InkWell(
                              //         onTap: () {
                              //           Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //               builder: (context) => ThemeConsumer(
                              //                 child: PostDetail(
                              //                   veri1: mainFeed[index]
                              //                       ["sahipavatarminnak"],
                              //                   veri2: mainFeed[index]
                              //                       ["sahipad"],
                              //                   veri3: mainFeed[index]
                              //                       ["sosyalicerik"],
                              //                   veri4: mainFeed[index]
                              //                       ["paylasimzaman"],
                              //                   veri5: mainFeed[index]
                              //                       ["begenisay"],
                              //                   veri6: mainFeed[index]
                              //                       ["yorumsay"],
                              //                   veri7: mainFeed[index]
                              //                       ["repostsay"],
                              //                   veri8: mainFeed[index]
                              //                       ["sikayetsay"],
                              //                   veri9: mainFeed[index]
                              //                       ["benbegendim"],
                              //                   veri10: mainFeed[index]
                              //                       ["postID"],
                              //                   veri11: mainFeed[index]
                              //                       ["sahipID"],
                              //                   veri12: mainFeed[index]
                              //                       ["paylasimnereden"],
                              //                   veri13: mainFeed[index]
                              //                       ["benyorumladim"],
                              //                   veri14: mainFeed[index]
                              //                       ["oyunculink"],
                              //                 ),
                              //               ),
                              //             ),
                              //           ).whenComplete(
                              //             () => isMusicOn = false,
                              //           );
                              //           if (mounted) {
                              //             setState(() {
                              //               detayid = mainFeed[index]["postID"];
                              //               // print(detaylink);
                              //               detaylink =
                              //                   "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/&postislem=yorumlarim";
                              //             });
                              //           }
                              //         },
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Row(
                              //             children: [
                              //               mainFeed[index]["benyorumladim"] ==
                              //                       0
                              //                   ? const FaIcon(
                              //                       FontAwesomeIcons.comment,
                              //                       color: Colors.grey,
                              //                       size: 22,
                              //                     )
                              //                   : const FaIcon(
                              //                       FontAwesomeIcons
                              //                           .solidComment,
                              //                       color: Colors.blue,
                              //                       size: 22,
                              //                     ),
                              //               const SizedBox(
                              //                 width: 10,
                              //               ),
                              //               (mainFeed[index]["yorumsay"] != "0")
                              //                   ? Text(
                              //                       mainFeed[index]["yorumsay"],
                              //                       style: const TextStyle(
                              //                         color: Colors.grey,
                              //                       ),
                              //                     )
                              //                   : const Text(""),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //       InkWell(
                              //         onTap: () {
                              //           Fluttertoast.showToast(
                              //             msg: comingSoon,
                              //             toastLength: Toast.LENGTH_SHORT,
                              //             gravity: ToastGravity.CENTER,
                              //             timeInSecForIosWeb: 1,
                              //           );
                              //         },
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Row(
                              //             children: [
                              //               const FaIcon(
                              //                 FontAwesomeIcons.retweet,
                              //                 color: Colors.grey,
                              //                 size: 22,
                              //               ),
                              //               const SizedBox(
                              //                 width: 10,
                              //               ),
                              //               (mainFeed[index]["repostsay"] !=
                              //                       "0")
                              //                   ? Text(
                              //                       mainFeed[index]
                              //                           ["repostsay"],
                              //                       style: const TextStyle(
                              //                         color: Colors.grey,
                              //                       ),
                              //                     )
                              //                   : const Text(""),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //       InkWell(
                              //         onTap: () {
                              //           Share.share(
                              //             mainFeed[index]["sosyalicerik"],
                              //           );
                              //         },
                              //         child: const Padding(
                              //           padding: EdgeInsets.all(8.0),
                              //           child: Icon(
                              //             Icons.share_outlined,
                              //             color: Colors.grey,
                              //           ),
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         width: screenWidth / 15,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),

        // body: RefreshIndicator(
        //   onRefresh: _refresh,
        //   child: Container(
        //     child: grupFeed != null
        //         ? ListView.separated(
        //             physics: const BouncingScrollPhysics(),
        //             scrollDirection: Axis.vertical,
        //             itemBuilder: (context, index) {
        //               if (mainFeed[index]["paylasimfoto"] != null) {
        //                 gonderifotolar = mainFeed[index]["paylasimfoto"];
        //                 // print(grupFeed[index]["benbegendim"]);
        //                 visible = true;
        //               } else {
        //                 visible = false;
        //               }
        //               return InkWell(
        //                 onTap: () {
        //                   // Navigator.push(
        //                   //   context,
        //                   //   MaterialPageRoute(
        //                   //     builder: (context) => PostDetail(
        //                   //       veri1: grupFeed[index]["sahipavatarminnak"],
        //                   //       veri2: grupFeed[index]["sahipad"],
        //                   //       veri3: grupFeed[index]["sosyalicerik"],
        //                   //       veri4: grupFeed[index]["paylasimzaman"],
        //                   //       veri5: grupFeed[index]["begenisay"],
        //                   //       veri6: grupFeed[index]["yorumsay"],
        //                   //       veri7: grupFeed[index]["repostsay"],
        //                   //       veri8: grupFeed[index]["sikayetsay"],
        //                   //       veri9: grupFeed[index]["benbegendim"],
        //                   //       veri10: mainFeed[index]["postID"],
        //                   //       veri11: mainFeed[index]["sahipID"],
        //                   //       veri12: mainFeed[index]["paylasimnereden"],
        //                   //       veri13: mainFeed[index]["benyorumladim"],
        //                   //       veri14: mainFeed[index]["oyunculink"],
        //                   //     ),
        //                   //   ),
        //                   // );
        //                   // print(grupFeed[index]["benbegendim"]);
        //                 },
        //                 child: Row(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     CircleAvatar(
        //                       radius: screenWidth / 12,
        //                       backgroundImage: NetworkImage(
        //                         grupFeed[index]["sahipavatarminnak"],
        //                       ),
        //                       backgroundColor: Colors.transparent,
        //                     ),
        //                     SizedBox(width: screenWidth / 35),
        //                     Expanded(
        //                       child: Column(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Row(
        //                             children: [
        //                               Text(
        //                                 grupFeed[index]["sahipad"],
        //                                 style: const TextStyle(
        //                                   fontWeight: FontWeight.bold,
        //                                 ),
        //                               ),
        //                               Text(
        //                                 "  -  ${grupFeed[index]["paylasimzamangecen"]}",
        //                                 style: const TextStyle(
        //                                   color: Colors.grey,
        //                                   fontWeight: FontWeight.bold,
        //                                 ),
        //                               ),
        //                               const Spacer(),
        //                               InkWell(
        //                                 onTap: () {},
        //                                 child: const Icon(
        //                                   Icons.more_vert,
        //                                   size: 20,
        //                                   color: Colors.grey,
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                           SizedBox(height: screenHeight / 90),
        //                           Text(
        //                             grupFeed[index]["sosyalicerik"],
        //                           ),
        //                           SizedBox(height: screenHeight / 50),
        //                           SizedBox(height: screenHeight / 65),
        //                           Container(
        //                             color: Colors.transparent,
        //                             width: screenWidth,
        //                             height: screenHeight / 20,
        //                             child: Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 InkWell(
        //                                   onTap: () {},
        //                                   child: Padding(
        //                                     padding: const EdgeInsets.all(8.0),
        //                                     child: Row(
        //                                       children: [
        //                                         (grupFeed[index]
        //                                                     ["benbegendim"] !=
        //                                                 0)
        //                                             ? const Icon(
        //                                                 Icons.favorite,
        //                                                 color: Colors.red,
        //                                               )
        //                                             : const Icon(
        //                                                 Icons.favorite_border,
        //                                                 color: Colors.grey,
        //                                               ),
        //                                         const SizedBox(width: 10),
        //                                         (grupFeed[index]["begenisay"] !=
        //                                                 "0")
        //                                             ? Text(
        //                                                 grupFeed[index]
        //                                                     ["begenisay"],
        //                                                 style: const TextStyle(
        //                                                   color: Colors.grey,
        //                                                 ),
        //                                               )
        //                                             : const Text(""),
        //                                       ],
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 InkWell(
        //                                   onTap: () {},
        //                                   child: Padding(
        //                                     padding: const EdgeInsets.all(8.0),
        //                                     child: Row(
        //                                       children: [
        //                                         const Icon(
        //                                           Icons.chat_bubble_outline,
        //                                           color: Colors.grey,
        //                                         ),
        //                                         const SizedBox(
        //                                           width: 10,
        //                                         ),
        //                                         (grupFeed[index]["yorumsay"] !=
        //                                                 "0")
        //                                             ? Text(
        //                                                 grupFeed[index]
        //                                                     ["yorumsay"],
        //                                                 style: const TextStyle(
        //                                                   color: Colors.grey,
        //                                                 ),
        //                                               )
        //                                             : const Text(""),
        //                                       ],
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 InkWell(
        //                                   onTap: () {},
        //                                   child: Padding(
        //                                     padding: const EdgeInsets.all(8.0),
        //                                     child: Row(
        //                                       children: [
        //                                         const Icon(
        //                                           Icons.repeat,
        //                                           color: Colors.grey,
        //                                         ),
        //                                         const SizedBox(
        //                                           width: 5,
        //                                         ),
        //                                         (grupFeed[index]["repostsay"] !=
        //                                                 "0")
        //                                             ? Text(
        //                                                 mainFeed[index]
        //                                                     ["repostsay"],
        //                                                 style: const TextStyle(
        //                                                   color: Colors.grey,
        //                                                 ),
        //                                               )
        //                                             : const Text(""),
        //                                       ],
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 InkWell(
        //                                   onTap: () {
        //                                     Share.share(
        //                                       grupFeed[index]["sosyalicerik"],
        //                                     );
        //                                   },
        //                                   child: const Padding(
        //                                     padding: EdgeInsets.all(8.0),
        //                                     child: Icon(
        //                                       Icons.share_outlined,
        //                                       color: Colors.grey,
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 SizedBox(
        //                                   width: screenWidth / 15,
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               );
        //             },
        //             separatorBuilder: (context, index) => const Divider(),
        //             itemCount: grupFeed.length,
        //             padding: const EdgeInsets.only(
        //               top: 10,
        //               left: 10,
        //               right: 10,
        //               bottom: 10,
        //             ),
        //           )
        //         : ListView.separated(
        //             physics: const BouncingScrollPhysics(),
        //             scrollDirection: Axis.vertical,
        //             itemBuilder: (context, index) => const Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: [
        //                 SizedBox(height: 150),
        //                 Text(
        //                   "Henüz grubunuzda hiç\npaylaşım yapılmamış...",
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                     fontSize: 22,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             separatorBuilder: (context, index) =>
        //                 const SizedBox(height: 5),
        //             itemCount: 1,
        //           ),
        //   ),
        // ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Container(),
    // );
  }
}
