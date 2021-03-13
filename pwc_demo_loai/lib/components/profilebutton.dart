import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pwc_demo_loai/api/api.dart';

var res;

class ProfileButton extends StatefulWidget {
  const ProfileButton({
    Key key,
  }) : super(key: key);

  @override
  _ProfileButtonState createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  OverlayEntry _dialog;
  Container _rescol = Container();
  @override
  void initState() {
    super.initState();
    getInfo();
  }

  getInfo() async {
    res = await getUserInfo();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: IconButton(
        icon: Icon(Icons.person),
        onPressed: () {
          if (res != "An Error Occured") {
            _dialog = popOut();
            Overlay.of(context).insert(_dialog);
          }
        },
      ),
    );
  }

  popOut() {
    setState(() {
      _rescol = Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        width: max(MediaQuery.of(context).size.width / 3.5, 400),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 500,
          ),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:
                            max(MediaQuery.of(context).size.width * .02, 30),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.cancel_outlined,
                      ),
                      onPressed: () {
                        _dialog?.remove();
                      },
                    ),
                  ],
                ),
                UInfoBox(),
              ],
            ),
          ),
        ),
      );
    });
    return OverlayEntry(
        builder: (context) => AnimatedDialog(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 9),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: _rescol,
                    ),
                  ],
                  mainAxisSize: MainAxisSize.max,
                ),
              ),
            ));
  }
}

class UInfoBox extends StatefulWidget {
  @override
  _UInfoBoxState createState() => _UInfoBoxState();
}

class _UInfoBoxState extends State<UInfoBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: " + res['name'],
              style: TextStyle(
                  fontSize: max(MediaQuery.of(context).size.width * .01, 15)),
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Phone Number: " + res['phone'],
              style: TextStyle(
                  fontSize: max(MediaQuery.of(context).size.width * .01, 15)),
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Email: " + res['email'],
              style: TextStyle(
                  fontSize: max(MediaQuery.of(context).size.width * .01, 15)),
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Address: " + res['address'],
              style: TextStyle(
                  fontSize: max(MediaQuery.of(context).size.width * .01, 15)),
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedDialog extends StatefulWidget {
  const AnimatedDialog({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() => AnimatedDialogState();
}

class AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutExpo);
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.6).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutExpo));

    controller.addListener(() => setState(() {}));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(opacityAnimation.value),
      child: Center(
        child: FadeTransition(
          opacity: scaleAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
