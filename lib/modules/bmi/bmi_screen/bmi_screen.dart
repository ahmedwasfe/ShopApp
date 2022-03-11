import 'dart:math';

import 'package:bmi_calculator/modules/bmi/bmi_result/bmi_reslut.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({Key? key}) : super(key: key);

  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  static final String TAG = "BMIScreenState";
  bool _isMale = true;
  double _height = 80.0;
  int _weight = 40;
  int _age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage("assets/images/male.png"),
                            width: 90.0,
                            height: 90.0,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "MALE",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: _isMale ? Colors.blueAccent : Colors.grey[500],
                      ),
                    ),
                    onTap: () => setState(() {
                      _isMale = true;
                    }),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(
                              "assets/images/female.png",
                            ),
                            height: 90.0,
                            width: 90.0,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "FEMALE",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: _isMale ? Colors.grey[500] : Colors.blueAccent,
                      ),
                    ),
                    onTap: () => setState(() {
                      _isMale = false;
                    }),
                  ),
                ),
              ],
            ),
          )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[500],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "HEIGHT",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          "${_height.round()}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 40.0),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          "CM",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                    Slider(
                        value: _height,
                        max: 220.0,
                        min: 80.0,
                        onChanged: (value) {
                          setState(() {
                            _height = value;
                            print(value.round());
                          });
                        }),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[500],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "WEIGHT",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                          ),
                          Text(
                            "$_weight",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 40.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                  child: Icon(Icons.remove),
                                  mini: true,
                                  heroTag: "weight-",
                                  onPressed: () => setState(() {
                                    _weight--;
                                  })),
                              FloatingActionButton(
                                  child: Icon(Icons.add),
                                  mini: true,
                                  heroTag: "weight+",
                                  onPressed: () => setState(() {
                                    _weight++;
                                  })),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[500],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "AGE",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                          ),
                          Text(
                            "$_age",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 40.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                  child: Icon(Icons.remove),
                                  mini: true,
                                  heroTag: "age-",
                                  onPressed: () => setState(() {
                                    _age--;
                                  })),
                              FloatingActionButton(
                                  child: Icon(Icons.add),
                                  mini: true,
                                  heroTag: "age+",
                                  onPressed: () => setState(() {
                                    _age++;
                                  })),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blueAccent,
            child: MaterialButton(
                height: 50.0,
                child: Text("CALCULATE", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  var result = _weight / pow(_height / 100, 2);
                  print(result.round());
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => BMIResult(
                            result: result.round(),
                            isMale: _isMale,
                            age:_age,
                          )));
                }),
          ),
        ],
      ),
    );
  }
}
