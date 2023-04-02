// ignore_for_file: avoid_print

import 'package:armoyu/Utilities/Import&Export/export.dart';
import 'package:http/http.dart' as http;

// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);
//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   @override
//   Widget build(BuildContext context) {
//     screenWidth = MediaQuery.of(context).size.width;
//     screenHeight = MediaQuery.of(context).size.height;
//     register() async {
//       http.post(
//         Uri.parse(
//           "https://aramizdakioyuncu.com/botlar/$botId1/kayit-ol/0/0/0/0/",
//         ),
//         body: {
//           "ad": adi.text,
//           "soyad": soyadi.text,
//           "kullaniciadi": kadi.text,
//           "email": eposta.text,
//           "parola": parola.text,
//           "parolakontrol": parolatekrar.text,
//         },
//       ).then((cevap) async {
//         print(cevap.body);
//         print(cevap.body[10]);
//         cevap.body[10] == "1"
//             ? Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const Login(),
//                 ),
//               )
//             : print("hata");
//         adi.clear();
//         soyadi.clear();
//         kadi.clear();
//         eposta.clear();
//         parola.clear();
//         parolatekrar.clear();
//         setState(() {
//           setstatedegiden = cevap.body;
//         });
//       });
//       print("register");
//     }
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: const Color.fromRGBO(73, 144, 226, 1),
//       body: InkWell(
//         highlightColor: Colors.transparent,
//         splashColor: Colors.transparent,
//         onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//         child: ListView(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: screenHeight / 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Text(
//                         "Kayıt Ol",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 24,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: screenHeight / 15),
//                   const Text("Ad"),
//                   SizedBox(height: screenHeight / 80),
//                   TextField(
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                         RegExp(
//                             "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_]"),
//                       ),
//                     ],
//                     controller: adi,
//                     keyboardType: TextInputType.name,
//                     textInputAction: TextInputAction.next,
//                     autofillHints: const [AutofillHints.username],
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(),
//                       ),
//                       prefixIcon: Icon(Icons.person),
//                       prefixIconColor: Colors.white,
//                       hintText: "Adı",
//                     ),
//                   ),
//                   SizedBox(height: screenHeight / 40),
//                   const Text("Soyad"),
//                   SizedBox(height: screenHeight / 80),
//                   TextField(
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                         RegExp(
//                             "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_]"),
//                       ),
//                     ],
//                     controller: soyadi,
//                     keyboardType: TextInputType.name,
//                     textInputAction: TextInputAction.next,
//                     autofillHints: const [AutofillHints.username],
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(),
//                       ),
//                       prefixIcon: Icon(Icons.person),
//                       prefixIconColor: Colors.white,
//                       hintText: "Soyadı",
//                     ),
//                   ),
//                   SizedBox(height: screenHeight / 40),
//                   const Text("E-posta"),
//                   SizedBox(height: screenHeight / 80),
//                   TextField(
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                         RegExp(
//                             "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
//                       ),
//                     ],
//                     controller: eposta,
//                     keyboardType: TextInputType.emailAddress,
//                     textInputAction: TextInputAction.next,
//                     autofillHints: const [AutofillHints.password],
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(),
//                       ),
//                       prefixIcon: Icon(Icons.mail),
//                       prefixIconColor: Colors.white,
//                       hintText: "E-posta",
//                     ),
//                     onEditingComplete: () => TextInput.finishAutofillContext(),
//                   ),
//                   SizedBox(height: screenHeight / 40),
//                   const Text("Kullanıcı Adı"),
//                   SizedBox(height: screenHeight / 80),
//                   TextField(
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                         RegExp(
//                             "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
//                       ),
//                     ],
//                     controller: kadi,
//                     keyboardType: TextInputType.visiblePassword,
//                     textInputAction: TextInputAction.next,
//                     autofillHints: const [AutofillHints.password],
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(),
//                       ),
//                       prefixIcon: Icon(Icons.person),
//                       prefixIconColor: Colors.white,
//                       hintText: "Kullanıcı Adı",
//                     ),
//                     onEditingComplete: () => TextInput.finishAutofillContext(),
//                   ),
//                   SizedBox(height: screenHeight / 40),
//                   const Text("Şifre"),
//                   SizedBox(height: screenHeight / 80),
//                   TextField(
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                         RegExp(
//                             "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
//                       ),
//                     ],
//                     controller: parola,
//                     keyboardType: TextInputType.visiblePassword,
//                     obscureText: true,
//                     textInputAction: TextInputAction.next,
//                     autofillHints: const [AutofillHints.password],
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(),
//                       ),
//                       prefixIcon: Icon(Icons.lock),
//                       prefixIconColor: Colors.white,
//                       hintText: "Şifre",
//                     ),
//                     onEditingComplete: () => TextInput.finishAutofillContext(),
//                   ),
//                   SizedBox(height: screenHeight / 40),
//                   const Text("Şifre Tekrar"),
//                   SizedBox(height: screenHeight / 80),
//                   TextField(
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                         RegExp(
//                             "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
//                       ),
//                     ],
//                     controller: parolatekrar,
//                     keyboardType: TextInputType.visiblePassword,
//                     obscureText: true,
//                     textInputAction: TextInputAction.next,
//                     autofillHints: const [AutofillHints.password],
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(),
//                       ),
//                       prefixIcon: Icon(Icons.lock),
//                       prefixIconColor: Colors.white,
//                       hintText: "Şifre Tekrar",
//                     ),
//                     onEditingComplete: () => TextInput.finishAutofillContext(),
//                   ),
//                   SizedBox(height: screenHeight / 20),
//                   Center(
//                     child: InkWell(
//                       onTap: () async {
//                         FocusManager.instance.primaryFocus?.unfocus();
//                         if (adi.text == "" ||
//                             soyadi.text == "" ||
//                             kadi.text == "" ||
//                             eposta.text == "" ||
//                             parola.text == "" ||
//                             parolatekrar.text == "") {
//                           const snackBar = SnackBar(
//                             content:
//                                 Text('Kayıt Bilgilerinizi Boş Bıraktınız!'),
//                             shape: StadiumBorder(),
//                           );
//                           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                         } else {
//                           if (adi.text != "" ||
//                               soyadi.text != "" ||
//                               kadi.text != "" ||
//                               eposta.text != "" ||
//                               parola.text != "" ||
//                               parolatekrar.text != "") {
//                             if (parola.text == parolatekrar.text) {
//                               register();
//                             } else {
//                               print("sifreler uyusmuyor");
//                               const snackBar = SnackBar(
//                                 content: Text('Şifreler uyuşmuyor!'),
//                                 shape: StadiumBorder(),
//                               );
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(snackBar);
//                               print(adi.text);
//                               print(soyadi.text);
//                               print(kadi.text);
//                               print(eposta.text);
//                               print(parola.text);
//                               print(parolatekrar.text);
//                             }
//                           }
//                         }
//                       },
//                       child: Container(
//                         height: screenHeight / 15,
//                         width: screenWidth / 2,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             "Kayıt Ol",
//                             style: TextStyle(fontSize: 20, color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: screenHeight / 25),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         color: Colors.white,
//                         width: screenWidth / 15,
//                         height: screenHeight / 500,
//                       ),
//                       SizedBox(width: screenWidth / 100),
//                       const Text(
//                         "VEYA",
//                       ),
//                       SizedBox(width: screenWidth / 100),
//                       Container(
//                         color: Colors.white,
//                         width: screenWidth / 15,
//                         height: screenHeight / 500,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: screenHeight / 25),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         onTap: () {},
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.white,
//                           ),
//                           width: screenWidth / 7,
//                           height: screenHeight / 12,
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Image.asset(
//                                 "assets/images/google.png",
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: screenWidth / 8),
//                       InkWell(
//                         onTap: () {},
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.white,
//                           ),
//                           width: screenWidth / 7,
//                           height: screenHeight / 12,
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Image.asset(
//                                 "assets/images/steam.png",
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: screenHeight / 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Zaten hesabın var mı ?",
//                         style: TextStyle(),
//                       ),
//                       SizedBox(
//                         width: screenWidth / 40,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const Login(),
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           "Giriş Yap",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(height: screenHeight / 20),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    register() async {
      http.post(
        Uri.parse(
          "https://aramizdakioyuncu.com/botlar/$botId1/kayit-ol/0/0/0/0/",
        ),
        body: {
          "ad": adi.text,
          "soyad": soyadi.text,
          "kullaniciadi": kadi.text,
          "email": eposta.text,
          "parola": parola.text,
          "parolakontrol": parolatekrar.text,
        },
      ).then((cevap) async {
        print(cevap.body);
        print(cevap.body[10]);
        cevap.body[10] == "1"
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ),
              )
            : print("hata");
        adi.clear();
        soyadi.clear();
        kadi.clear();
        eposta.clear();
        parola.clear();
        parolatekrar.clear();
        setState(() {
          setstatedegiden = cevap.body;
        });
      });
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                            "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_]"),
                      ),
                    ],
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                            "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_]"),
                      ),
                    ],
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                            "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                      ),
                    ],
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                            "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                      ),
                    ],
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                            "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                      ),
                    ],
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                            "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                      ),
                    ],
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
                            parolatekrar.text == "") {
                          const snackBar = SnackBar(
                            content:
                                Text('Kayıt Bilgilerinizi Boş Bıraktınız!'),
                            shape: StadiumBorder(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          if (adi.text != "" ||
                              soyadi.text != "" ||
                              kadi.text != "" ||
                              eposta.text != "" ||
                              parola.text != "" ||
                              parolatekrar.text != "") {
                            if (parola.text == parolatekrar.text) {
                              register();
                            } else {
                              print("sifreler uyusmuyor");
                              const snackBar = SnackBar(
                                content: Text('Şifreler uyuşmuyor!'),
                                shape: StadiumBorder(),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              print(adi.text);
                              print(soyadi.text);
                              print(kadi.text);
                              print(eposta.text);
                              print(parola.text);
                              print(parolatekrar.text);
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
                          Navigator.push(
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
