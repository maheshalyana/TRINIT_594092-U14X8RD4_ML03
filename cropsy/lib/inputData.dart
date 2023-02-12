import 'dart:convert';

import 'package:cropsy/result.dart';
import 'package:cropsy/unitls.dart';
import 'package:cropsy/weather_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class RequestPrediction extends StatefulWidget {
  const RequestPrediction({super.key});

  @override
  State<RequestPrediction> createState() => _RequestPredictionState();
}

class _RequestPredictionState extends State<RequestPrediction> {
  bool open = true;
  WeatherData? wdata;
  void getData() async {
    await Geolocator.requestPermission();
    // Geolocator.checkPermission();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      var response = await http.post(Uri.parse(
          'http://api.weatherapi.com/v1/current.json?key=0afe0ac6a055436c9cd165636231102&q=${position.latitude},${position.longitude}'));
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    temperature.text = wdata!.current!.tempC.toString();
    rainfall.text = (wdata!.current!.cloud! * wdata!.current!.humidity!).toString();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getData();
  }

  TextEditingController nsoil = TextEditingController();
  TextEditingController psoil = TextEditingController();
  TextEditingController ksoil = TextEditingController();
  TextEditingController pHsoil = TextEditingController();
  TextEditingController temperature = TextEditingController();
  TextEditingController rainfall = TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return wdata == null
        ? Container(
            height: height,
            width: width,
            child: Center(
              child: Container(
                height: 100,
                width: 100,
                child: Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: utils.majorColor,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          )
        : ListView(
          children: [Container(
              child: Column(
                children: [
                  SizedBox(
                    width: width * 0.7,
                    child: Text(
                      "We’ll predict the better crop for you...........!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.04,
                        fontFamily: "Ubuntu",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (() {
                          setState(() {
                            open = !open;
                          });
                        }),
                        child: Text(
                          (open ? "V " : ">") + "   Tell us about ur soil",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.045,
                            fontFamily: "Ubuntu",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: open,
                    child: Container(
                      width: width * 0.85,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "N : ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.08,
                                          fontFamily: "Ubuntu",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.2,
                                      child: TextFormField(
                                        controller: nsoil,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      " K : ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.08,
                                        fontFamily: "Ubuntu",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.2,
                                      child: TextFormField(
                                        controller: ksoil,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "P : ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.08,
                                            fontFamily: "Ubuntu",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.2,
                                        child: TextFormField(
                                          controller: psoil,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "pH : ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.08,
                                          fontFamily: "Ubuntu",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.2,
                                        child: TextFormField(
                                          controller: pHsoil,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                      child: Text(
                        "Temperature ( °C )",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Ubuntu",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: TextFormField(
                      controller: temperature,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                      child: Text(
                        "Rain fall (ppm)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Ubuntu",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: TextFormField(
                      controller: rainfall,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      width: width * 0.45,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3f000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                          BoxShadow(
                            color: Color(0x3fffffff),
                            blurRadius: 5,
                            offset: Offset(-2, -2),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: MaterialButton(
                            onPressed: () async {
                              var data = jsonEncode(<String, dynamic>{
                                "N": double.parse(nsoil.text),
                                "P": double.parse(psoil.text),
                                "K": double.parse(ksoil.text),
                                "temperature": double.parse(temperature.text),
                                "humidity": wdata!.current!.humidity,
                                "ph": double.parse(pHsoil.text),
                                "rainfall": double.parse(rainfall.text),
                              });
                              print(data);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        child: Center(
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CircularProgressIndicator(
                                              color: utils.majorColor,
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                    );
                                  });
                              var response = await http.post(
                                  Uri.parse(
                                      'https://cropsyweb.onrender.com/predict'),
                                  body: data);
                              print(response.body);
                              print(response.statusCode);
        
                              if (response.statusCode == 200) {
                                Navigator.pop(context);
                                Map<String, dynamic> output =
                                    json.decode(response.body);
                                List data = output['prediction'];
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Results(
                                              data: data,
                                            )),
                                    (route) => false);
                              }
                            },
                            child: Text(
                              "submit",
                              style: TextStyle(
                                color: Color(0xff0a7f00),
                                fontSize: width * 0.04,
                                fontFamily: "Ubuntu",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),]
        );
  }
}
