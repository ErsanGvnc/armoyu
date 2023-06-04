// ignore_for_file: must_be_immutable, library_private_types_in_public_api, file_names, avoid_print

import 'package:armoyu/Utilities/Import&Export/export.dart';

class NewsDetail extends StatefulWidget {
  String veri1, veri2, veri3, veri5, veri6, veri7, veri8, veri9, veri10;
  NewsDetail({
    Key? key,
    required this.veri1,
    required this.veri2,
    required this.veri3,
    required this.veri5,
    required this.veri6,
    required this.veri7,
    required this.veri8,
    required this.veri9,
    required this.veri10,
  }) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.veri1),
          actions: [
            IconButton(
              onPressed: () async {
                await Share.share(widget.veri9);
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 250,
                width: screenWidth,
                child: CachedNetworkImage(
                  imageUrl: widget.veri5,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          widget.veri7,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: screenWidth / 75),
                        const CircleAvatar(
                          radius: 3,
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(width: screenWidth / 75),
                        Text(
                          widget.veri10,
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.veri2,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: screenWidth / 75),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text(widget.veri8),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            print(widget.veri9);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Site(
                                  verilink: widget.veri9,
                                  veribaslik: widget.veri1,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Haberin devamı",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
