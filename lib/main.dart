// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers, prefer_is_empty, sized_box_for_whitespace, sort_child_properties_last, prefer_const_constructors_in_immutables, must_be_immutable, unused_import

import 'dart:async';
import 'dart:convert';
import 'package:armoyu/Firebase/firebase.dart';
import 'package:armoyu/Utilities/links.dart';
import 'package:armoyu/initsayfa.dart';
import 'package:armoyu/profile.dart';
import 'package:armoyu/notification.dart';
import 'package:armoyu/search.dart';
import 'package:armoyu/site.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_notification/in_app_notification.dart';
import 'package:armoyu/grup.dart';
import 'package:armoyu/login.dart';
import 'package:armoyu/post.dart';
import 'package:armoyu/skelaton.dart';
import 'package:armoyu/splash.dart';
import 'package:armoyu/anasayfa.dart';
import 'package:armoyu/news.dart';
import 'package:armoyu/toplanti.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:animations/animations.dart';
import 'Controllers/controllers.dart';
import 'Variables/variables.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );
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

  // // Get any initial links
  // final PendingDynamicLinkData? initialLink =
  //     await FirebaseDynamicLinks.instance.getInitialLink();
  // runApp(MyApp(initialLink));

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

final screens = [
  AnaSayfa(),
  Search(),
  Notif(),
];

class MyApp extends StatelessWidget {
  // var initialLink;

  // MyApp(this.initialLink);

  // checkInitialLink(BuildContext context) {
  //   if (initialLink != null) {
  //     final Uri deepLink = initialLink.link;
  //     // Example of using the dynamic link to push the user to a different screen
  //     Navigator.pushNamed(context, deepLink.path);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: <AppTheme>[
        AppTheme.dark(),
        AppTheme.light(),
      ],
      child: InAppNotification(
        child: MaterialApp(
          // theme: ThemeData(
          //   pageTransitionsTheme: PageTransitionsTheme(
          //     builders: {
          //       TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          //     },
          //   ),
          // ),
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
        shape: StadiumBorder(),
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
              gruplarim.clear();
              gkontrolAd = "";
              gkontrolSifre = "";
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

    return ThemeConsumer(
      child: Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ThemeConsumer(
                                child: Profile(
                                  veri1: girisdata["oyuncuID"],
                                ),
                              ),
                            ),
                          );
                          print("Profile");
                        },
                        child: DrawerHeader(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  girisdata["parkaresimufak"]),
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
                                    backgroundImage: CachedNetworkImageProvider(
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
                        leading: Icon(Icons.article),
                        title: Text("Haberler"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ThemeConsumer(
                                child: News(),
                              ),
                            ),
                          );
                        },
                      ),
                      // Toplantı

                      Visibility(
                        visible: girisdata["yetkisi"] == "-1" ? false : true,
                        child: ListTile(
                          leading: Icon(Icons.group),
                          title: Text("Toplantı"),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Toplanti(),
                              ),
                            );
                          },
                        ),
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
                      //           // veri1: girisdata["presim"],
                      //           // veri2: girisdata["adim"],
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

                      // Hakkımızda
                    ],
                  ),
                ),
                Visibility(
                  visible: gruplarim.length >= 1 ? true : false,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  controller: drawerScrollController,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          grupid = gruplarim[index]["grupID"];
                                          grupdetail =
                                              "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/0/0/&grupid=$grupid";
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
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: CachedNetworkImage(
                                                      imageUrl: gruplarim[index]
                                                          ["grupufaklogo"],
                                                      placeholder:
                                                          (context, url) =>
                                                              Container(
                                                        color: Colors.grey[700],
                                                      ),
                                                      fit: BoxFit.cover,
                                                      width: 35,
                                                      height: 35,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: screenwidth / 25),
                                                  Text(gruplarim[index]
                                                      ["grupadi"]),
                                                ],
                                              ),
                                            ),
                                          ),
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
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ThemeConsumer(
                                    child: Site(
                                      verilink:
                                          "https://aramizdakioyuncu.com/gizlilik-politikasi",
                                      veribaslik: "Gizlilik Politikası",
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.info_outline),
                          ),
                          IconButton(
                            onPressed:
                                ThemeProvider.controllerOf(context).nextTheme,
                            icon: Icon(Icons.dark_mode_outlined),
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
                    backgroundImage: CachedNetworkImageProvider(
                      girisdata["presimminnak"],
                    ),
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
            Visibility(
              visible: currentIndex == 2 ? true : false,
              child: IconButton(
                onPressed: () {
                  // print(bildirimler);
                },
                icon: Icon(Icons.settings),
              ),
            ),
          ],
        ),

        // body: Builder(
        //   builder: (BuildContext context) => bodyPageDegis(),
        // ),
        // body: screens[_currentIndex],
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Badge(
                badgeColor: Colors.blue,
                showBadge: showNotification,
                ignorePointer: true,
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 0.3,
                ),
                position: BadgePosition(
                  start: 0,
                  top: 0,
                  isCenter: false,
                ),
                child: Icon(Icons.notifications),
              ),
              label: "",
            ),
          ],
          onTap: (index) => setState(() {
            currentIndex == index && currentIndex == 0
                ? anaSayfaScrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOut,
                  )
                : null;

            currentIndex == index && currentIndex == 1
                ? searchMainScrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOut,
                  )
                : null;

            currentIndex == index && currentIndex == 2
                ? notificationScrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOut,
                  )
                : null;

            if (currentIndex == 2 || index == 2) {
              showNotification = false;
            }
            currentIndex = index;
          }),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.blue,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
        ),
        floatingActionButton: currentIndex == 0
            ? OpenContainer(
                openColor: Colors.transparent,
                closedColor: Colors.transparent,
                openElevation: 0,
                closedElevation: 0,
                closedBuilder: (context, openWidget) {
                  return FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.edit_note,
                      color: Colors.black,
                      size: 35,
                    ),
                    onPressed: openWidget,
                  );
                },
                openBuilder: (context, closeWidget) {
                  return ThemeConsumer(
                    child: Post(
                      veri1: "",
                    ),
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
