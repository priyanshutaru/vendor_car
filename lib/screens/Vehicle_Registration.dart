// ignore_for_file: unnecessary_import, camel_case_types, prefer_final_fields, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Drawer_Page/Drawer_page.dart';

class Vehicle_Registration extends StatefulWidget {
  const Vehicle_Registration({Key? key}) : super(key: key);

  @override
  State<Vehicle_Registration> createState() => _Vehicle_RegistrationState();
}

class _Vehicle_RegistrationState extends State<Vehicle_Registration> {
  final formKey = GlobalKey<FormState>();
  String dropdownValue = "--Select type of Vehicle--";
  //String dropdownValue2="--Select Vehicle Model--";
  TextEditingController _vehicleNo = TextEditingController();
  TextEditingController _vehicleName = TextEditingController();
  TextEditingController _modelNo = TextEditingController();
  List segmentItemlist = [];
  Future getsegment() async {
    var baseUrl = "https://bitacars.com/api/get_segment/$dropdownValue";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)["response_userRegister"];
      setState(() {
        segmentItemlist = jsonData;
        print("@@@@@@@@@@@@@@@@===>>>>>>" + segmentItemlist.toString());
      });
    }
  }

  var dropdownvalue;
  Future vehicle_Regs() async {
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    String? vendor_id = pref2.getString('vendor_id');
    var dio = Dio();
    var formData = FormData.fromMap({
      'vendor_id': vendor_id.toString(),
      'vehicle_no': _vehicleNo.text.toString(),
      'model_no': _modelNo.text.toString(),
      'vehicle_type': dropdownValue.toString(),
      'segment': dropdownvalue.toString(),
      'vehicle_name': _vehicleName.text.toString(),
    });
    var response = await dio.post(
        'https://bitacars.com/api/new_vehicle_registration',
        data: formData);
    var res = response.data;
    String msg = res['status_message'];
    print("bjhgbvfjhdfgbfu====>..." + msg);
    if (msg == 'Registration Successful') {
      Fluttertoast.showToast(
          msg: 'Registration Successful',
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green);
      setState(() {
        _vehicleName.clear();
        _vehicleNo.clear();
        _modelNo.clear();
        Navigator.pop(context);
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getsegment();
      vehicle_Regs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.5,
        // ignore: prefer_const_constructors
        title: Text(
          "Vehicle Registration",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer_page(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: _vehicleName,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 7),
                                hintText: 'Vehicle Name',
                                hintStyle: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 1),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter vehicle name.....';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _vehicleNo,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 7),
                                hintText: 'Vehicle Number',
                                hintStyle: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 1),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter vehicle no.....';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _modelNo,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 7),
                                hintText: 'Model Number',
                                hintStyle: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 1),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter model no.....';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 47,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.green),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: Padding(
                                  padding: EdgeInsets.only(left: 60.0),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                elevation: 16,
                                style: TextStyle(color: Colors.black),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                    getsegment();
                                    print(
                                        "Vehicle value+===>>" + dropdownValue);
                                  });
                                },
                                items: <String>[
                                  '--Select type of Vehicle--',
                                  'car',
                                  'bike'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 47,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.green),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text(
                                  '-- Select Segment --',
                                  style: TextStyle(color: Colors.black),
                                ),
                                items: segmentItemlist.map((item) {
                                  return DropdownMenuItem(
                                    value: item['id'].toString(),
                                    child:
                                        Text(item['vsub_sub_type'].toString()),
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    dropdownvalue = newVal;
                                    print("Value=======>>>>>" +
                                        dropdownvalue.toString());
                                  });
                                },
                                value: dropdownvalue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              vehicle_Regs();
                            } else {}
                          },
                          color: Colors.green,
                          child: Text(
                            "Submit",
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
