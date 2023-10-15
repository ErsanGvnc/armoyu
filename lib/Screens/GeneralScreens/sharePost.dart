// ignore_for_file: must_be_immutable, file_names, avoid_print, use_build_context_synchronously

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:intl/intl.dart';

class SharePost extends StatefulWidget {
  String veri1;
  String veri2;

  SharePost({
    Key? key,
    required this.veri1,
    required this.veri2,
  }) : super(key: key);

  @override
  State<SharePost> createState() => _PostState();
}

class _PostState extends State<SharePost> {
  @override
  void initState() {
    super.initState();
    post.text = widget.veri1;
    if (widget.veri2 != "") {
      post.text = widget.veri2;
      isEditPost = true;
    } else {
      isEditPost = false;
    }
  }

  Future<MultipartFile> generateImageFile(XFile file) async {
    return await MultipartFile.fromFile(
      file.path,
      contentType: MediaType("image", "jpg"),
    );
  }

  Future<Response> postGonder(List<XFile> files) async {
    List<MultipartFile> photosCollection = [];
    for (var file in files) {
      photosCollection.add(await generateImageFile(file));
      print(file.path);
    }

    var formData = FormData.fromMap({
      "paylasimfoto[]": photosCollection,
      "sosyalicerik": post.text,
      "cihazicerik": "mobil",
    });

    print(photosCollection);
    print(photosCollection.runtimeType);

    var response = await Dio().post(
      "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/olustur/0/0/",
      data: formData,
    );

    print(response);

    return response;
  }

  _imgFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> image = await picker.pickMultiImage();
    if (mounted) {
      setState(() {
        images.addAll(image);
      });
    }
  }

  _imgFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo == null) return;
    if (mounted) {
      setState(() {
        images.add(photo);
      });
    }
  }

  _videoFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video == null) return;
    if (mounted) {
      setState(() {
        print(images);
        images.add(video);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          actions: [
            Visibility(
              visible: post.text.isNotEmpty || images.isNotEmpty ? true : false,
              child: IconButton(
                onPressed: () {
                  post.clear();
                  images.clear();
                  if (mounted) {
                    setState(() {
                      textLength = 0;
                    });
                  }
                },
                icon: const Icon(Icons.clear),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () async {
                  if (post.text.isNotEmpty) {
                    // isEditPost != true
                    //     ? print("Paylaşıldı !")
                    //     : print("Düzenlendi !");
                    if (mounted) {
                      setState(() {
                        isUpload = true;
                      });
                    }

                    isEditPost != true
                        ? await postGonder(images)
                        : postDuzenle(post.text);
                    if (mounted) {
                      setState(() {
                        isUpload = false;
                      });
                    }
                    post.clear();
                    images.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "  ${isEditPost != true ? sharePostNotice : editPostNotice} ${DateFormat('kk:mm , d MMM y').format(DateTime.now())}"),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: post.text.isNotEmpty ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Center(
                      child: Text(
                        isEditPost != true ? "Gönder" : "Yeniden Gönder",
                        style: const TextStyle(
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
                        girisdata["presimminnak"],
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
                      "  -  ${DateFormat('kk:mm , d MMM y').format(DateTime.now())}",
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
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  basicStyle: const TextStyle(
                    fontSize: 18,
                  ),
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
                    if (mounted) {
                      setState(() {
                        textLength = value.length;
                      });
                    }
                    // print(textLength.toDouble());
                  },
                ),
              ),
              Visibility(
                visible: images.isNotEmpty ? true : false,
                // visible: false,
                child: SizedBox(
                  width: screenWidth,
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              File(images[index].path),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: InkWell(
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    images.removeAt(index);
                                  });
                                }
                              },
                              child: const Icon(
                                Icons.clear,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: images.length,
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth,
                child: Column(
                  children: [
                    Visibility(
                      visible: post.text.isNotEmpty ? true : false,
                      child: Container(
                        color: textLength == 250 ? Colors.red : Colors.blue,
                        width: min(screenWidth, textLength.toDouble() * 1.65),
                        height: 1,
                      ),
                    ),
                    Visibility(
                      visible: post.text.isEmpty ? true : false,
                      child: Container(
                        color: Colors.grey,
                        width: screenWidth,
                        height: 0.5,
                      ),
                    ),
                    SafeArea(
                      child: SizedBox(
                        width: screenWidth,
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            IconButton(
                              onPressed: () async {
                                await _imgFromGallery();
                              },
                              icon: const Icon(
                                Icons.image_outlined,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await _imgFromCamera();
                              },
                              icon: const Icon(
                                Icons.photo_camera_outlined,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text("Yakında !"),
                                  ),
                                );

                                // await _videoFromGallery();
                              },
                              icon: const Icon(
                                Icons.video_camera_back_outlined,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
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
                              onPressed: () async {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text("Yakında !"),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.mic_outlined,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
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
                            const SizedBox(width: 25),
                            Visibility(
                              visible: isUpload,
                              child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Visibility(
                              visible: images.isNotEmpty ? true : false,
                              child: Row(
                                children: [
                                  Text(
                                    "${images.length} images",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      images.clear();
                                      if (mounted) {
                                        setState(() {});
                                      }
                                    },
                                    icon: const Icon(Icons.clear),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
