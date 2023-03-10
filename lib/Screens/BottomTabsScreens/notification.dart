// ignore_for_file: avoid_print

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:skeletons/skeletons.dart';
import 'package:badges/badges.dart' as badge;
import 'package:http/http.dart' as http;

class Notif extends StatefulWidget {
  const Notif({Key? key}) : super(key: key);

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  Future bildirimcek() async {
    final gelen = await http.get(
      Uri.parse(bildirimlink),
    );

    try {
      bildirimler = jsonDecode(gelen.body);
    } catch (e) {
      print('Unknown exception: $e');
    }
    setState(() {});
  }

  Future<void> _refresh() async {
    bildirimcek();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

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

    return FutureBuilder(
      initialData: bildirimcek(),
      future: bildirimcek(),
      builder: (context, snapshot) => RefreshIndicator(
        onRefresh: _refresh,
        child: bildirimler.isNotEmpty
            ? ListView.separated(
                controller: notificationScrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: bildirimler.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThemeConsumer(
                            child: Profile(
                              veri1: bildirimler[index]["bildirimkimID"],
                            ),
                          ),
                        ),
                      );
                    },
                    child: badge.Badge(
                      badgeStyle: const badge.BadgeStyle(
                        badgeColor: Colors.blue,
                      ),
                      position: badge.BadgePosition.topStart(),
                      showBadge: bildirimler[index]["bildirimdurum"] == "1"
                          ? true
                          : false,
                      ignorePointer: true,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  bildirimler[index]["bildirimkimavatar"] ??
                                      "https://aramizdakioyuncu.com/galeri/ana-yapi/armoyu64.png",
                                ),
                              ),
                            ),
                            width: 50,
                            height: 50,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: SizedBox(
                              // color: Colors.amber,
                              width: screenWidth,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          bildirimler[index]
                                                  ["bildirimkimadsoyad"] ??
                                              "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          bildirimler[index]
                                              ["bildirimzamandetay"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    DetectableText(
                                      detectionRegExp: RegExp(r"@(\w+)|#(\w+)"),
                                      text: bildirimler[index]
                                          ["bildirimicerik"],
                                      detectedStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Visibility(
                                      visible: bildirimler[index]
                                                      ["bildirimkategori"] ==
                                                  "istek" ||
                                              bildirimler[index]
                                                      ["bildirimkategori"] ==
                                                  "davet"
                                          ? true
                                          : false,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    // color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        bildirimler[index][
                                                                    "bildirimkategori"] ==
                                                                "istek"
                                                            ? "Kabul Et"
                                                            : "Katıl",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    // color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        bildirimler[index][
                                                                    "bildirimkategori"] ==
                                                                "istek"
                                                            ? "Reddet"
                                                            : "Yoksay",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 15,
                  right: 10,
                  bottom: 10,
                ),
                separatorBuilder: (context, index) => const Divider(),
              )
            : SkeletonListView(
                scrollable: true,
                itemCount: 20,
              ),
      ),
    );
  }
}
