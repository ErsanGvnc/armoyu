// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:armoyu/login.dart';
import 'package:flutter/material.dart';
import 'package:armoyu/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';
import 'Variables/variables.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigate();
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
          builder: (context) => Login(),
        ),
      );
    } else {
      MyHomePageState().girisKontrol(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(),
    );
  }
}
