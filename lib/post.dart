// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, unused_local_variable, avoid_print, unnecessary_string_interpolations, prefer_adjacent_string_concatenation

import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:theme_provider/theme_provider.dart';
import 'Controllers/controllers.dart';
import 'Variables/variables.dart';
import 'utilities/utilities.dart';

class Post extends StatefulWidget {
  String veri1;

  Post({
    required this.veri1,
  });

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  void initState() {
    super.initState();
    // _initSpeech();
    post.text = widget.veri1;
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    return ThemeConsumer(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          actions: [
            Visibility(
              visible: post.text.isNotEmpty ? true : false,
              child: IconButton(
                onPressed: () {
                  post.clear();
                  setState(() {
                    textLength = 0;
                  });
                },
                icon: const Icon(Icons.clear),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  if (post.text.isNotEmpty) {
                    print("Paylaşıldı !");
                    postgonder();
                    post.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Paylaşıldı ! " +
                            "${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
                      ),
                    );
                    Navigator.pop(context);
                  }
                  //  else {
                  //   // print("Paylaşım boş olamaz !");
                  //   // ScaffoldMessenger.of(context).showSnackBar(
                  //   //   const SnackBar(
                  //   //     content: Text("Paylaşım boş olamaz !"),
                  //   //   ),
                  //   // );
                  //   null;
                  // }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: post.text.isNotEmpty ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Center(
                      child: Text(
                        "Gönder",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
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
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "  -  " +
                          "${DateFormat('kk:mm , d MMM y').format(DateTime.now())}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: DetectableTextField(
                  detectionRegExp: RegExp(
                    "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                    multiLine: true,
                  ),
                  controller: post,
                  expands: true,
                  autofocus: true,
                  minLines: null,
                  maxLines: null,
                  maxLength: maxLength,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  basicStyle: const TextStyle(
                    fontSize: 18,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r"[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQXZÇŞĞÜÖİçşğüöı0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*# ]",
                        caseSensitive: true,
                        unicode: true,
                        dotAll: true,
                      ),
                    ),
                  ],
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                    hintText: 'Neler söylemek istersin ?',
                    hintStyle: TextStyle(
                      fontSize: 18,
                    ),
                    counterText: "",
                  ),
                  onChanged: (value) {
                    setState(() {
                      textLength = value.length;
                    });
                    print(textLength.toDouble());
                  },
                ),
              ),
              SizedBox(
                width: screenwidth,
                child: Column(
                  children: [
                    Visibility(
                      visible: post.text.isNotEmpty ? true : false,
                      child: Container(
                        color: textLength == 250 ? Colors.red : Colors.blue,
                        width: min(screenwidth, textLength.toDouble() * 1.65),
                        height: 1,
                      ),
                    ),
                    Visibility(
                      visible: post.text.isEmpty ? true : false,
                      child: Container(
                        color: Colors.grey,
                        width: screenwidth,
                        height: 0.5,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text("Yakında !"),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.image_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text("Yakında !"),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.video_camera_back_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text("Yakında !"),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.gif_box_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text("Yakında !"),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.red,
        //   child: Icon(
        //     speechToText.isNotListening ? Icons.mic_off : Icons.mic,
        //     color: Colors.black,
        //     size: 35,
        //   ),
        //   onPressed:
        //       speechToText.isNotListening ? _startListening : _stopListening,
        // ),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.miniCenterFloat,
      ),
    );
  }

  // // void _initSpeech() async {
  // //   speechEnabled = await speechToText.initialize();
  // //   setState(() {});
  // // }

  // void _startListening() async {
  //   print("_startListening");
  //   await speechToText.listen(
  //     onResult: _onSpeechResult,
  //     localeId: "TR",
  //   );
  //   setState(() {});
  // }

  // void _stopListening() async {
  //   print("_stopListening");
  //   await speechToText.stop();
  //   setState(() {});
  // }

  // void _onSpeechResult(SpeechRecognitionResult result) {
  //   setState(() {
  //     lastWords = result.recognizedWords;
  //     post.text = lastWords;
  //   });
  // }

  // void _listen() async {
  //   if (!_isListening) {
  //     print("dinliyo");
  //     bool available = await _speech.initialize(
  //       onStatus: (val) => print("status: $val"),
  //       onError: (val) => print("error: $val"),
  //     );
  //     if (available) {
  //       print(available);
  //       setState(() => _isListening = true);
  //       _speech.listen(
  //         onResult: (val) => setState(() {
  //           _text = val.recognizedWords;
  //         }),
  //         localeId: "TR",
  //       );
  //     }
  //   } else {
  //     print("durdu");
  //     setState(() => _isListening = false);
  //     _speech.stop();
  //   }
  // }
}
