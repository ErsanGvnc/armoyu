// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, avoid_print

import 'package:armoyu/Utilities/Import&Export/export.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with TickerProviderStateMixin {
  // late StreamSubscription _subscription;
  @override
  void initState() {
    super.initState();

    // connectionStatus();

    Platform.isAndroid ? connectionStatus() : navigate();

    // Platform.isAndroid ? connectionStatus() : null;

    // _subscription = Connectivity().onConnectivityChanged.listen((event) async {
    //   print("splash");
    //   print(_subscription);
    //   final connectivityResult = await Connectivity().checkConnectivity();
    //   connectivityResult != ConnectivityResult.none ? await navigate() : null;
    // });
  }

  @override
  void dispose() {
    // _subscription.cancel();
    super.dispose();
  }

  connectionStatus() async {
    // print("splash connectionStatus");
    final connectivityResult = await (Connectivity().checkConnectivity());
    // print(connectivityResult);
    if (connectivityResult != ConnectivityResult.none) {
      await navigate();
      setState(() {});
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NoInternet(),
        ),
      );
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
    return const ThemeConsumer(
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
