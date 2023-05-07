// ignore_for_file: avoid_print

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:http/http.dart' as http;

// Post //
// postgonder() {
//   http.post(
//     Uri.parse(
//       "https://aramizdakioyuncu.com/botlar/$botId1/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/olustur/0/0/",
//     ),
//     body: {
//       "sosyalicerik": post.text,
//     },
//   );
// }

postlike() async {
  var gelen = await http.post(
    Uri.parse(postbegenlink),
    body: {
      "postID": postID,
      "kategori": "post",
    },
  );
  try {
    response = jsonDecode(gelen.body);
    print(response["durum"]);

    if (response["durum"] != 1) {
      print(response["aciklama"]);
    }
  } catch (e) {
    print(e);
  }
}

postbildir() async {
  var gelen = await http.post(
    Uri.parse(postbildirlink),
    body: {
      "postID": postID,
      "bildirikategori": "postbildiri",
    },
  );

  try {
    response = jsonDecode(gelen.body);
    print(response["durum"]);

    if (response["durum"] != 1) {
      print(response["aciklama"]);
    }
  } catch (e) {
    print(e);
  }
}

postsil() async {
  var gelen = await http.post(
    Uri.parse(postsillink),
    body: {
      "postID": postID,
    },
  );

  try {
    response = jsonDecode(gelen.body);
    print(response["durum"]);

    if (response["durum"] != 1) {
      print(response["aciklama"]);
    }
  } catch (e) {
    print(e);
  }
}

postDuzenle(content) async {
  var gelen = await http.post(
    Uri.parse(postduzenle),
    body: {
      "postID": postID,
      "sosyalicerik": content,
    },
  );

  try {
    response = jsonDecode(gelen.body);
    print(response["durum"]);

    if (response["durum"] != 1) {
      print(response["aciklama"]);
    }
  } catch (e) {
    print(e);
  }
}

postyorumlike(dynamic yorum) async {
  var gelen = await http.post(
    Uri.parse(yorumlike),
    body: {
      "postID": yorum["yorumID"],
      "kategori": "postyorum",
    },
  );

  try {
    response = jsonDecode(gelen.body);
    print(response["durum"]);

    if (response["durum"] != 1) {
      print(response["aciklama"]);
    }
  } catch (e) {
    print(e);
  }
}

editProfie(content) async {
  var gelen = await http.post(
    Uri.parse(editProfileUrl),
    body: {
      "hakkimda": content,
    },
  );

  try {
    response = jsonDecode(gelen.body);
    print(response["durum"]);

    if (response["durum"] != 1) {
      print(response["aciklama"]);
    }
  } catch (e) {
    print(e);
  }
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
