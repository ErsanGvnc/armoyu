// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:armoyu/Utilities/Import&Export/export.dart';

//  var  //
var botId1 = dotenv.env['botId1'];
var girisdata;
var datahaber;
var datagrup;
var grupid;
var detayid;
var profiledata;
var arkadas;
var postID;
var yorumID;
var toplantiid;
var toplantitarih = "";
var toplantiadi = "";
var setstatedegiden;
var maxLength = 250;
var textLength = 0;
var profileID;
var id;
var kulAdSoyad;
var screenWidth;
var screenHeight;

//  String  //
String mevcutpage = "anasayfa";
String? gelenID;
String? gkontrolAd;
String? gkontrolSifre;
String baslik = "";
String csgo = "CS:GO";
String ets = "ETS";
String mc = "MC";
String gta = "GTA";
String lol = "LOL";
String theforest = "THE FOREST";
String lastWords = '';
String? byr;
String arkadasText = "";
String addFavoritePost = "Postu favorilere ekle.";
String editPost = "Postu düzenle.";
String removePost = "Postu kaldır.";
String shareUser = "Kullanıcıyı paylaş.";
String shareUserProfileLink = "Kullanıcı profil linkini kopyala.";
String reportPost = "Postu bildir.";
String blockUser = "Kullanıcıyı engelle.";
String reportUser = "Kullanıcıyı bildir.";

//  int  //
int startPage = 0;
int currentIndex = 0;
int profileCurrentIndex = 0;
int aratildi = 0;

//  bool  //
bool? gkontrolHatirla;
bool visible = false;
bool beniHatirla = true;
bool speechEnabled = false;
bool isUpload = false;
bool showNotification = true;

//  List  //
List gruplarim = [];
List dataanasayfa = [];
List gonderifotolar = [];
List detaylar = [];
List toplantilar = [];
List cekilisler = [];
List postdata = [];
List medyadata = [];
List reactiondata = [];
List bildirimler = [];
List xpsiralama = [];
List popsiralama = [];
List<dynamic> kullanicilar = [];
List<dynamic> searchler = [];
List postlar = [];
List haberler = [];
List postbyr = [];
List ayinpostu = [];
List hashtagler = [];
List<XFile> images = [];
List searchgaleri = [];
List searchhaber = [];

//  final  //
final screens = [
  const AnaSayfa(),
  const Search(),
  const Notif(),
];

//  Timer  //
Timer? timer;

//  FocusNode  //
FocusNode focusNodeAnaDetail = FocusNode();
FocusNode focusNodeSearch = FocusNode();

//  SpeechToText  //
// SpeechToText speechToText = SpeechToText();

//  GlobalKey  //
GlobalKey autocompleteKey = GlobalKey();
