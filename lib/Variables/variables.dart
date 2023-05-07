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
var toplantitarih = "";
var toplantiadi = "";
var maxLength = 250;
var textLength = 0;
var profileID;
var id;
var kulAdSoyad;
var screenWidth;
var screenHeight;
var response;

//  String  //
// String version = "";
String mevcutpage = "anasayfa";
String sifirlamatercihi = "";
String completeVerified = "";
String? gelenID;
String? gkontrolAd;
String? gkontrolSifre;
String toplantiid = "";
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
String sharePostNotice = "Paylaşıldı !";
String editPostNotice = "Düzenlendi !";
String editPost = "Postu düzenle.";
String removePost = "Postu kaldır.";
String removePostNotification = "Post kaldırıldı.";
String shareUser = "Kullanıcıyı paylaş.";
String shareUserProfileLink = "Kullanıcı profil linkini kopyala.";
String reportPost = "Postu bildir.";
String blockUser = "Kullanıcıyı engelle.";
String removeFriend = "Arkadaşı çıkar.";
String reportUser = "Kullanıcıyı bildir.";
String editProfile = "Profili düzenle.";
String dogumTarihi = "";
String userGender = "";
String userPhonenumber = "";
String userCountry = "";
String userState = "";
String markAllasRead = "Tümünü okundu işaretle.";
String comingSoon = "Yakında";
String privacyPolicy = "Gizlilik Politikası";
String exitApp = "ARMOYU'dan çıkış yapmak istediğine emin misin?";

//  int  //
int startPage = 0;
int currentIndex = 0;
int profileCurrentIndex = 0;
int aratildi = 0;
int appIcon = 1;
int countTimerTime = 120;

//  bool  //
bool? gkontrolHatirla;
bool visible = false;
bool isMobileEnable = true;
bool beniHatirla = true;
bool forgetError = false;
bool speechEnabled = false;
bool isUpload = false;
bool? isEditPost;
bool showNotification = true;
bool isPlay = false;
bool isMusicOn = false;
bool isFullScreen = false;
bool isIconShow = true;
bool isEditProfileIconShow = false;
bool isGenderSelected = false;
bool isMale = false;
bool isFemale = false;
bool isPhoneValidate = false;
bool checked = false;
bool isSocial = false;
bool beingChecked = false;
bool hasNotificationBeenSeen = true;

//  List  //
List gruplarim = [];
List dataanasayfa = [];
List gonderifotolar = [];
List postDetails = [];
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
// late final XFile? video;

//  Timer  //
Timer? timer;
Timer? countTimer;

//  FocusNode  //
FocusNode focusNodeAnaDetail = FocusNode();
FocusNode focusNodeSearch = FocusNode();

//  SpeechToText  //
// SpeechToText speechToText = SpeechToText();

//  GlobalKey  //
GlobalKey autocompleteKey = GlobalKey();

//  StreamSubscription  //
// StreamSubscription? subscription;
