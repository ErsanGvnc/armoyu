// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, no_leading_underscores_for_local_identifiers, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import '../../Controllers/controllers.dart';
import '../../Utilities/utilities.dart';
import '../../Variables/variables.dart';

class ByrDetail extends StatefulWidget {
  int veri1;
  String veri2;

  ByrDetail({
    required this.veri1,
    required this.veri2,
  });

  @override
  State<ByrDetail> createState() => _ByrDetailState();
}

class _ByrDetailState extends State<ByrDetail> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    String _title = "";

    if (widget.veri1 == 0) {
      setState(() {
        _title = "Beğeniler";
      });
    } else if (widget.veri1 == 1) {
      setState(() {
        _title = "Yorumlar";
      });
    } else {
      setState(() {
        _title = "Repostlar";
      });
    }
    @override
    void initState() {
      super.initState();
      // postbyrcek();
    }

    Future<void> _refresh() {
      setState(() {
        postbyr.clear();
      });
      return postbyrcek();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          child: postbyr.isNotEmpty
              ? ListView.separated(
                  controller: byrScrollController,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: screenWidth / 20,
                          backgroundImage: NetworkImage(
                              "https://aramizdakioyuncu.com/galeri/profilresimleri/11profilresimminnak1655290338.jpg"),
                          backgroundColor: Colors.red,
                        ),
                        title: Text("Ersan Güvenç"),
                        // subtitle: Text("data"),
                        trailing: Text(
                          "20 dakika önce",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  },
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 15,
                    right: 10,
                    bottom: 10,
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                )
              : SkeletonListView(
                  scrollable: true,
                  itemCount: 20,
                ),
        ),
      ),
    );
  }
}
