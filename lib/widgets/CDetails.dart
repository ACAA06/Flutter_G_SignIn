import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cdetails extends StatefulWidget {
  final DocumentSnapshot details;
  Cdetails({@required this.details});
  @override
  _CdetailsState createState() => _CdetailsState();
}

class _CdetailsState extends State<Cdetails> {
  String About,url;
  @override
  Widget build(BuildContext context) {
    url=widget.details["ImageUrl"];
    About = widget.details["About"];

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: new AppBar(
        backgroundColor: Colors.red[700],
        title: new Text("Home",
        style: new TextStyle(color: Colors.white),
    ),
    ),
    body:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
    Container(
    height: MediaQuery.of(context).size.height*0.30,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
            child: Image.network(url, fit: BoxFit.cover),
            onTap: () {
            })
    ),
    SizedBox(height: 40),
    Text(
    'About',
    style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black54),
    ),
    Text(
    About,
    style: TextStyle(
    fontSize: 25,
    color: Colors.deepPurple,
    fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 20),
    ],
    ),
    );
  }
}
