// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new, prefer_const_literals_to_create_immutables, unused_local_variable, use_key_in_widget_constructors, must_be_immutable, avoid_print, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

TextEditingController kayitAd = TextEditingController();
TextEditingController kayitSoyad = TextEditingController();
TextEditingController kayitEposta = TextEditingController();
TextEditingController kayitUsername = TextEditingController();
TextEditingController kayitSifre = TextEditingController();
TextEditingController kayitSifreTekrar = TextEditingController();
TextEditingController kayitUlke = TextEditingController();
TextEditingController kayitSehir = TextEditingController();

DateFormat formatter = DateFormat('yyyy-MM-dd');
String formatted = formatter.format(DateTime.now());
String tarih = formatted;
String dropdownValue = "Erkek";

class _RegisterState extends State<Register> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    return ThemeConsumer(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Stepper(
                    type: StepperType.horizontal,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    steps: <Step>[
                      Step(
                        title: Text("Kullanıcı"),
                        content: Column(
                          children: <Widget>[
                            TextField(
                              controller: kayitAd,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                prefixIcon: Icon(Icons.person),
                                prefixIconColor: Colors.white,
                                hintText: "Ad",
                              ),
                            ),
                            SizedBox(height: screenheight / 80),
                            TextField(
                              controller: kayitSoyad,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                prefixIcon: Icon(Icons.person),
                                prefixIconColor: Colors.white,
                                hintText: "Soyad",
                              ),
                            ),
                            SizedBox(height: screenheight / 80),
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: kayitEposta,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                prefixIcon: Icon(Icons.mail),
                                prefixIconColor: Colors.white,
                                hintText: "E-posta",
                              ),
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: Text("Hesap"),
                        content: Column(
                          children: <Widget>[
                            TextField(
                              controller: kayitUsername,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                prefixIcon: Icon(Icons.person),
                                prefixIconColor: Colors.white,
                                hintText: "Kullanıcı Adı",
                              ),
                            ),
                            SizedBox(height: screenheight / 80),
                            TextField(
                              obscureText: true,
                              controller: kayitSifre,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                prefixIcon: Icon(Icons.lock),
                                prefixIconColor: Colors.white,
                                hintText: "Şifre",
                              ),
                            ),
                            SizedBox(height: screenheight / 80),
                            TextField(
                              obscureText: true,
                              controller: kayitSifreTekrar,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                prefixIcon: Icon(Icons.lock),
                                prefixIconColor: Colors.white,
                                hintText: "Şifre Tekrar",
                              ),
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: Text("Bilgi"),
                        content: Column(
                          children: <Widget>[
                            TextField(
                              controller: kayitUlke,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                prefixIcon: Icon(Icons.location_city),
                                prefixIconColor: Colors.white,
                                hintText: "Ülke",
                              ),
                            ),
                            SizedBox(height: screenheight / 80),
                            TextField(
                              controller: kayitSehir,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                prefixIcon: Icon(Icons.location_city),
                                prefixIconColor: Colors.white,
                                hintText: "Şehir",
                              ),
                            ),
                            SizedBox(height: screenheight / 80),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(1905, 3, 5),
                                        maxTime: DateTime.now(),
                                        onConfirm: (date) {
                                      DateFormat formatter =
                                          DateFormat('yyyy-MM-dd');
                                      String formatted = formatter.format(date);
                                      setState(() {
                                        tarih = "$formatted";
                                      });
                                    }, locale: LocaleType.tr);
                                  },
                                  child: Container(
                                      child: Row(
                                    children: [
                                      Icon(Icons.date_range),
                                      SizedBox(
                                        width: screenwidth / 50,
                                      ),
                                      Text(tarih),
                                    ],
                                  )),
                                ),
                                SizedBox(width: screenwidth / 10),
                                DropdownButton(
                                  value: dropdownValue,
                                  items: <String>[
                                    'Erkek',
                                    'Kadın',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: screenheight / 10),
                            InkWell(
                              onTap: () {
                                if (kayitAd.text == "" ||
                                    kayitSoyad.text == "" ||
                                    kayitEposta.text == "" ||
                                    kayitUsername.text == "" ||
                                    kayitSifre.text == "" ||
                                    kayitSifreTekrar.text == "" ||
                                    kayitUlke.text == "" ||
                                    kayitSehir.text == "") {
                                  const snackBar = SnackBar(
                                    content: Text(
                                        'Boş Alanları Tamamen Doldurduğunuzdan Emin Olun!'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  if (kayitSifre.text !=
                                      kayitSifreTekrar.text) {
                                    const snackBar = SnackBar(
                                      content: Text('Şifreler Eşleşmiyor!'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    if (tarih == formatted) {
                                      const snackBar = SnackBar(
                                        content: Text(
                                            'Doğum Tarihinizi Değiştirmeyi Unuttunuz!'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      ////////////////////////////
                                    }
                                  }
                                }
                              },
                              child: Container(
                                height: screenheight / 15,
                                width: screenwidth / 2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Kayıt Ol",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenheight / 10),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
