// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/screens/homeScreens/Home_Page.dart';

import 'Drawer_Page/Drawer_page.dart';

class Your_profile extends StatefulWidget {
  const Your_profile({Key? key}) : super(key: key);

  @override
  State<Your_profile> createState() => _Your_profileState();
}

class _Your_profileState extends State<Your_profile> {
  var name, email, mobile, profile_pic, path;
  var adhaar1, adhaar2, dl1, dl2, bank;
  var acc,
      bname,
      bbranch,
      buname,
      ifsc,
      wallet_amount,
      pan_status,
      adhaar_status,
      bank_status;

  @override
  void initState() {
    super.initState();
    setState(() {
      path = "https://onway.creditmywallet.in.net/public/vendorfile/";
      getProfile();
      _setValue(wallet_amount);
      _setValue1(pan_status);
      _setValue2(adhaar_status);
      _setValue3(bank_status);
    });
  }

  void _setValue(wallet_amount) async {
    final pref = await SharedPreferences.getInstance();
    final set1 = pref.setString('wallet_amount', wallet_amount);
    print("hdusifgudsigfiu==>>>=++++" + set1.toString());
  }

  void _setValue1(pan_status) async {
    final pref = await SharedPreferences.getInstance();
    final set1 = pref.setString('status_id', pan_status);
    print("hdusifgudsigfiu==>>>=++++" + set1.toString());
  }

  void _setValue2(adhaar_status) async {
    final pref = await SharedPreferences.getInstance();
    final set1 = pref.setString('address_status', adhaar_status);
    print("hdusifgudsigfiu==>>>=++++" + set1.toString());
  }

  void _setValue3(bank_status) async {
    final pref = await SharedPreferences.getInstance();
    final set1 = pref.setString('bank_status', bank_status);
    print("hdusifgudsigfiu==>>>=++++" + set1.toString());
  }

  Future getProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString('id');
    Map data = {
      'id': id.toString(),
    };
    Uri url = Uri.parse("https://bitacars.com/api/vendor_profile");
    var body1 = jsonEncode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "Application/json"}, body: body1);
    var res = await json.decode(response.body);
    //path=res['path'];
    print("hgvuhuygfu==--->>" + path.toString());
    var res1 = res['response_userRegister'];
    setState(() {
      name = res1['vendor_name'];
      email = res1['email'];
      mobile = res1['mobile'];
      profile_pic = res1['photo'];
      adhaar1 = res1['address_front'];
      adhaar2 = res1['address_back'];
      dl1 = res1['id_front'];
      dl2 = res1['id_back'];
      bank = res1['passbook'];
      acc = res1['account'];
      bname = res1['bank_name'];
      bbranch = res1['branch'];
      buname = res1['accountholder'];
      ifsc = res1['ifsc'];
      wallet_amount = res1['vendor_wallet'];
      pan_status = res1['status_id'];
      adhaar_status = res1['address_status'];
      bank_status = res1['bank_status'];
      _setValue1(pan_status);
      _setValue2(adhaar_status);
      _setValue3(bank_status);
      _setValue(wallet_amount);
    });
    print('data=========>>>>>>>>' + name.toString());
    print('data=========>>>>>>>>' + email.toString());
    print('data=========>>>>>>>>' + profile_pic.toString());
    if (response.statusCode == 200) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.5,
        // ignore: prefer_const_constructors
        title: Text(
          "Your Profile",
          // ignore: prefer_const_constructors
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer_page(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        decoration: BoxDecoration(color: Colors.white54),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.green,
                              padding: EdgeInsets.only(bottom: 35),
                              child: Column(
                                children: [
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: path.toString() +
                                                // ignore: unnecessary_null_comparison
                                                profile_pic.toString() ==
                                            null
                                        ? CircleAvatar(
                                            backgroundColor: Colors.white,
                                            maxRadius: 50,
                                            child: Image(
                                              image: NetworkImage(
                                                  'https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png'),
                                            ))
                                        : Container(
                                            height: 100,
                                            width: 100,
                                            child: ClipOval(
                                              child: Image.network(
                                                '${path.toString() + profile_pic.toString()}',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                  )),
                                  Text(
                                    name.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    mobile.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    email.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                    Positioned(
                        left: 100,
                        bottom: 10,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home_Page()));
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2.5,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.green.shade200,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(
                                  CupertinoIcons.arrow_left_circle_fill,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Back to\n Home",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account Info",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: Icon(
                        CupertinoIcons.person_crop_circle,
                        size: 35,
                        color: Colors.green,
                      ),
                      title: Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        name.toString(),
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: Icon(
                        CupertinoIcons.phone_fill_arrow_up_right,
                        size: 35,
                        color: Colors.green,
                      ),
                      title: Text(
                        "Mobile",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        mobile.toString(),
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: Icon(
                        CupertinoIcons.mail_solid,
                        size: 35,
                        color: Colors.green,
                      ),
                      title: Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        email.toString(),
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: Icon(
                        FontAwesomeIcons.addressCard,
                        size: 30,
                        color: Colors.green,
                      ),
                      title: Text(
                        "Adhaar Card Proof",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 4.2,
                                width: MediaQuery.of(context).size.width / 2.3,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 1),
                                    image: DecorationImage(
                                        //fit: BoxFit.fill,
                                        image: NetworkImage(
                                            path + adhaar1.toString()))),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 4.2,
                                width: MediaQuery.of(context).size.width / 2.3,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 1),
                                    image: DecorationImage(
                                        //fit: BoxFit.fill,
                                        image: NetworkImage(
                                            path + adhaar2.toString()))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: Icon(
                        Icons.credit_card_outlined,
                        size: 35,
                        color: Colors.green,
                      ),
                      title: Text(
                        "PAN Card Proof",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 4.2,
                                width: MediaQuery.of(context).size.width / 2.3,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 1),
                                    image: DecorationImage(
                                        // fit: BoxFit.fill,
                                        image: NetworkImage(
                                            path + dl1.toString()))),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 4.2,
                                width: MediaQuery.of(context).size.width / 2.3,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 1),
                                    image: DecorationImage(
                                        //fit: BoxFit.fill,
                                        image: NetworkImage(
                                            path + dl2.toString()))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: Icon(
                        Icons.account_balance,
                        size: 30,
                        color: Colors.green,
                      ),
                      title: Text(
                        "Bank Proof",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bank Account No. " + acc.toString(),
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Bank Name : " + bname.toString(),
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Bank Branch : " + bbranch.toString(),
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Bank User Name : " + buname.toString(),
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Bank IFSC : " + ifsc.toString(),
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 4.2,
                                width: MediaQuery.of(context).size.width / 2.3,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 1),
                                    image: DecorationImage(
                                        //fit: BoxFit.fill,
                                        image: NetworkImage(
                                            path + bank.toString()))),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
