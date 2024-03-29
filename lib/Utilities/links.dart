import 'package:armoyu/Utilities/Import&Export/export.dart';

var androidStoreLink =
    "https://play.google.com/store/apps/details?id=$androidID";
var iosStoreLink = "https://apps.apple.com/app/id$iosID";
var redirectUrl = "https://aramizdakioyuncu.com/guvenlik-kontrol.php";
var versionControlLink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/0/0/0/0/0/";
var kayitolLink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/kayit-ol/0/0/0/0/";
var sifreSifirlaLink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/sifremi-unuttum/0/0/0/0/";
var sifreDogrulaLink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/sifremi-unuttum-dogrula/0/0/0/0/";
var qrlink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/$gkontrolAd/$gkontrolSifre/oturum-ac/qr/$gelenID/";
var gizliliklink = "https://aramizdakioyuncu.com/gizlilik-politikasi";
// var gonderiurl =
//     "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/$startPage/0/";
var haberurl =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/haberler/0/0/";
var oturumkontrolurl =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/0/0/0/";
var editProfileUrl =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/profil/hakkimda/0/0/";
var grupurl =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/gruplarim/0/0/";
var grupdetail =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/0/0/&grupid=$grupid";
var detaylink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/detay/$detayid/";
var etkinlikler =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/etkinlikler/0/0/";
var toplantilink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/toplantilar/0/0/";
var cekilislink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/cekilis/0/0/";
var postlink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/profil/0/";
var postyorumlink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/yorum-olustur/0/0/";
var postyorumsillink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/yorum-sil/0/0/";
var medyalink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/medya/0/0/";
var medyaSilLink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/medya/sil/0/";
// var reactionlink =
//     "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/tepki/0/0/";
var postbildirlink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/bildirim/0/";
var postbegenlink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/begen/0/0/";
var postsillink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/sil/0/0/";
var postduzenle =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/duzenle/0/0/";
var yorumlike =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/begen/0/0/";
var arkadasollink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/arkadas-ol/0/0/";
var arkadascikarlink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/arkadas-cikar/0/0/";
var arkadascevaplink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/arkadas-cevap/0/0/";
var xplink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/xpsiralama/0/0/";
var poplink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/popsiralama/0/0/";
var kullanicilink =
    "https://aramizdakioyuncu.com/botlar/ana-arama-motoru.php?deger=0";
var postbegenenlerlink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/begenenler/0/";
var postyorumlayanlarlink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/yorumlayanlar/0/";
var postrepostlayanlarlink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/postrepostlayanlarlink/0/";
var ayinpostulink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/sosyal/ayinpostu/0/";
var hashtaglink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/etiketler/0/0/";
var bildirimlink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/bildirim/0/0/";
var searchaberlink =
    "https://aramizdakioyuncu.com/botlar/$APIKey/${beniHatirla ? gkontrolAd : ad.text}/${beniHatirla ? gkontrolSifre : sifre.text}/haberler/yazar/0/";
