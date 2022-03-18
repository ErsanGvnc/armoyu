// ignore_for_file: avoid_print, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jsonekleme/detail.dart';
import 'package:jsonekleme/main.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  @override
  NewsState createState() => NewsState();
}

class NewsState extends State<News> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var gelen = await http.get(
      Uri.parse(haberurl),
    );
    datahaber = jsonDecode(gelen.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    Future<void> _refresh() {
      return fetchData();
    }

    final items = List<String>.generate(15, (i) => "Item $i");
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Container(
        child: datahaber != null
            ? ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  //return NewsCardSkelton();
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(
                            veri: items[index],
                            veri1: datahaber[index]["haberbaslik"],
                            //veri2: data[index]["id"].toString(),
                            veri3: datahaber[index]["resim"],
                            //veri4: data[index]["yaziicerik"],
                            veri5: datahaber[index]["resimorijinal"],
                            veri6: datahaber[index]["gecenzaman"],
                            veri7: datahaber[index]["yazar"],
                            veri8: datahaber[index]["ozet"],
                            veri9: datahaber[index]["link"],
                            veri10: datahaber[index]["kategori"],
                          ),
                        ),
                      ).then((value) => print(items[index]));
                      {
                        datahaber[index]["id"];
                      }
                      // print(data[index]["id"]);
                      print(datahaber[index]["haberbaslik"]);
                    },
                    child: Container(
                      //color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: screenwidth / 3,
                              height: screenheight / 6,
                              child: Image.network(datahaber[index]["resim"]),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                //color: Colors.brown,
                                height: screenheight / 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Text("Id:${data[index]["id"]}"),
                                    SizedBox(height: screenheight / 100),
                                    Text(
                                      datahaber[index]["yazar"],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: screenwidth / 25,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      datahaber[index]["haberbaslik"],
                                      maxLines: 2,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          datahaber[index]["kategori"],
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: screenwidth / 30,
                                          ),
                                        ),
                                        SizedBox(width: screenwidth / 75),
                                        CircleAvatar(
                                          radius: 3,
                                          backgroundColor: Colors.grey,
                                        ),
                                        SizedBox(width: screenwidth / 75),
                                        Text(
                                          datahaber[index]["gecenzaman"],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: screenwidth / 30,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          datahaber[index]["goruntulen"],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: screenwidth / 30,
                                          ),
                                        ),
                                        SizedBox(width: screenwidth / 150),
                                        Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.grey,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    SizedBox(height: screenheight / 100),
                itemCount: 15,
              )
            : ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => NewsCardSkelton(),
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: 10,
              ),
      ),
    );
  }
}
