import 'package:flutter/material.dart';
import 'package:fluttergsignin/carousel_datacollect.dart';
import 'package:fluttergsignin/login_page.dart';
import 'package:fluttergsignin/widgets/carousel.dart';
import 'package:fluttergsignin/widgets/loading.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //bool isLoading = true;
  String data;


  @override
  void initState() {
    super.initState;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: new AppBar(
            backgroundColor: Colors.red[700],
            title: new Text("Home",
              style: new TextStyle(color: Colors.white),
            ),
          ),
          body: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  getCarousaldata().whenComplete(() {
                    Navigator.push(context,
                        MaterialPageRoute<void>(builder: (BuildContext context) =>
                            Carouselhome(ImageList: ImageList,
                            )));
                  } );

                },
                child: Text("Carousel"),

              ),
              RaisedButton(
                onPressed: () {
                  getCarousaldata().whenComplete(() {
                    Navigator.push(context,
                        MaterialPageRoute<void>(builder: (BuildContext context) =>
                            LoginPage()));
                  } );

                },
                child: Text("Sign In"),

              ),
            ],
          ))
      );
    }

  }
