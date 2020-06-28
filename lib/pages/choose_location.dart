import 'package:flutter/material.dart';
import 'package:dart_countries_states/country_provider.dart';
import 'package:dart_countries_states/models/alpha2_codes.dart';
import 'package:dart_countries_states/models/alpha3_code.dart';
import 'package:dart_countries_states/models/country.dart';
import 'package:dart_countries_states/models/currencies.dart';
import 'package:dart_countries_states/models/languages.dart';
import 'package:dart_countries_states/models/regional_blocs.dart';
import 'package:dart_countries_states/models/streets_info.dart';
import 'package:dart_countries_states/models/supported_languages.dart';
import 'package:dart_countries_states/street_provider.dart';
import 'package:world_time/service/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}




class _ChooseLocationState  extends State<ChooseLocation> {

  List<WorldTime> locations = [];


  void update_location() async {

    final countryProvider = CountryProvider();
    var  countries = await countryProvider.getCountries();

    for(int i=1;i<countries.length;i++)
    {

      String region = countries.elementAt(i).region;
      String capital = countries.elementAt(i).capital;


      locations.add(
          WorldTime(url: '$region/$capital', location: '$capital', flag: 'f' )
      );


    }


  }

  Future<void> updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    Navigator.pop(context,{
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDay': instance.isDay,
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {});
    });

    update_location();


  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(

                  onTap: () async {
                    print(locations[index].location);
                    await locations[index].getTime();
                    await updateTime(index);
                    print(locations[index].location);
                  },
                  title: Text(locations[index].location),
                  leading: Icon(
                    Icons.edit_location,
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
