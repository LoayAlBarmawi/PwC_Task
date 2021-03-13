import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pwc_demo_loai/components/loginform.dart';
import 'package:pwc_demo_loai/components/registerform.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Color _c1 = Colors.deepOrange;
  Color _c2 = Colors.grey;
  CarouselController _con = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.red[800], Colors.deepOrange, Colors.amber[700]])),
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minWidth: 300,
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * .1),
              child: Container(
                constraints: BoxConstraints(maxWidth: 750),
                width: MediaQuery.of(context).size.width * .75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: [
                      Colors.red[800],
                      Colors.deepOrange,
                      Colors.amber[800]
                    ])),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 750),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    width: MediaQuery.of(context).size.width * .75 - 5,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _c1 = Colors.deepOrange;
                                      _c2 = Colors.grey;
                                    });
                                    _con.animateToPage(0);
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: _c1,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .04),
                                  )),
                              Text(
                                "|",
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .04),
                              ),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _c2 = Colors.deepOrange;
                                      _c1 = Colors.grey;
                                    });
                                    _con.animateToPage(1);
                                  },
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: _c2,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .04),
                                  )),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.deepOrange,
                        ),
                        CarouselSlider(
                          carouselController: _con,
                          items: [LoginForm(), Registration()],
                          options: CarouselOptions(
                              viewportFraction: 1,
                              height: MediaQuery.of(context).size.height * .6,
                              scrollPhysics: NeverScrollableScrollPhysics()),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
