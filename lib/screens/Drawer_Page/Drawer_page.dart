// ignore_for_file: camel_case_types, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/screens/Profile_Verification_all_screen/Proflie_Verification_Page.dart';
import 'package:vendor/screens/Redeem_Amount_page.dart';
import 'package:vendor/screens/homeScreens/Home_Page.dart';

import '../Booking_page.dart';
import '../Transactions_Page.dart';
import '../Vehicle_Details.dart';
import '../Vehicle_Registration.dart';
import '../Your_profile_page.dart';
import '../basicScreen/LoginPage.dart';

class Drawer_page extends StatefulWidget {
  const Drawer_page({Key? key}) : super(key: key);

  @override
  State<Drawer_page> createState() => _Drawer_pageState();
}

class _Drawer_pageState extends State<Drawer_page> {
  String? photo;
  String? path;
  String? name, email;
  _getValue1() async {
    final pref3 = await SharedPreferences.getInstance();
    String? get2 = pref3.getString('photo');
    final pref5 = await SharedPreferences.getInstance();
    String? get5 = pref5.getString('vendor_name');
    final pref6 = await SharedPreferences.getInstance();
    String? get6 = pref6.getString('email');
    setState(() {
      photo = get2!;
      name = get5;
      email = get6;
      print("jcbgkgc dggeg fgcg===>>>----" + photo.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getValue1();
      path = "https://onway.creditmywallet.in.net/public/vendorfile/";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            accountName: Text(
              name.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              email.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: Center(
                child: path.toString() + photo.toString() == null
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
                            "https://onway.creditmywallet.in.net/public/vendorfile/$photo",
                            fit: BoxFit.fill,
                          ),
                        ),
                      )),
          ),
          ListTile(
            tileColor: Colors.grey.shade300,
            leading: Icon(
              Icons.home,
              color: Colors.green,
              size: 35,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.green),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_Page()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle_rounded,
              size: 35,
            ),
            title: Text('Your Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Your_profile()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.badge,
              size: 35,
            ),
            title: const Text('Profile Verification'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile_Verification()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.app_registration,
              size: 35,
            ),
            title: const Text('Vehicle Registration'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Vehicle_Registration()));
            },
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.car_detailed,
              size: 30,
            ),
            title: const Text('Vehicle Details'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => vehicle_details_page()));
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.bookReader,
              size: 30,
            ),
            title: const Text('Bookings'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Bookings_page()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_balance,
              size: 35,
            ),
            title: const Text('Transactions'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Transactions_page()));
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.wallet,
              size: 30,
            ),
            title: const Text('Redeem Your Amount'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Redeem_Amount()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 30,
            ),
            title: const Text('Log Out'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Log Out"),
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
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.remove('mobile');
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (Route<dynamic> route) => false);
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
          /*AboutListTile( // <-- SEE HERE
              icon: Icon(
                Icons.info,
              ),
              child: Text('About app'),
              applicationIcon: Icon(
                Icons.local_play,
              ),
              applicationName: 'My Cool App',
              applicationVersion: '1.0.25',
              applicationLegalese: '© 2019 Company',
              aboutBoxChildren: [
                ///Content goes here...
              ],
            ),*/
        ],
      ),
    );
  }
}
