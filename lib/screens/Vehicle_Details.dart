// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Drawer_Page/Drawer_page.dart';
import 'Model/Booking_Details_model.dart';

class vehicle_details_page extends StatefulWidget {
  const vehicle_details_page({Key? key}) : super(key: key);

  @override
  State<vehicle_details_page> createState() => _vehicle_details_pageState();
}

class _vehicle_details_pageState extends State<vehicle_details_page> {
  var status1 = "Online";
  Future<List<Response>> getBookingDetails() async {
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    String? vendor_id = pref2.getString('vendor_id');
    Map data = {
      'vendor_id': vendor_id.toString(),
      //'vendor_id' : "VEND0925",
    };
    Uri url = Uri.parse("https://bitacars.com/api/get_vehicle_details");
    var body1 = jsonEncode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body1);
    if (response.statusCode == 200) {
      //var jsonData = json.decode(response.body)["response"];
      List data = json.decode(response.body)["response"];
      /* booking_id=data[0]['booking_id'];
       print("slot data====>>>>>"+booking_id);*/
      return data.map((data) => Response.fromJson(data)).toList();
    } else {
      throw Exception('unexpected error occurred');
    }
  }

  var path;
  @override
  void initState() {
    super.initState();
    getBookingDetails();
    setState(() {
      path = "https://bitacars.com/public/uploads/";
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
          "Vehicle Details",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer_page(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<List<Response>>(
              future: getBookingDetails(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  List<Response>? data = snapshot.data;
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      path.toString() +
                                                  data[index]
                                                      .vehicleImage
                                                      // ignore: unnecessary_null_comparison
                                                      .toString() ==
                                              null
                                          ? Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  7.3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.7,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(7)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "images/car7.jpg"),
                                                      fit: BoxFit.fill)),
                                            )
                                          : Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  7.3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.7,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(7)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          path.toString() +
                                                              data[index]
                                                                  .vehicleImage
                                                                  .toString()),
                                                      fit: BoxFit.fill)),
                                            ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(data[index]
                                                .vehicleNo
                                                .toString()),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Text(data[index]
                                                  .modelNo
                                                  .toString()),
                                            ),
                                            Text("Ac :" +
                                                data[index].ac.toString() +
                                                "  " +
                                                data[index]
                                                    .fuelType
                                                    .toString()),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      path + data[index].rcImage.toString() ==
                                              null
                                          ? Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  9.3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.8,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(7)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black45),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "images/car5.jpg"),
                                                      fit: BoxFit.fill)),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                showGeneralDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  transitionDuration: Duration(
                                                      milliseconds: 500),
                                                  transitionBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) {
                                                    return FadeTransition(
                                                      opacity: animation,
                                                      child: ScaleTransition(
                                                        scale: animation,
                                                        child: child,
                                                      ),
                                                    );
                                                  },
                                                  pageBuilder: (context,
                                                      animation,
                                                      secondaryAnimation) {
                                                    return Scaffold(
                                                      appBar: AppBar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        foregroundColor:
                                                            Colors.black,
                                                      ),
                                                      body: SafeArea(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            color: Colors.white,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                path.toString() +
                                                                            // ignore: unnecessary_null_comparison
                                                                            data[index].rcImage.toString() ==
                                                                        null
                                                                    ? Container(
                                                                        height:
                                                                            MediaQuery.of(context).size.height /
                                                                                3,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                                image: DecorationImage(
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          image:
                                                                              AssetImage("images/backCar.jpg"),
                                                                        )),
                                                                      )
                                                                    : Container(
                                                                        height: MediaQuery.of(context).size.height /
                                                                            2.5,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                                image: DecorationImage(
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          image:
                                                                              NetworkImage(path.toString() + data[index].rcImage.toString()),
                                                                        )),
                                                                      )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    9.3,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3.8,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(7)),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black45),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            path +
                                                                data[index]
                                                                    .rcImage
                                                                    .toString()),
                                                        fit: BoxFit.fill)),
                                              ),
                                            ),
                                      Spacer(),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Booking Status"),
                                                  Spacer(),
                                                  data[index]
                                                              .status
                                                              .toString() ==
                                                          "0"
                                                      ? Text(
                                                          "Pending",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .yellowAccent
                                                                  .shade700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      : data[index]
                                                                  .status
                                                                  .toString() ==
                                                              "1"
                                                          ? Text(
                                                              "Booked",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : data[index]
                                                                      .status
                                                                      .toString() ==
                                                                  "2"
                                                              ? Text(
                                                                  "On Going",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .yellow,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              : data[index]
                                                                          .status
                                                                          .toString() ==
                                                                      "3"
                                                                  ? Text(
                                                                      "End Ride ",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Colors
                                                                              .red,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  : Text(
                                                                      "Cancelled",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Colors
                                                                              .red,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    Text("Booking ID"),
                                                    Spacer(),
                                                    Text(data[index]
                                                            .id
                                                            .toString() +
                                                        "AG"),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text("Vehicle Color"),
                                                  Spacer(),
                                                  Text(data[index]
                                                      .colour
                                                      .toString()),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Driver Seats"),
                                      Text(data[index].driver.toString()),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Vehicle Status"),
                                      Spacer(),
                                      data[index].vehicleStatus.toString() ==
                                              "Online"
                                          ? Text(
                                              data[index]
                                                  .vehicleStatus
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: Colors.green),
                                            )
                                          : Text(
                                              data[index]
                                                  .vehicleStatus
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 25,
                                        width: 60,
                                        child: Switch(
                                          value: data[index]
                                                  .vehicleStatus
                                                  .toString() ==
                                              "Online",
                                          activeColor: Colors.green,
                                          onChanged: (bool value) {
                                            setState(() {
                                              data[index]
                                                      .vehicleStatus
                                                      .toString() ==
                                                  value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Add Date And Time"),
                                      Row(
                                        children: [
                                          Text(
                                              data[index].createdAt.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Row(
                                //   children: [
                                //     TextButton(onPressed: () {},
                                //       child: Text("Edit Vehicles Detail", style: TextStyle(
                                //           fontSize: 15,
                                //           fontWeight: FontWeight.w700,
                                //           color: Colors.red),),)
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
        ),
      ),
    );
  }
}
