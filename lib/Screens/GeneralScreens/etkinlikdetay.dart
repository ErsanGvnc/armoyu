// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:armoyu/Utilities/Import&Export/export.dart';

class EtkinlikDetay extends StatefulWidget {
  String veri;

  EtkinlikDetay({
    Key? key,
    required this.veri,
  }) : super(key: key);
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
                  physics: const BouncingScrollPhysics(),
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
                      child: const Text("data"),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: dataanasayfa.length,
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                )
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => const NewsCardSkelton(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                  itemCount: 10,
                ),
        ),
      ),
    );
  }
}
