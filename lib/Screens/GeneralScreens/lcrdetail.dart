// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers, avoid_print, unnecessary_statements

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:http/http.dart' as http;

class PostLCRScreen extends StatefulWidget {
  String veri1, veri3;
  int veri2;

  PostLCRScreen({
    Key? key,
    required this.veri1,
    required this.veri2,
    required this.veri3,
  }) : super(key: key);

  @override
  State<PostLCRScreen> createState() => _ByrDetailState();
}

class _ByrDetailState extends State<PostLCRScreen> {
  getPostLCR(content) async {
    await http.post(
      Uri.parse(widget.veri3),
      body: {
        "postID": content,
      },
    ).then((cevap) {
      setState(() {
        try {
          postlcrMap = jsonDecode(cevap.body);
          postlcrMap["durum"] == 1 ? postlcr = postlcrMap["icerik"] : null;
          // print(postlcrMap["durum"]);
          // print(postlcr);
        } catch (e) {
          print('Unknown exception: $e');
        }
      });
    });
  }

  @override
  void initState() {
    postlcr.clear();
    getPostLCR(widget.veri1);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _title = "";

    if (widget.veri2 == 0) {
      setState(() {
        _title = "Beğeniler";
      });
    } else if (widget.veri2 == 1) {
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
        postlcr.clear();
      });
      return getPostLCR(widget.veri1);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          child: postlcr.isNotEmpty
              ? ListView.separated(
                  controller: byrScrollController,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: postlcr.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThemeConsumer(
                              child: Profile(
                                veri1: postlcr[index]["begenenID"].toString(),
                              ),
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: screenWidth / 20,
                          backgroundImage: NetworkImage(
                            postlcr[index]["begenenavatar"],
                          ),
                        ),
                        title: Text(
                          postlcr[index]["begenenadi"],
                        ),
                        // trailing: const Text(
                        //   "20 dakika önce",
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //   ),
                        // ),
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
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
