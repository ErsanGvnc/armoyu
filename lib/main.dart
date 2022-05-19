// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, unused_local_variable, avoid_print, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, sized_box_for_whitespace, unused_element, unused_import, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_is_empty, library_prefixes

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:jsonekleme/detail.dart';
import 'package:jsonekleme/grup.dart';
import 'package:jsonekleme/login.dart';
import 'package:jsonekleme/post.dart';
import 'package:jsonekleme/register.dart';
import 'package:jsonekleme/sabit.dart';
import 'package:jsonekleme/skelaton.dart';
import 'package:jsonekleme/splash.dart';
import 'package:jsonekleme/anasayfa.dart';
import 'package:jsonekleme/news.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter/foundation.dart' as Foundation;

void main() async {
  runApp(MyApp());

  if (Foundation.kReleaseMode) {
    print('app release mode');
  } else {
    print('App debug mode');
  }

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  var sharedPreferences = await SharedPreferences.getInstance();
  if (!sharedPreferences.containsKey("ad")) {
    sharedPreferences.setString("ad", "");
  }
  if (!sharedPreferences.containsKey("sifre")) {
    sharedPreferences.setString("sifre", "");
  }
  if (!sharedPreferences.containsKey("beniHatirla")) {
    sharedPreferences.setBool("beniHatirla", true);
  }
}

var girisdata;
var datahaber;
var datagrup;
var grupid;
List gruplarim = [];
List dataanasayfa = [];
List gonderifotolar = [];

String mevcutpage = "anasayfa";
String? gelenID;
String? gkontrolAd;
String? gkontrolSifre;

bool? gkontrolHatirla;
bool _brightness = false;
bool visible = false;

Timer? timer;
String baslik = "";

var qrlink =
    "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/$gkontrolAd/$gkontrolSifre/oturum-ac/qr/$gelenID/";
var gonderiurl =
    "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/kullaniciadi/kullaniciparola/sosyal/0/0/";
var haberurl =
    "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/kullaniciadi/kullaniciparola/haberler/0/0/";
var oturumkontrolurl =
    "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/0/0/0/";
var grupurl =
    "https://aramizdakioyuncu.com/botlar/c99e178d83cdfea3c167bc1d15f9b47ff8f80145/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/gruplarim/0/0/";
var grupdetail =
    "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/0/0/&grupid=$grupid";

// burası gonderi beğeniyi siteye yollama yeri postid sini linke çekemedik(${AnaSayfa.gonderibegeniyollanan})
// var gonderibegeni =
//     "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/${AnaSayfa.gonderibegeniyollanan}/begen/";

