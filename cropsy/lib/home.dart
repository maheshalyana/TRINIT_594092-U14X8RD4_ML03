import 'dart:convert';

import 'package:cropsy/weather_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherData? wdata;

  void getData() async {
    await Geolocator.requestPermission();
    // Geolocator.checkPermission();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      var response = await http.post(Uri.parse(
          'http://api.weatherapi.com/v1/current.json?key=0afe0ac6a055436c9cd165636231102&q=${position.longitude},${position.latitude}'));
      print("Status code");
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> output = json.decode(response.body);
        Condition condata = Condition(
            code: output['current']['condition']['code'],
            icon: output['current']['condition']['icon'],
            text: output['current']['condition']['text']);
        Current cdata = Current(
          cloud: output['current']['cloud'],
          condition: condata,
          feelslikeC: output['current']['feelslike_c'],
          gustKph: output['current']['gust_kph'],
          humidity: output['current']['humidity'],
          precipIn: output['current']['precip_in'],
          windKph: output['current']['wind_kph'],
        );
        Location ldata = Location(
          country: output['location']['country'],
          lat: output['location']['lat'],
          localtime: output['location']['localtime'],
          localtimeEpoch: output['location']['localtime_epoch'],
          lon: output['location']['lon'],
          name: output['location']['name'],
          region: output['location']['region'],
          tzId: output['location']['tzId'],
        );
        WeatherData data = WeatherData(current: cdata, location: ldata);
        setState(() {
          wdata = data;
        });
      }
    });
  }

  String day = '';
  @override
  void initState() {
    super.initState();
    getData();
    var x = DateTime.now().weekday;
    if (x == 1) {
      day = 'Moday';
    } else if (x == 2) {
      day = 'Tuesday';
    } else if (x == 3) {
      day = 'Wednesday';
    } else if (x == 4) {
      day = 'Thursday';
    } else if (x == 5) {
      day = 'Friday';
    } else if (x == 6) {
      day = 'Saturday';
    } else {
      day = 'Sunday';
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return wdata == null
        ? CircularProgressIndicator()
        : Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/images/weather.png'),
                    // Image.network(wdata!.current!.condition!.icon.toString()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    wdata!.current!.feelslikeC.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.08,
                                      fontFamily: "Ubuntu",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    " °C",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Ubuntu",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Precipitation: ${wdata!.current!.precipIn}%\nHumidity: ${wdata!.current!.humidity}%\nWind: ${wdata!.current!.windKph}km/h",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Ubuntu",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Weather\n$day ${DateTime.now().hour}:${DateTime.now().minute}\n${wdata!.current!.condition!.text}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.04,
                      fontFamily: "Ubuntu",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Seasonal Crops",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.05,
                      fontFamily: "Ubuntu",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.18,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: width * 0.25,
                            height: height * 0.18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(31),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xe00a7f00),
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                                BoxShadow(
                                  color: Color(0x3fffffff),
                                  blurRadius: 11,
                                  offset: Offset(-7, -4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(31),
                                child: FlutterLogo(size: 108)),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Demanded Crops",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.05,
                      fontFamily: "Ubuntu",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.15,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: width * 0.25,
                            height: height * 0.18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(31),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xe00a7f00),
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                                BoxShadow(
                                  color: Color(0x3fffffff),
                                  blurRadius: 11,
                                  offset: Offset(-7, -4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(31),
                                child: FlutterLogo(size: 108)),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
  }
}
