import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:world_time/service/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}



class _LoadingState  extends State<Loading> {

  String time = "loading...";

  void getData() async {
    WorldTime ins = WorldTime(location: 'Dhaka',flag: 'bangladesh.png',url: 'Asia/Dhaka');
    await ins.getTime();

    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'location' : ins.location,
      'time' : ins.time,
      'flag' : ins.flag,
      'isDay' : ins.isDay,
    });
  }


  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
     body: Center(
       child: SpinKitFadingCircle(
         color: Colors.white,
         size: 60,
       ),
     ),

    );
  }
}
