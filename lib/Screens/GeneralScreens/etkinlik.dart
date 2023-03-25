import 'package:armoyu/Utilities/Import&Export/export.dart';

class Etkinlik extends StatefulWidget {
  const Etkinlik({Key? key}) : super(key: key);

  @override
  State<Etkinlik> createState() => _EtkinlikState();
}

class _EtkinlikState extends State<Etkinlik> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EtkinlikDetay(
                  veri: csgo,
                ),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/csgo.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                csgo,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EtkinlikDetay(
                  veri: ets,
                ),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ets.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                ets,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EtkinlikDetay(
                  veri: mc,
                ),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/mc.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                mc,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EtkinlikDetay(
                  veri: gta,
                ),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/gta.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                gta,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EtkinlikDetay(
                  veri: lol,
                ),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/lol.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                lol,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EtkinlikDetay(
                  veri: theforest,
                ),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/the_forest.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                theforest,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
