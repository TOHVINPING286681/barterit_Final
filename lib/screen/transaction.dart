import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/item.dart';
import '../model/user.dart';
import '../myconfig.dart';

class TransactionSCreen extends StatefulWidget {
  final User user;

  final Item item;

  const TransactionSCreen({
    super.key,
    required this.user,
    required this.item,
  });

  @override
  State<TransactionSCreen> createState() => _TransactionSCreenState();
}

class _TransactionSCreenState extends State<TransactionSCreen> {
  late double screenHeight, screenWidth, cardwitdh;
  int barterpoint = 15;
  int userqty = 1;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barter Item Transaction"),
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
                    width: screenWidth * 0.35,
                    height: screenHeight * 0.35,
                    child: Image.asset(
                      "assets/images/transaction.png",
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            "From : ${widget.user.name}",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("To : Toh Vin Ping"),
                        ],
                      ))
                ]),
              ),
            ),
            const Divider(
              color: Colors.blueGrey,
              height: 2,
              thickness: 2.0,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("TOTAL: RM 15", style: TextStyle(fontSize: 26)),
            ),
            const Divider(
              color: Colors.blueGrey,
              height: 2,
              thickness: 2.0,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  width: 275,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        const SnackBar(content: Text("Barter Successful"));
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  width: 275,
                  child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Transaction Declined")));
                      },
                      child: const Text("Declined",
                          style: TextStyle(fontSize: 16))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
