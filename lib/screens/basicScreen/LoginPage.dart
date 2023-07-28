// ignore_for_file: prefer_final_fields, use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vendor/screens/basicScreen/partner_reg.dart';
import 'Otp_Page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _mobileNumber = TextEditingController();
  bool isChecked = false;
  bool visible = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.lightGreen;
  }

  Future LoginApi() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Loading');
      Map data = {
        'mobile': _mobileNumber.text.toString(),
      };
      Uri url = Uri.parse("https://bitacars.com/api/send_votp");
      var body1 = jsonEncode(data);
      var response = await http.post(url,
          headers: {"Content-Type": "Application/json"}, body: body1);

      var res = await json.decode(response.body);
      String msg = res['status_message'].toString();
      if (msg == 'OTP Sent Successfully') {
        EasyLoading.dismiss();
        //Fluttertoast.showToast(msg: 'OTP Sent Successfully');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginOtpScreen(
                      mobile: _mobileNumber.text.toString(),
                    )));
      } else {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Enter valid mobile number');
      }
    }
  }

  @override
  void initState() {
    visible = false;
    super.initState();
    LoginApi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.dstATop),
              image: AssetImage('images/car5.jpg'),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Column(
                    children: [
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Text(
                            'Login Now',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Welcome Partner',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.green,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
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
                                    Visibility(
                                      visible: visible ? false : true,
                                      child: Form(
                                        key: formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (val) {
                                                return val!.length == 10
                                                    ? null
                                                    : "Please enter 10 digit mobile Number";
                                              },
                                              controller: _mobileNumber,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    10),
                                              ],
                                              style: TextStyle(
                                                  color: Colors.black),
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      'Enter your mobile number',
                                                  hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ButtonTheme(
                                      minWidth: 150.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: const BorderSide(
                                              color: Colors.white, width: 1)),
                                      child: MaterialButton(
                                        elevation: 5.0,
                                        hoverColor: Colors.green,
                                        color: Colors.black,
                                        child: const Text(
                                          "Verify",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onPressed: () {
                                          LoginApi();
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginOtpScreen(
                                          //   mobile: _mobileNumber.text.toString(),
                                          // )));
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
                        height: 15,
                      ),
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                                'By login i agree with Terms and Conditions',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 20.0),
                                child: const Divider(
                                  thickness: 1,
                                  color: Colors.white,
                                  indent: 30,
                                  height: 36,
                                )),
                          ),
                          const Text(
                            "OR",
                            style: TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    left: 20.0, right: 10.0),
                                child: const Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                    height: 36,
                                    endIndent: 30)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WelcomeRegistration()));
                          },
                          child: const Text(
                            "Create Partner Account",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // TextButton(
                        //   onPressed: (){
                        //     //Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                        //   }, child: const Text(
                        //   "Register here",
                        //   style: TextStyle(
                        //       fontSize: 14,
                        //       color: Colors.blue,
                        //       fontWeight: FontWeight.bold),
                        // ),)
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
