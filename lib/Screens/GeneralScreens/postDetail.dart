// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, curly_braces_in_flow_control_structures, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, avoid_unnecessary_containers, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, use_build_context_synchronously, file_names

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:http/http.dart' as http;

class PostDetail extends StatefulWidget {
  String veri1,
      veri2,
      veri3,
      veri4,
      veri5,
      veri6,
      veri7,
      veri8,
      veri10,
      veri11,
      veri12,
      veri14;

  int veri9, veri13;

  PostDetail({
    required this.veri1,
    required this.veri2,
    required this.veri3,
    required this.veri4,
    required this.veri5,
    required this.veri6,
    required this.veri7,
    required this.veri8,
    required this.veri9,
    required this.veri10,
    required this.veri11,
    required this.veri12,
    required this.veri13,
    required this.veri14,
  });

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  List images = [];
  List comments = [];
  String shareType = "";

  @override
  void initState() {
    commentsIsLoading = false;
    commentsIsUploading = false;
    yorum.clear();
    getDetails();
    getComments();
    super.initState();
  }

  getDetails() async {
    var gelen = await http.get(
      Uri.parse(detaylink),
    );
    postDetails = jsonDecode(gelen.body);

    if (postDetails[0]["paylasimfoto"] != null) {
      for (var i = 0; i < postDetails[0]["paylasimfoto"].length; i++) {
        images.add(postDetails[0]["paylasimfoto"][i]["fotoufakurl"]);
      }
      shareType = postDetails[0]["paylasimfoto"][0]["paylasimkategori"];
    }
    if (mounted) {
      setState(() {});
    }
  }

  getComments() async {
    if (mounted) {
      setState(() {
        commentsIsLoading = true;
      });
    }
    var gelen = await http.get(
      Uri.parse(detaylink),
    );
    postDetails = jsonDecode(gelen.body);

    if (postDetails[0]["yorumlar"] != null) {
      for (var i = 0; i < postDetails[0]["yorumlar"].length; i++) {
        comments.add(postDetails[0]["yorumlar"][i]);
      }
    }

    // print(comments);
    if (mounted) {
      setState(() {
        commentsIsLoading = false;
      });
    }
  }

  Future<bool> onLikeButtonTapped(bool isLike) async {
    if (mounted) {
      setState(() {
        widget.veri9 = widget.veri9 == 0 ? 1 : 0;

        isLike = !isLike;

        if (isLike == true) {
          widget.veri5 = (int.parse(widget.veri5) + 1).toString();
        } else {
          widget.veri5 = (int.parse(widget.veri5) - 1).toString();
        }
      });
    }
    print(isLike);
    postID = widget.veri10;
    print("onLikeButtonTapped");

    postlike();

    return isLike;
  }

  Future<bool> onCommentLikeButtonTapped(bool isLike, dynamic yorum) async {
    if (mounted) {
      setState(() {
        yorum["benbegendim"] = yorum["benbegendim"] == 0 ? 1 : 0;

        isLike = !isLike;

        if (isLike == true) {
          yorum["yorumbegenisayi"] =
              (int.parse(yorum["yorumbegenisayi"]) + 1).toString();
        } else {
          yorum["yorumbegenisayi"] =
              (int.parse(yorum["yorumbegenisayi"]) - 1).toString();
        }
      });
    }
    print(isLike);

    yorumID = yorum["yorumID"];
    print("onCommentLikeButtonTapped");

    postyorumlike(yorum);

    return isLike;
  }

  postyorum() async {
    if (mounted) {
      setState(() {
        commentsIsUploading = true;
      });
    }
    var gelen = await http.post(
      Uri.parse(postyorumlink),
      body: {
        "yorumicerik": yorum.text,
        "postID": postID,
        "kimeyanit": "0",
        "kategori": "sosyal",
      },
    );
    try {
      response = jsonDecode(gelen.body);

      if (response["durum"] == 1) {
        yorum.clear();
        comments.clear();
        await getComments();
        widget.veri13 = 1;
        widget.veri6 = (int.parse(widget.veri6) + 1).toString();
        if (mounted) {
          setState(() {});
        }
        print(response["aciklama"]);
      } else {
        print(response["aciklama"]);
      }
    } catch (e) {
      print(e);
    }
    if (mounted) {
      setState(() {
        commentsIsUploading = false;
      });
    }
  }

