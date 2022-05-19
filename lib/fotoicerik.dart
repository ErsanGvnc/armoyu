// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, unused_local_variable, must_be_immutable, sized_box_for_whitespace, unused_import

import 'package:flutter/material.dart';
import 'package:jsonekleme/main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theme_provider/theme_provider.dart';

class FotoIcerik extends StatefulWidget {
  String veri5, veri6, veri7, veri8, veri9;
  FotoIcerik({
    required this.veri5,
    required this.veri6,
    required this.veri7,
    required this.veri8,
    required this.veri9,
  });

  @override
  _FotoIcerikState createState() => _FotoIcerikState();
}

class _FotoIcerikState extends State<FotoIcerik> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    // return ThemeConsumer(
    //   child: Scaffold(
    //     appBar: AppBar(),
    //     body: Container(),
    //   ),
    // );
    // return ThemeConsumer(
    //   child: Scaffold(
    //     appBar: AppBar(),
    //     body: Container(
    //       child: ElevatedButton(
    //         onPressed: () {
    //           ImageViewer.showImageSlider(
    //             images: [
    //               'https://cdn.eso.org/images/thumb300y/eso1907a.jpg',
    //               'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg',
    //               'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    //             ],
    //             startingPosition: 1,
    //           );
    //         },
    //         child: Text('Show slider'),
    //       ),
    //     ),
    //   ),
    // );
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        // body: Container(
        //   child: widget.veri9 != null
        //       ? Container(
        //           width: screenwidth,
        //           height: 150,
        //           child: Flexible(
        //             child: Image.network(
        //               widget.veri9,
        //               fit: BoxFit.cover,
        //               filterQuality: FilterQuality.high,
        //             ),
        //             // child: ListView.separated(
        //             //   physics: BouncingScrollPhysics(),
        //             //   scrollDirection: Axis.horizontal,
        //             //   itemBuilder: (context, index) {
        //             //     // return Container(
        //             //     //   decoration: BoxDecoration(
        //             //     //     color: Colors.red,
        //             //     //     borderRadius: BorderRadius.circular(50),
        //             //     //   ),
        //             //     // );
        //             //     // return Text("data");
        //             //     return Image.network(
        //             //       widget.veri9,
        //             //       fit: BoxFit.cover,
        //             //       filterQuality: FilterQuality.high,
        //             //     );
        //             //   },
        //             //   separatorBuilder: (context, index) => SizedBox(width: 0),
        //             //   itemCount: gonderifotolar.length,
        //             // ),
        //           ),
        //         )
        //       : Center(
        //           child: CircularProgressIndicator(),
        //         ),
        // ),

        body: Dismissible(
          key: Key("item"),
          onDismissed: (_) {
            Navigator.pop(context);
          },
          direction: DismissDirection.vertical,
          child: widget.veri9 != null
              ? Container(
                  child: Center(
                    child: Column(
                      children: [
                        Spacer(),
                        Image.network(
                          widget.veri9,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                        Spacer(),
                        Container(
                          color: Colors.transparent,
                          width: screenwidth,
                          height: screenheight / 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.favorite_border,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 10),
                                      (widget.veri5 != "0")
                                          ? Text(
                                              widget.veri5,
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            )
                                          : Text(""),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.chat_bubble_outline,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      (widget.veri6 != "0")
                                          ? Text(
                                              widget.veri6,
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            )
                                          : Text(""),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.repeat,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      (widget.veri7 != "0")
                                          ? Text(
                                              widget.veri7,
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            )
                                          : Text(""),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Share.share(
                                    widget.veri9,
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.share_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
