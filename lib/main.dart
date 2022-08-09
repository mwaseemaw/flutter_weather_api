import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(MaterialApp(
    home: WeatherApp(),));
}

class WeatherApp extends StatefulWidget {
  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late Map mapResponse={};
  Future fetchData()async{
    http.Response response;
    response = await http.get(Uri.parse('https://goweather.herokuapp.com/weather/qatar'));
    if(response.statusCode == 200){
      setState((){
        mapResponse = json.decode(response.body);
      });
    }
  }
  @override
  void initState() {
    fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('lib/turtleDeepWater.jpg'))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text( 'Qatar Weather Today',textScaleFactor: 2,),
            ContText(text: 'Temperature: ${mapResponse['temperature']}'),
            ContText(text: 'Wind: ${mapResponse['wind']}'),
            ContText(text: 'Description: ${mapResponse['description']}'),


          ],
        ),
      ),
    );
  }
}


class ContText extends StatelessWidget {
  String text;
  ContText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin:const EdgeInsets.symmetric(horizontal: 30,vertical: 10) ,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepPurpleAccent.withOpacity(0.4),
      ),
      child: Text(text,textScaleFactor: 1.5,style:const  TextStyle(color: Colors.white),),
    );
  }
}