  postyorumsil() async {
    var gelen = await http.post(
      Uri.parse(postyorumsillink),
      body: {
        "yorumID": yorumID,
      },
    );

    try {
      response = jsonDecode(gelen.body);
      print(response["durum"]);

      if (response["durum"] == 1) {
        postID = widget.veri10;
        comments.clear();
        getComments();
        widget.veri13 = 0;
        widget.veri6 = "0";
        if (mounted) {
          setState(() {});
        }
        Navigator.pop(context);

        print(response["aciklama"]);
      } else {
        print(response["aciklama"]);
      }
    } catch (e) {
      print(e);
    }
  }

  getPostMedia() {
    // print(shareType);
    if (shareType == "image/jpeg" ||
        shareType == "image/png" ||
        shareType == "image/jpg") {
      if (images.length == 1)
        return Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: OpenContainer(
            transitionType: ContainerTransitionType.fade,
            openColor: Colors.transparent,
            closedColor: Colors.transparent,
            openElevation: 0,
            closedElevation: 0,
            closedBuilder: (context, openWidget) {
              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: openWidget,
                child: Row(
                  children: [
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          images[0],
                          width: double.infinity,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            openBuilder: (context, closeWidget) {
              return Resiminceleme(
                veri1: images,
              );
            },
          ),
        );
      if (images.length == 2)
        return Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Row(
            children: [
              Flexible(
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    print("2 resim");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Resiminceleme(
                          veri1: images,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      images[0],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth / 35),
              Flexible(
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    print("2 resim");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Resiminceleme(
                          veri1: images,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      images[1],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      if (images.length > 2)
        return Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Row(
            children: [
              Flexible(
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    print("3 ve üstü resim");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Resiminceleme(
                          veri1: images,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      images[0],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth / 35),
              Flexible(
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    print("3 ve üstü resim");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Resiminceleme(
                          veri1: images,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ColorFiltered(
                          colorFilter: ColorFilter.srgbToLinearGamma(),
                          child: Image.network(
                            images[1],
                            width: double.infinity,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        Text(
                          "+ ${images.length - 1}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
    } else if (shareType == "application/octet-stream" ||
        shareType == "video/x-matroska" ||
        shareType == "video/mp4") {
      return Padding(
        padding: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: VideoWidgetDetail(
            play: true,
            url: images[0],
          ),
        ),
      );
    }
  }

  Future<void> _refresh() async {
    postID = widget.veri10;
    comments.clear();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            child: Stack(
              children: [
                ListView(
                  controller: anaSayfaDetailScrollController,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight / 60),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  borderRadius:
                                      BorderRadius.circular(screenWidth / 12),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ThemeConsumer(
                                          child: Profile(
                                            veri1: widget.veri11,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: screenWidth / 12,
                                    backgroundImage: CachedNetworkImageProvider(
                                      widget.veri1,
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                SizedBox(width: screenWidth / 35),
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ThemeConsumer(
                                          child: Profile(
                                            veri1: widget.veri11,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    widget.veri2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10),
                                        ),
                                      ),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SafeArea(
                                          child: Wrap(
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[900],
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(30),
                                                        ),
                                                      ),
                                                      width: screenWidth / 4,
                                                      height: 5,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: ListTile(
                                                      leading:
                                                          Icon(Icons.post_add),
                                                      title:
                                                          Text(addFavoritePost),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: widget.veri11 ==
                                                            girisdata[
                                                                "oyuncuID"]
                                                        ? true
                                                        : false,
                                                    child: InkWell(
                                                      onTap: () {
                                                        postID = widget.veri10;

                                                        Navigator.pop(context);

                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ThemeConsumer(
                                                              child: SharePost(
                                                                veri1: "",
                                                                veri2: widget
                                                                    .veri3,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: ListTile(
                                                        leading: Icon(
                                                            Icons.edit_note),
                                                        title: Text(editPost),
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: widget.veri11 ==
                                                            girisdata[
                                                                "oyuncuID"]
                                                        ? true
                                                        : false,
                                                    child: InkWell(
                                                      onTap: () {
                                                        postID = widget.veri10;
                                                        postsil();
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              removePostNotification,
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                        );
                                                      },
                                                      child: ListTile(
                                                        leading: Icon(Icons
                                                            .delete_sweep_outlined),
                                                        title: Text(removePost),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Share.share(
                                                          widget.veri14);
                                                      Navigator.pop(context);
                                                    },
                                                    child: ListTile(
                                                      leading: Icon(
                                                          Icons.share_outlined),
                                                      title: Text(shareUser),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Clipboard.setData(
                                                        ClipboardData(
                                                          text: widget.veri14,
                                                        ),
                                                      );
                                                      Navigator.pop(context);

                                                      Fluttertoast.showToast(
                                                        msg: "Kopyalandı !",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.CENTER,
                                                        timeInSecForIosWeb: 1,
                                                      );
                                                    },
                                                    child: ListTile(
                                                      leading: Icon(
                                                          Icons.content_copy),
                                                      title: Text(
                                                          shareUserProfileLink),
                                                    ),
                                                  ),
                                                  // buraya web de aç özelliği ekle bunun için sitede her post için ayrı sayfa yapılmalı.
                                                  Visibility(
                                                    visible: widget.veri11 ==
                                                            girisdata[
                                                                "oyuncuID"]
                                                        ? false
                                                        : true,
                                                    child: Divider(),
                                                  ),
                                                  Visibility(
                                                    visible: widget.veri11 ==
                                                            girisdata[
                                                                "oyuncuID"]
                                                        ? false
                                                        : true,
                                                    child: InkWell(
                                                      onTap: () {
                                                        postID = widget.veri10;
                                                        postbildir();
                                                        Navigator.pop(context);

                                                        Fluttertoast.showToast(
                                                          msg: "Bildirildi !",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                        );
                                                      },
                                                      child: ListTile(
                                                        textColor: Colors.red,
                                                        leading: Icon(
                                                          Icons.flag_outlined,
                                                          color: Colors.red,
                                                        ),
                                                        title: Text(reportPost),
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: widget.veri11 ==
                                                            girisdata[
                                                                "oyuncuID"]
                                                        ? false
                                                        : true,
                                                    child: InkWell(
                                                      onTap: () {
                                                        postID = widget.veri10;
                                                        postbildir();
                                                        Navigator.pop(context);

                                                        Fluttertoast.showToast(
                                                          msg: "Engellendi !",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                        );
                                                      },
                                                      child: ListTile(
                                                        textColor: Colors.red,
                                                        leading: Icon(
                                                          Icons
                                                              .person_off_outlined,
                                                          color: Colors.red,
                                                        ),
                                                        title: Text(blockUser),
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: widget.veri11 ==
                                                            girisdata[
                                                                "oyuncuID"]
                                                        ? false
                                                        : true,
                                                    child: InkWell(
                                                      onTap: () {
                                                        postID = widget.veri10;
                                                        postbildir();
                                                        Navigator.pop(context);

                                                        Fluttertoast.showToast(
                                                          msg: "Bildirildi !",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                        );
                                                      },
                                                      child: ListTile(
                                                        textColor: Colors.red,
                                                        leading: Icon(
                                                          Icons.person_outline,
                                                          color: Colors.red,
                                                        ),
                                                        title: Text(reportUser),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.more_vert,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight / 35),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onLongPress: () async {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: widget.veri3,
                                  ),
                                ).then((_) {
                                  Fluttertoast.showToast(
                                    msg: "Kopyalandı !",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                  );
                                });
                              },
                              child: DetectableText(
                                onTap: (p0) {
                                  if (p0.substring(0, 4) == "http" ||
                                      p0.substring(0, 5) == "https") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Site(
                                          verilink: p0,
                                          veribaslik: "",
                                        ),
                                      ),
                                    );
                                  }
                                },
                                detectionRegExp: RegExp(
                                  "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                                  multiLine: true,
                                ),
                                text: widget.veri3,
                                trimCollapsedText: " devamını oku",
                                trimExpandedText: " daha az göster",
                                lessStyle: const TextStyle(color: Colors.grey),
                                moreStyle: const TextStyle(color: Colors.grey),
                                basicStyle: const TextStyle(
                                  fontSize: 16,
                                ),
                                detectedStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),

                          if (shareType == "image/jpeg" ||
                              shareType == "image/png" ||
                              shareType == "image/jpg" ||
                              shareType == "application/octet-stream" ||
                              shareType == "video/x-matroska" ||
                              shareType == "video/mp4")
                            getPostMedia(),
                          // buraya resim yüklenirken animasyon koy.

                          SimpleUrlPreview(
                            url: widget.veri3,
                            isClosable: true,
                            imageLoaderColor: Colors.blue,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            descriptionStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            siteNameStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: screenHeight / 50),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Row(
                              children: [
                                Text(
                                  widget.veri4,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  " - ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                // buraya for web ise web e basılınca sitede postu aç bunun için sitede her post için ayrı sayfa yapılması lazım.
                                Text(
                                  widget.veri12 == ""
                                      ? "For Web"
                                      : "For Mobile",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(endIndent: 10, indent: 10),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    widget.veri5 != "0"
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ThemeConsumer(
                                                child: PostLCRScreen(
                                                  veri1: widget.veri10,
                                                  veri2: 0,
                                                  veri3: postbegenenlerlink,
                                                ),
                                              ),
                                            ),
                                          )
                                        : null;
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(widget.veri5),
                                        Text(
                                          "  Beğeni",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => ThemeConsumer(
                                    //       child: PostLCRScreen(
                                    //         veri1: widget.veri10,
                                    //         veri2: 1,
                                    //         veri3: postyorumlayanlarlink,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(widget.veri6),
                                        Text(
                                          "  Yorum",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => ThemeConsumer(
                                    //       child: PostLCRScreen(
                                    //         veri1: widget.veri10,
                                    //         veri2: 2,
                                    //         veri3: postrepostlayanlarlink,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(widget.veri7),
                                        Text(
                                          "  Repost",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(endIndent: 10, indent: 10),
                          Container(
                            color: Colors.transparent,
                            width: screenWidth,
                            height: screenHeight / 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                LikeButton(
                                  onTap: (bool isLike) {
                                    return onLikeButtonTapped(isLike);
                                  },
                                  countPostion: CountPostion.right,
                                  isLiked: widget.veri9 != 0 ? true : false,
                                  // likeCount: int.parse(widget.veri5),
                                  likeBuilder: (bool isLiked) {
                                    return isLiked
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : Icon(
                                            Icons.favorite_outline,
                                            color: Colors.grey,
                                          );
                                  },
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: Colors.red,
                                    dotSecondaryColor: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    focusNodeAnaDetail.requestFocus();
                                    // print(widget.veri13);
                                    // print(widget.veri13.runtimeType);
                                  },
                                  icon: widget.veri13 == 0
                                      ? const FaIcon(
                                          FontAwesomeIcons.comment,
                                          color: Colors.grey,
                                          size: 22,
                                        )
                                      : const FaIcon(
                                          FontAwesomeIcons.solidComment,
                                          color: Colors.blue,
                                          size: 22,
                                        ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Fluttertoast.showToast(
                                      msg: comingSoon,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                    );
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.retweet,
                                    color: Colors.grey,
                                    size: 22,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Share.share(
                                      widget.veri3,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.share_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Yorumlar
                          Divider(),
                          Visibility(
                            visible: commentsIsLoading,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: comments.length,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(bottom: 70),
                            controller: anaSayfaDetailScrollController,
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    leading: InkWell(
                                      borderRadius: BorderRadius.circular(
                                          screenWidth / 12),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ThemeConsumer(
                                              child: Profile(
                                                veri1: comments[index]
                                                    ["yorumcuid"],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: screenWidth / 12,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          comments[index]
                                              ["yorumcuminnakavatar"],
                                        ),
                                        backgroundColor: Colors.grey[700],
                                      ),
                                    ),
                                    title: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ThemeConsumer(
                                                  child: Profile(
                                                    veri1: comments[index]
                                                        ["yorumcuid"],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            comments[index]["yorumcuadsoyad"],
                                          ),
                                        ),
                                        Text(
                                          "",
                                          // "  -  " + comments[i]["yorumcuzaman"],
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet<void>(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(10),
                                                ),
                                              ),
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SafeArea(
                                                  child: Wrap(
                                                    children: [
                                                      Container(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      900],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            30),
                                                                  ),
                                                                ),
                                                                width:
                                                                    screenWidth /
                                                                        4,
                                                                height: 5,
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: ListTile(
                                                                leading: Icon(Icons
                                                                    .post_add),
                                                                title: Text(
                                                                    "Yorumu favorilere ekle."),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Share.share(comments[
                                                                        index][
                                                                    "oyunculink"]);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: ListTile(
                                                                leading: Icon(Icons
                                                                    .share_outlined),
                                                                title: Text(
                                                                    shareUser),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Clipboard
                                                                    .setData(
                                                                  ClipboardData(
                                                                    text: comments[
                                                                            index]
                                                                        [
                                                                        "oyunculink"],
                                                                  ),
                                                                );
                                                                Navigator.pop(
                                                                    context);
                                                                Fluttertoast
                                                                    .showToast(
                                                                  msg:
                                                                      "Kopyalandı !",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .CENTER,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                );
                                                              },
                                                              child: ListTile(
                                                                leading: Icon(Icons
                                                                    .content_copy),
                                                                title: Text(
                                                                    shareUserProfileLink),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: true,
                                                              child: Divider(),
                                                            ),
                                                            Visibility(
                                                              visible: comments[
                                                                              index]
                                                                          [
                                                                          "yorumcuid"] ==
                                                                      girisdata[
                                                                          "oyuncuID"]
                                                                  ? true
                                                                  : false,
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  if (mounted) {
                                                                    setState(
                                                                        () {
                                                                      yorumID =
                                                                          comments[index]
                                                                              [
                                                                              "yorumID"];
                                                                    });
                                                                  }
                                                                  await postyorumsil();
                                                                },
                                                                child: ListTile(
                                                                  leading: Icon(
                                                                    Icons
                                                                        .delete_sweep_outlined,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  title: Text(
                                                                    "Yorumu kaldır.",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: comments[
                                                                              index]
                                                                          [
                                                                          "yorumcuid"] ==
                                                                      girisdata[
                                                                          "oyuncuID"]
                                                                  ? false
                                                                  : true,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: ListTile(
                                                                  textColor:
                                                                      Colors
                                                                          .red,
                                                                  leading: Icon(
                                                                    Icons
                                                                        .flag_outlined,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  title: Text(
                                                                      "Yorumu bildir."),
                                                                ),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: comments[
                                                                              index]
                                                                          [
                                                                          "yorumcuid"] ==
                                                                      girisdata[
                                                                          "oyuncuID"]
                                                                  ? false
                                                                  : true,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  postID = widget
                                                                      .veri10;
                                                                  postbildir();
                                                                  Navigator.pop(
                                                                      context);
                                                                  Fluttertoast
                                                                      .showToast(
                                                                    msg:
                                                                        "Engellendi !",
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_SHORT,
                                                                    gravity:
                                                                        ToastGravity
                                                                            .CENTER,
                                                                    timeInSecForIosWeb:
                                                                        1,
                                                                  );
                                                                },
                                                                child: ListTile(
                                                                  textColor:
                                                                      Colors
                                                                          .red,
                                                                  leading: Icon(
                                                                    Icons
                                                                        .person_off_outlined,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  title: Text(
                                                                      blockUser),
                                                                ),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: comments[
                                                                              index]
                                                                          [
                                                                          "yorumcuid"] ==
                                                                      girisdata[
                                                                          "oyuncuID"]
                                                                  ? false
                                                                  : true,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: ListTile(
                                                                  textColor:
                                                                      Colors
                                                                          .red,
                                                                  leading: Icon(
                                                                    Icons
                                                                        .person_outline,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  title: Text(
                                                                      reportUser),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.more_vert,
                                            size: 15,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: DetectableText(
                                      detectionRegExp: RegExp(
                                        "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                                        multiLine: true,
                                      ),
                                      text: comments[index]["yorumcuicerik"],
                                      basicStyle: TextStyle(
                                        fontSize: 14,
                                      ),
                                      detectedStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth,
                                    height: screenHeight / 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        LikeButton(
                                          onTap: (bool isLike) {
                                            return onCommentLikeButtonTapped(
                                              isLike,
                                              comments[index],
                                            );
                                          },
                                          countPostion: CountPostion.right,
                                          isLiked: comments[index]
                                                      ["benbegendim"] !=
                                                  0
                                              ? true
                                              : false,
                                          likeCount: comments[index]
                                                      ["yorumbegenisayi"] !=
                                                  "0"
                                              ? int.parse(comments[index]
                                                  ["yorumbegenisayi"])
                                              : null,
                                          likeBuilder: (bool isLiked) {
                                            return isLiked
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : Icon(
                                                    Icons.favorite_outline,
                                                    color: Colors.grey,
                                                  );
                                          },
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor: Colors.red,
                                            dotSecondaryColor: Colors.blue,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            yorum.text =
                                                "${comments[index]["yorumcuetiketad"]} ";
                                            focusNodeAnaDetail.requestFocus();
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.comment,
                                            color: Colors.grey,
                                            size: 21,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Share.share(
                                              widget.veri3,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.share_outlined,
                                            color: Colors.grey,
                                            size: 19,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // yorum yeri

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: ThemeProvider.controllerOf(context)
                                .currentThemeId
                                .toString() !=
                            "default_dark_theme"
                        ? Colors.grey
                        : Colors.grey[900],
                    width: screenWidth,
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: DetectableTextField(
                          onChanged: (value) =>
                              mounted ? setState(() {}) : null,
                          focusNode: focusNodeAnaDetail,
                          detectionRegExp: RegExp(
                            "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                            multiLine: true,
                          ),
                          controller: yorum,
                          maxLength: 150,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            prefixIcon: Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  girisdata["presimminnak"],
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: ThemeProvider.controllerOf(context)
                                        .currentThemeId
                                        .toString() !=
                                    "default_dark_theme"
                                ? Colors.white
                                : Colors.grey[850],
                            filled: true,
                            counterText: "",
                            hintText: "Yorum Yap",
                            suffixIcon: IconButton(
                              onPressed: () async {
                                postID = widget.veri10;
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (yorum.text.isNotEmpty) {
                                  await postyorum();
                                } else {
                                  print("Yorum boş olamaz !");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Yorum boş olamaz !"),
                                    ),
                                  );
                                }
                              },
                              icon: commentsIsUploading
                                  ? CircularProgressIndicator()
                                  : Icon(
                                      Icons.send,
                                      color: yorum.text.isNotEmpty
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                            ),
                          ),
                        ),
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
