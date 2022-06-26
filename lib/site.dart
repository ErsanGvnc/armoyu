// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Site extends StatefulWidget {
  String verilink;
  Site({
    required this.verilink,
  });
  @override
  _SiteState createState() => _SiteState();
}

class _SiteState extends State<Site> {
  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          title: Text("aramizdakioyuncu.com"),
        ),
        body: WebView(
          // initialUrl: "https://aramizdakioyuncu.com/",
          javascriptMode: JavascriptMode.unrestricted,
          zoomEnabled: false,
          initialUrl: widget.verilink,
        ),
      ),
    );
  }
}
