// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:theme_provider/theme_provider.dart';

class Resiminceleme extends StatefulWidget {
  String veri1;

  Resiminceleme({
    required this.veri1,
  });
  @override
  State<Resiminceleme> createState() => _ResimincelemeState();
}

class _ResimincelemeState extends State<Resiminceleme> {
  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: PhotoViewGallery.builder(
            backgroundDecoration: BoxDecoration(color: Colors.transparent),
            // scrollPhysics: BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(
                  widget.veri1,
                ),
                // heroAttributes: HeroAttributes(tag: galleryItems[index].id),
              );
            },
            // itemCount: widget.veri1.length,
            itemCount: 1,
            loadingBuilder: (context, progress) => CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
