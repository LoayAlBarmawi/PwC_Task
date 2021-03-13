import 'dart:convert';

import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

Future<String> registerUser(email, name, password, address, phone) async {
  Uri url = new Uri(path: "//loai-demo.000webhostapp.com/login_demo/reg.php");
  var data = {
    'email': email,
    'name': name,
    'pass': password,
    'address': address,
    'phone': phone
  };

  var res = await http.post(url, body: data);

  return jsonDecode(res.body);
}

Future<String> registerAdmin(email, name, password, address, phone) async {
  Uri url =
      new Uri(path: "//loai-demo.000webhostapp.com/login_demo/addadmin.php");
  var data = {
    'email': email,
    'name': name,
    'pass': password,
    'address': address,
    'phone': phone
  };

  var res = await http.post(url, body: data);

  return jsonDecode(res.body);
}

Future<String> login(email, password, rem) async {
  Uri url = new Uri(path: "//loai-demo.000webhostapp.com/login_demo/login.php");
  var data = {
    'email': email,
    'pass': password,
  };

  var res = await http.post(url, body: data);
  if (jsonDecode(res.body).toString() != "Wrong Credentials") {
    if (rem) {
      var session = FlutterSession();
      await session.set("token", 1);
      await session.set("email", jsonDecode(res.body)["email"].toString());
      await session.set("pass", jsonDecode(res.body)["pass"].toString());
    }
    return jsonDecode(res.body)["type"].toString();
  } else {
    return "Wrong Credentials";
  }
}

Future<dynamic> getUserInfo() async {
  var email = await FlutterSession().get("email");

  Uri url =
      new Uri(path: "//loai-demo.000webhostapp.com/login_demo/getdata.php");
  var data = {
    'email': email,
  };

  var res = await http.post(url, body: data);
  if (jsonDecode(res.body).toString() != "An Error Occured") {
    return jsonDecode(res.body);
  } else {
    return "An Error Occured";
  }
}

Future<String> addComplaint(title, content, satisfacion) async {
  var email = await FlutterSession().get("email");

  Uri url = new Uri(
      path: "//loai-demo.000webhostapp.com/login_demo/addcomplaint.php");
  var data = {
    'email': email,
    'title': title,
    'satisfaction': satisfacion,
    'content': content,
  };

  var res = await http.post(url, body: data);

  return jsonDecode(res.body);
}

Future<List> getUserComplaints() async {
  var email = await FlutterSession().get("email");

  Uri url = new Uri(
      path: "//loai-demo.000webhostapp.com/login_demo/getcomplaints.php");
  var data = {
    'email': email,
  };

  var res = await http.post(url, body: data);
  final List complaints = jsonDecode(res.body);
  return complaints;
}

Future<List> getUserComplaintsAdmin() async {
  var email = await FlutterSession().get("email");

  Uri url = new Uri(
      path: "//loai-demo.000webhostapp.com/login_demo/getcomplaintsadmin.php");
  var data = {
    'email': email,
  };

  var res = await http.post(url, body: data);
  final List complaints = jsonDecode(res.body);
  return complaints;
}

Future<List> getResolvedComplaintsAdmin() async {
  var email = await FlutterSession().get("email");

  Uri url = new Uri(
      path:
          "//loai-demo.000webhostapp.com/login_demo/getresolvedcomplaints.php");
  var data = {
    'email': email,
  };

  var res = await http.post(url, body: data);
  final List complaints = jsonDecode(res.body);
  return complaints;
}

Future<String> resolveComplaint(action, compid) async {
  var email = await FlutterSession().get("email");

  Uri url = new Uri(
      path: "//loai-demo.000webhostapp.com/login_demo/resolvecomplaints.php");
  var data = {'email': email, 'status': action, 'compid': compid};

  var res = await http.post(url, body: data);
  var result = jsonDecode(res.body);
  return result;
}
