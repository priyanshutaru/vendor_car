// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Drawer_Page/Drawer_page.dart';
import 'Adhaar_Card_page.dart';
import 'Bank_Detail_page.dart';
import 'DL_PAN_Upload_page.dart';
import 'Live_photo_page.dart';

class Profile_Verification extends StatefulWidget {
  const Profile_Verification({Key? key}) : super(key: key);

  @override
  State<Profile_Verification> createState() => _Profile_VerificationState();
}

class _Profile_VerificationState extends State<Profile_Verification> {
  var verification, pan_status, adhaar_status, bank_status;
  _getValue() async {
    final pref = await SharedPreferences.getInstance();
    String? get1 = pref.getString('verification');
    setState(() {
      verification = get1!;
      print("jcbgkgc dggeg fgcg===>>>----" + verification.toString());
    });
  }

  _getValue1() async {
    final pref3 = await SharedPreferences.getInstance();
    String? get2 = pref3.getString('status_id');
    final pref5 = await SharedPreferences.getInstance();
    String? get5 = pref5.getString('address_status');
    final pref6 = await SharedPreferences.getInstance();
    String? get6 = pref6.getString('bank_status');
    setState(() {
      pan_status = get2!;
      adhaar_status = get5;
      bank_status = get6;
      print("jcbgkgc pan_status===>>>----" + pan_status.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getValue();
      _getValue1();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.5,
        title: Text(
          "Profile Verification",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer_page(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width / 1,
                      height: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.width / 3,
                                width: MediaQuery.of(context).size.width / 2.7,
                                child: PieChart(PieChartData(
                                    centerSpaceRadius: 35,
                                    centerSpaceColor: Colors.white,
                                    borderData: FlBorderData(show: false),
                                    sections: [
                                      pan_status == "2"
                                          ? PieChartSectionData(
                                              value: 33, color: Colors.green)
                                          : PieChartSectionData(
                                              value: 33, color: Colors.orange),
                                      bank_status == "2"
                                          ? PieChartSectionData(
                                              value: 33, color: Colors.green)
                                          : PieChartSectionData(
                                              value: 33, color: Colors.orange),
                                      adhaar_status == "2"
                                          ? PieChartSectionData(
                                              value: 34, color: Colors.green)
                                          : PieChartSectionData(
                                              value: 34, color: Colors.orange),
                                    ])),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.width / 3.4,
                                width: MediaQuery.of(context).size.width / 2.5,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.green, width: 2)),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.badge,
                                      size: 35,
                                    ),
                                    Text("View Profile"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        verification == "0"
                                            ? Text(
                                                "Pending",
                                                style: TextStyle(
                                                    color:
                                                        Colors.yellow.shade900),
                                              )
                                            : verification == "1"
                                                ? Text(
                                                    "Processing",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.greenAccent),
                                                  )
                                                : verification == "2"
                                                    ? Text(
                                                        "success",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )
                                                    : verification == "3"
                                                        ? Text(
                                                            "Rejected",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          )
                                                        : Text(
                                                            "Pending",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .yellow
                                                                    .shade900),
                                                          ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        verification == "0"
                                            ? Icon(
                                                CupertinoIcons
                                                    .exclamationmark_triangle_fill,
                                                color:
                                                    Colors.amberAccent.shade200,
                                              )
                                            : verification == "1"
                                                ? Icon(
                                                    CupertinoIcons
                                                        .arrow_clockwise_circle_fill,
                                                    color: Colors
                                                        .amberAccent.shade400,
                                                  )
                                                : verification == "2"
                                                    ? Icon(
                                                        CupertinoIcons
                                                            .checkmark_circle_fill,
                                                        color: Colors.green,
                                                      )
                                                    : verification == "3"
                                                        ? Icon(
                                                            CupertinoIcons
                                                                .nosign,
                                                            color: Colors.red,
                                                          )
                                                        : Icon(
                                                            CupertinoIcons
                                                                .exclamationmark_triangle_fill,
                                                            color: Colors
                                                                .amberAccent
                                                                .shade200,
                                                          )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                  child: ListTile(
                    leading: Icon(
                      Icons.credit_card_outlined,
                      size: 35,
                      color: Colors.green,
                    ),
                    title: Text(
                      "PAN Card(ID proof)",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dl_Pan_page()));
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 3.35,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                Text(
                                  "UPLOAD",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.addressCard,
                      size: 30,
                      color: Colors.green,
                    ),
                    title: Text(
                      "Adhaar/VoterId Card(Address proof)",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Adhaar_Card()));
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 3.35,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                Text(
                                  "UPLOAD",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_balance,
                      size: 35,
                      color: Colors.green,
                    ),
                    title: Text(
                      "Bank detail(Passbook photo)",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Bank_Detail()));
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 3.35,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                Text(
                                  "UPLOAD",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.grinAlt,
                      size: 35,
                      color: Colors.green,
                    ),
                    title: Text(
                      "Live Photo",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Live_photo()));
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 3.35,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                Text(
                                  "UPLOAD",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "Why do I need to verify my profile?",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your Profile verification allows the Bita Car Rental community to share cars and bicks seamlessly",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black54),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
