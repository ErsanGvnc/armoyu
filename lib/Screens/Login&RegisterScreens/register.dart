// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {

    register() async {
      var gelen = await http.post(
        Uri.parse(kayitolLink),
        body: {
          "ad": adi.text,
          "soyad": soyadi.text,
          "kullaniciadi": kadi.text,
          "email": eposta.text,
          "parola": parola.text,
          "parolakontrol": parolatekrar.text,
          "dogumtarihi": dogumtarihi.text,
          "cinsiyet": userGender,
          "telefon": userPhonenumber,
          "ulke": "212",
          "il": "63",
        },
      );

      try {
        response = jsonDecode(gelen.body);
        print(response["durum"]);

        if (response["durum"] == 1) {
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Login(),
            ),
          );
          adi.clear();
          soyadi.clear();
          kadi.clear();
          eposta.clear();
          parola.clear();
          parolatekrar.clear();
          dogumTarihi = "";
          userGender = "";
          userPhonenumber = "";
          userCountry = "";
          userState = "";
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
                        "Kayıt Ol",
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
                    //         "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_]"),
                    //   ),
                    // ],
                    controller: adi,
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
                      hintText: "Adı",
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
                    //         "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_]"),
                    //   ),
                    // ],
                    controller: soyadi,
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
                      hintText: "Soyadı",
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
                    controller: eposta,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.password],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.mail),
                      prefixIconColor: Colors.white,
                      hintText: "E-posta",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade900,
                    ),
                    onEditingComplete: () => TextInput.finishAutofillContext(),
                  ),
                  SizedBox(height: screenHeight / 30),
                  TextField(
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(
                    //     RegExp(
                    //         "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                    //   ),
                    // ],
                    controller: kadi,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.password],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: Colors.white,
                      hintText: "Kullanıcı Adı",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade900,
                    ),
                    onEditingComplete: () => TextInput.finishAutofillContext(),
                  ),
                  SizedBox(height: screenHeight / 30),
                  TextField(
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(
                    //     RegExp(
                    //         "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                    //   ),
                    // ],
                    controller: parola,
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
                  SizedBox(height: screenHeight / 30),
                  TextField(
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(
                    //     RegExp(
                    //         "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                    //   ),
                    // ],
                    controller: parolatekrar,
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
                      hintText: "Şifre Tekrar",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade900,
                    ),
                    onEditingComplete: () => TextInput.finishAutofillContext(),
                  ),
                  SizedBox(height: screenHeight / 30),
                  TextField(
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(1923, 0, 0),
                        maxTime: DateTime.now(),
                        onChanged: (date) {
                          setState(() {
                            dogumTarihi =
                                "${date.year}-${date.day}-${date.month}";
                            dogumtarihi.text = dogumTarihi.toString();
                          });
                        },
                        onConfirm: (date) {
                          setState(() {
                            dogumTarihi =
                                "${date.year}-${date.day}-${date.month}";
                            dogumtarihi.text = dogumTarihi.toString();
                          });
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.tr,
                      );
                    },
                    controller: dogumtarihi,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.birthday],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.date_range),
                      prefixIconColor: Colors.white,
                      hintText: "Doğum Tarihi (Optional)",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade900,
                    ),
                    onEditingComplete: () => TextInput.finishAutofillContext(),
                    readOnly: true,
                  ),
                  SizedBox(height: screenHeight / 30),
                  InternationalPhoneNumberInput(
                    // searchBoxDecoration: InputDecoration(
                    //   border: const OutlineInputBorder(
                    //     borderSide: BorderSide.none,
                    //   ),
                    //   prefixIconColor: Colors.white,
                    //   hintText: "Telefon Numarası",
                    //   hintStyle: const TextStyle(
                    //     color: Colors.white,
                    //   ),
                    //   filled: true,
                    //   fillColor: Colors.grey.shade900,
                    // ),
                    autoValidateMode: AutovalidateMode.always,
                    spaceBetweenSelectorAndTextField: 0,
                    maxLength: 13,
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    selectorTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    onInputChanged: (PhoneNumber number) {
                      // print(number.phoneNumber);
                      setState(() {
                        userPhonenumber = number.phoneNumber!;
                      });
                    },
                    onInputValidated: (bool value) {
                      setState(() {
                        if (value == true) {
                          isPhoneValidate = true;
                        } else {
                          isPhoneValidate = false;
                        }
                      });
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    initialValue: PhoneNumber(isoCode: 'TR'),
                    inputDecoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIconColor: Colors.white,
                      hintText: "Telefon Numarası (Optional)",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade900,
                    ),
                  ),
                  SizedBox(height: screenHeight / 30),
                  CSCPicker(
                    dropdownDecoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    dropdownDialogRadius: 5,
                    defaultCountry: CscCountry.Turkey,
                    showCities: false,
                    selectedItemStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    onCountryChanged: (value) {
                      setState(() {
                        // print(value);
                        userCountry = value;
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        // print(value);
                        value != null ? userState = value : null;
                      });
                    },
                    onCityChanged: (value) {},
                  ),
                  SizedBox(height: screenHeight / 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => setState(() {
                          isMale = !isMale;
                          isFemale = false;
                          userGender = "E";
                          print(userGender);
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: isMale
                                ? Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  )
                                : Border.all(
                                    color: Colors.grey.shade900,
                                    width: 2,
                                  ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(30),
                            child: Center(
                              child: Icon(
                                Icons.man,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenHeight / 30),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => setState(() {
                          isFemale = !isFemale;
                          isMale = false;
                          userGender = "K";
                          print(userGender);
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: isFemale
                                ? Border.all(
                                    color: Colors.pink,
                                    width: 2,
                                  )
                                : Border.all(
                                    color: Colors.grey.shade900,
                                    width: 2,
                                  ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(30),
                            child: Center(
                              child: Icon(
                                Icons.woman,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Optional",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: screenHeight / 15),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (adi.text == "" ||
                            soyadi.text == "" ||
                            kadi.text == "" ||
                            eposta.text == "" ||
                            parola.text == "" ||
                            parolatekrar.text == "" ||
                            // dogumtarihi.text == "" ||
                            // userGender == "" ||
                            // isPhoneValidate == false ||
                            // userPhonenumber == "" ||
                            userCountry == "" ||
                            userState == "") {
                          const snackBar = SnackBar(
                            content:
                                Text('Kayıt Bilgilerinizi Boş Bıraktınız!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          if (adi.text != "" ||
                              soyadi.text != "" ||
                              kadi.text != "" ||
                              eposta.text != "" ||
                              parola.text != "" ||
                              parolatekrar.text != "" ||
                              // dogumtarihi.text != "" ||
                              // userGender != "" ||
                              // isPhoneValidate != false ||
                              // userPhonenumber != "" ||
                              userCountry != "" ||
                              userState != "") {
                            if (parola.text == parolatekrar.text) {
                              register();
                            } else {
                              print("sifreler uyusmuyor");
                              const snackBar = SnackBar(
                                content: Text('Şifreler uyuşmuyor!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              print(adi.text);
                              print(soyadi.text);
                              print(kadi.text);
                              print(eposta.text);
                              print(parola.text);
                              print(parolatekrar.text);
                              print(dogumtarihi.text);
                              print(userGender);
                              print(isPhoneValidate);
                              print(userCountry);
                              print(userState);
                            }
                          }
                        }
                      },
                      child: Container(
                        height: screenHeight / 15,
                        width: screenWidth / 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Kayıt Ol",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight / 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Zaten hesabın var mı?",
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
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: const Text(
                          "Giriş Yap",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight / 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
