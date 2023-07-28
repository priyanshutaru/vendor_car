// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class WelcomeRegistration extends StatefulWidget {
  const WelcomeRegistration({super.key});

  @override
  State<WelcomeRegistration> createState() => _WelcomeRegistrationState();
}

class _WelcomeRegistrationState extends State<WelcomeRegistration> {
  // formfield(hinttext) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.grey[200],
  //         border: Border.all(color: Colors.white, width: 0.2),
  //         //  border: Border.all(color: Colors.black, width: 0.2),
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 20),
  //         child: TextField(
  //           // obscureText: true,
  //           decoration: InputDecoration(
  //             border: InputBorder.none,
  //             hintText: hinttext,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.dstATop),
              image: AssetImage('images/car7.jpg'),
              fit: BoxFit.fill)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(""),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Column(
                    children: [
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Center(
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          // Text(
                          //   'Welcome Partner',
                          //   style: TextStyle(
                          //       letterSpacing: 1,
                          //       color: Colors.green,
                          //       fontSize: 25,
                          //       fontWeight: FontWeight.w500),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Card(
                        // color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              // color: Colors.black12,
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.width / 1.4,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        TextFormField(
                                          keyboardType: TextInputType.text,
                                          // validator: (val) {
                                          //   return val!.length == 10
                                          //       ? null
                                          //       : "Please enter 10 digit mobile Number";
                                          // },
                                          style: TextStyle(color: Colors.black),
                                          decoration: const InputDecoration(
                                              hintText: 'Enter your name',
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.text,
                                          // validator: (val) {
                                          //   return val!.length == 10
                                          //       ? null
                                          //       : "Please enter 10 digit mobile Number";
                                          // },
                                          style: TextStyle(color: Colors.black),
                                          decoration: const InputDecoration(
                                              hintText: 'Enter your email',
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          validator: (val) {
                                            return val!.length == 10
                                                ? null
                                                : "Please enter 10 digit mobile Number";
                                          },
                                          style: TextStyle(color: Colors.black),
                                          decoration: const InputDecoration(
                                              hintText:
                                                  'Enter your mobile number',
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.text,
                                          // validator: (val) {
                                          //   return val!.length == 10
                                          //       ? null
                                          //       : "Please enter 10 digit mobile Number";
                                          // },
                                          style: TextStyle(color: Colors.black),
                                          decoration: const InputDecoration(
                                              hintText: 'Enter your city',
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ],
                                    ),
                                    ButtonTheme(
                                      minWidth: 150.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: const BorderSide(
                                              color: Colors.white, width: 1)),
                                      child: MaterialButton(
                                        elevation: 5.0,
                                        hoverColor: Colors.green,
                                        color: Colors.black,
                                        child: const Text(
                                          "Create Account",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onPressed: () {
                                          // LoginApi();
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginOtpScreen(
                                          //   mobile: _mobileNumber.text.toString(),
                                          // )));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Color.fromARGB(255, 94, 42, 236),
    //     title: Text("New User Registration"),
    //     elevation: 0,
    //   ),
    //   body: Card(
    //     child: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         // ignore: prefer_const_literals_to_create_immutables
    //         children: [
    //           formfield("Name"),
    //           formfield("Email"),
    //           formfield("Mobile Number"),
    //           formfield("City"),
    //           // formfield("Email"),
    //           SizedBox(
    //             height: 10,
    //           ),

    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 25),
    //             child: Container(
    //               height: MediaQuery.of(context).size.height * .05,
    //               width: MediaQuery.of(context).size.width,
    //               // width: MediaQuery.of(context).size.width * .3,
    //               decoration: BoxDecoration(
    //                 color: Colors.black,
    //                 borderRadius: BorderRadius.circular(10),
    //               ),
    //               child: Center(
    //                 child: Text(
    //                   "Create Account",
    //                   style: TextStyle(
    //                       color: Colors.white, fontWeight: FontWeight.bold),
    //                 ),
    //               ),
    //             ),
    //           ),

    //           // GestureDetector(
    //           //   onTap: () => Navigator.push(
    //           //     context,
    //           //     MaterialPageRoute(builder: (context) => WedSignIn()),
    //           //   ),
    //           //   child: Container(
    //           //     child: Text(
    //           //       "Have already an account? Login",
    //           //       style: TextStyle(decoration: TextDecoration.underline),
    //           //     ),
    //           //   ),
    //           // )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
