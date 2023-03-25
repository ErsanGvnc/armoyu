// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:skeletons/skeletons.dart';

class ByrDetail extends StatefulWidget {
  int veri1;
  String veri2;

  ByrDetail({
    Key? key,
    required this.veri1,
    required this.veri2,
  }) : super(key: key);

  @override
  State<ByrDetail> createState() => _ByrDetailState();
}

class _ByrDetailState extends State<ByrDetail> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

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
                          backgroundImage: const NetworkImage(
                              "https://aramizdakioyuncu.com/galeri/profilresimleri/11profilresimminnak1655290338.jpg"),
                          backgroundColor: Colors.red,
                        ),
                        title: const Text("Ersan Güvenç"),
                        trailing: const Text(
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
