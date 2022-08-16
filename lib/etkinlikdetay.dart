// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, avoid_unnecessary_containers, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:armoyu/main.dart';
import 'package:theme_provider/theme_provider.dart';

import 'Variables/variables.dart';

class EtkinlikDetay extends StatefulWidget {
  String veri;

  EtkinlikDetay({
    required this.veri,
  });
  @override
  State<EtkinlikDetay> createState() => _EtkinlikDetayState();
}

class _EtkinlikDetayState extends State<EtkinlikDetay> {
  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.veri),
        ),
        body: Container(
          child: dataanasayfa != null
              ? ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    if (dataanasayfa[index]["paylasimfoto"] != null) {
                      gonderifotolar = dataanasayfa[index]["paylasimfoto"];
                      visible = true;
                    } else {
                      visible = false;
                    }
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        child: Text("data"),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: dataanasayfa.length,
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                )
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => NewsCardSkelton(),
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemCount: 10,
                ),
        ),
      ),
    );
  }
}
