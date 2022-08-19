import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodcourt_tenant_flutter/history_detail_screen.dart';
import 'package:http/http.dart' as http;

class HistoryScreen extends StatelessWidget{
  HistoryScreen({Key? key, this.tenantId});
  final tenantId;

  String urlGetHistory = 'http://192.168.0.22:8000/api/get-history/';

  Future _getHistory() async{
    var response = await http.get(Uri.parse(urlGetHistory + tenantId.toString()));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: _getHistory(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
              if(snapshot.hasData){
                if(snapshot.data['data']!=null){
                  return ListView.separated(
                      itemBuilder: (BuildContext context, int index){
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryDetail(order: snapshot.data['data'][index])));

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data['data'][index]['name'], style: TextStyle(color: Colors.black),),
                                    // Text(snapshot.data['data'][index]['date_time'], style: TextStyle(color: Colors.black),),
                                    const SizedBox(height: 8,),
                                    const Text('2022-08-18 13:26:46', style: TextStyle(color: Colors.black),),
                                  ],
                                ),
                                Text(snapshot.data['data'][index]['total'].toString(), style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index){
                        return const SizedBox(height: 5,);
                      },
                      itemCount: snapshot.data['data'].length
                  );
                }
                else{
                  return const Center(
                    child: Text('Has no data'),
                  );
                }

              }
              else{
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator.adaptive(),
                      SizedBox(height: 8,),
                      Text('Memuat Data', style: TextStyle(fontSize: 15),),
                    ],
                  ),
                );
              }
            }
        ),
      ),
    );
  }

}
