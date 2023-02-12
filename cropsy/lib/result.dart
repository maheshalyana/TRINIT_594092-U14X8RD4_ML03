import 'package:cropsy/home_screen.dart';
import 'package:cropsy/unitls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class Results extends StatefulWidget {
   Results({super.key,required this.data});
  List data ;

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: utils.majorColor,
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff0a7f00), Colors.white],
          ),
        ),
        // margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/logo.svg'),
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),

              // child: RequestPrediction(),
              child: Container(
                height: height * 0.7,
                child: ListView.builder(
                 itemCount: 1, 
                  itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: width * 0.8,
                      height: height * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        color: Colors.white,
                      ),
                      child: Row(children: [
                        Container(
                          width: 107,
                          height: height * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(19),
                          ),
                          // child: FlutterLogo(size: 100),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                widget.data[0],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: "Ubuntu",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Min Price:- ${widget.data[1]}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 9,
                                ),
                              ),
                              Text(
                                "Max Price:- ${widget.data[2]}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 9,
                                ),
                              ),
                              Text(
                                "Avg Price:- ${widget.data[2]}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 9,
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  );
                })),
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  width: width,
                  height: height * 0.2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          width: width,
                          height: height * 0.1,
                        ),
                      ),
                      Positioned(
                        bottom: height * 0.03,
                        child: Container(
                          width: height * 0.12,
                          height: height * 0.12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff0a8000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: FloatingActionButton(
                            focusColor: Colors.white,
                            backgroundColor: Colors.white,
                            mini: false,
                            onPressed: (() {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (route) => false);
                            }),
                            child: Center(
                                child:
                                    SvgPicture.asset('assets/images/icon.svg')),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
