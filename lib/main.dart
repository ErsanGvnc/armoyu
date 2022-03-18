// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, unused_local_variable, avoid_print, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, sized_box_for_whitespace, unused_element, unused_import, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:jsonekleme/detail.dart';
import 'package:jsonekleme/login.dart';
import 'package:jsonekleme/register.dart';
import 'package:jsonekleme/sabit.dart';
import 'package:jsonekleme/skelaton.dart';
import 'package:jsonekleme/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

import 'anasayfa.dart';
import 'news.dart';

void main() async {
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

var girisdata;
var datahaber;
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

var qrlink =
    "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/$gkontrolAd/$gkontrolSifre/oturum-ac/qr/$gelenID/";
var gonderiurl =
    "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/kullaniciadi/kullaniciparola/sosyal/0/0/";
var haberurl =
    "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/kullaniciadi/kullaniciparola/haberler/0/0/";
var oturumkontrolurl =
    "https://aramizdakioyuncu.com/botlar/8cdee5526476b101869401a37c03e379/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/0/0/0/";

Widget bodyPageDegis() {
  switch (mevcutpage) {
    case "anasayfa":
      return AnaSayfa();
    case "news":
      return News();
    case "etkinlik":
      return News();
    case "cekilis":
      return News();
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

    final items = List<String>.generate(15, (i) => "Item $i");

    return ThemeConsumer(
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Color.fromRGBO(0, 0, 0, 1),
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
                    ListTile(
                      leading: Icon(Icons.event),
                      title: Text("Etkinlikler"),
                      onTap: () {
                        setState(() {
                          mevcutpage = "etkinlik";
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.redeem),
                      title: Text("Çekiliş"),
                      onTap: () {
                        setState(() {
                          mevcutpage = "cekilis";
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.forum),
                      title: Text("Forum"),
                      onTap: () {
                        setState(() {
                          mevcutpage = "forum";
                        });
                        Navigator.pop(context);
                      },
                    ),
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
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
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Sabit(
                        veri5: dataanasayfa[0]["begenisay"],
                        veri6: dataanasayfa[0]["yorumsay"],
                        veri7: dataanasayfa[0]["repostsay"],
                        veri8: dataanasayfa[0]["sikayetsay"],
                        veri9: gonderifotolar[0]["fotourl"],
                      );
                    },
                  ),
                );
              },
              child: Hero(
                tag: 'imageHero',
                child: Image.network(
                  'https://picsum.photos/250?image=9',
                ),
              ),
            ),
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
          onPressed: () {},
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
