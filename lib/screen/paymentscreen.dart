import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';
import '../myconfig.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  final int point;
  final String userpoint;

  const PaymentScreen(
      {super.key,
      required this.user,
      required this.point,
      required this.userpoint});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late double screenHeight, screenWidth, cardwitdh;
  late User user = User(
    id: "na",
    email: "na",
    name: "na",
    password: "na",
    otp: "na",
    datereg: "na",
    phone: "na",
    point: "na",
  );

  String? gender;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: screenHeight * 0.25,
              width: screenWidth,
              child: Card(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: EdgeInsets.all(11),
                    width: screenWidth * 0.4,
                    child: Image.asset(
                      "assets/images/payment.jpeg",
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 55,
                          ),
                          const Text(
                            "Choose Your Transaction Method",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )),
                ]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 300, 4),
              child: Text(
                "Pay With: ",
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Column(
                children: [
                  RadioListTile(
                    title: Text("Online Banking"),
                    value: "Online Banking",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("E-Wallet"),
                    value: "E-Wallet",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Credit Card"),
                    value: "Credit Card",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Debit Card"),
                    value: "Debit Card",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                ],
              ),
              // child: const Row(
              //   children: [
              //     Card(
              //       child: Padding(
              //         padding: EdgeInsets.all(16.0),
              //         child: Text('Online Banking'),
              //       ),
              //     ),
              //     Card(
              //       child: Padding(
              //         padding: EdgeInsets.all(16.0),
              //         child: Text('   E-wallet   '),
              //       ),
              //     ),
              //     Card(
              //       child: Padding(
              //         padding: EdgeInsets.all(16.0),
              //         child: Text('Credit card'),
              //       ),
              //     ),
              //   ],
              // ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              color: Colors.blueGrey,
              height: 2,
              thickness: 2.0,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("TOTAL: RM " + widget.point.toString(),
                  style: TextStyle(fontSize: 26)),
            ),
            const Divider(
              color: Colors.blueGrey,
              height: 2,
              thickness: 2.0,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      successfulPay();
                    },
                    child: const Text(
                      "Payment Done",
                      style: TextStyle(fontSize: 16),
                    )),
                ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Payment Fail")));
                    },
                    child: const Text("Payment Fail",
                        style: TextStyle(fontSize: 16))),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> successfulPay() async {
    Navigator.of(context).pop();
    await http.post(
        Uri.parse("${MyConfig().SERVER}/barterit/php/update_profile.php"),
        body: {
          "selectpoint": widget.point.toString(),
          "userid": widget.user.id,
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);

        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Payment Success")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Payment Fail")));
        }
      }
      setState(() {});
    }).timeout(const Duration(seconds: 5));
  }
}
