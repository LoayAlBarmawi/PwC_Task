import 'package:flutter/material.dart';
import 'package:pwc_demo_loai/api/api.dart';

class RevComplaints extends StatefulWidget {
  @override
  _RevComplaintsState createState() => _RevComplaintsState();
}

class _RevComplaintsState extends State<RevComplaints> {
  List comps;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      builder: (context, snapshot) {
        if (comps == null) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
            itemCount: comps.length,
            itemBuilder: (context, index) => ComplaintBox(
                  complaint: comps[index],
                ));
      },
      future: getComps(),
    ));
  }

  getComps() async {
    comps = await getUserComplaintsAdmin();
  }
}

class ComplaintBox extends StatefulWidget {
  final Map complaint;

  const ComplaintBox({Key key, this.complaint}) : super(key: key);

  @override
  _ComplaintBoxState createState() => _ComplaintBoxState(complaint);
}

class _ComplaintBoxState extends State<ComplaintBox> {
  final Map complaint;

  _ComplaintBoxState(this.complaint);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.deepOrange, Colors.amber[800]]),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("ID:" + complaint['id'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * .025)),
              Text("Title:" + complaint['title'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * .025)),
              Text(
                  "Date Submitted:" +
                      complaint['add-date'].toString().substring(0, 10),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * .025)),
              Text("Status:" + complaint['status'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * .025)),
              ExpansionTile(
                title: Text("Description",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * .025)),
                children: [
                  Text(complaint['content'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * .025))
                ],
              ),
              ExpansionTile(
                title: Text("Actions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * .025)),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          var res = await resolveComplaint(
                              'Resolved', complaint['id']);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.green[800], Colors.green]),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Resolve",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .025)),
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          var res = await resolveComplaint(
                              'Dismissed', complaint['id']);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.red[800], Colors.red]),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Dismiss",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .025)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
