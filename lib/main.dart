// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, unused_local_variable, avoid_print, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, sized_box_for_whitespace, unused_element, unused_import, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_is_empty, library_prefixes, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:armoyu/cekilis.dart';
import 'package:armoyu/myProfile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_notification/in_app_notification.dart';
import 'package:armoyu/detail.dart';
import 'package:armoyu/etkinlik.dart';
import 'package:armoyu/grup.dart';
import 'package:armoyu/login.dart';
import 'package:armoyu/post.dart';
import 'package:armoyu/resiminceleme.dart';
import 'package:armoyu/skelaton.dart';
import 'package:armoyu/splash.dart';
import 'package:armoyu/anasayfa.dart';
import 'package:armoyu/news.dart';
import 'package:armoyu/toplanti.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:animations/animations.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    sound: true,
    criticalAlert: true,
    provisional: true,
  );
  // print(settings.authorizationStatus);

  runApp(MyApp());

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

var botId1 = dotenv.env['botId1'];
var botId2 = dotenv.env['botId2'];

var girisdata;
var datahaber;
var datagrup;
var grupid;
var detayid;
var profiledata;

List gruplarim = [];
List dataanasayfa = [];
List gonderifotolar = [];
List detaylar = [];
List toplantilar = [];
List cekilisler = [];
List postdata = [];
List medyadata = [];
List reactiondata = [];

String mevcutpage = "anasayfa";
String? gelenID;
String? gkontrolAd;
String? gkontrolSifre;

bool? gkontrolHatirla;
bool _brightness = false;
bool visible = false;

Timer? timer;
String baslik = "";

var postID;
var postsildengiden;

// late ConfettiController _confettiController;

var qrlink =
    "https://aramizdakioyuncu.com/botlar/$botId1/$gkontrolAd/$gkontrolSifre/oturum-ac/qr/$gelenID/";
var gonderiurl =
    "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/0/0/";
var haberurl =
    "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/haberler/0/0/";
var oturumkontrolurl =
    "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/0/0/0/";
var grupurl =
    "https://aramizdakioyuncu.com/botlar/$botId2/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/gruplarim/0/0/";
var grupdetail =
    "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/0/0/&grupid=$grupid";
var detaylink =
    "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/";
var etkinlikler =
    "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/etkinlikler/0/0/";
var toplantilink =
    "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/toplantilar/0/0/";
var cekilislink =
    "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/toplantilar/0/0/";
var postlink =
    "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/profil/0/";
var medyalink =
    "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/medya/0/0/";
var postbildirlink =
    "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/bildirim/0/";

// var reactionlink =
//     "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/tepki/0/0/";

Widget bodyPageDegis() {
  switch (mevcutpage) {
    case "anasayfa":
      return AnaSayfa();
    case "news":
      return News();
    case "etkinlik":
      return Etkinlik();
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
      child: InAppNotification(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ThemeConsumer(
            child: Splash(),
          ),
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
    // _confettiController = ConfettiController(duration: Duration(seconds: 1));
  }

  girisKontrol(BuildContext context) async {
    var giris =
        "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/0/0/0/";
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
        .then(
      (value) {
        setState(() {
          gelenID = value;
          qrlink =
              "https://aramizdakioyuncu.com/botlar/$botId1/$gkontrolAd/$gkontrolSifre/oturum-ac/qr/$gelenID/";
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
        );

        qrsite();

        InAppNotification.show(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/yenilogo.png',
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            "ARMOYU",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Giriş Yapılıyor !",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Lütfen web sayfanızın yenilenmesini bekleyin...",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          context: context,
          onTap: () => print('Notification tapped!'),
          duration: Duration(seconds: 5),
        );
      },
    );
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
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ThemeConsumer(
                                child: MyProfile(
                                  veri1: girisdata["oyuncuID"],
                                  // veri2: girisdata["parkaresimufak"],
                                  // veri3: girisdata["presimufak"],
                                  // veri4: girisdata["adim"],
                                  // veri5: girisdata["hakkimda"],
                                  // veri6: girisdata["ulkesi"],
                                  // veri7: girisdata["kayittarihikisa"],
                                  // veri8: girisdata["kullaniciadi"],
                                  // veri9: 1,
                                  // veri10: "asda",
                                  // veri11: "asda",
                                  // veri12: "asda",
                                  // veri13: 2,
                                ),
                                // child: ProfileDeneme(),
                              ),
                            ),
                          );
                          print("Profile");
                        },
                        child: DrawerHeader(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            image: DecorationImage(
                              image: NetworkImage(girisdata["parkaresimufak"]),
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
                                      girisdata["presimufak"],
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
                      // Toplantı

                      ListTile(
                        leading: Icon(Icons.group),
                        title: Text("Toplantı"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Toplanti(
                                veri1: girisdata["presim"],
                                veri2: girisdata["adim"],
                              ),
                            ),
                          );
                        },
                      ),

                      // // Etkinlik

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

                      // // Cekiliş

                      // ListTile(
                      //   leading: Icon(Icons.redeem),
                      //   title: Text("Çekiliş"),
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => Cekilis(
                      //           veri1: girisdata["presim"],
                      //           veri2: girisdata["adim"],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),

                      // // Forum

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
                                              "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/0/0/&grupid=$grupid";

                                          // print(grupdetail);
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
                                        //       "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/0/0/&grupid=$grupid";
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
                                                        ["grupufaklogo"],
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
          // title: Text(mevcutpage == "etkinlik" ? "Etkinlikler" : ""),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Padding(
                  padding: EdgeInsets.all(4),
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(girisdata["presimminnak"]),
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
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => Resiminceleme(
            //           veri1: resimler,
            //         ),
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

            // confetti parti

            // IconButton(
            //   onPressed: () {
            //     _confettiController.play();
            //   },
            //   icon: Icon(
            //     Icons.celebration,
            //     color: Colors.red,
            //   ),
            // ),

            // sohbet chat

            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.question_answer_outlined),
            // ),
            SizedBox(width: screenwidth / 70),
          ],
        ),
        body: Builder(
          builder: (BuildContext context) => bodyPageDegis(),
        ),
        // body: ConfettiWidget(
        //   confettiController: _confettiController,
        //   blastDirection: 0.5,
        //   emissionFrequency: 1,
        //   numberOfParticles: 10,
        //   shouldLoop: false,
        //   blastDirectionality: BlastDirectionality.explosive,
        //   // displayTarget: true,
        //   child: Builder(
        //     builder: (BuildContext context) => bodyPageDegis(),
        //   ),
        // ),

        // floatingActionButton: mevcutpage == "anasayfa"
        //     ? FloatingActionButton(
        //         backgroundColor: Colors.red,
        //         child: Icon(
        //           Icons.add,
        //         ),
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => Post(),
        //             ),
        //           );
        //         },
        //       )
        //     : null,

        floatingActionButton: mevcutpage == "anasayfa"
            ? OpenContainer(
                openColor: Colors.transparent,
                closedColor: Colors.transparent,
                openElevation: 0,
                closedElevation: 0,
                closedBuilder: (context, openWidget) {
                  return FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    onPressed: openWidget,
                  );
                },
                openBuilder: (context, closeWidget) {
                  return ThemeConsumer(
                    child: Post(),
                  );
                },
              )
            : null,
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
