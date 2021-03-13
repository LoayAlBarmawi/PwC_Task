import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:pwc_demo_loai/components/home.dart';
import 'package:pwc_demo_loai/components/profilebutton.dart';
import 'package:pwc_demo_loai/components/userpage/complaintform.dart';
import 'package:pwc_demo_loai/components/userpage/prevcomplaints.dart';
import 'package:pwc_demo_loai/components/userpage/userhome.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
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
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.edit_sharp),
                selectedIcon: Icon(Icons.edit_sharp),
                label: Text('Submit\nComplaints'),
              ),
              NavigationRailDestination(
                icon: Icon(CupertinoIcons.doc_on_doc),
                selectedIcon: Icon(CupertinoIcons.doc_on_doc),
                label: Text('Previous\nComplaints'),
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
      return UserHome();
    }
    if (idx == 1) {
      return ComplaintForm();
    }
    if (idx == 2) {
      return PrevComplaints();
    }
  }
}