Widget bodyPageDegis() {
  switch (mevcutpage) {
    case "anasayfa":
      return AnaSayfa();
    case "news":
      return News();
    // case "post":
    //   return Post();
    // case "grup":
    //   return Grup();
    default:
      return AnaSayfa();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: <AppTheme>[
        AppTheme.light(),
        AppTheme.dark(),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ThemeConsumer(
          child: Splash(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    grupcek();
  }

  girisKontrol(BuildContext context) async {
    var giris =
        "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/0/0/0/";
    var sharedPreferences = await SharedPreferences.getInstance();

    gkontrolAd = sharedPreferences.getString("ad");
    gkontrolSifre = sharedPreferences.getString("sifre");
    gkontrolHatirla = sharedPreferences.getBool("beniHatirla");

    var gelen = await http.get(
      Uri.parse(giris),
    );
    girisdata = jsonDecode(gelen.body);

    if (girisdata["kontrol"] == "1") {
      ad.clear();
      sifre.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
      oturumKontrol();
    } else {
      const snackBar = SnackBar(
        content: Text('Hatalı Kullanıcı Adı Veya Parola!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  qrsite() async {
    await http.get(
      Uri.parse(qrlink),
    );
  }

  void oturumKontrol() {
    timer = Timer.periodic(
      Duration(seconds: 5),
      (timer) async {
        await http.get(
          Uri.parse(oturumkontrolurl),
        );
      },
    );
  }

  void scanQrCode() {
    FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", true, ScanMode.QR)
        .then((value) {
      setState(() {
        gelenID = value;
        qrlink =
            "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/$gkontrolAd/$gkontrolSifre/oturum-ac/qr/$gelenID/";
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
      qrsite();
    });
  }

  grupcek() async {
    var gelengrup = await http.get(
      Uri.parse(grupurl),
    );
    try {
      gruplarim = jsonDecode(gelengrup.body);
    } catch (e) {
      print('Unknown exception: $e');
    }

    setState(() {});
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.8),
      title: Text(
        "ARMOYU",
        style: TextStyle(color: Colors.black),
      ),
      content: Text(
        "Çıkış Yapmak İstediğinize Emin misiniz?",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        InkWell(
          onTap: () async {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
            var sharedPreferences = await SharedPreferences.getInstance();
            setState(() {
              sharedPreferences.setString("ad", "");
              sharedPreferences.setString("sifre", "");
            });
            timer!.cancel();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: EdgeInsets.all(13),
              child: Text(
                "Evet",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: EdgeInsets.all(13),
              child: Text(
                "Hayır",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    bool? _isExpanded;

    final items = List<String>.generate(15, (i) => "Item $i");
    final ScrollController drawergrup = ScrollController();
    return ThemeConsumer(
      child: Scaffold(
        drawer: Drawer(
          // backgroundColor: Color.fromRGBO(0, 0, 0, 1),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          image: DecorationImage(
                            image: NetworkImage(girisdata["parkaresim"]),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        child: Container(
                          child: Column(
                            children: [
                              Flexible(
                                child: CircleAvatar(
                                  radius: screenwidth / 8,
                                  backgroundImage: NetworkImage(
                                    girisdata["presim"],
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              SizedBox(
                                height: screenheight / 50,
                              ),
                              Text(
                                girisdata["adim"],
                                style: TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text("Ana Sayfa"),
                        onTap: () {
                          setState(() {
                            mevcutpage = "anasayfa";
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.article),
                        title: Text("Haberler"),
                        onTap: () {
                          setState(() {
                            mevcutpage = "news";
                          });
                          Navigator.pop(context);
                        },
                      ),
                      // ListTile(
                      //   leading: Icon(Icons.event),
                      //   title: Text("Etkinlikler"),
                      //   onTap: () {
                      //     setState(() {
                      //       mevcutpage = "etkinlik";
                      //     });
                      //     Navigator.pop(context);
                      //   },
                      // ),
                      // ListTile(
                      //   leading: Icon(Icons.redeem),
                      //   title: Text("Çekiliş"),
                      //   onTap: () {
                      //     setState(() {
                      //       mevcutpage = "cekilis";
                      //     });
                      //     Navigator.pop(context);
                      //   },
                      // ),
                      // ListTile(
                      //   leading: Icon(Icons.forum),
                      //   title: Text("Forum"),
                      //   onTap: () {
                      //     setState(() {
                      //       mevcutpage = "forum";
                      //     });
                      //     Navigator.pop(context);
                      //   },
                      // ),
                    ],
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: ListTile(
                //     leading: Icon(Icons.logout),
                //     title: Text('Çıkış Yap'),
                //     onTap: () async {
                //       showAlertDialog(context);
                //     },
                //   ),
                // ),
                Visibility(
                  visible: gruplarim.length >= 1 ? true : false,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        // child: gruplarim.length == 1
                        //     ? Column(
                        //         children: [
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Text("Gruplarım"),
                        //             ],
                        //           ),
                        //           Stack(
                        //             children: [
                        //               ListView.builder(
                        //                 shrinkWrap: true,
                        //                 physics: BouncingScrollPhysics(),
                        //                 scrollDirection: Axis.vertical,
                        //                 controller: drawergrup,
                        //                 itemBuilder: (context, index) {
                        //                   return InkWell(
                        //                     onTap: () {
                        //                       grupid =
                        //                           gruplarim[index]["grupID"];
                        //                       setState(() {
                        //                         mevcutpage = "grup";
                        //                       });
                        //                       Navigator.pop(context);
                        //                     },
                        //                     child: Row(
                        //                       children: [
                        //                         Container(
                        //                           height: 50,
                        //                           child: Padding(
                        //                             padding:
                        //                                 EdgeInsets.symmetric(
                        //                                     horizontal: 8),
                        //                             child: Row(
                        //                               children: [
                        //                                 Image.network(
                        //                                   gruplarim[index]
                        //                                       ["gruplogo"],
                        //                                   fit: BoxFit.cover,
                        //                                   width: 35,
                        //                                   height: 35,
                        //                                 ),
                        //                                 SizedBox(
                        //                                     width: screenwidth /
                        //                                         25),
                        //                                 Text(gruplarim[index]
                        //                                     ["grupadi"]),
                        //                               ],
                        //                             ),
                        //                           ),
                        //                         ),
                        //                         // Spacer(),
                        //                         // IconButton(
                        //                         //   onPressed: () {},
                        //                         //   icon: Icon(Icons.arrow_drop_down),
                        //                         // ),
                        //                       ],
                        //                     ),
                        //                   );
                        //                 },
                        //                 itemCount: 1,
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       )
                        //    :
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Gruplarım"),
                              ],
                            ),
                            Stack(
                              children: [
                                // PopupMenuButton(
                                //   child: ListTile(
                                //     leading: Image.network(
                                //       gruplarim[0]["gruplogo"],
                                //       fit: BoxFit.cover,
                                //       width: 35,
                                //       height: 35,
                                //     ),
                                //     title: Text(gruplarim[0]["grupadi"]),
                                //     trailing: Icon(Icons.arrow_drop_down),
                                //   ),
                                //   itemBuilder: (context) => [
                                //     PopupMenuItem(
                                //       child: ListTile(
                                //         leading: Image.network(
                                //           gruplarim[1]["gruplogo"],
                                //           fit: BoxFit.cover,
                                //           width: 35,
                                //           height: 35,
                                //         ),
                                //         title: Text(gruplarim[1]["grupadi"]),
                                //       ),
                                //       value: 1,
                                //     ),
                                //     PopupMenuItem(
                                //       child: ListTile(
                                //         leading: Image.network(
                                //           gruplarim[2]["gruplogo"],
                                //           fit: BoxFit.cover,
                                //           width: 35,
                                //           height: 35,
                                //         ),
                                //         title: Text(gruplarim[2]["grupadi"]),
                                //       ),
                                //       value: 2,
                                //     ),
                                //   ],
                                // )
                                // ExpansionPanelList(
                                //   expansionCallback:
                                //       (int index, bool isExpanded) {},
                                //   children: [
                                //     ExpansionPanel(
                                //       headerBuilder: (BuildContext context,
                                //           bool isExpanded) {
                                //         return ListTile(
                                //           onTap: () {
                                //             setState(() {
                                //               _isExpanded == false ? true : false;
                                //             });
                                //             print(_isExpanded);
                                //             print("object");
                                //           },
                                //           title: Text('Item 1'),
                                //         );
                                //       },
                                //       body: ListTile(
                                //         title: Text('Item 1 child'),
                                //         subtitle: Text('Details goes here'),
                                //       ),
                                //       isExpanded: _isExpanded,
                                //     ),
                                //   ],
                                // ),

                                // ListView.builder(
                                //   shrinkWrap: true,
                                //   physics: BouncingScrollPhysics(),
                                //   scrollDirection: Axis.vertical,
                                //   controller: drawergrup,
                                //   itemBuilder: (context, index) {
                                //     return PopupMenuButton(
                                //       child: ListTile(
                                //         leading: Image.network(
                                //           gruplarim[index]["gruplogo"],
                                //           fit: BoxFit.cover,
                                //           width: 35,
                                //           height: 35,
                                //         ),
                                //         title: Text(gruplarim[index]["grupadi"]),
                                //         trailing: Icon(Icons.arrow_drop_down),
                                //       ),
                                //       itemBuilder: (context) => [
                                //         PopupMenuItem(
                                //           child: ListTile(
                                //             leading: Image.network(
                                //               gruplarim[index]["gruplogo"],
                                //               fit: BoxFit.cover,
                                //               width: 35,
                                //               height: 35,
                                //             ),
                                //             title:
                                //                 Text(gruplarim[index]["grupadi"]),
                                //           ),
                                //           value: 1,
                                //         ),
                                //         PopupMenuItem(
                                //           child: ListTile(
                                //             leading: Image.network(
                                //               gruplarim[index]["gruplogo"],
                                //               fit: BoxFit.cover,
                                //               width: 35,
                                //               height: 35,
                                //             ),
                                //             title:
                                //                 Text(gruplarim[index]["grupadi"]),
                                //           ),
                                //           value: 2,
                                //         ),
                                //       ],
                                //     );
                                //   },
                                //   itemCount: gruplarim.length,
                                // ),

                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  controller: drawergrup,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          grupid = gruplarim[index]["grupID"];
                                          grupdetail =
                                              "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/0/0/&grupid=$grupid";

                                          print(grupdetail);
                                        });

                                        Navigator.pop(context);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Grup(
                                              veri1: gruplarim[index]
                                                  ["grupadi"],
                                              veri2: grupdetail,
                                            ),
                                          ),
                                        );

                                        ////////////////////////////////////////////////////////////////

                                        // gidilen sayfada kalıyorum, orada initstate i bir daha çalıştırmaya çalış. // yukarıdaki kod ile çözüldü.

                                        // print(
                                        //     "*****************************************" +
                                        //         grupid);

                                        // print(
                                        //     "*****************************************" +
                                        //         grupdetail);

                                        // setState(() {
                                        //   grupid = gruplarim[index]["grupID"];
                                        //   grupdetail =
                                        //       "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/0/0/&grupid=$grupid";
                                        //   print(grupdetail);
                                        //   mevcutpage = "grup";
                                        // });

                                        // Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Row(
                                                children: [
                                                  Image.network(
                                                    gruplarim[index]
                                                        ["gruplogo"],
                                                    fit: BoxFit.cover,
                                                    width: 35,
                                                    height: 35,
                                                  ),
                                                  SizedBox(
                                                      width: screenwidth / 25),
                                                  Text(gruplarim[index]
                                                      ["grupadi"]),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Spacer(),
                                          // IconButton(
                                          //   onPressed: () {},
                                          //   icon: Icon(Icons.arrow_drop_down),
                                          // ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: gruplarim.length,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Divider(thickness: 2),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              showAlertDialog(context);
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.logout),
                                    SizedBox(width: screenwidth / 13),
                                    Text('Çıkış Yap'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed:
                                ThemeProvider.controllerOf(context).nextTheme,
                            icon: _brightness
                                ? Icon(Icons.dark_mode)
                                : Icon(Icons.dark_mode_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              scanQrCode();
                            },
                            icon: Icon(Icons.qr_code_scanner),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Padding(
                  padding: EdgeInsets.all(4),
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(girisdata["presim"]),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                onPressed: () async {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          // title:
          //     mevcutpage == "grup" ? Text(gruplarim[0]["grupadi"]) : Text(""),
          actions: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return Sabit(
            //             veri5: dataanasayfa[0]["begenisay"],
            //             veri6: dataanasayfa[0]["yorumsay"],
            //             veri7: dataanasayfa[0]["repostsay"],
            //             veri8: dataanasayfa[0]["sikayetsay"],
            //             veri9: gonderifotolar[0]["fotourl"],
            //           );
            //         },
            //       ),
            //     );
            //   },
            //   child: Hero(
            //     tag: 'imageHero',
            //     child: Image.network(
            //       'https://picsum.photos/250?image=9',
            //     ),
            //   ),
            // ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.question_answer_outlined),
            ),
            SizedBox(width: screenwidth / 70),
          ],
        ),
        body: Builder(
          builder: (BuildContext context) => bodyPageDegis(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            // setState(() {
            //   mevcutpage = "post";
            // });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Post(
                  veri1: girisdata["presim"],
                  veri2: girisdata["adim"],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class NewsCardSkelton extends StatelessWidget {
  NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Skeleton(height: screenheight / 6, width: screenwidth / 3.3),
        SizedBox(width: screenwidth / 75),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(width: screenwidth / 3.7),
              SizedBox(height: 16 / 2),
              Skeleton(),
              SizedBox(height: 16 / 2),
              Skeleton(),
              SizedBox(height: 16 / 2),
              Row(
                children: [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: screenwidth / 6),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
