// ignore_for_file: no_leading_underscores_for_local_identifiers

import '../../Utilities/Import&Export/export.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  NewsState createState() => NewsState();
}

class NewsState extends State<News> {
  @override
  void initState() {
    super.initState();
    habercek();
  }

  habercek() async {
    var gelen = await http.get(
      Uri.parse(haberurl),
    );
    datahaber = jsonDecode(gelen.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _refresh() {
      return habercek();
    }

    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          child: datahaber != null
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: newsScrollController,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail(
                              veri1: datahaber[index]["haberbaslik"],
                              veri3: datahaber[index]["resimminnak"],
                              veri5: datahaber[index]["resim"],
                              veri6: datahaber[index]["gecenzaman"],
                              veri7: datahaber[index]["yazar"],
                              veri8: datahaber[index]["ozet"],
                              veri9: datahaber[index]["link"],
                              veri10: datahaber[index]["kategori"],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: screenWidth / 3,
                              height: screenHeight / 6,
                              child: datahaber[index]["resimminnak"] != null
                                  ? CachedNetworkImage(
                                      imageUrl: datahaber[index]["resim"],
                                    )
                                  : null,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: screenHeight / 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: screenHeight / 100),
                                    Text(
                                      datahaber[index]["yazar"] ?? "",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: screenWidth / 25,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      datahaber[index]["haberbaslik"],
                                      maxLines: 2,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          datahaber[index]["kategori"],
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: screenWidth / 30,
                                          ),
                                        ),
                                        SizedBox(width: screenWidth / 75),
                                        const CircleAvatar(
                                          radius: 3,
                                          backgroundColor: Colors.grey,
                                        ),
                                        SizedBox(width: screenWidth / 75),
                                        Text(
                                          "",
                                          // datahaber[index]["gecenzaman"],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: screenWidth / 30,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          datahaber[index]["goruntulen"],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: screenWidth / 30,
                                          ),
                                        ),
                                        SizedBox(width: screenWidth / 150),
                                        const Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.grey,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: screenHeight / 100),
                  itemCount: 15,
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
