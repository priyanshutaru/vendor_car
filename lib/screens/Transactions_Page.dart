// ignore_for_file: camel_case_types, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Drawer_Page/Drawer_page.dart';
import 'Model/Transaction_model.dart';

class Transactions_page extends StatefulWidget {
  const Transactions_page({Key? key}) : super(key: key);

  @override
  State<Transactions_page> createState() => _Transactions_pageState();
}

class _Transactions_pageState extends State<Transactions_page> {
  Future<List<Response>> getMyvenTransaction() async {
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    String? vendor_id = pref2.getString('vendor_id');
    Map data = {
      'vendor_id': vendor_id.toString(),
      //'vendor_id' : "VEND0925",
    };
    Uri url = Uri.parse("https://bitacars.com/api/transections_history");
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

  String? path;
  @override
  void initState() {
    super.initState();
    getMyvenTransaction();
    setState(() {
      path = "https://onway.creditmywallet.in.net/public/uploads/";
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
          "Transactions",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer_page(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<List<Response>>(
              future: getMyvenTransaction(),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    border: Border.all(
                                                        color: Colors.black87,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(8)),
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                          "images/car5.jpg"),
                                                    )),
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
                                                    border: Border.all(
                                                        color: Colors.black87,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(8)),
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          path.toString() +
                                                              data[index]
                                                                  .vehicleImage
                                                                  .toString()),
                                                    )),
                                              ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          data[index].vehicleNo.toString(),
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          data[index].modelNo.toString(),
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          data[index].paymentStatus.toString(),
                                          style: TextStyle(
                                              color: Colors.green.shade600,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Divider(),
                                Text(
                                  data[index].vehicleName.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Transaction id: ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      data[index].transectionIds.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order id: ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      data[index].id.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Amount : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "₹ " +
                                          data[index].totalPaidRent.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Date Time : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      data[index].creatDate.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                )
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
