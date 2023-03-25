// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print, sort_child_properties_last

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:badges/badges.dart' as badge;
import 'package:http/http.dart' as http;
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

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

  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      child: const InAppNotification(
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
  const MyHomePage({Key? key}) : super(key: key);

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
          builder: (context) => const MyHomePage(),
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
      const Duration(seconds: 5),
      (timer) async {
        try {
          await http.get(
            Uri.parse(oturumkontrolurl),
          );
        } catch (e) {
          print(e);
        }
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
            builder: (context) => const MyHomePage(),
          ),
        );

        qrsite();

        InAppNotification.show(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/yenilogo.png',
                          width: 35,
                          height: 35,
                        ),
                        const SizedBox(width: 5),
                        const Flexible(
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
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
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
          duration: const Duration(seconds: 5),
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
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
      title: const Text(
        "ARMOYU",
        style: TextStyle(color: Colors.black),
      ),
      content: const Text(
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
                builder: (context) => const Login(),
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
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: const Padding(
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
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: const Padding(
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
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

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
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  girisdata["parkaresimufak"]),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                          child: Column(
                            children: [
                              Flexible(
                                child: CircleAvatar(
                                  radius: screenWidth / 8,
                                  backgroundImage: CachedNetworkImageProvider(
                                    girisdata["presimufak"],
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight / 50,
                              ),
                              Text(
                                girisdata["adim"],
                                style: const TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      ListTile(
                        leading: const Icon(Icons.article),
                        title: const Text("Haberler"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ThemeConsumer(
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
                          leading: const Icon(Icons.group),
                          title: const Text("Toplantı"),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Toplanti(),
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
                  visible: gruplarim.isNotEmpty ? true : false,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Gruplarım"),
                            ],
                          ),
                          Stack(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
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
                                            veri1: gruplarim[index]["grupadi"],
                                            veri2: grupdetail,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
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
                                                    width: screenWidth / 25),
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
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Divider(thickness: 2),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            showAlertDialog(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.logout),
                                SizedBox(width: screenWidth / 13),
                                const Text('Çıkış Yap'),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
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
                          icon: const Icon(Icons.info_outline),
                        ),
                        IconButton(
                          onPressed:
                              ThemeProvider.controllerOf(context).nextTheme,
                          icon: const Icon(Icons.dark_mode_outlined),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            scanQrCode();
                          },
                          icon: const Icon(Icons.qr_code_scanner),
                        ),
                      ],
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
                  padding: const EdgeInsets.all(4),
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
                icon: const Icon(Icons.settings),
              ),
            ),
          ],
        ),
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: badge.Badge(
                badgeStyle: const badge.BadgeStyle(
                  badgeColor: Colors.blue,
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 0.3,
                  ),
                ),
                showBadge: showNotification,
                ignorePointer: true,
                position: badge.BadgePosition.topStart(
                  start: 0,
                  top: 0,
                ),
                child: const Icon(Icons.notifications),
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
                    child: const Icon(
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
