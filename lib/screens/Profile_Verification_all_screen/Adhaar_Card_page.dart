// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, use_build_context_synchronously, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Proflie_Verification_Page.dart';

class Adhaar_Card extends StatefulWidget {
  const Adhaar_Card({Key? key}) : super(key: key);

  @override
  State<Adhaar_Card> createState() => _Adhaar_CardState();
}

class _Adhaar_CardState extends State<Adhaar_Card> {
  TextEditingController _Adhaar_No = TextEditingController();
  TextEditingController _Address = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File? frontAdhaarLicense;
  File? backAdhaarLicense;
  Future frontAdhaarLicense1(context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        frontAdhaarLicense = new File(pickedFile.path);
        print(frontAdhaarLicense!.path);
      });
    }
  }

  Future backAdhaarLicense2(context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        backAdhaarLicense = new File(pickedFile.path);
        print(backAdhaarLicense!.path);
      });
    }
  }

  Future Adhaar_Verification() async {
    if (formKey.currentState!.validate()) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? id = pref.getString('id');
      String driving1 = frontAdhaarLicense!.path.split('/').last;
      String driving2 = backAdhaarLicense!.path.split('/').last;
      var dio = Dio();
      var formData = FormData.fromMap({
        'id': id.toString(),
        'aadhar_front': await MultipartFile.fromFile(frontAdhaarLicense!.path,
            filename: driving1),
        'aadhar_back': await MultipartFile.fromFile(backAdhaarLicense!.path,
            filename: driving2),
        'aadhar_number': _Adhaar_No.text.toString(),
        'address': _Address.text.toString(),
      });
      var response = await dio
          .post('https://bitacars.com/api/aadhar_verification', data: formData);
      print(formData.toString() + "^^^^^^^^^^^^^^^^^^^");
      print("response ====>>>" + response.toString());
      var res = response.data;
      String msg = res['status_message'];
      print("bjhgbvfjhdfgbfu====>..." + msg);
      if (msg == 'Uploaded Successful') {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Verify Profile Successfully');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Profile_Verification()));
        setState(() {
          _Adhaar_No.clear();
          Navigator.pop(context);
        });
      } else {
        EasyLoading.dismiss();
      }
    }
  }

  var verification;
  _getValue() async {
    final pref = await SharedPreferences.getInstance();
    String? get1 = pref.getString('address_status');
    setState(() {
      verification = get1!;
      print("jcbgkgc dggeg fgcg===>>>----" + verification.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getValue();
      Adhaar_Verification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.5,
        title: Text(
          "Adhaar Card Upload",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: verification == "0"
                ? Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Adhaar front image     Adhaar back image",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    print('love');
                                    // frontDrivingLicense1(context, ImageSource.camera);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                              Text("Please upload the image"),
                                          actions: <Widget>[
                                            MaterialButton(
                                              child: Text("Camera"),
                                              onPressed: () {
                                                frontAdhaarLicense1(context,
                                                    ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            MaterialButton(
                                              child: Text("Gallery"),
                                              onPressed: () {
                                                frontAdhaarLicense1(context,
                                                    ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.green.shade400,
                                                width: 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: frontAdhaarLicense == null
                                            ? Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .add_circled,
                                                    ),
                                                    Text(
                                                      'Upload front picture of Adhaar Card',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Image.file(frontAdhaarLicense!,
                                                fit: BoxFit.fitWidth),
                                      ),
                                      Positioned(
                                          right: 5,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                frontAdhaarLicense = null;
                                              });
                                            },
                                            icon: Icon(Icons.highlight_remove),
                                          ))
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print('love');
                                    // frontDrivingLicense1(context, ImageSource.camera);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                              Text("Please upload the image"),
                                          actions: <Widget>[
                                            MaterialButton(
                                              child: Text("Camera"),
                                              onPressed: () {
                                                backAdhaarLicense2(context,
                                                    ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            MaterialButton(
                                              child: Text("Gallery"),
                                              onPressed: () {
                                                backAdhaarLicense2(context,
                                                    ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.green.shade400,
                                                width: 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: backAdhaarLicense == null
                                            ? Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .add_circled,
                                                    ),
                                                    Text(
                                                      'Upload back picture of Adhaar Card',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Image.file(backAdhaarLicense!,
                                                fit: BoxFit.fitWidth),
                                      ),
                                      Positioned(
                                          right: 5,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                backAdhaarLicense = null;
                                              });
                                            },
                                            icon: Icon(Icons.highlight_remove),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _Adhaar_No,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          fillColor: Colors.green.shade50,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 7),
                                          hintText: 'Enter Adhaar Number',
                                          hintStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black54),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green, width: 1),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green, width: 1),
                                          )),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter adhaar no.....';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _Address,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                          fillColor: Colors.green.shade50,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 7),
                                          hintText: 'Enter Address',
                                          hintStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black54),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green, width: 1),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green, width: 1),
                                          )),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter address.....';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: MaterialButton(
                                onPressed: () {
                                  Adhaar_Verification();
                                },
                                color: Colors.green,
                                child: Text(
                                  "Upload",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : verification == "1"
                    ? Card(
                        child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height / 3.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.amberAccent.shade400,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Icon(
                                CupertinoIcons.arrow_clockwise_circle_fill,
                                color: Colors.white,
                                size: 90,
                              ),
                              Text(
                                "Verification Processing",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    : verification == "2"
                        ? Card(
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height / 3.5,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.green,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Icon(
                                    CupertinoIcons.checkmark_circle_fill,
                                    color: Colors.white,
                                    size: 90,
                                  ),
                                  Text(
                                    "Verification Success",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : verification == "3"
                            ? Column(
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      children: [
                                        verification == "3"
                                            ? Card(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      5.5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Colors.red,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      Icon(
                                                        CupertinoIcons.nosign,
                                                        color: Colors.white,
                                                        size: 50,
                                                      ),
                                                      Text(
                                                        "Verification Rejected",
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "Documents Upload Again",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          "Adhaar front image     Adhaar back image",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                print('love');
                                                // frontDrivingLicense1(context, ImageSource.camera);
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Please upload the image"),
                                                      actions: <Widget>[
                                                        MaterialButton(
                                                          child: Text("Camera"),
                                                          onPressed: () {
                                                            frontAdhaarLicense1(
                                                                context,
                                                                ImageSource
                                                                    .camera);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        MaterialButton(
                                                          child:
                                                              Text("Gallery"),
                                                          onPressed: () {
                                                            frontAdhaarLicense1(
                                                                context,
                                                                ImageSource
                                                                    .gallery);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            4,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.2,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .green.shade400,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: frontAdhaarLicense ==
                                                            null
                                                        ? Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              // ignore: prefer_const_literals_to_create_immutables
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .add_circled,
                                                                ),
                                                                Text(
                                                                  'Upload front picture of Adhaar Card',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : Image.file(
                                                            frontAdhaarLicense!,
                                                            fit: BoxFit
                                                                .fitWidth),
                                                  ),
                                                  Positioned(
                                                      right: 5,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            frontAdhaarLicense =
                                                                null;
                                                          });
                                                        },
                                                        icon: Icon(Icons
                                                            .highlight_remove),
                                                      ))
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                print('love');
                                                // frontDrivingLicense1(context, ImageSource.camera);
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Please upload the image"),
                                                      actions: <Widget>[
                                                        MaterialButton(
                                                          child: Text("Camera"),
                                                          onPressed: () {
                                                            backAdhaarLicense2(
                                                                context,
                                                                ImageSource
                                                                    .camera);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        MaterialButton(
                                                          child:
                                                              Text("Gallery"),
                                                          onPressed: () {
                                                            backAdhaarLicense2(
                                                                context,
                                                                ImageSource
                                                                    .gallery);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            4,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.2,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .green.shade400,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: backAdhaarLicense ==
                                                            null
                                                        ? Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              // ignore: prefer_const_literals_to_create_immutables
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .add_circled,
                                                                ),
                                                                Text(
                                                                  'Upload back picture of Adhaar Card',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : Image.file(
                                                            backAdhaarLicense!,
                                                            fit: BoxFit
                                                                .fitWidth),
                                                  ),
                                                  Positioned(
                                                      right: 5,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            backAdhaarLicense =
                                                                null;
                                                          });
                                                        },
                                                        icon: Icon(Icons
                                                            .highlight_remove),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Form(
                                            key: formKey,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  controller: _Adhaar_No,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      fillColor:
                                                          Colors.green.shade50,
                                                      filled: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 7),
                                                      hintText:
                                                          'Enter Adhaar Number',
                                                      hintStyle: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black54),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.green,
                                                            width: 1),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.green,
                                                            width: 1),
                                                      )),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter adhaar no.....';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  controller: _Address,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                      fillColor:
                                                          Colors.green.shade50,
                                                      filled: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 7),
                                                      hintText: 'Enter Address',
                                                      hintStyle: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black54),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.green,
                                                            width: 1),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.green,
                                                            width: 1),
                                                      )),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter address.....';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 45,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Adhaar_Verification();
                                            },
                                            color: Colors.green,
                                            child: Text(
                                              "Upload",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          "Adhaar front image     Adhaar back image",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                print('love');
                                                // frontDrivingLicense1(context, ImageSource.camera);
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Please upload the image"),
                                                      actions: <Widget>[
                                                        MaterialButton(
                                                          child: Text("Camera"),
                                                          onPressed: () {
                                                            frontAdhaarLicense1(
                                                                context,
                                                                ImageSource
                                                                    .camera);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        MaterialButton(
                                                          child:
                                                              Text("Gallery"),
                                                          onPressed: () {
                                                            frontAdhaarLicense1(
                                                                context,
                                                                ImageSource
                                                                    .gallery);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            4,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.2,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .green.shade400,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: frontAdhaarLicense ==
                                                            null
                                                        ? Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              // ignore: prefer_const_literals_to_create_immutables
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .add_circled,
                                                                ),
                                                                Text(
                                                                  'Upload front picture of Adhaar Card',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : Image.file(
                                                            frontAdhaarLicense!,
                                                            fit: BoxFit
                                                                .fitWidth),
                                                  ),
                                                  Positioned(
                                                      right: 5,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            frontAdhaarLicense =
                                                                null;
                                                          });
                                                        },
                                                        icon: Icon(Icons
                                                            .highlight_remove),
                                                      ))
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                print('love');
                                                // frontDrivingLicense1(context, ImageSource.camera);
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Please upload the image"),
                                                      actions: <Widget>[
                                                        MaterialButton(
                                                          child: Text("Camera"),
                                                          onPressed: () {
                                                            backAdhaarLicense2(
                                                                context,
                                                                ImageSource
                                                                    .camera);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        MaterialButton(
                                                          child:
                                                              Text("Gallery"),
                                                          onPressed: () {
                                                            backAdhaarLicense2(
                                                                context,
                                                                ImageSource
                                                                    .gallery);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            4,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.2,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .green.shade400,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: backAdhaarLicense ==
                                                            null
                                                        ? Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              // ignore: prefer_const_literals_to_create_immutables
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .add_circled,
                                                                ),
                                                                Text(
                                                                  'Upload back picture of Adhaar Card',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : Image.file(
                                                            backAdhaarLicense!,
                                                            fit: BoxFit
                                                                .fitWidth),
                                                  ),
                                                  Positioned(
                                                      right: 5,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            backAdhaarLicense =
                                                                null;
                                                          });
                                                        },
                                                        icon: Icon(Icons
                                                            .highlight_remove),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Form(
                                            key: formKey,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  controller: _Adhaar_No,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      fillColor:
                                                          Colors.green.shade50,
                                                      filled: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 7),
                                                      hintText:
                                                          'Enter Adhaar Number',
                                                      hintStyle: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black54),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.green,
                                                            width: 1),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.green,
                                                            width: 1),
                                                      )),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter adhaar no.....';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  controller: _Address,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                      fillColor:
                                                          Colors.green.shade50,
                                                      filled: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 7),
                                                      hintText: 'Enter Address',
                                                      hintStyle: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black54),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.green,
                                                            width: 1),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.green,
                                                            width: 1),
                                                      )),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter address.....';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 45,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Adhaar_Verification();
                                            },
                                            color: Colors.green,
                                            child: Text(
                                              "Upload",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
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
}
