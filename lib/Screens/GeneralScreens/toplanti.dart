// ignore_for_file: avoid_print

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:intl/intl.dart';

class Toplanti extends StatefulWidget {
  const Toplanti({Key? key}) : super(key: key);

  @override
  State<Toplanti> createState() => _ToplantiState();
}

class _ToplantiState extends State<Toplanti> {
  @override
  void initState() {
    super.initState();
    toplanticek();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return ThemeConsumer(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(toplantiadi.toString()),
              const SizedBox(width: 15),
              Text(
                toplantitarih.toString(),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                print(toplantiid);
                print(toplantitarih);
                print(toplantiadi);

                toplantiid = "";
                toplantitarih = "";
                toplantiadi = "";

                print("temizlendi");

                setState(() {});

                print(toplantiid);
                print(toplantitarih);
                print(toplantiadi);
              },
              icon: const Icon(Icons.close),
            ),
            IconButton(
              onPressed: () {
                toplanticek();
                print("yenilendi");
                setState(() {});
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: screenWidth / 12,
                      backgroundImage: CachedNetworkImageProvider(
                        girisdata["presimufak"],
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      girisdata["adim"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "  -  ${DateFormat('kk:mm , d MMM y').format(DateTime.now())}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Flexible(
                  child: TextField(
                    controller: toplanti,
                    maxLines: 10,
                    maxLength: maxLength,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                          r"[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQXZÇŞĞÜÖİçşğüöı0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)* ]",
                          caseSensitive: true,
                          unicode: true,
                          dotAll: true,
                        ),
                      ),
                    ],
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      counterText: "",
                      suffixText:
                          "${textLength.toString()}/${maxLength.toString()}",
                      suffixIcon: IconButton(
                        onPressed: toplanti.clear,
                        icon: const Icon(Icons.clear),
                      ),
                      border: const OutlineInputBorder(),
                      hintText: 'Mazeretini bildir !',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: InkWell(
                      onTap: () {
                        if (toplanti.text.isNotEmpty &&
                            toplantiid.toString().isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Gönderildi ! ${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
                              shape: const StadiumBorder(),
                            ),
                          );
                          toplantigonder();
                          toplanti.clear();
                          toplantiid = "";
                          toplantitarih = "";
                          toplantiadi = "";

                          print("Gönderildi !");
                        } else if (toplanti.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "İçerik boş olamaz ! ${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
                              shape: const StadiumBorder(),
                            ),
                          );
                          print("İçerik boş olamaz !");
                        } else if (toplantiid.toString().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Lütfen toplantı seçin ! ${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
                              shape: const StadiumBorder(),
                            ),
                          );
                          print("Lütfen toplantı seçin !");
                        }
                      },
                      child: Container(
                        width: screenWidth,
                        height: screenHeight / 12,
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            "Gönder",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: toplantilar.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            horizontalTitleGap: 5,
                            contentPadding: const EdgeInsets.only(left: 5),
                            leading: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                "assets/images/yenilogo.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                            title: Text(toplantilar[index]["toplantiadi"]),
                            subtitle: Text(toplantilar[index]["toplantizaman"]),
                            onTap: () {
                              toplantiid = toplantilar[index]["toplantiID"];
                              toplantitarih =
                                  toplantilar[index]["toplantizaman"];
                              toplantiadi = toplantilar[index]["toplantiadi"];
                              print(toplantiid);
                              setState(() {});
                            },
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
