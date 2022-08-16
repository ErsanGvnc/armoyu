// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable, prefer_typing_uninitialized_variables, unused_element, use_build_context_synchronously, prefer_interpolation_to_compose_strings, unused_import

import 'package:armoyu/login.dart';
import 'package:armoyu/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'Variables/variables.dart';
import 'Controllers/controllers.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    register() async {
      http.post(
        Uri.parse(
          "https://aramizdakioyuncu.com/botlar/$botId1/kayit-ol/0/0/0/0/",
        ),
        body: {
          "ad": adi.text,
          "soyad": soyadi.text,
          "kullaniciadi": kadi.text,
          "email": eposta.text,
          "parola": parola.text,
          "parolakontrol": parolatekrar.text,
        },
      ).then((cevap) async {
        print(cevap.body);
        print(cevap.body[10]);

        cevap.body[10] == "1"
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              )
            : print("hata");
        adi.clear();
        soyadi.clear();
        kadi.clear();
        eposta.clear();
        parola.clear();
        parolatekrar.clear();
        setState(() {
          setstatedegiden = cevap.body;
        });
      });

      print("register");
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(73, 144, 226, 1),
      body: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            Container(
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
                          "Kayıt Ol",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenheight / 15),
                    Text("Ad"),
                    SizedBox(height: screenheight / 80),
                    TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                              "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_]"),
                        ),
                      ],
                      controller: adi,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      autofillHints: [AutofillHints.username],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        prefixIcon: Icon(Icons.person),
                        prefixIconColor: Colors.white,
                        hintText: "Adı",
                      ),
                    ),
                    SizedBox(height: screenheight / 40),
                    Text("Soyad"),
                    SizedBox(height: screenheight / 80),
                    TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                              "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_]"),
                        ),
                      ],
                      controller: soyadi,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      autofillHints: [AutofillHints.username],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        prefixIcon: Icon(Icons.person),
                        prefixIconColor: Colors.white,
                        hintText: "Soyadı",
                      ),
                    ),
                    SizedBox(height: screenheight / 40),
                    Text("E-posta"),
                    SizedBox(height: screenheight / 80),
                    TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                              "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                        ),
                      ],
                      controller: eposta,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: [AutofillHints.password],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        prefixIcon: Icon(Icons.mail),
                        prefixIconColor: Colors.white,
                        hintText: "E-posta",
                      ),
                      onEditingComplete: () =>
                          TextInput.finishAutofillContext(),
                    ),
                    SizedBox(height: screenheight / 40),
                    Text("Kullanıcı Adı"),
                    SizedBox(height: screenheight / 80),
                    TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                              "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                        ),
                      ],
                      controller: kadi,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      autofillHints: [AutofillHints.password],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        prefixIcon: Icon(Icons.person),
                        prefixIconColor: Colors.white,
                        hintText: "Kullanıcı Adı",
                      ),
                      onEditingComplete: () =>
                          TextInput.finishAutofillContext(),
                    ),
                    SizedBox(height: screenheight / 40),
                    Text("Şifre"),
                    SizedBox(height: screenheight / 80),
                    TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                              "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                        ),
                      ],
                      controller: parola,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      autofillHints: [AutofillHints.password],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        prefixIconColor: Colors.white,
                        hintText: "Şifre",
                      ),
                      onEditingComplete: () =>
                          TextInput.finishAutofillContext(),
                    ),
                    SizedBox(height: screenheight / 40),
                    Text("Şifre Tekrar"),
                    SizedBox(height: screenheight / 80),
                    TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                              "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                        ),
                      ],
                      controller: parolatekrar,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      autofillHints: [AutofillHints.password],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        prefixIconColor: Colors.white,
                        hintText: "Şifre Tekrar",
                      ),
                      onEditingComplete: () =>
                          TextInput.finishAutofillContext(),
                    ),
                    SizedBox(height: screenheight / 20),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (adi.text == "" ||
                              soyadi.text == "" ||
                              kadi.text == "" ||
                              eposta.text == "" ||
                              parola.text == "" ||
                              parolatekrar.text == "") {
                            const snackBar = SnackBar(
                              content:
                                  Text('Kayıt Bilgilerinizi Boş Bıraktınız!'),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            if (adi.text != "" ||
                                soyadi.text != "" ||
                                kadi.text != "" ||
                                eposta.text != "" ||
                                parola.text != "" ||
                                parolatekrar.text != "") {
                              if (parola.text == parolatekrar.text) {
                                register();
                              } else {
                                print("sifreler uyusmuyor");
                                const snackBar = SnackBar(
                                  content: Text('Şifreler uyuşmuyor!'),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                print(adi.text);
                                print(soyadi.text);
                                print(kadi.text);
                                print(eposta.text);
                                print(parola.text);
                                print(parolatekrar.text);
                              }
                            }
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
                              "Kayıt Ol",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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
                    SizedBox(height: screenheight / 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Zaten hesabın var mı ?",
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
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: screenheight / 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
