import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:pwc_demo_loai/components/adminpage/addadmin.dart';
import 'package:pwc_demo_loai/components/adminpage/prevcompsadmn.dart';
import 'package:pwc_demo_loai/components/adminpage/revcomplaints.dart';
import 'package:pwc_demo_loai/components/home.dart';
import 'package:pwc_demo_loai/components/profilebutton.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () async {
                  var session = FlutterSession();
                  await session.set("email", null.toString());
                  await session.set("pass", null.toString());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                icon: Icon(Icons.logout)),
          )
        ],
        leading: ProfileButton(),
        elevation: 30,
        centerTitle: true,
        gradient: LinearGradient(
            colors: [Colors.red[800], Colors.deepOrange, Colors.amber[800]]),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Suggestion",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Icon(
              CupertinoIcons.cube_box,
              size: 35,
            )
          ],
        ),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            elevation: 40,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dynamic_feed_rounded),
                selectedIcon: Icon(Icons.dynamic_feed_rounded),
                label: Text('Review\nComplaints'),
              ),
              NavigationRailDestination(
                icon: Icon(CupertinoIcons.doc_on_doc),
                selectedIcon: Icon(CupertinoIcons.doc_on_doc),
                label: Text('Previous\nComplaints'),
              ),
              NavigationRailDestination(
                icon: Icon(CupertinoIcons.person_add),
                selectedIcon: Icon(CupertinoIcons.person_add),
                label: Text('Add Admin'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: goToIndex(_selectedIndex),
            ),
          )
        ],
      ),
    );
  }

  goToIndex(idx) {
    if (idx == 0) {
      return RevComplaints();
    }
    if (idx == 1) {
      return OldComplaints();
    }
    if (idx == 2) {
      return AddAdmin();
    }
  }
}
