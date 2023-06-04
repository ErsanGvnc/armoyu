// ignore_for_file: avoid_print

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:intl/intl.dart';

class Cekilis extends StatefulWidget {
  const Cekilis({Key? key}) : super(key: key);

  @override
  State<Cekilis> createState() => _CekilisState();
}

class _CekilisState extends State<Cekilis> {
  @override
  void initState() {
    super.initState();
    cekiliscek();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Çekilişler"),
          actions: [
            IconButton(
              onPressed: () {
                cekiliscek();
                print("yenilendi");
                if (mounted) {
                  setState(() {});
                }
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: screenWidth / 12,
                    backgroundImage: NetworkImage(
                      girisdata["presimminnak"],
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
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
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
                          title: const Text(""),
                          subtitle: const Text(""),
                          // burada çekilişin devam edip etmedigini kontrol et
                          // ediyorsa "+" etmiyorsa "x" döndür.
                          trailing: IconButton(
                            onPressed: () {
                              print("Çekilişe Katıldın !");
                            },
                            icon: const Icon(Icons.add),
                          ),
                          onTap: () {},
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
    );
  }
}
