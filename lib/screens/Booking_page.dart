// ignore_for_file: camel_case_types, prefer_interpolation_to_compose_strings, avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Drawer_Page/Drawer_page.dart';
import 'Model/Vender_booking_model.dart';

class Bookings_page extends StatefulWidget {
  const Bookings_page({Key? key}) : super(key: key);

  @override
  State<Bookings_page> createState() => _Bookings_pageState();
}

class _Bookings_pageState extends State<Bookings_page> {
  bool isSwitched = true;
  bool off = false;
  Future<List<Response>> getMyvenBooking() async {
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    String? vendor_id = pref2.getString('vendor_id');
    Map data = {
      'vendor_id': vendor_id.toString(),
      //'vendor_id' : "VEND0925",
    };
    Uri url = Uri.parse("https://bitacars.com/api/your_booking");
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

  Future getBookingStatus() async {
    Map data = {
      'booking_id': "34",
    };
    print(data.toString() + "fbmkfhjgikhgki");
    Uri url = Uri.parse("https://bitacars.com/api/booking_status");
    var body1 = jsonEncode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "Application/json"}, body: body1);
    var res = await json.decode(response.body);
    setState(() {
      print("ihguydguyg====>>???" + res.toString());
      rent = res["rent"];
      tax = res["tax"];
      plateform_charge = res["plateform_charge"];
      income = res["income"];
    });
  }

  String? path;
  var booking_id;
  int? rent;
  double? tax, plateform_charge, income;

  @override
  void initState() {
    super.initState();
    getMyvenBooking();
    setState(() {
      getBookingStatus();
      path = "https://onway.creditmywallet.in.net/public/uploads/";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.5,
        title: Text(
          "Bookings",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer_page(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<List<Response>>(
              future: getMyvenBooking(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  List<Response>? data = snapshot.data;
                  return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            path.toString() +
                                                        (data[index]
                                                            .vehicleImage
                                                            // ignore: unnecessary_null_comparison
                                                            .toString()) ==
                                                    null
                                                ? Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            7.3,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.7,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black87,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8)),
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: AssetImage(
                                                              "images/car7.jpg"),
                                                        )),
                                                  )
                                                : Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            7.3,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.7,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black87,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8)),
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(path
                                                                  .toString() +
                                                              data[index]
                                                                  .vehicleImage
                                                                  .toString()),
                                                        )),
                                                  ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Pick Date",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  data[index]
                                                          .pickupDate
                                                          .toString() +
                                                      " " +
                                                      data[index]
                                                          .pickupTime
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  "Drop Date",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  data[index]
                                                          .dropDate
                                                          .toString() +
                                                      " " +
                                                      data[index]
                                                          .dropTime
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  "Booking Status",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "Order Id",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showGeneralDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      transitionDuration:
                                                          Duration(
                                                              milliseconds:
                                                                  500),
                                                      transitionBuilder:
                                                          (context,
                                                              animation,
                                                              secondaryAnimation,
                                                              child) {
                                                        return FadeTransition(
                                                          opacity: animation,
                                                          child:
                                                              ScaleTransition(
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
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                color: Colors
                                                                    .white,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    path.toString() +
                                                                                // ignore: unnecessary_null_comparison
                                                                                data[index].startingMeter.toString() ==
                                                                            null
                                                                        ? Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 3,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                              fit: BoxFit.fill,
                                                                              image: AssetImage("images/backCar.jpg"),
                                                                            )),
                                                                          )
                                                                        : Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 3,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                              fit: BoxFit.fill,
                                                                              image: NetworkImage(path.toString() + data[index].startingMeter.toString()),
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 3,
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.black,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        color: Colors.green),
                                                    child: Text(
                                                      "Start Meter Reading >",
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showGeneralDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      transitionDuration:
                                                          Duration(
                                                              milliseconds:
                                                                  500),
                                                      transitionBuilder:
                                                          (context,
                                                              animation,
                                                              secondaryAnimation,
                                                              child) {
                                                        return FadeTransition(
                                                          opacity: animation,
                                                          child:
                                                              ScaleTransition(
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
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                color: Colors
                                                                    .white,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    path.toString() +
                                                                                // ignore: unnecessary_null_comparison
                                                                                data[index].endMeter.toString() ==
                                                                            null
                                                                        ? Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 3,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                              fit: BoxFit.fill,
                                                                              image: AssetImage("images/backCar.jpg"),
                                                                            )),
                                                                          )
                                                                        : Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 3,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                              fit: BoxFit.fill,
                                                                              image: NetworkImage(path.toString() + data[index].endMeter.toString()),
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 3,
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.black,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        color: Colors.green),
                                                    child: Text(
                                                      "End Meter Reading >",
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          "  " +
                                              data[index]
                                                  .vehicleName
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "  " +
                                              data[index].vehicleNo.toString(),
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Booking Date",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data[index].creatDate.toString(),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data[index].paymentStatus.toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        data[index].rideStatus.toString() == "0"
                                            ? Text(
                                                "Pending",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors
                                                        .yellowAccent.shade700,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : data[index]
                                                        .rideStatus
                                                        .toString() ==
                                                    "1"
                                                ? Text(
                                                    "Booked",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : data[index]
                                                            .rideStatus
                                                            .toString() ==
                                                        "2"
                                                    ? Text(
                                                        "On Going",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.yellow,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    : data[index]
                                                                .rideStatus
                                                                .toString() ==
                                                            "3"
                                                        ? Text(
                                                            "End Ride ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : Text(
                                                            "Cancelled",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          data[index].id.toString(),
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          data[index].startingKm.toString(),
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          data[index].endReading.toString(),
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Divider(),
                                Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            booking_id =
                                                data[index].id.toString();
                                            getBookingStatus();
                                          });
                                          showGeneralDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            transitionDuration:
                                                Duration(milliseconds: 500),
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
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return Scaffold(
                                                appBar: AppBar(
                                                  backgroundColor: Colors.green,
                                                  elevation: 5,
                                                  title: Text(
                                                    "Booking Status",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                body: SafeArea(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      color: Colors.white,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                4,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            decoration:
                                                                BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: AssetImage(
                                                                  "images/backCar.jpg"),
                                                            )),
                                                          ),
                                                          Container(
                                                            child: Card(
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          data[index]
                                                                              .modelNo
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              50,
                                                                        ),
                                                                        Text(
                                                                          data[index]
                                                                              .vehicleNo
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Divider(),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Column(
                                                                          children: [
                                                                            Text(
                                                                              "Pickup Date and Time",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Text(data[index].pickupDate.toString() +
                                                                                "  " +
                                                                                data[index].pickupTime.toString()),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            Text(
                                                                              "Drop Date and Time",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Text(data[index].dropDate.toString() +
                                                                                "  " +
                                                                                data[index].dropTime.toString()),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Divider(),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        // ignore: unnecessary_null_comparison
                                                                        path.toString() + (data[index].vehicleImage.toString()) ==
                                                                                null
                                                                            ? Container(
                                                                                height: MediaQuery.of(context).size.height / 7.3,
                                                                                width: MediaQuery.of(context).size.width / 2.7,
                                                                                decoration: BoxDecoration(
                                                                                    border: Border.all(color: Colors.black87, width: 1),
                                                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                                                    image: DecorationImage(
                                                                                      fit: BoxFit.fill,
                                                                                      image: AssetImage("images/car7.jpg"),
                                                                                    )),
                                                                              )
                                                                            : Container(
                                                                                height: MediaQuery.of(context).size.height / 7.3,
                                                                                width: MediaQuery.of(context).size.width / 2.7,
                                                                                decoration: BoxDecoration(
                                                                                    border: Border.all(color: Colors.black87, width: 1),
                                                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                                                    image: DecorationImage(
                                                                                      fit: BoxFit.fill,
                                                                                      image: NetworkImage(path.toString() + data[index].vehicleImage.toString()),
                                                                                    )),
                                                                              ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Text(
                                                                              data[index].vehicleName.toString(),
                                                                              style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Text(
                                                                              data[index].totalHrs.toString() + " hours",
                                                                              style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Text(
                                                                              data[index].totalKm.toString() + " Kms free",
                                                                              style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Divider(),
                                                                    Text(
                                                                      "Payment Summary",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Divider(),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          "Total Price",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          "₹ " +
                                                                              rent.toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          "Tax",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          "-₹ " +
                                                                              (double.parse(tax.toString()).toStringAsFixed(0)),
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          "Platform Charge",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          "-₹ " +
                                                                              (double.parse(plateform_charge.toString()).toStringAsFixed(0)),
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Divider(),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          "Your Total Earning",
                                                                          style: TextStyle(
                                                                              color: Colors.green,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          "₹ " +
                                                                              (double.parse(income.toString()).toStringAsFixed(0)),
                                                                          style: TextStyle(
                                                                              color: Colors.green,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
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
                                            },
                                          );
                                        },
                                        child: Container(
                                            height: 25,
                                            width: 60,
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            )))
                                  ],
                                ),
                                Divider(),
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
