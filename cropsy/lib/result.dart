import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.7,
      child: ListView.builder(itemBuilder: ((context, index) {
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
                height: height*0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                ),
                child: FlutterLogo(size: 100),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "RICE",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: "Ubuntu",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Min Price:- 7000",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 9,
                      ),
                    ),
                    Text(
                      "Max Price:- 7000",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 9,
                      ),
                    ),
                    Text(
                      "Avg Price:- 7000",
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
    );
  }
}
