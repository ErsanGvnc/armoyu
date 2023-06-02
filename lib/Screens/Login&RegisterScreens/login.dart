// ignore_for_file: use_build_context_synchronously, avoid_print, unnecessary_statements

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    sifirlamatercihi = "";
    completeVerified = "";
    forgetError = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    firstResetPassword() async {
      print(forgeteposta.text);
      print(forgetkadi.text);
      print(forgetdogumtarihi.text);

      var gelen = await http.post(
        Uri.parse(sifreSifirlaLink),
        body: {
          "email": forgeteposta.text,
          "kullaniciadi": forgetkadi.text,
          "dogumtarihi": forgetdogumtarihi.text,
        },
      );

      try {
        response = jsonDecode(gelen.body);
        print(response["durum"]);
        if (response["durum"] == 1) {
          await response["aciklamadetay"] == null
              ? isMobileEnable = true
              : isMobileEnable = false;

          forgetPasswordScrollController.nextPage(
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.easeIn,
          );

          setState(() {});
          print(response["aciklama"]);
        }
      } catch (e) {
        print(e);
      }

      print(response);
    }

    resetPassword() async {
      print(forgeteposta.text);
      print(forgetkadi.text);
      print(forgetdogumtarihi.text);
      print(sifirlamatercihi);
      var gelen = await http.post(
        Uri.parse(sifreSifirlaLink),
        body: {
          "email": forgeteposta.text,
          "kullaniciadi": forgetkadi.text,
          "dogumtarihi": forgetdogumtarihi.text,
          "sifirlamatercihi": sifirlamatercihi,
        },
      );

      try {
        response = jsonDecode(gelen.body);
        print(response["durum"]);
        if (response["durum"] == 1) {
          forgetPasswordScrollController.nextPage(
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.easeIn,
          );
          setState(() {});
          print(response["aciklama"]);
        }
      } catch (e) {
        print(e);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["aciklama"]),
        ),
      );

      print(response);

      print("register");
    }

    confirmCode() async {
      completeVerified = verified1.text +
          verified2.text +
          verified3.text +
          verified4.text +
          verified5.text +
          verified6.text;
      print(completeVerified);
      print(forgeteposta.text);
      print(forgetkadi.text);
      print(forgetdogumtarihi.text);
      var gelen = await http.post(
        Uri.parse(sifreDogrulaLink),
        body: {
          "email": forgeteposta.text,
          "kullaniciadi": forgetkadi.text,
          "dogumtarihi": forgetdogumtarihi.text,
          "dogrulamakodu": completeVerified,
        },
      );

      try {
        response = jsonDecode(gelen.body);
        print(response["durum"]);

        if (response["durum"] == 1) {
          forgetPasswordScrollController.nextPage(
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.easeIn,
          );
          setState(() {});
          print(response["aciklama"]);
        }
      } catch (e) {
        print(e);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["aciklama"]),
        ),
      );

      print(response);
    }

    newPasspord() async {
      var gelen = await http.post(
        Uri.parse(sifreDogrulaLink),
        body: {
          "email": forgeteposta.text,
          "kullaniciadi": forgetkadi.text,
          "dogumtarihi": forgetdogumtarihi.text,
          "dogrulamakodu": completeVerified,
          "sifre": forgetparola.text,
          "sifretekrar": forgetparolatekrar.text,
        },
      );

      try {
        response = jsonDecode(gelen.body);
        print(response["durum"]);

        if (response["durum"] == 1) {
          Navigator.pop(context);

          setState(() {});
          print(response["aciklama"]);
        }
      } catch (e) {
        print(e);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["aciklama"]),
        ),
      );

      print(response);
    }

    clear() async {
      forgetkadi.clear();
      forgeteposta.clear();
      forgetdogumtarihi.clear();
      sifirlamatercihi = "";
      completeVerified = "";
      verified1.clear();
      verified2.clear();
      verified3.clear();
      verified4.clear();
      verified5.clear();
      verified6.clear();
      forgetparola.clear();
      forgetparolatekrar.clear();
      setState(() {});
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey[900],
      body: ListView(
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight / 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/yenilogo.png",
                        width: 150,
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Giriş Yap",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight / 15),
                  TextField(
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(
                    //     RegExp(
                    //         "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                    //   ),
                    // ],
                    controller: ad,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.username],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: Colors.white,
                      hintText: "Kullanıcı adı",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade900,
                    ),
                  ),
                  SizedBox(height: screenHeight / 30),
                  TextField(
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(
                    //     RegExp(
                    //         "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                    //   ),
                    // ],
                    controller: sifre,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.password],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      prefixIconColor: Colors.white,
                      hintText: "Şifre",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade900,
                    ),
                    onEditingComplete: () => TextInput.finishAutofillContext(),
                  ),
                  SizedBox(height: screenHeight / 75),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            beniHatirla = !beniHatirla;
                          });
                        },
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.grey[900],
                              value: beniHatirla,
                              onChanged: (bool? value) {
                                setState(() {
                                  beniHatirla = value!;
                                });
                              },
                            ),
                            const Text(
                              "Beni Hatırla",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await clear();
                          showModalBottomSheet<void>(
                            // isScrollControlled: true,
                            backgroundColor: Colors.blueGrey[900],
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return SafeArea(
                                    child: PageView(
                                      controller:
                                          forgetPasswordScrollController,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [
                                        InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () => FocusManager
                                              .instance.primaryFocus
                                              ?.unfocus(),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Şifremi unuttum",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: screenHeight / 30),
                                                TextField(
                                                  controller: forgeteposta,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  autofillHints: const [
                                                    AutofillHints.password
                                                  ],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    prefixIcon:
                                                        const Icon(Icons.mail),
                                                    prefixIconColor:
                                                        forgetError == false
                                                            ? Colors.white
                                                            : Colors.red,
                                                    hintText: "E-posta",
                                                    hintStyle: TextStyle(
                                                      color:
                                                          forgetError == false
                                                              ? Colors.white
                                                              : Colors.red,
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.grey.shade900,
                                                  ),
                                                  onEditingComplete: () =>
                                                      TextInput
                                                          .finishAutofillContext(),
                                                ),
                                                SizedBox(
                                                    height: screenHeight / 30),
                                                TextField(
                                                  controller: forgetkadi,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  autofillHints: const [
                                                    AutofillHints.password
                                                  ],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    prefixIcon: const Icon(
                                                        Icons.person),
                                                    prefixIconColor:
                                                        forgetError == false
                                                            ? Colors.white
                                                            : Colors.red,
                                                    hintText: "Kullanıcı Adı",
                                                    hintStyle: TextStyle(
                                                      color:
                                                          forgetError == false
                                                              ? Colors.white
                                                              : Colors.red,
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.grey.shade900,
                                                  ),
                                                  onEditingComplete: () =>
                                                      TextInput
                                                          .finishAutofillContext(),
                                                ),
                                                SizedBox(
                                                    height: screenHeight / 30),
                                                TextField(
                                                  onTap: () {
                                                    DatePicker.showDatePicker(
                                                      context,
                                                      showTitleActions: true,
                                                      minTime:
                                                          DateTime(1923, 0, 0),
                                                      maxTime: DateTime.now(),
                                                      onChanged: (date) {
                                                        setState(() {
                                                          dogumTarihi =
                                                              "${date.year}-${date.day}-${date.month}";
                                                          forgetdogumtarihi
                                                                  .text =
                                                              dogumTarihi
                                                                  .toString();
                                                        });
                                                      },
                                                      onConfirm: (date) {
                                                        setState(() {
                                                          dogumTarihi =
                                                              "${date.year}-${date.day}-${date.month}";
                                                          forgetdogumtarihi
                                                                  .text =
                                                              dogumTarihi
                                                                  .toString();
                                                        });
                                                      },
                                                      currentTime:
                                                          DateTime.now(),
                                                      locale: LocaleType.tr,
                                                    );
                                                  },
                                                  controller: forgetdogumtarihi,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  autofillHints: const [
                                                    AutofillHints.birthday
                                                  ],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    prefixIcon: const Icon(
                                                        Icons.date_range),
                                                    prefixIconColor:
                                                        forgetError == false
                                                            ? Colors.white
                                                            : Colors.red,
                                                    hintText: "Doğum Tarihi",
                                                    hintStyle: TextStyle(
                                                      color:
                                                          forgetError == false
                                                              ? Colors.white
                                                              : Colors.red,
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.grey.shade900,
                                                  ),
                                                  onEditingComplete: () =>
                                                      TextInput
                                                          .finishAutofillContext(),
                                                  readOnly: true,
                                                ),
                                                SizedBox(
                                                    height: screenHeight / 30),
                                                Center(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      if (forgeteposta.text !=
                                                              "" &&
                                                          forgetkadi.text !=
                                                              "" &&
                                                          forgetdogumtarihi
                                                                  .text !=
                                                              "") {
                                                        await firstResetPassword();
                                                        setState(() {});
                                                      } else {
                                                        setState(() {
                                                          forgetError = true;
                                                        });
                                                        await Future.delayed(
                                                          const Duration(
                                                              seconds: 1),
                                                        );
                                                        setState(() {
                                                          forgetError = false;
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      height: screenHeight / 15,
                                                      width: screenWidth / 2,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "Devam Et",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 30, 20, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Yenileme tercihi",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  height: screenHeight / 30),
                                              InkWell(
                                                onTap: () async {
                                                  isMobileEnable == true
                                                      ? {
                                                          setState(() {
                                                            sifirlamatercihi =
                                                                "telefon";
                                                          }),
                                                          await resetPassword(),
                                                        }
                                                      : print("null");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade900,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.phone_iphone,
                                                          color:
                                                              isMobileEnable !=
                                                                      true
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .white,
                                                          size: 64,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          "SMS gönder.",
                                                          style: TextStyle(
                                                            color:
                                                                isMobileEnable !=
                                                                        true
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: screenHeight / 30),
                                              InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    sifirlamatercihi = "mail";
                                                  });
                                                  await resetPassword();
                                                  // forgetPasswordScrollController
                                                  //     .nextPage(
                                                  //         duration: const Duration(
                                                  //           milliseconds: 300,
                                                  //         ),
                                                  //         curve: Curves.easeIn);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade900,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(20),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.mail_outline,
                                                          color: Colors.white,
                                                          size: 64,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          "Mail gönder.",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: screenHeight / 30),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () => FocusManager
                                              .instance.primaryFocus
                                              ?.unfocus(),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Doğrulama kodu",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: screenHeight / 30),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CircularCountDownTimer(
                                                      width: 75,
                                                      height: 75,
                                                      duration: 120,
                                                      fillColor: Colors.blue,
                                                      ringColor:
                                                          Colors.transparent,
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      isReverse: true,
                                                      isReverseAnimation: true,
                                                      textFormat:
                                                          CountdownTextFormat.S,
                                                      onComplete: () {},
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height: screenHeight / 30),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SizedBox(
                                                      width: 60,
                                                      height: 60,
                                                      child: TextField(
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(
                                                              1),
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                        ],
                                                        controller: verified1,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          prefixIconColor:
                                                              Colors.white,
                                                          hintText: "___",
                                                          hintStyle:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          filled: true,
                                                          fillColor: Colors
                                                              .grey.shade900,
                                                        ),
                                                        onChanged: (value) {
                                                          if (value.length ==
                                                              1) {
                                                            FocusScope.of(
                                                                    context)
                                                                .nextFocus();
                                                          } else if (value
                                                              .isEmpty) {
                                                            FocusScope.of(
                                                                    context)
                                                                .previousFocus();
                                                          }
                                                        },
                                                        onEditingComplete: () =>
                                                            TextInput
                                                                .finishAutofillContext(),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 60,
                                                      height: 60,
                                                      child: TextField(
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(
                                                              1),
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                        ],
                                                        controller: verified2,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          prefixIconColor:
                                                              Colors.white,
                                                          hintText: "___",
                                                          hintStyle:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          filled: true,
                                                          fillColor: Colors
                                                              .grey.shade900,
                                                        ),
                                                        onChanged: (value) {
                                                          if (value.length ==
                                                              1) {
                                                            FocusScope.of(
                                                                    context)
                                                                .nextFocus();
                                                          } else if (value
                                                              .isEmpty) {
                                                            FocusScope.of(
                                                                    context)
                                                                .previousFocus();
                                                          }
                                                        },
                                                        onEditingComplete: () =>
                                                            TextInput
                                                                .finishAutofillContext(),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 60,
                                                      height: 60,
                                                      child: TextField(
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(
                                                              1),
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                        ],
                                                        controller: verified3,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          prefixIconColor:
                                                              Colors.white,
                                                          hintText: "___",
                                                          hintStyle:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          filled: true,
                                                          fillColor: Colors
                                                              .grey.shade900,
                                                        ),
                                                        onChanged: (value) {
                                                          if (value.length ==
                                                              1) {
                                                            FocusScope.of(
                                                                    context)
                                                                .nextFocus();
                                                          } else if (value
                                                              .isEmpty) {
                                                            FocusScope.of(
                                                                    context)
                                                                .previousFocus();
                                                          }
                                                        },
                                                        onEditingComplete: () =>
                                                            TextInput
                                                                .finishAutofillContext(),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 60,
                                                      height: 60,
                                                      child: TextField(
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(
                                                              1),
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                        ],
                                                        controller: verified4,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          prefixIconColor:
                                                              Colors.white,
                                                          hintText: "___",
                                                          hintStyle:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          filled: true,
                                                          fillColor: Colors
                                                              .grey.shade900,
                                                        ),
                                                        onChanged: (value) {
                                                          if (value.length ==
                                                              1) {
                                                            FocusScope.of(
                                                                    context)
                                                                .nextFocus();
                                                          } else if (value
                                                              .isEmpty) {
                                                            FocusScope.of(
                                                                    context)
                                                                .previousFocus();
                                                          }
                                                        },
                                                        onEditingComplete: () =>
                                                            TextInput
                                                                .finishAutofillContext(),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 60,
                                                      height: 60,
                                                      child: TextField(
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(
                                                              1),
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                        ],
                                                        controller: verified5,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          prefixIconColor:
                                                              Colors.white,
                                                          hintText: "___",
                                                          hintStyle:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          filled: true,
                                                          fillColor: Colors
                                                              .grey.shade900,
                                                        ),
                                                        onChanged: (value) {
                                                          if (value.length ==
                                                              1) {
                                                            FocusScope.of(
                                                                    context)
                                                                .nextFocus();
                                                          } else if (value
                                                              .isEmpty) {
                                                            FocusScope.of(
                                                                    context)
                                                                .previousFocus();
                                                          }
                                                        },
                                                        onEditingComplete: () =>
                                                            TextInput
                                                                .finishAutofillContext(),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 60,
                                                      height: 60,
                                                      child: TextField(
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(
                                                              1),
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                        ],
                                                        controller: verified6,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          prefixIconColor:
                                                              Colors.white,
                                                          hintText: "___",
                                                          hintStyle:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          filled: true,
                                                          fillColor: Colors
                                                              .grey.shade900,
                                                        ),
                                                        onChanged:
                                                            (value) async {
                                                          if (value.length ==
                                                              1) {
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                            await confirmCode();
                                                          } else if (value
                                                              .isEmpty) {
                                                            FocusScope.of(
                                                                    context)
                                                                .previousFocus();
                                                          }
                                                        },
                                                        onEditingComplete:
                                                            () async {
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                          await confirmCode();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height: screenHeight / 30),
                                                Center(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      await confirmCode();
                                                    },
                                                    child: Container(
                                                      height: screenHeight / 15,
                                                      width: screenWidth / 2,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "Doğrula",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                        InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () => FocusManager
                                              .instance.primaryFocus
                                              ?.unfocus(),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 30, 20, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Yeni şifre",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: screenHeight / 30),
                                                TextField(
                                                  controller: forgetparola,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  obscureText: true,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  autofillHints: const [
                                                    AutofillHints.password
                                                  ],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    prefixIcon:
                                                        const Icon(Icons.lock),
                                                    prefixIconColor:
                                                        Colors.white,
                                                    hintText: "Şifre Tekrar",
                                                    hintStyle: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.grey.shade900,
                                                  ),
                                                  onEditingComplete: () =>
                                                      TextInput
                                                          .finishAutofillContext(),
                                                ),
                                                SizedBox(
                                                    height: screenHeight / 30),
                                                TextField(
                                                  controller:
                                                      forgetparolatekrar,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  obscureText: true,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  autofillHints: const [
                                                    AutofillHints.password
                                                  ],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    prefixIcon:
                                                        const Icon(Icons.lock),
                                                    prefixIconColor:
                                                        Colors.white,
                                                    hintText: "Şifre Tekrar",
                                                    hintStyle: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.grey.shade900,
                                                  ),
                                                  onEditingComplete: () =>
                                                      TextInput
                                                          .finishAutofillContext(),
                                                ),
                                                SizedBox(
                                                    height: screenHeight / 30),
                                                Center(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      await newPasspord();
                                                    },
                                                    child: Container(
                                                      height: screenHeight / 15,
                                                      width: screenWidth / 2,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "Sıfırla",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: const Text(
                          "Şifremi Unuttum",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight / 15),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (ad.text == "" || sifre.text == "") {
                          const snackBar = SnackBar(
                            content:
                                Text('Giriş Bilgilerinizi Boş Bıraktınız!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          if (beniHatirla == true) {
                            var sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setString("ad", ad.text);
                            sharedPreferences.setString("sifre", sifre.text);
                            sharedPreferences.setBool("beniHatirla", true);
                            setState(() {
                              gkontrolAd = sharedPreferences.getString("ad");
                              gkontrolSifre =
                                  sharedPreferences.getString("sifre");
                              gkontrolHatirla =
                                  sharedPreferences.getBool("beniHatirla");
                            });
                          } else {
                            var sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setString("ad", "");
                            sharedPreferences.setString("sifre", "");
                            sharedPreferences.setBool("beniHatirla", false);
                          }
                          setState(() {
                            checked = true;
                          });
                          await MyHomePageState().girisKontrol(context);
                          setState(() {
                            checked = false;
                          });
                        }
                      },
                      child: Container(
                        height: screenHeight / 15,
                        width: screenWidth / 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: checked
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Devam Et",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight / 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Hesabın yok mu?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 40,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          );
                        },
                        child: const Text(
                          "Kayıt Ol",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Devam ederek ",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
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
                            child: const Text(
                              "Gizlilik Politikamızı ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(
                            "ve",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ThemeConsumer(
                                    child: Site(
                                      verilink: gizliliklink,
                                      veribaslik:
                                          "Hizmet Şartlarımızı/Kullanıcı Politikamızı",
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Hizmet Şartlarımızı/Kullanıcı Politikamızı ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "kabul etmiş olursunuz.",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
