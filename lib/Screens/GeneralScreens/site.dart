// ignore_for_file: must_be_immutable, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:armoyu/Utilities/Import&Export/export.dart';

class Site extends StatefulWidget {
  String verilink, veribaslik;
  Site({
    Key? key,
    required this.verilink,
    required this.veribaslik,
  }) : super(key: key);
  @override
  _SiteState createState() => _SiteState();
}

class _SiteState extends State<Site> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: Text(widget.veribaslik),
          actions: [
            IconButton(
              onPressed: () {
                _controller.reload();
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: WebView(
          onWebViewCreated: (_controller) {
            this._controller = _controller;
          },
          javascriptMode: JavascriptMode.unrestricted,
          zoomEnabled: false,
          initialUrl: widget.verilink,
        ),
      ),
    );
  }
}
