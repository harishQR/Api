import 'dart:convert';

import 'package:api/complexgetmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class complex extends StatefulWidget {
  const complex({super.key});

  @override
  State<complex> createState() => _complexState();
}

class _complexState extends State<complex> {

  Future<List<Items>> tsk() async{
    var res = await http.get(Uri.parse(""));
    var data = jsonDecode(res.body)["items"];
    return (data as List).map((e) => Items.fromJson(e)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: tsk() ,builder: (BuildContext context,snapshot){
        if(snapshot.hasData){
                  List<Items> getting = snapshot.data!;
                   DateTime now = new DateTime.now();
                   DateTime last = now.subtract(Duration(days : 30 ));
                   print(last);
                   List<Items> filtered = getting.where((element) => DateTime.parse(element.updatedAt!).isAfter(last)).toList();
                   print(filtered);
                   return Container(
                     height: 900,
                     child: ListView.builder(itemCount: filtered.length,
                         scrollDirection: Axis.horizontal,
                         itemBuilder: (BuildContext context,int index){
                           return Column(
                             children: [
                               Text(filtered[index].name.toString()),
                               Text(filtered[index].description.toString()),
                               Text(filtered[index].fullName.toString()),
                               Text(filtered[index].sshUrl.toString()),

                             ],
                           );

                     }
                     ),
                   );

        }
        else if(snapshot.hasError){
          return Text("error");
        }
        return Column(
          children: [
            CircularProgressIndicator(),
          ],
        );

      } ,
      ),
    );
  }
}
