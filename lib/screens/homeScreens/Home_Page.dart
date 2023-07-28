// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Drawer_Page/Drawer_page.dart';
import '../Profile_Verification_all_screen/Proflie_Verification_Page.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  var verification, pan_status, adhaar_status, bank_status;
  int? todayEarning;
  int? monthlyEarning;
  int? totalEarning;
  int? ongoing;
  int? end;
  int? cancelled;
  int? total;

  Future getTodayEarning() async {
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    String? vendor_id = pref2.getString('vendor_id');
    Map data = {
      'vendor_id': vendor_id.toString(),
    };
    print(data.toString() + "fbmkfhjgikhgki");
    Uri url = Uri.parse("https://bitacars.com/api/today_earning");
    var body1 = jsonEncode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "Application/json"}, body: body1);
    var res = await json.decode(response.body);

    setState(() {
      print("ihguydguyg====>>???" + res.toString());
      todayEarning = res["response"];
    });
  }

  Future getMonthlyEarning() async {
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    String? vendor_id = pref2.getString('vendor_id');
    Map data = {
      'vendor_id': vendor_id.toString(),
    };
    print(data.toString() + "fbmkfhjgikhgki");
    Uri url = Uri.parse("https://bitacars.com/api/monthly_earning");
    var body1 = jsonEncode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "Application/json"}, body: body1);
    var res = await json.decode(response.body);
    setState(() {
      print("ihguydguyg====>>???" + res.toString());
      monthlyEarning = res["response"];
    });
  }

  Future getTotalEarning() async {
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    String? vendor_id = pref2.getString('vendor_id');
    Map data = {
      'vendor_id': vendor_id.toString(),
    };
    print(data.toString() + "fbmkfhjgikhgki");
    Uri url = Uri.parse("https://bitacars.com/api/total_earning");
    var body1 = jsonEncode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "Application/json"}, body: body1);
    var res = await json.decode(response.body);
    setState(() {
      print("ihguydguyg====>>???" + res.toString());
      totalEarning = res["response"];
    });
  }

  Future CountBookingDetails() async {
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    String? vendor_id = pref2.getString('vendor_id');
    Map data = {
      'vendor_id': vendor_id.toString(),
    };
    print(data.toString() + "fbmkfhjgikhgki");
    Uri url = Uri.parse("https://bitacars.com/api/count_vehicle_booking");
    var body1 = jsonEncode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "Application/json"}, body: body1);
    var res = await json.decode(response.body);
    setState(() {
      print("ongoing====>>???" + ongoing.toString());
      ongoing = res["ongoing"];
      end = res["end"];
      cancelled = res["cancelled"];
      total = res["total"];
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getValue();
      _getValue1();
      getTodayEarning();
      getMonthlyEarning();
      getTotalEarning();
      CountBookingDetails();
      verification = verification;
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

  _getValue() async {
    final pref = await SharedPreferences.getInstance();
    String? get1 = pref.getString('verification');
    setState(() {
      verification = get1!;
      print("jcbgkgc dggeg fgcg===>>>----" + verification.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.5,
        title: Text(
          "Home",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer_page(),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width / 1,
                              height: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        child: PieChart(PieChartData(
                                            centerSpaceRadius: 35,
                                            //centerSpaceColor: Colors.white,
                                            //borderData: FlBorderData(show: false),
                                            sections: [
                                              pan_status == "2"
                                                  ? PieChartSectionData(
                                                      value: 33,
                                                      color: Colors.green)
                                                  : PieChartSectionData(
                                                      value: 33,
                                                      color: Colors.orange),
                                              bank_status == "2"
                                                  ? PieChartSectionData(
                                                      value: 33,
                                                      color: Colors.green)
                                                  : PieChartSectionData(
                                                      value: 33,
                                                      color: Colors.orange),
                                              adhaar_status == "2"
                                                  ? PieChartSectionData(
                                                      value: 34,
                                                      color: Colors.green)
                                                  : PieChartSectionData(
                                                      value: 34,
                                                      color: Colors.orange),
                                            ])),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Profile_Verification()));
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.4,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.red.shade500,
                                                  width: 2)),
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
                                                              color: Colors
                                                                  .yellow
                                                                  .shade900),
                                                        )
                                                      : verification == "1"
                                                          ? Text(
                                                              "Processing",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .greenAccent),
                                                            )
                                                          : verification == "2"
                                                              ? Text(
                                                                  "success",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green),
                                                                )
                                                              : verification ==
                                                                      "3"
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
                                                          color: Colors
                                                              .amberAccent
                                                              .shade200,
                                                        )
                                                      : verification == "1"
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .arrow_clockwise_circle_fill,
                                                              color: Colors
                                                                  .amberAccent
                                                                  .shade400,
                                                            )
                                                          : verification == "2"
                                                              ? Icon(
                                                                  CupertinoIcons
                                                                      .checkmark_circle_fill,
                                                                  color: Colors
                                                                      .green,
                                                                )
                                                              : verification ==
                                                                      "3"
                                                                  ? Icon(
                                                                      CupertinoIcons
                                                                          .nosign,
                                                                      color: Colors
                                                                          .red,
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
                      Card(
                        elevation: 10,
                        color: Colors.teal.shade300,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width / 1,
                              height: MediaQuery.of(context).size.width / 1.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                5.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.red.shade500,
                                                width: 2)),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Today Earning",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              todayEarning != null
                                                  ? Text(
                                                      "₹ " +
                                                          todayEarning
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Text(
                                                      "₹ 0",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                            ]),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                5.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.red.shade500,
                                                width: 2)),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Monthly Earning",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              monthlyEarning != null
                                                  ? Text(
                                                      "₹ " +
                                                          monthlyEarning
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Text(
                                                      "₹ 0",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                            ]),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.width / 5.5,
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.red.shade500,
                                            width: 2)),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total Earning",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          totalEarning != null
                                              ? Text(
                                                  "₹ " +
                                                      totalEarning.toString(),
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : Text(
                                                  "₹ 0",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                        ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 6.5,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width / 3.4,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.red, width: 1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Ongoing\n Booking",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green),
                                ),
                                ongoing != null
                                    ? Text(
                                        "₹ " + ongoing.toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green),
                                      )
                                    : Text(
                                        "₹ 0",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green),
                                      ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width / 3.4,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.red, width: 1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "End Booking",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green),
                                ),
                                end != null
                                    ? Text(
                                        "₹ " + end.toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green),
                                      )
                                    : Text(
                                        "₹ 0",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green),
                                      )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width / 3.4,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.red, width: 1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Cancelled \n booking",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red),
                                ),
                                cancelled != null
                                    ? Text(
                                        "₹ " + cancelled.toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red),
                                      )
                                    : Text(
                                        "₹ 0",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green),
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 3,
                        color: Colors.teal.shade500,
                      ),
                      Card(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height / 20,
                            width: MediaQuery.of(context).size.width,
                            child: total != null
                                ? Text(
                                    "Total Booking : " + total.toString(),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w900),
                                  )
                                : Text(
                                    "Total Booking : 0",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w900),
                                  )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
