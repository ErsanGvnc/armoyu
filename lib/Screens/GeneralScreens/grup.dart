// ignore_for_file: must_be_immutable, avoid_print, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:http/http.dart' as http;

class Grup extends StatefulWidget {
  String veri1, veri2;
  Grup({
    Key? key,
    required this.veri1,
    required this.veri2,
  }) : super(key: key);

  @override
  State<Grup> createState() => _GrupState();
}

class _GrupState extends State<Grup> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var gelen = await http.get(
      Uri.parse(grupdetail),
    );
    datagrup = jsonDecode(gelen.body);
    setState(() {
      print(grupdetail);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    Future<void> _refresh() {
      return fetchData();
    }

    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.veri1),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Container(
            child: datagrup != null
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (dataanasayfa[index]["paylasimfoto"] != null) {
                        gonderifotolar = dataanasayfa[index]["paylasimfoto"];
                        print(datagrup[index]["benbegendim"]);
                        visible = true;
                      } else {
                        visible = false;
                      }
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnaDetail(
                                veri1: datagrup[index]["sahipavatarminnak"],
                                veri2: datagrup[index]["sahipad"],
                                veri3: datagrup[index]["sosyalicerik"],
                                veri4: datagrup[index]["paylasimzaman"],
                                veri5: datagrup[index]["begenisay"],
                                veri6: datagrup[index]["yorumsay"],
                                veri7: datagrup[index]["repostsay"],
                                veri8: datagrup[index]["sikayetsay"],
                                veri9: datagrup[index]["benbegendim"],
                                veri10: dataanasayfa[index]["postID"],
                                veri11: dataanasayfa[index]["sahipID"],
                                veri12: dataanasayfa[index]["paylasimnereden"],
                                veri13: dataanasayfa[index]["benyorumladim"],
                                veri14: dataanasayfa[index]["oyunculink"],
                              ),
                            ),
                          );
                          print(datagrup[index]["benbegendim"]);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: screenWidth / 12,
                              backgroundImage: NetworkImage(
                                datagrup[index]["sahipavatarminnak"],
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(width: screenWidth / 35),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        datagrup[index]["sahipad"],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "  -  " +
                                            datagrup[index]
                                                ["paylasimzamangecen"],
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.more_vert,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight / 90),
                                  Text(
                                    datagrup[index]["sosyalicerik"],
                                  ),
                                  SizedBox(height: screenHeight / 50),
                                  SizedBox(height: screenHeight / 65),
                                  Container(
                                    color: Colors.transparent,
                                    width: screenWidth,
                                    height: screenHeight / 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                (datagrup[index]
                                                            ["benbegendim"] !=
                                                        0)
                                                    ? const Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )
                                                    : const Icon(
                                                        Icons.favorite_border,
                                                        color: Colors.grey,
                                                      ),
                                                const SizedBox(width: 10),
                                                (datagrup[index]["begenisay"] !=
                                                        "0")
                                                    ? Text(
                                                        datagrup[index]
                                                            ["begenisay"],
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                    : const Text(""),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.chat_bubble_outline,
                                                  color: Colors.grey,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                (datagrup[index]["yorumsay"] !=
                                                        "0")
                                                    ? Text(
                                                        datagrup[index]
                                                            ["yorumsay"],
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                    : const Text(""),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.repeat,
                                                  color: Colors.grey,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                (datagrup[index]["repostsay"] !=
                                                        "0")
                                                    ? Text(
                                                        dataanasayfa[index]
                                                            ["repostsay"],
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                    : const Text(""),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Share.share(
                                              datagrup[index]["sosyalicerik"],
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.share_outlined,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth / 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: datagrup.length,
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
                    itemBuilder: (context, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(height: 150),
                        Text(
                          "Henüz grubunuzda hiç\npaylaşım yapılmamış...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5),
                    itemCount: 1,
                  ),
          ),
        ),
      ),
    );
  }
}
