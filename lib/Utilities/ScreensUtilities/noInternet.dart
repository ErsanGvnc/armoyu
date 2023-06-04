// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'package:armoyu/Utilities/Import&Export/export.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> with TickerProviderStateMixin {
  late final AnimationController _controller;
  // late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // Platform.isAndroid ? connectionStatus() : navigate();

    // connectionStatus();

    // _subscription = Connectivity().onConnectivityChanged.listen((event) {
    //   print("noInternet");
    //   print(_subscription);
    //   print(Connectivity().checkConnectivity().toString());
    //   connectionStatus();
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    // _subscription.cancel();
    super.dispose();
  }

  connectionStatus() async {
    print("noInternet connectionStatus");
    final connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult != ConnectivityResult.none) {
      await navigate();
      setState(() {});
    } else {
      const snackBar = SnackBar(
        content: Text('Bağlantı başarısız!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  navigate() async {
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
    gkontrolAd = sharedPreferences.getString("ad");
    gkontrolSifre = sharedPreferences.getString("sifre");

    if (gkontrolAd == "" || gkontrolSifre == "") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    } else {
      MyHomePageState().girisKontrol(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return ThemeConsumer(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/animations/no-internet.json",
              controller: _controller,
              animate: true,
              repeat: true,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
                _controller.repeat();
              },
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  beingChecked = true;
                });
                await Future.delayed(const Duration(seconds: 2));
                await connectionStatus();
                setState(() {
                  beingChecked = false;
                });
              },
              child: Container(
                height: screenHeight / 15,
                width: screenWidth / 2,
                decoration: BoxDecoration(
                  color: ThemeProvider.controllerOf(context)
                              .currentThemeId
                              .toString() !=
                          "default_dark_theme"
                      ? Colors.blue
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: beingChecked
                      ? const CircularProgressIndicator()
                      : Text(
                          "Tekrar Dene",
                          style: TextStyle(
                            fontSize: 20,
                            color: ThemeProvider.controllerOf(context)
                                        .currentThemeId
                                        .toString() !=
                                    "default_dark_theme"
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: screenHeight / 10),
          ],
        ),
      ),
    );
  }
}
