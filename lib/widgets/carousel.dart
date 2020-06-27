import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttergsignin/carousel_datacollect.dart';
import 'package:fluttergsignin/widgets/CDetails.dart';

class Carouselhome extends StatefulWidget {
  final List<String> ImageList;
  Carouselhome({this.ImageList});
  @override
  _CarouselhomeState createState() => _CarouselhomeState();
}

class _CarouselhomeState extends State<Carouselhome> {
  int _currentIndex=0;
//List<String> ImageList=["https://cdn.pixabay.com/photo/2015/12/08/00/26/food-1081707_1280.jpg","https://cdn.pixabay.com/photo/2020/04/13/01/20/chinese-hamburgers-5036410_1280.jpg"];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: new AppBar(
          backgroundColor: Colors.red[700],
          title: new Text("Carousel Home",
            style: new TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(height: 200.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 2.0,
                onPageChanged: (index,CarouselPageChangedReason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },),
              items: widget.ImageList.map((i){
                return Builder(
                    builder:(BuildContext context){
                      return Container(
                        height: MediaQuery.of(context).size.height*0.30,
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                            child: Image.network(i, fit: BoxFit.cover),
                            onTap: () {
                              getCarousaldetails(i).whenComplete(() {
                                Navigator.push(context,
                                    MaterialPageRoute<void>(builder: (BuildContext context) =>
                                        Cdetails(details: details,
                                        )));
                              });
                            })
                      );
                    }
                );
              }).toList(),
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(widget.ImageList, (index, url) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
              ),
            );
          }),),
          ],
        )
    );
  }
}
