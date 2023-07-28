// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../homeScreens/Home_Page.dart';

class LoginOtpScreen extends StatefulWidget {
  const LoginOtpScreen({Key? key, required this.mobile}) : super(key: key);
  final String mobile;

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  TextEditingController otp = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String msg = '';
  var data;
  var id, verification, vendor_id, photo, mobile, name, email;
  void _setValue(id) async {
    final pref = await SharedPreferences.getInstance();
    final set1 = pref.setString('id', id);
    print("hdusifgudsigfiu==>>>=++++" + set1.toString());
  }

  void _setValue1(verification) async {
    final pref1 = await SharedPreferences.getInstance();
    final set3 = pref1.setString('verification', verification);
    print("hdusifgudsigfiu==>>>=++++" + set3.toString());
  }

  void _setValue2(vendor_id) async {
    final pref2 = await SharedPreferences.getInstance();
    final set4 = pref2.setString('vendor_id', vendor_id);
    print("hdusifgudsigfiu==>>>=++++" + set4.toString());
  }

  void _setValue3(photo) async {
    final pref3 = await SharedPreferences.getInstance();
    final set5 = pref3.setString('photo', photo);
    print("hdusifgudsigfiu==>>>=++++" + set5.toString());
  }

  void _setValue4(mobile) async {
    final pref3 = await SharedPreferences.getInstance();
    final set5 = pref3.setString('mobile', mobile);
    print("hdusifgudsigfiu==>>>=++++" + set5.toString());
  }

  void _setValue5(name) async {
    final pref5 = await SharedPreferences.getInstance();
    final set5 = pref5.setString('vendor_name', name);
    print("hdusifgudsigfiu==>>>=++++" + set5.toString());
  }

  void _setValue6(email) async {
    final pref6 = await SharedPreferences.getInstance();
    final set6 = pref6.setString('email', email);
    print("hdusifgudsigfiu==>>>=++++" + set6.toString());
  }

  Future verifyNumber() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show(status: 'loading..');
      var api = Uri.parse("https://bitacars.com/api/verify_votp");
      Map mapeddate = {
        'mobile': widget.mobile.toString(),
        'otp': otp.text.toString(),
      };
      final response = await http.post(
        api,
        body: mapeddate,
      );
      var res = await json.decode(response.body);
      msg = res["status_message"];
      data = res["response_userRegister"];
      id = data['id'];
      vendor_id = data['vendor_id'];
      verification = data['verification'];
      photo = data['photo'];
      mobile = data['mobile'];
      name = data['vendor_name'];
      email = data['email'];
      setState(() {
        _setValue(id);
        _setValue1(verification);
        _setValue2(vendor_id);
        _setValue3(photo);
        _setValue4(mobile);
        _setValue5(name);
        _setValue6(email);
      });

      print("hvikhfgvuighiu=======>>" + vendor_id);
      // print("response" + response.body);
      print(msg);
      // print("UserId:: ${res["mobile"]}");
      try {
        if (msg == "Login Successful") {
          Fluttertoast.showToast(msg: "Mobile Verified");
          // await HelperFunctions.saveUserLoggedInSharedPreference(true);
          EasyLoading.dismiss();
          setState(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Home_Page(),
              ),
            );
          });
        } else if (msg == "Invalid OTP") {
          EasyLoading.dismiss();
          Fluttertoast.showToast(msg: 'Invalid OTP');
        }
      } catch (e) {
        print(e);
        print(msg);
        EasyLoading.dismiss();
      }
    }
  }

  Future LoginApi() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Loading');
      Map data = {
        'mobile': widget.mobile.toString(),
      };
      Uri url = Uri.parse("https://bitacars.com/api/send_votp");
      var body1 = jsonEncode(data);
      var response = await http.post(url,
          headers: {"Content-Type": "Application/json"}, body: body1);
      var res = await json.decode(response.body);
      String msg = res['status_message'].toString();
      if (msg == 'OTP Sent Successfully') {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'OTP Sent Successfully');
      } else {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Enter valid mobile number');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _setValue(id);
      _setValue1(verification);
      _setValue2(vendor_id);
      _setValue3(photo);
      _setValue4(mobile);
      _setValue5(name);
      _setValue6(email);
      verifyNumber();
    });
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.dstATop),
              image: AssetImage('images/car7.jpg'),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    height: 120,
                  ),
                  Column(
                    children: [
                      Column(
                        children: const [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Enter OTP',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              border:
                                  Border.all(color: Colors.black, width: 0.5)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              // color: Colors.black12,
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.width / 2.1,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: otp,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                                hintText: 'Enter OTP',
                                                hintStyle: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ButtonTheme(
                                      minWidth: 150.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          side: const BorderSide(
                                              color: Colors.black, width: 0.5)),
                                      child: MaterialButton(
                                        elevation: 5.0,
                                        hoverColor: Colors.green,
                                        color: Colors.black,
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onPressed: () {
                                          verifyNumber();
                                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_Page()));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              LoginApi();
                            },
                            child: const Text(
                              'Resend Otp : ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          Countdown(
                            seconds: 20,
                            build: (BuildContext context, double time) => Text(
                              time.toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            interval: Duration(seconds: 1),
                            onFinished: () {
                              // print('Timer is done!');
                              // Fluttertoast.showToast(msg: "Re-send OTP");
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
