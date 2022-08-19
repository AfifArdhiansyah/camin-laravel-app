import 'dart:convert';
import 'package:foodcourt_tenant_flutter/edit_menu_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget{
  MenuScreen({Key? key, this.tenantId});
  final tenantId;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>{

  final String rawUrl = 'http://192.168.0.22:8000/';
  final String urlGetFoodApi = 'http://192.168.0.22:8000/api/food/find/';
  // final String rawUrl = 'http://192.168.1.19:8000/';
  // final String urlGetFoodApi = 'http://192.168.1.19:8000/api/food/find/';

  Future _getFoods() async{
    var response = await http.get(Uri.parse(urlGetFoodApi + widget.tenantId.toString()));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Menu'),
      ),
      body: FutureBuilder(
        future: _getFoods(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index){
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
                      ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  EditMenuScreen(
                                    tenantId: widget.tenantId,
                                    food: snapshot.data['data'][index],)
                              )
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                snapshot.data['data'][index] = value;
                              });
                            }
                            else null;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                  child: Image.network(rawUrl + 'storage/' + snapshot.data['data'][index]['img_path'], width: 130,)
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(snapshot.data['data'][index]['name'], style: TextStyle(color: Colors.black), textAlign: TextAlign.end,),
                                    SizedBox(height: 10,),
                                    Text(snapshot.data['data'][index]['price'].toString(), style: TextStyle(color: Colors.black, fontSize: 12),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                    );
                  },
                  separatorBuilder: (BuildContext context, int index){
                    return SizedBox(height: 10,);
                  },
                  itemCount: snapshot.data['data'].length
              ),
            );
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