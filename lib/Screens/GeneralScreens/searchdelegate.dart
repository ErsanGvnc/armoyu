// ignore_for_file: avoid_print

import 'package:armoyu/Utilities/Import&Export/export.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),

      // Expanded(
      //   child: TextFormField(
      //     onTap: () async {
      //       // await showSearch(
      //       //   // query: "app",
      //       //   context: context,
      //       //   delegate: CustomSearchDelegate(),
      //       // );
      //     },
      //     // readOnly: true,
      //     autofocus: true,
      //     decoration: InputDecoration(
      //       contentPadding: const EdgeInsets.all(10),
      //       border: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(30),
      //       ),
      //       enabledBorder: OutlineInputBorder(
      //         borderSide: BorderSide.none,
      //         borderRadius: BorderRadius.circular(30),
      //       ),
      //       disabledBorder: OutlineInputBorder(
      //         borderSide: BorderSide.none,
      //         borderRadius: BorderRadius.circular(30),
      //       ),
      //       focusedBorder: const OutlineInputBorder(
      //         borderRadius: BorderRadius.all(
      //           Radius.circular(30),
      //         ),
      //         borderSide: BorderSide.none,
      //       ),
      //       fillColor:
      //           ThemeProvider.controllerOf(context).currentThemeId.toString() !=
      //                   "default_dark_theme"
      //               ? Colors.white
      //               : Colors.grey[850],
      //       filled: true,
      //       counterText: "",
      //       hintText: "Ara...",
      //     ),
      //   ),
      // ),
      // IconButton(
      //   onPressed: () {
      //     query = '';
      //   },
      //   icon: const Icon(Icons.clear),
      // ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
    // return Container(
    //   height: 0,
    // );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];

    for (var fruit in userSearchTerms) {
      if (fruit[0].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit.toString());
      }
    }

    return matchQuery.isNotEmpty
        ? ListView.builder(
            itemCount: matchQuery.length,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (context, index) {
              var resultName = matchQuery[index];
              var user = (resultName.split(','));

              return ListTile(
                onTap: () async {
                  id = user[1]
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .replaceAll("", "")
                      .substring(1);

                  print(user[0]
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .replaceAll("", ""));
                  print(user[1]
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .replaceAll("", "")
                      .substring(1));
                  print(user[2]
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .replaceAll("", "")
                      .substring(1));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThemeConsumer(
                        child: Profile(
                          veri1: id,
                        ),
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    user[2]
                        .replaceAll("[", "")
                        .replaceAll("]", "")
                        .replaceAll("", "")
                        .substring(1),
                  ),
                ),
                title: Text(user[0]
                    .replaceAll("[", "")
                    .replaceAll("]", "")
                    .replaceAll("", "")),
              );
            },
          )
        : InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animations/notFound.json",
                  animate: true,
                  repeat: true,
                  reverse: true,
                  fit: BoxFit.cover,
                  width: screenWidth / 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: query,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const TextSpan(
                            text: " için sonuç bulunamadı",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Başka bir şey aramayı dene.",
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight / 10),
              ],
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];

    for (var fruit in userSearchTerms) {
      if (fruit[0].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit.toString());
      }
    }

    return matchQuery.isNotEmpty
        ? ListView.builder(
            itemCount: matchQuery.length,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (context, index) {
              var resultName = matchQuery[index];
              var user = (resultName.split(','));

              return ListTile(
                onTap: () async {
                  id = user[1]
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .replaceAll("", "")
                      .substring(1);

                  print(user[0]
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .replaceAll("", ""));
                  print(user[1]
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .replaceAll("", "")
                      .substring(1));
                  print(user[2]
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .replaceAll("", "")
                      .substring(1));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThemeConsumer(
                        child: Profile(
                          veri1: id,
                        ),
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    user[2]
                        .replaceAll("[", "")
                        .replaceAll("]", "")
                        .replaceAll("", "")
                        .substring(1),
                  ),
                ),
                title: Text(user[0]
                    .replaceAll("[", "")
                    .replaceAll("]", "")
                    .replaceAll("", "")),
              );
            },
          )
        : InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animations/notFound.json",
                  animate: true,
                  repeat: true,
                  reverse: true,
                  fit: BoxFit.cover,
                  width: screenWidth / 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: query,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const TextSpan(
                            text: " için sonuç bulunamadı",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Başka bir şey aramayı dene.",
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight / 10),
              ],
            ),
          );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      colorScheme:
          ThemeProvider.controllerOf(context).currentThemeId.toString() !=
                  "default_dark_theme"
              ? const ColorScheme.light()
              : const ColorScheme.dark(),
      appBarTheme: AppBarTheme(
        backgroundColor:
            ThemeProvider.controllerOf(context).currentThemeId.toString() !=
                    "default_dark_theme"
                ? Colors.blue
                : Colors.grey[800],
      ),
    );
  }
}
