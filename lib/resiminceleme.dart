// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    // print(widget.veri1);
    // print(widget.veri1.runtimeType);

    return ThemeConsumer(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: PhotoViewGallery.builder(
            backgroundDecoration: BoxDecoration(color: Colors.transparent),
            // scrollPhysics: BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(
                  widget.veri1[index],
                ),
                // heroAttributes: PhotoViewHeroAttributes(tag: "tag"),
              );
            },
            itemCount: widget.veri1.length,
            loadingBuilder: (context, progress) => CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
