// ignore_for_file: file_names, camel_case_types, prefer_final_fields, non_constant_identifier_names, prefer_interpolation_to_compose_strings, use_build_context_synchronously, prefer_const_constructors

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Proflie_Verification_Page.dart';

class Bank_Detail extends StatefulWidget {
  const Bank_Detail({Key? key}) : super(key: key);

  @override
  State<Bank_Detail> createState() => _Bank_DetailState();
}

class _Bank_DetailState extends State<Bank_Detail> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _Acc_No = TextEditingController();
  TextEditingController _User_name = TextEditingController();
  TextEditingController _Bank_name = TextEditingController();
  TextEditingController _Bank_branch = TextEditingController();
  TextEditingController _IFSC_code = TextEditingController();

  final picker = ImagePicker();
  File? uploadPhoto;
  Future uploadPhoto1(context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        uploadPhoto = new File(pickedFile.path);
        print(uploadPhoto!.path);
      });
    }
  }

  Future Bank_Verification() async {
    if (formKey.currentState!.validate()) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? id = pref.getString('id');
      String driving1 = uploadPhoto!.path.split('/').last;
      var dio = Dio();
      var formData = FormData.fromMap({
        'id': id.toString(),
        'passbook':
            await MultipartFile.fromFile(uploadPhoto!.path, filename: driving1),
        'account_num': _Acc_No.text.toString(),
        'ifsc': _IFSC_code.text.toString(),
        'acholder_name': _User_name.text.toString(),
        'bank': _Bank_name.text.toString(),
        'branch': _Bank_branch.text.toString()
      });
      var response = await dio
          .post('https://bitacars.com/api/bank_verification', data: formData);
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
          _Acc_No.clear();
          _Bank_branch.clear();
          _Bank_name.clear();
          _User_name.clear();
          _IFSC_code.clear();
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
    String? get1 = pref.getString('bank_status');
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
      Bank_Verification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.5,
        title: Text(
          "Bank Detail Upload",
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
                        child: Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Icon(Icons.account_balance,size: 90,),
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
                                                uploadPhoto1(context,
                                                    ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            MaterialButton(
                                              child: Text("Gallery"),
                                              onPressed: () {
                                                uploadPhoto1(context,
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
                                                4.2,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.green.shade400,
                                                width: 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: uploadPhoto == null
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
                                                      'Upload your PassBook Photo',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Image.file(uploadPhoto!,
                                                fit: BoxFit.fitWidth),
                                      ),
                                      Positioned(
                                          right: 5,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                uploadPhoto = null;
                                              });
                                            },
                                            icon: Icon(Icons.highlight_remove),
                                          ))
                                    ],
                                  ),
                                ),
                                Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: _Acc_No,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              fillColor: Colors.green.shade50,
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 7),
                                              hintText: 'Bank Acc. Number',
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 1),
                                              )),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter Acc. no.....';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: _User_name,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              fillColor: Colors.green.shade50,
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 7),
                                              hintText: 'Enter User Name',
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 1),
                                              )),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter  User Name.....';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: _Bank_name,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              fillColor: Colors.green.shade50,
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 7),
                                              hintText: 'Bank Name',
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 1),
                                              )),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter bank name.....';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: _Bank_branch,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              fillColor: Colors.green.shade50,
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 7),
                                              hintText: 'Bank Branch',
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 1),
                                              )),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter branch.....';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: _IFSC_code,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              fillColor: Colors.green.shade50,
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 7),
                                              hintText: 'Bank IFSC Code',
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 1),
                                              )),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter IFSC code.....';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 25,
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
                                              Bank_Verification();
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
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Text(
                                  "Guide Lines ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "1." +
                                      " Account number should be clearly visible.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "2." +
                                      " We need your account number/UPI id for refund your security money.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
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
                                  verification == "3"
                                      ? Card(
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Colors.red,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Documents Upload Again",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Container(
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            //Icon(Icons.account_balance,size: 90,),
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
                                                            uploadPhoto1(
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
                                                            uploadPhoto1(
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
                                                            4.2,
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
                                                    child: uploadPhoto == null
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
                                                                  'Upload your PassBook Photo',
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
                                                            uploadPhoto!,
                                                            fit: BoxFit
                                                                .fitWidth),
                                                  ),
                                                  Positioned(
                                                      right: 5,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            uploadPhoto = null;
                                                          });
                                                        },
                                                        icon: Icon(Icons
                                                            .highlight_remove),
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Form(
                                                key: formKey,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextFormField(
                                                      controller: _Acc_No,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor: Colors
                                                                  .green
                                                                  .shade50,
                                                              filled: true,
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          7),
                                                              hintText:
                                                                  'Bank Acc. Number',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black54),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              )),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter Acc. no.....';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller: _User_name,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor: Colors
                                                                  .green
                                                                  .shade50,
                                                              filled: true,
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          7),
                                                              hintText:
                                                                  'Enter User Name',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black54),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              )),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter User Name.....';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller: _Bank_name,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor: Colors
                                                                  .green
                                                                  .shade50,
                                                              filled: true,
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          7),
                                                              hintText:
                                                                  'Bank Name',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black54),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              )),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter bank name.....';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller: _Bank_branch,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor: Colors
                                                                  .green
                                                                  .shade50,
                                                              filled: true,
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          7),
                                                              hintText:
                                                                  'Bank Branch',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black54),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              )),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter branch.....';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller: _IFSC_code,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor: Colors
                                                                  .green
                                                                  .shade50,
                                                              filled: true,
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          7),
                                                              hintText:
                                                                  'Bank IFSC Code',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black54),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              )),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter IFSC code.....';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Container(
                                                      height: 45,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: MaterialButton(
                                                        onPressed: () {
                                                          Bank_Verification();
                                                        },
                                                        color: Colors.green,
                                                        child: Text(
                                                          "Upload",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Text(
                                              "Guide Lines ",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "1." +
                                                  " Account number should be clearly visible.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "2." +
                                                  " We need your account number/UPI id for refund your security money.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Column(
                                children: <Widget>[
                                  Container(
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            //Icon(Icons.account_balance,size: 90,),
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
                                                            uploadPhoto1(
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
                                                            uploadPhoto1(
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
                                                            4.2,
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
                                                    child: uploadPhoto == null
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
                                                                  'Upload your PassBook Photo',
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
                                                            uploadPhoto!,
                                                            fit: BoxFit
                                                                .fitWidth),
                                                  ),
                                                  Positioned(
                                                      right: 5,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            uploadPhoto = null;
                                                          });
                                                        },
                                                        icon: Icon(Icons
                                                            .highlight_remove),
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Form(
                                                key: formKey,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextFormField(
                                                      controller: _Acc_No,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor: Colors
                                                                  .green
                                                                  .shade50,
                                                              filled: true,
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          7),
                                                              hintText:
                                                                  'Bank Acc. Number',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black54),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              )),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter Acc. no.....';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller: _User_name,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor: Colors
                                                                  .green
                                                                  .shade50,
                                                              filled: true,
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          7),
                                                              hintText:
                                                                  'Enter User Name',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black54),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              )),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter  User Name.....';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller: _Bank_name,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor: Colors
                                                                  .green
                                                                  .shade50,
                                                              filled: true,
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          7),
                                                              hintText:
                                                                  'Bank Name',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black54),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              )),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter bank name.....';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller: _Bank_branch,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor: Colors
                                                                  .green
                                                                  .shade50,
                                                              filled: true,
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          7),
                                                              hintText:
                                                                  'Bank Branch',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black54),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              )),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter branch.....';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller: _IFSC_code,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor: Colors
                                                                  .green
                                                                  .shade50,
                                                              filled: true,
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          7),
                                                              hintText:
                                                                  'Bank IFSC Code',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black54),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 1),
                                                              )),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter IFSC code.....';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Container(
                                                      height: 45,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: MaterialButton(
                                                        onPressed: () {
                                                          Bank_Verification();
                                                        },
                                                        color: Colors.green,
                                                        child: Text(
                                                          "Upload",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Text(
                                              "Guide Lines ",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "1." +
                                                  " Account number should be clearly visible.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "2." +
                                                  " We need your account number/UPI id for refund your security money.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
          ),
        ),
      ),
    );
  }
}
