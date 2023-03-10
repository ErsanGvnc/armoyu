// ignore_for_file: use_build_context_synchronously

import 'package:armoyu/Utilities/Import&Export/export.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(73, 144, 226, 1),
            Color.fromARGB(255, 7, 50, 99)
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight / 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Giriş Yap",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight / 15),
                const Text("Kullanıcı Adı"),
                SizedBox(height: screenHeight / 80),
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                          "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_]"),
                    ),
                  ],
                  controller: ad,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.username],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Colors.white,
                    hintText: "Kullanıcı adı",
                  ),
                ),
                SizedBox(height: screenHeight / 30),
                const Text("Şifre"),
                SizedBox(height: screenHeight / 80),
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                          "[abcçdefgğhıijklmnoöprsştuüvyzwqxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWQX0-9-_@€₺¨~`;,:<>.||=)({}/&%+^^'!é)*]"),
                    ),
                  ],
                  controller: sifre,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.password],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    prefixIconColor: Colors.white,
                    hintText: "Şifre",
                  ),
                  onEditingComplete: () => TextInput.finishAutofillContext(),
                ),
                SizedBox(height: screenHeight / 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Text("Şifremi Unuttum"),
                    ),
                  ],
                ),
                Row(
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
                            value: beniHatirla,
                            onChanged: (bool? value) {
                              setState(
                                () {
                                  beniHatirla = value!;
                                },
                              );
                            },
                          ),
                          const Text("Beni Hatırla"),
                        ],
                      ),
                    ),
                  ],
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (ad.text == "" || sifre.text == "") {
                        const snackBar = SnackBar(
                          content: Text('Giriş Bilgilerinizi Boş Bıraktınız!'),
                          shape: StadiumBorder(),
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

                        MyHomePageState().girisKontrol(context);
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
                          "Devam Et",
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
                    Container(
                      color: Colors.white,
                      width: screenWidth / 15,
                      height: screenHeight / 500,
                    ),
                    SizedBox(width: screenWidth / 100),
                    const Text(
                      "VEYA",
                    ),
                    SizedBox(width: screenWidth / 100),
                    Container(
                      color: Colors.white,
                      width: screenWidth / 15,
                      height: screenHeight / 500,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight / 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        width: screenWidth / 7,
                        height: screenHeight / 12,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/google.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth / 8),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        width: screenWidth / 7,
                        height: screenHeight / 12,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/steam.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Hesabın yok mu ?",
                      style: TextStyle(
                        fontSize: 16,
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
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                      child: const Text(
                        "Kayıt Ol",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Devam ederek ",
                          style: TextStyle(),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ThemeConsumer(
                                  child: Site(
                                    verilink:
                                        "https://aramizdakioyuncu.com/gizlilik-politikasi",
                                    veribaslik: "Gizlilik Politikası",
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
                        const Text("ve"),
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
                                    verilink:
                                        "https://aramizdakioyuncu.com/gizlilik-politikasi",
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
                      style: TextStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
