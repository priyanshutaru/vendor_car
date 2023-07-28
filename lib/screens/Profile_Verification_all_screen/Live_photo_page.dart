// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_interpolation_to_compose_strings, use_build_context_synchronously, prefer_const_constructors

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Proflie_Verification_Page.dart';

class Live_photo extends StatefulWidget {
  const Live_photo({Key? key}) : super(key: key);

  @override
  State<Live_photo> createState() => _Live_photoState();
}

class _Live_photoState extends State<Live_photo> {
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

  Future Photo_Verification() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString('id');
    String driving1 = uploadPhoto!.path.split('/').last;
    var dio = Dio();
    var formData = FormData.fromMap({
      'id': id.toString(),
      'photo':
          await MultipartFile.fromFile(uploadPhoto!.path, filename: driving1),
    });
    var response = await dio.post(
        'https://bitacars.com/api/livephoto_verification',
        data: formData);
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
        Navigator.pop(context);
      });
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    Photo_Verification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.5,
        title: Text(
          "Live Photo Upload",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 5,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "Upload Your Photo",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        InkWell(
                          onTap: () {
                            print('love');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Please upload the image"),
                                  actions: <Widget>[
                                    MaterialButton(
                                      child: Text("Camera"),
                                      onPressed: () {
                                        uploadPhoto1(
                                            context, ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    MaterialButton(
                                      child: Text("Gallery"),
                                      onPressed: () {
                                        uploadPhoto1(
                                            context, ImageSource.gallery);
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
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width / 2.2,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green.shade400, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: uploadPhoto == null
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Icon(
                                              CupertinoIcons.add_circled,
                                            ),
                                            Text(
                                              'Upload your photo',
                                              textAlign: TextAlign.center,
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
                              Photo_Verification();
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
