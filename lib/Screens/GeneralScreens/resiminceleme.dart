// ignore_for_file: must_be_immutable

import 'package:armoyu/Utilities/Import&Export/export.dart';

class Resiminceleme extends StatefulWidget {
  List veri1;

  Resiminceleme({
    Key? key,
    required this.veri1,
  }) : super(key: key);
  @override
  State<Resiminceleme> createState() => _ResimincelemeState();
}

class _ResimincelemeState extends State<Resiminceleme> {
  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color:
                ThemeProvider.controllerOf(context).currentThemeId.toString() !=
                        "default_dark_theme"
                    ? Colors.black
                    : Colors.white,
          ),
        ),
        body: InkWell(
          child: DismissiblePage(
            backgroundColor: Colors.transparent,
            direction: DismissiblePageDismissDirection.vertical,
            onDismissed: () {
              Navigator.of(context).pop();
            },
            child: PhotoViewGallery.builder(
              backgroundDecoration:
                  const BoxDecoration(color: Colors.transparent),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(
                    widget.veri1[index],
                  ),
                );
              },
              itemCount: widget.veri1.length,
              loadingBuilder: (context, progress) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
