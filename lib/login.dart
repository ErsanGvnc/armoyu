// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jsonekleme/main.dart';
import 'package:jsonekleme/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

TextEditingController ad = TextEditingController();
TextEditingController sifre = TextEditingController();

bool beniHatirla = true;

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(73, 144, 226, 1),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenwidth / 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenheight / 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Giriş Yap",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenheight / 15),
              Text("E-Mail"),
              SizedBox(height: screenheight / 80),
              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(
                        "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_]"),
                  ),
                ],
                controller: ad,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  prefixIcon: Icon(Icons.person),
                  prefixIconColor: Colors.white,
                  hintText: "Kullanıcı adı",
                ),
              ),
              SizedBox(height: screenheight / 20),
              Text("Şifre"),
              SizedBox(height: screenheight / 80),
              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(
                        "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                  ),
                ],
                controller: sifre,
                keyboardType: TextInputType.text,
                obscureText: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  prefixIconColor: Colors.white,
                  hintText: "Şifre",
                ),
              ),
              SizedBox(height: screenheight / 75),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text("Şifremi Unuttum"),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        beniHatirla = !beniHatirla;
                      });
                    },
                    child: Container(
                        child: Row(
                      children: [
                        Checkbox(
                          value: beniHatirla,
                          onChanged: (bool? value) {
                            setState(
                              () {
                                beniHatirla = value!;
                              },
                            );
                          },
                        ),
                        Text("Beni Hatırla"),
                      ],
                    )),
                  ),
                ],
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    if (ad.text == "" || sifre.text == "") {
                      const snackBar = SnackBar(
                        content: Text('Giriş Bilgilerinizi Boş Bıraktınız!'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      if (beniHatirla == true) {
                        var sharedPreferences =
                            await SharedPreferences.getInstance();

                        sharedPreferences.setString("ad", ad.text);
                        sharedPreferences.setString("sifre", sifre.text);
                        sharedPreferences.setBool("beniHatirla", true);
                        setState(() {
                          gkontrolAd = sharedPreferences.getString("ad");
                          gkontrolSifre = sharedPreferences.getString("sifre");
                          gkontrolHatirla =
                              sharedPreferences.getBool("beniHatirla");
                        });
                      } else {
                        var sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setString("ad", "");
                        sharedPreferences.setString("sifre", "");
                        sharedPreferences.setBool("beniHatirla", false);
                      }

                      MyHomePageState().girisKontrol(context);
                    }
                  },
                  child: Container(
                    height: screenheight / 15,
                    width: screenwidth / 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Devam Et",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenheight / 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.white,
                    width: screenwidth / 15,
                    height: screenheight / 500,
                  ),
                  SizedBox(width: screenwidth / 100),
                  Text(
                    "VEYA",
                  ),
                  SizedBox(width: screenwidth / 100),
                  Container(
                    color: Colors.white,
                    width: screenwidth / 15,
                    height: screenheight / 500,
                  ),
                ],
              ),
              SizedBox(height: screenheight / 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: screenwidth / 7,
                      height: screenheight / 12,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/google.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenwidth / 8),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: screenwidth / 7,
                      height: screenheight / 12,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/steam.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenheight / 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hesabın yok mu ?",
                    style: TextStyle(),
                  ),
                  SizedBox(
                    width: screenwidth / 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                    child: Text(
                      "Kayıt Ol",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
