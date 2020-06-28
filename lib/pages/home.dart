import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {


    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    String bgImage = data['isDay'] ? 'day.jpg' : 'night.jpg';
    Color FontColor = data['isDay'] ? Colors.black : Colors.white;


    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0,0),
            child: Column(
              children: [

                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 35,
                        letterSpacing: 1,
                        color: FontColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 80,
                    letterSpacing: 2,
                    fontStyle: FontStyle.normal,
                    color: FontColor,
                  ),
                ),


              ],
            ),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic result = await Navigator.pushNamed(context, '/location');
          if (result != null) {
            setState(() {
              data = {
                'time': result['time'],
                'location': result['location'],
                'isDay': result['isDay'],
                'flag': result['flag']
              };
            });
          }
        },
        backgroundColor: Colors.indigoAccent,
        elevation: 10,
        highlightElevation: 10,
        child: Icon(
          Icons.edit_location
        ),
        splashColor: Colors.blueAccent,
      ),
    );
  }
}
