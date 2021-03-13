import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CarouselSlider(
              items: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.red[600],
                    Colors.deepOrange,
                  ])),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Welcome To SuggestionBox!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: max(
                                80, MediaQuery.of(context).size.width * .1)),
                      ),
                      Text(
                        "ABC's complaint management system",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: max(
                                25, MediaQuery.of(context).size.width * .02)),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.deepOrange, Colors.amber[700]])),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Step 1:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: max(
                                80, MediaQuery.of(context).size.width * .1)),
                      ),
                      Text(
                        "Submit a complaint",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: max(
                                25, MediaQuery.of(context).size.width * .02)),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.amber[700], Colors.deepOrange])),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Step 2:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: max(
                                80, MediaQuery.of(context).size.width * .1)),
                      ),
                      Text(
                        "Wait...",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: max(
                                25, MediaQuery.of(context).size.width * .02)),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.deepOrange, Colors.red[600]])),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Step 3:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: max(
                                80, MediaQuery.of(context).size.width * .1)),
                      ),
                      Text(
                        "Get your complaint resolved!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: max(
                                25, MediaQuery.of(context).size.width * .02)),
                      ),
                    ],
                  ),
                ),
              ],
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  height: MediaQuery.of(context).size.height - 56))
        ],
      ),
    );
  }
}
