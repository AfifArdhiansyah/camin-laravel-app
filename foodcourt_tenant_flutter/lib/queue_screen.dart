import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class QueueScreen extends StatelessWidget{
  QueueScreen({Key? key, this.tenantId});
  final tenantId;

  String urlGetQueue = 'http://192.168.0.22:8000/api/get-queue/';
  String urlSetServed = 'http://192.168.0.22:8000/api/set-served/';

  Future _getQueue() async{
    var response = await http.get(Uri.parse(urlGetQueue + tenantId.toString()));
    debugPrint(response.body.toString());
    return json.decode(response.body);

  }
  Future _setServed(int id) async{
    var response = await http.get(Uri.parse(urlSetServed + id.toString()));
    debugPrint(id.toString());
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Queue'),
      ),
      body: FutureBuilder(
        future: _getQueue(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            if(snapshot.data['data']!=null){
              return Padding(
                padding: EdgeInsets.all(20),
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index){
                      return Dismissible(
                        key: Key(index.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          decoration: BoxDecoration(color: Colors.red),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text('Delete', style: TextStyle(color: Colors.white),),
                              SizedBox(width: 10,),
                              Icon(Icons.delete, color: Colors.white,),
                              SizedBox(width: 20,)
                            ],
                          ),
                        ),
                        onDismissed: (direction){
                          _setServed(snapshot.data['data'][index]['trans_id']);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: Column(
                              children : [
                                Text(snapshot.data['data'][index]['name'], style: const TextStyle(fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                Container(
                                  height: 2,
                                  decoration: const BoxDecoration(color: Colors.black),
                                ),
                                const SizedBox(height: 10,),
                                ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int indexFood){
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data['data'][index]['order'][indexFood]['name']),
                                          Text('x ' + snapshot.data['data'][index]['order'][indexFood]['quantity'].toString())
                                        ],
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int indexFood){
                                      return SizedBox(height: 5,);
                                    },
                                    itemCount: snapshot.data['data'][index]['order'].length
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  height: 2,
                                  decoration: const BoxDecoration(color: Colors.black),
                                ),
                                const SizedBox(height: 10,),
                                const Align(alignment: Alignment.centerLeft, child: Text('Note :')),
                                const SizedBox(height: 5,),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: (snapshot.data['data'][index]['note'] != null) ? Text(snapshot.data['data'][index]['note']) :
                                  const SizedBox(),
                                ),
                                const SizedBox(height: 5,),
                                // Container(
                                //   height: 2,
                                //   decoration: const BoxDecoration(color: Colors.black),
                                // ),
                              ]
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index){
                      return const SizedBox(height: 20,);
                    },
                    itemCount: snapshot.data['data'].length
                ),
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

        },
      ),
    );
  }

}