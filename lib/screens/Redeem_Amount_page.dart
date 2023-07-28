// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/screens/homeScreens/Home_Page.dart';
import 'Drawer_Page/Drawer_page.dart';
import 'Model/RedeemTransiction_model.dart';

class Redeem_Amount extends StatefulWidget {
  const Redeem_Amount({Key? key}) : super(key: key);

  @override
  State<Redeem_Amount> createState() => _Redeem_AmountState();
}

class _Redeem_AmountState extends State<Redeem_Amount>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String? wallet_amount;
  _getValue1() async {
    final pref = await SharedPreferences.getInstance();
    String? get = pref.getString('wallet_amount');
    setState(() {
      wallet_amount = get;
      print("jcbgkgc dggeg fgcg===>>>----" + wallet_amount.toString());
    });
  }

  Future getRedeemAmount() async {
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    String? vendor_id = pref2.getString('vendor_id');
    Map data = {
      'vendor_id': vendor_id.toString(),
      'payment_amount': wallet_amount.toString()
    };
    print(data.toString() + "fbmkfhjgikhgki");
    Uri url = Uri.parse("https://bitacars.com/api/redeem_wallet");
    var body1 = jsonEncode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "Application/json"}, body: body1);
    var res = await json.decode(response.body);
    String msg = res['status_message'];
    if (msg == "Redeem Successful") {
      Fluttertoast.showToast(msg: "Redeem Successful");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home_Page()));
    } else {
      Fluttertoast.showToast(msg: "Redeem Not  Successful");
    }
    setState(() {
      print("ihguydguyg====>>???" + res.toString());
    });
  }

  Future<List<Response>> getRedeemTransaction() async {
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    String? vendor_id = pref2.getString('vendor_id');
    Map data = {
      'vendor_id': vendor_id.toString(),
      //'vendor_id' : "VEND0925",
    };
    Uri url = Uri.parse("https://bitacars.com/api/redeem_history");
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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    setState(() {
      _getValue1();
      getRedeemTransaction();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.5,
        title: Text(
          "Redeem Your Amount",
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
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Wallet Amount : " + wallet_amount.toString(),
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Divider(
                thickness: 3,
                color: Colors.teal.shade500,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          5.0,
                        ),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        // give the indicator a decoration (color and border radius)
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            5.0,
                          ),
                          color: Colors.green,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        // ignore: prefer_const_literals_to_create_immutables
                        tabs: [
                          // first tab [you can add an icon using the icon property]
                          Tab(
                            text: 'Redeem money',
                          ),

                          // second tab [you can add an icon using the icon property]
                          Tab(
                            text: 'Redeem Transactions',
                          ),
                        ],
                      ),
                    ),
                    // tab bar view here
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // first tab bar view widget
                          Center(
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Redeem Amount",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      content: Text("Your Amount  => " +
                                          wallet_amount.toString()),
                                      actions: <Widget>[
                                        MaterialButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        MaterialButton(
                                          child: Text("Yes"),
                                          onPressed: () async {
                                            setState(() {
                                              getRedeemAmount();
                                            });
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                //height:MediaQuery.of(context).size.height/30,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 55),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.green),
                                ),
                                child: Text(
                                  'REDEEM',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // second tab bar view widget
                          FutureBuilder<List<Response>>(
                              future: getRedeemTransaction(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  List<Response>? data = snapshot.data;
                                  return ListView.builder(
                                      itemCount: data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Card(
                                            elevation: 3,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: ListTile(
                                                  leading: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50)),
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: AssetImage(
                                                              "images/car5.jpg"),
                                                        )),
                                                  ),
                                                  title: Text(
                                                    data[index]
                                                        .description
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  subtitle: Text(data[index]
                                                      .createdAt
                                                      .toString()),
                                                  trailing: (int.parse(data[
                                                                  index]
                                                              .earn
                                                              .toString())) >=
                                                          0
                                                      ? Text(
                                                          "₹ " +
                                                              data[index]
                                                                  .earn
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 15),
                                                        )
                                                      : Text(
                                                          "₹ " +
                                                              data[index]
                                                                  .earn
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 15),
                                                        )),
                                            ));
                                      });
                                }
                              }),
                        ],
                      ),
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
