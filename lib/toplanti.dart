// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_unnecessary_containers, must_be_immutable, use_key_in_widget_constructors, unnecessary_null_comparison, avoid_print, prefer_typing_uninitialized_variables, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, valid_regexps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:armoyu/login.dart';
import 'package:armoyu/main.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:http/http.dart' as http;

class Toplanti extends StatefulWidget {
  String veri1, veri2;
  Toplanti({
    required this.veri1,
    required this.veri2,
  });

  @override
  State<Toplanti> createState() => _ToplantiState();
}

class _ToplantiState extends State<Toplanti> {
  @override
  void initState() {
    super.initState();
    toplanticek();
  }

  final toplanti = TextEditingController();
  var toplantiid;
  var toplantitarih = "";
  var toplantiadi = "";
  var setstatedegiden;
  var maxLength = 250;
  var textLength = 0;

  var now = DateTime.now();

  toplanticek() async {
    var gelen = await http.get(
      Uri.parse(toplantilink),
    );

    try {
      toplantilar = jsonDecode(gelen.body);
    } catch (e) {
      print(e);
    }
    print("toplantilar");
    print(toplantilar);
    setState(() {});
  }

  toplantigonder() {
    http.post(
      Uri.parse(
        "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/toplantilar/$toplantiid/0/",
      ),
      body: {
        "icerik": toplanti.text,
      },
    ).then((cevap) {
      print(cevap.statusCode);
      print(cevap.body);
      setState(() {
        setstatedegiden = cevap.body;
      });
    });
    print("toplantı");
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    return ThemeConsumer(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(toplantiadi.toString()),
              SizedBox(width: 15),
              Text(
                toplantitarih.toString(),
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                print(toplantiid);
                print(toplantitarih);
                print(toplantiadi);

                toplantiid = "";
                toplantitarih = "";
                toplantiadi = "";

                print("temizlendi");

                setState(() {});

                print(toplantiid);
                print(toplantitarih);
                print(toplantiadi);
              },
              icon: Icon(Icons.close),
            ),
            IconButton(
              onPressed: () {
                toplanticek();
                print("yenilendi");
                setState(() {});
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: screenwidth / 12,
                      backgroundImage: NetworkImage(
                        girisdata["presimufak"],
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(width: 15),
                    Text(
                      girisdata["adim"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "  -  " +
                          "${DateFormat('kk:mm , d MMM y').format(DateTime.now())}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Flexible(
                  child: TextField(
                    controller: toplanti,
                    maxLines: 10,
                    maxLength: maxLength,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                          r"[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQXZÇŞĞÜÖİçşğüöı0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)* ]",
                          //r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
                          caseSensitive: true,
                          unicode: true,
                          dotAll: true,
                        ),
                      ),
                    ],
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      counterText: "",
                      suffixText:
                          "${textLength.toString()}/${maxLength.toString()}",
                      suffixIcon: IconButton(
                        onPressed: toplanti.clear,
                        icon: Icon(Icons.clear),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'Neler söylemek istersin ?',
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: InkWell(
                      onTap: () {
                        if (toplanti.text.isNotEmpty &&
                            toplantiid.toString().isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Gönderildi ! " +
                                  "${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
                            ),
                          );
                          toplantigonder();
                          toplanti.clear();
                          toplantiid = "";
                          toplantitarih = "";
                          toplantiadi = "";

                          print("Gönderildi !");
                        } else if (toplanti.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("İçerik boş olamaz ! " +
                                  "${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
                            ),
                          );
                          print("İçerik boş olamaz !");
                        } else if (toplantiid.toString().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Lütfen toplantı seçin ! " +
                                  "${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
                            ),
                          );
                          print("Lütfen toplantı seçin !");
                        }
                      },
                      child: Container(
                        width: screenwidth,
                        height: screenheight / 12,
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            "Gönder",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: toplantilar.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            horizontalTitleGap: 5,
                            contentPadding: EdgeInsets.only(left: 5),
                            leading: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset(
                                "assets/images/yenilogo.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                            title: Text(toplantilar[index]["toplantiadi"]),
                            subtitle: Text(toplantilar[index]["toplantizaman"]),
                            onTap: () {
                              toplantiid = toplantilar[index]["toplantiID"];
                              toplantitarih =
                                  toplantilar[index]["toplantizaman"];
                              toplantiadi = toplantilar[index]["toplantiadi"];
                              print(toplantiid);
                              setState(() {});
                            },
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
