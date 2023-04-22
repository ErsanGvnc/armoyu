// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:armoyu/Utilities/Import&Export/export.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        title: Text(
          girisdata["eposta"],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          exitApp,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          InkWell(
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ),
              );
              var sharedPreferences = await SharedPreferences.getInstance();
              setState(() {
                sharedPreferences.setString("ad", "");
                sharedPreferences.setString("sifre", "");
                gruplarim.clear();
                gkontrolAd = "";
                gkontrolSifre = "";
              });
              timer!.cancel();
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: const Padding(
                padding: EdgeInsets.all(13),
                child: Text(
                  "Çıkış yap",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: const Padding(
                padding: EdgeInsets.all(13),
                child: Text(
                  "İptal et",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        controller: settingsScrollController,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10),
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Hesaplar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    "Beta",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Fluttertoast.showToast(
                        msg: comingSoon,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            girisdata["presimminnak"],
                          ),
                          radius: 40,
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          girisdata["adim"],
                          style: const TextStyle(
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "@" + girisdata["kullaniciadi"],
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Fluttertoast.showToast(
                        msg: comingSoon,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[900],
                          child: const Icon(Icons.add),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          ".....",
                          style: TextStyle(
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Text(
                          "@.....",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 2),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "Tema",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        ThemeProvider.controllerOf(context)
                                    .currentThemeId
                                    .toString() !=
                                "default_dark_theme"
                            ? ThemeProvider.controllerOf(context).nextTheme()
                            : null;
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ThemeProvider.controllerOf(context)
                                          .currentThemeId
                                          .toString() ==
                                      "default_light_theme"
                                  ? Colors.grey[900]
                                  : Colors.black38,
                              borderRadius: BorderRadius.circular(10),
                              border: ThemeProvider.controllerOf(context)
                                          .currentThemeId
                                          .toString() ==
                                      "default_dark_theme"
                                  ? Border.all(
                                      color: Colors.blue,
                                      width: 2,
                                    )
                                  : const Border(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    radius: 15,
                                    backgroundImage: AssetImage(
                                      "assets/images/yenilogo.png",
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Koyu Tema",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Text(
                                          "Koyu temanın\nhavası🔥",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white10,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Image.asset(
                                              "assets/images/yenilogo.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: ThemeProvider.controllerOf(context)
                                        .currentThemeId
                                        .toString() ==
                                    "default_dark_theme"
                                ? true
                                : false,
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        ThemeProvider.controllerOf(context)
                                    .currentThemeId
                                    .toString() !=
                                "default_light_theme"
                            ? ThemeProvider.controllerOf(context).nextTheme()
                            : null;
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: ThemeProvider.controllerOf(context)
                                          .currentThemeId
                                          .toString() ==
                                      "default_light_theme"
                                  ? Border.all(
                                      color: Colors.blue,
                                      width: 2,
                                    )
                                  : const Border(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    radius: 15,
                                    backgroundImage: AssetImage(
                                      "assets/images/yenilogo.png",
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Açık Tema",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const Text(
                                          "Açık temanın\nberraklığı ❤️",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Image.asset(
                                              "assets/images/yenilogo.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: ThemeProvider.controllerOf(context)
                                        .currentThemeId
                                        .toString() ==
                                    "default_light_theme"
                                ? true
                                : false,
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Uygulama Simgesi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    "Beta",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        // setState(() {
                        //   appIcon = 0;
                        // });
                        Fluttertoast.showToast(
                          msg: comingSoon,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                              border: appIcon == 0
                                  ? Border.all(
                                      color: Colors.blue,
                                      width: 2,
                                    )
                                  : const Border(),
                            ),
                            child: Image.asset("assets/images/yenilogo.png"),
                          ),
                          Visibility(
                            visible: appIcon == 0 ? true : false,
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        // setState(() {
                        //   appIcon = 1;
                        // });
                        Fluttertoast.showToast(
                          msg: comingSoon,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: appIcon == 1
                                  ? Border.all(
                                      color: Colors.blue,
                                      width: 2,
                                    )
                                  : const Border(),
                            ),
                            child: Image.asset("assets/images/yenilogo.png"),
                          ),
                          Visibility(
                            visible: appIcon == 1 ? true : false,
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        // setState(() {
                        //   appIcon = 2;
                        // });
                        Fluttertoast.showToast(
                          msg: comingSoon,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: appIcon == 2
                                  ? Border.all(
                                      color: Colors.blue,
                                      width: 2,
                                    )
                                  : const Border(),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.blue,
                                  Colors.red,
                                ],
                                stops: [0.0, 1],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Image.asset("assets/images/yenilogo.png"),
                          ),
                          Visibility(
                            visible: appIcon == 2 ? true : false,
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text("Bildirim"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemeConsumer(
                    child: NotificationInSettings(),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_settings),
            title: const Text("Video Ayarları"),
            onTap: () async {
              Fluttertoast.showToast(
                msg: comingSoon,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.star_border_outlined),
            title: const Text("Değerlendir"),
            onTap: () async {
              if (await InAppReview.instance.isAvailable()) {
                InAppReview.instance.requestReview();
                InAppReview.instance.openStoreListing();
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text("Hata Bildir"),
            onTap: () {
              Fluttertoast.showToast(
                msg: comingSoon,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ThemeConsumer(
              //       child: Site(
              //         verilink: gizliliklink,
              //         veribaslik: privacyPolicy,
              //       ),
              //     ),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("Bilgi"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThemeConsumer(
                    child: Site(
                      verilink: gizliliklink,
                      veribaslik: privacyPolicy,
                    ),
                  ),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              "Çıkış Yap",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              showAlertDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
