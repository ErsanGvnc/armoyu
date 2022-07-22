// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_unnecessary_containers, must_be_immutable, use_key_in_widget_constructors, unnecessary_null_comparison, avoid_print, prefer_typing_uninitialized_variables, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, valid_regexps

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:armoyu/login.dart';
import 'package:armoyu/main.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:http/http.dart' as http;

class Post extends StatefulWidget {
  String veri1, veri2;
  Post({
    required this.veri1,
    required this.veri2,
  });

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final post = TextEditingController();
  var setstatedegiden;
  var maxLength = 250;
  var textLength = 0;

  var now = DateTime.now();

  postgonder() {
    http.post(
      Uri.parse(
        "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/olustur/0/0/",
      ),
      // Uri.parse(
      //   "https://jsonplaceholder.typicode.com/posts",
      // ),
      body: {
        "sosyalicerik": post.text,
      },
    ).then((cevap) {
      print(cevap.statusCode);
      print(cevap.body);
      setState(() {
        setstatedegiden = cevap.body;
      });
    });
    print("post");
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(8.0),
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
                  child: TextField(
                    controller: post,
                    maxLines: 10,
                    maxLength: maxLength,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    autofocus: false,
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
                        onPressed: post.clear,
                        icon: Icon(Icons.clear),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'Neler söylemek istersin ?',
                    ),
                    onChanged: (value) {
                      setState(() {
                        textLength = value.length;
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: InkWell(
                      onTap: () {
                        if (post.text.isNotEmpty) {
                          print("Paylaşıldı !");
                          postgonder();
                          post.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Paylaşıldı ! " +
                                  "${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          print("Paylaşım boş olamaz !");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Paylaşım boş olamaz !"),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: screenwidth,
                        height: screenheight / 12,
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            "Paylaş",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
