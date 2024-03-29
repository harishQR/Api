import 'dart:convert';
import 'package:api/agifymodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class agefy extends StatefulWidget {
  const agefy({super.key});

  @override
  State<agefy> createState() => _agefyState();
}
class _agefyState extends State<agefy> {
  Future<agi> agii() async{
    var agires = await http.get(Uri.parse("https://api.agify.io?name=meelad"));
        return agi.fromJson(jsonDecode(agires.body));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<agi>(future: agii(),builder: (BuildContext context , snapshot){
      if(snapshot.hasData){
      return  Column(
          children: [
            Text(snapshot.data!.count.toString()),
            Text(snapshot.data!.age.toString()),
            Text(snapshot.data!.name.toString()),
          ],
        );
      }
      else if(snapshot.hasError)
{
  Text("Error mr harish,focus!");
}
      return
         Column(
           children: [
             CircularProgressIndicator(),
           ],
         );
      },
      ),
    );
  }
}
