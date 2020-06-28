import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime {
  String location;
  String time;
  String flag; //url of flag icon
  String url;
  bool isDay;

  WorldTime({this.location,this.flag,this.url});

  Future<void>  getTime() async {
    
    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      
      Map map = jsonDecode(response.body);
      
      time = map['datetime'];
      String offset = map['utc_offset'].toString().substring(1,3);
      DateTime dateTime = DateTime.parse(time);
      dateTime = dateTime.add(Duration(hours: int.parse(offset)));


      time = DateFormat.jm().format(dateTime);
      isDay = (dateTime.hour>6 && dateTime.hour < 20) ? true : false;
    } catch (e) {
      // TODO
      time  = 'sorry bro :( ';
    }

  }
}

