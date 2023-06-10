// ignore_for_file: avoid_print

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:skeletons/skeletons.dart';
import 'package:badges/badges.dart' as badge;
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotifState();
}

class _NotifState extends State<Notifications> {
  Future bildirimcek() async {
    try {
      final gelen = await http.get(
        Uri.parse(bildirimlink),
      );

      myNotifications = jsonDecode(gelen.body);
    } catch (e) {
      print('Unknown exception: $e');
    }
    if (mounted) {
      setState(() {});
    }
  }

  arkadascevap(int index, String evethayir) async {
    var gelen = await http.post(
      Uri.parse(arkadascevaplink),
      body: {
        "oyuncubakid": myNotifications[index]["bildirimkimID"],
        "cevap": evethayir,
      },
    );

    try {
      response = jsonDecode(gelen.body);
      print(response["durum"]);

      if (response["durum"] != 1) {
        print(response["aciklama"]);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _refresh() async {
    await bildirimcek();
    // print(myNotifications[0]["bildirimzamandetay"]);
    // print(myNotifications[0]["bildirimzamandetay"].substring(0, 2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bildirimcek(),
      initialData: bildirimcek(),
      builder: (context, snapshot) => RefreshIndicator(
        onRefresh: _refresh,
        child: myNotifications.isNotEmpty
            ? ListView.separated(
                controller: notificationScrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: myNotifications.length,
                itemBuilder: (BuildContext context, int index) {
                  // if (myNotifications[index]["bildirimzamandetay"]
                  //         .substring(0, 2) <=
                  //     "24") {
                  //   return const Text("data");
                  // } else {
                  return InkWell(
                    onTap: () {
                      if (myNotifications[index]["bildirimkategori"] ==
                              "post" ||
                          myNotifications[index]["bildirimkategori"] ==
                              "postyorum" ||
                          myNotifications[index]["bildirimkategori"] ==
                              "postbildiri") {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ThemeConsumer(
                        //       child: Profile(
                        //         veri1: myNotifications[index]["bildirimkimID"],
                        //       ),
                        //     ),
                        //   ),
                        // );
                      } else if (myNotifications[index]["bildirimkategori"] ==
                              "kabul" ||
                          myNotifications[index]["bildirimkategori"] == "ret") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThemeConsumer(
                              child: Profile(
                                veri1: myNotifications[index]["bildirimkimID"],
                              ),
                            ),
                          ),
                        );
                      }

                      print(myNotifications[index]);
                    },
                    child: badge.Badge(
                      badgeStyle: const badge.BadgeStyle(
                        badgeColor: Colors.blue,
                      ),
                      position: badge.BadgePosition.topStart(),
                      showBadge: hasNotificationBeenSeen,
                      ignorePointer: true,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ThemeConsumer(
                                    child: Profile(
                                      veri1: myNotifications[index]
                                          ["bildirimkimID"],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    myNotifications[index]
                                            ["bildirimkimavatar"] ??
                                        "https://aramizdakioyuncu.com/galeri/ana-yapi/armoyu64.png",
                                  ),
                                ),
                              ),
                              width: 50,
                              height: 50,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: SizedBox(
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
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ThemeConsumer(
                                                  child: Profile(
                                                    veri1:
                                                        myNotifications[index]
                                                            ["bildirimkimID"],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            myNotifications[index]
                                                    ["bildirimkimadsoyad"] ??
                                                "",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          myNotifications[index]
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
                                      text: myNotifications[index]
                                          ["bildirimicerik"],
                                      detectedStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Visibility(
                                      visible: myNotifications[index]
                                                      ["bildirimkategori"] ==
                                                  "istek" ||
                                              myNotifications[index]
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
                                                onTap: () async {
                                                  await arkadascevap(
                                                      index, "evet");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
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
                                                        myNotifications[index][
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
                                                onTap: () async {
                                                  await arkadascevap(
                                                      index, "hayır");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
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
                                                        myNotifications[index][
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
                  // }
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
