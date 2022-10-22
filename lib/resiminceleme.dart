// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, must_be_immutable, unused_import

import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:theme_provider/theme_provider.dart';

class Resiminceleme extends StatefulWidget {
  List veri1;

  Resiminceleme({
    required this.veri1,
  });
  @override
  State<Resiminceleme> createState() => _ResimincelemeState();
}

class _ResimincelemeState extends State<Resiminceleme> {
  // @override
  // void dispose() {
  //   SystemChrome.setEnabledSystemUIMode(
  //     SystemUiMode.manual,
  //     overlays: SystemUiOverlay.values,
  //   );
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: InkWell(
          // highlightColor: Colors.transparent,
          // splashColor: Colors.transparent,
          // onTap: () {
          //   SystemChrome.setEnabledSystemUIMode(
          //     SystemUiMode.leanBack,
          //     overlays: [],
          //   );
          // },
          child: DismissiblePage(
            backgroundColor: Colors.transparent,
            direction: DismissiblePageDismissDirection.vertical,
            onDismissed: () {
              Navigator.of(context).pop();
            },
            child: PhotoViewGallery.builder(
              backgroundDecoration: BoxDecoration(color: Colors.transparent),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(
                    widget.veri1[index],
                  ),
                );
              },
              itemCount: widget.veri1.length,
              loadingBuilder: (context, progress) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
