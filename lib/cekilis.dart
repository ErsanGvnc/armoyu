// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, must_be_immutable, use_key_in_widget_constructors, unused_local_variable, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:armoyu/login.dart';
import 'package:armoyu/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:http/http.dart' as http;

class Cekilis extends StatefulWidget {
  String veri1, veri2;
  Cekilis({
    required this.veri1,
    required this.veri2,
  });

  @override
  State<Cekilis> createState() => _CekilisState();
}

class _CekilisState extends State<Cekilis> {
  @override
  void initState() {
    super.initState();
    cekiliscek();
  }

  var setstatedegiden;

  cekiliscek() async {
    var gelen = await http.get(
      Uri.parse(cekilislink),
    );

    try {
      cekilisler = jsonDecode(gelen.body);
    } catch (e) {
      print(e);
    }
    print("cekilisler");
    print(cekilisler);
    setState(() {});
  }

  cekiliskatil() {
    http.post(
      Uri.parse(
        "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/cekilis/0/0/",
      ),
      body: {},
    ).then((cevap) {
      print(cevap.statusCode);
      print(cevap.body);
      setState(() {
        setstatedegiden = cevap.body;
      });
    });
    print("çekiliş");
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    return ThemeConsumer(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Çekilişler"),
          actions: [
            IconButton(
              onPressed: () {
                cekiliscek();
                print("yenilendi");
                setState(() {});
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: screenwidth / 12,
                      backgroundImage: NetworkImage(
                        widget.veri1,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(width: 15),
                    Text(
                      widget.veri2.toString(),
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
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
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
                            title: Text(""),
                            subtitle: Text(""),
                            // burada çekilişin devam edip etmedigini kontrol et
                            // ediyorsa "+" etmiyorsa "x" döndür.
                            trailing: IconButton(
                              onPressed: () {
                                print("Çekilişe Katıldın !");
                              },
                              icon: Icon(Icons.add),
                            ),
                            onTap: () {},
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
