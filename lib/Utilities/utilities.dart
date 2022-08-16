// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import '../Controllers/controllers.dart';
import '../Variables/variables.dart';
import 'links.dart';
import 'dart:convert';

// Post //
postgonder() {
  http.post(
    Uri.parse(
      "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/olustur/0/0/",
    ),
    body: {
      "sosyalicerik": post.text,
    },
  );
}

postlike() {
  http.post(
    Uri.parse(postbegenlink),
    body: {
      "postID": postID,
    },
  );
}

postyorum() {
  http.post(
    Uri.parse(
      "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/yorum/0/0/",
    ),
    body: {
      "yorumicerik": yorum.text,
      "postID": postID,
    },
  );
}

postbildir() {
  http.post(
    Uri.parse(postbildirlink),
    body: {
      "postID": postID,
    },
  );
}

postsil() {
  http.post(
    Uri.parse(postsillink),
    body: {
      "postID": postID,
    },
  );
}

postyorumlike(dynamic yorum) {
  http.post(
    Uri.parse(yorumlike),
    body: {
      "postID": yorum["postid"],
      "yorumID": yorum["yorumid"],
      "kategori": "postyorum",
    },
  );
}

postbyrcek() {
  http.post(
    Uri.parse(postbyrlink),
    body: {
      "postID": postID,
    },
  );
}

// Cekilis //
cekiliscek() async {
  var gelen = await http.get(
    Uri.parse(cekilislink),
  );

  try {
    cekilisler = jsonDecode(gelen.body);
  } catch (e) {
    print(e);
  }
}

cekiliskatil() {
  http.post(
    Uri.parse(cekilislink),
    body: {},
  );
}

// Toplanti //
toplanticek() async {
  var gelen = await http.get(
    Uri.parse(toplantilink),
  );

  try {
    toplantilar = jsonDecode(gelen.body);
  } catch (e) {
    print(e);
  }
  print("toplantilar");
  print(toplantilar);
}

toplantigonder() {
  http.post(
    Uri.parse(
      "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/toplantilar/$toplantiid/0/",
    ),
    body: {
      "icerik": toplanti.text,
    },
  );
}
