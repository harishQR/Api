import 'dart:convert';
import 'package:api/modelclass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class output extends StatefulWidget {
  const output({super.key});

  @override
  State<output> createState() => _outputState();
}

class _outputState extends State<output> {

  Future<bored> fetch() async {
    var response = await http.get(
        Uri.parse("https://www.boredapi.com/api/activity"));
    return bored.fromJson(jsonDecode(response.body));
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          children: [
            FutureBuilder<bored>(
                future: fetch(), builder: (BuildContext context, snapshot){
                        if(snapshot.hasData){
                          return Center(
                            child: Column(
                              children: [
                                SizedBox(height: 200,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(snapshot.data!.activity.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(snapshot.data!.price.toString()),
                                ),
                                Text(snapshot.data!.accessibility.toString()),
                                Text(snapshot.data!.participants.toString()),
                                Text(snapshot.data!.link.toString()),
                                Text(snapshot.data!.key.toString()),
                                Text(snapshot.data!.type.toString()),
                              ],
                            ),
                          );
                        }
            else if(snapshot.hasError){
              return Center(child: Column(

                children: [
                  SizedBox(height: 100,),
                  Text("error occured"),
                ],
              ));
                        }
            return Column(
              children: [
                Center(
                   child:  CircularProgressIndicator()
                ),
              ],
            );
                }
            ),
          ],
        ),
      );
    }
  }
