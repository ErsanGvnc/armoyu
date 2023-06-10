// ignore_for_file: must_be_immutable, avoid_print, no_leading_underscores_for_local_identifiers

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
  @override
  void initState() {
    postlcr.clear();
    getPostLCR(widget.veri1);
    if (mounted) {
      setState(() {});
    }
    super.initState();
  }

  Future getPostLCR(content) async {
    await http.post(
      Uri.parse(widget.veri3),
      body: {
        "postID": content,
      },
    ).then((cevap) {
      if (mounted) {
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
      }
    });
  }

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    String _title = "";

    if (widget.veri2 == 0) {
      if (mounted) {
        setState(() {
          _title = "Beğeniler";
        });
      }
    } else if (widget.veri2 == 1) {
      if (mounted) {
        setState(() {
          _title = "Yorumlar";
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _title = "Repostlar";
        });
      }
    }

    // Future<void> _refresh() {
    //   setState(() {
    //     postlcr.clear();
    //   });
    //   return getPostLCR(widget.veri1);
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),

      body: FutureBuilder(
        future: _calculation,
        initialData: getPostLCR(widget.veri1),
        builder: (context, snapshot) {
          List<Widget> children;
          if (snapshot.hasData && postlcr.isNotEmpty) {
            children = <Widget>[
              ListView.separated(
                controller: byrScrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: postlcr.length,
                shrinkWrap: true,
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
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              SizedBox(height: screenHeight / 3),
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 72,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    unexpectedError,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ];
          } else {
            children = <Widget>[
              SizedBox(height: screenHeight / 3),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ];
          }

          return ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: children,
              ),
            ],
          );
        },
      ),

      // body: RefreshIndicator(
      //   onRefresh: _refresh,
      //   child: ListView.separated(
      //     controller: byrScrollController,
      //     physics: const BouncingScrollPhysics(),
      //     scrollDirection: Axis.vertical,
      //     itemCount: postlcr.length,
      //     shrinkWrap: true,
      //     itemBuilder: (context, index) {
      //       return InkWell(
      //         onTap: () async {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => ThemeConsumer(
      //                 child: Profile(
      //                   veri1: postlcr[index]["begenenID"].toString(),
      //                 ),
      //               ),
      //             ),
      //           );
      //         },
      //         child: ListTile(
      //           contentPadding: EdgeInsets.zero,
      //           leading: CircleAvatar(
      //             radius: screenWidth / 20,
      //             backgroundImage: NetworkImage(
      //               postlcr[index]["begenenavatar"],
      //             ),
      //           ),
      //           title: Text(
      //             postlcr[index]["begenenadi"],
      //           ),
      //           // trailing: const Text(
      //           //   "20 dakika önce",
      //           //   style: TextStyle(
      //           //     fontSize: 12,
      //           //   ),
      //           // ),
      //         ),
      //       );
      //     },
      //     padding: const EdgeInsets.only(
      //       top: 10,
      //       left: 15,
      //       right: 10,
      //       bottom: 10,
      //     ),
      //     separatorBuilder: (context, index) => const Divider(),
      //   ),
      // ),
    );
  }
}
