import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodcourt_tenant_flutter/home_screen.dart';
import 'package:http/http.dart' as http;

class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tenant Foodcourt',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: Theme.of(context).textTheme.apply(
          fontSizeFactor: 1.1,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _urlApi = 'http://192.168.0.22:8000/api/tenants/';
  // String _urlApi = 'http://192.168.1.19:8000/api/tenants/';

  Future _getUser(String username, String password) async{
    _urlApi = _urlApi + username + '/' + password;
    var response = await http.get(Uri.parse(_urlApi));
    return json.decode(response.body);
  }

  String _message = "";

  _callFuture(context, String username, String password){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder(
            future: _getUser(username, password),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                if(snapshot.data['message'] == "Success"){
                  // return Text("Cucokkk");
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen(data: snapshot.data['data'],))
                    );
                  });
                }
                else {
                  _message = "wrong input";
                  return Text("Salahh");
                };

              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                content: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator.adaptive(),
                      SizedBox(height: 10,),
                      Text('Loading...')
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  const Text("LOGIN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 30,),
                  TextField(
                    controller: _controllerUsername,
                    decoration: const InputDecoration(
                        hintText: "Masukan username tenant...",
                        labelText: "Username",
                        icon: Icon(Icons.people)),
                  ),
                  TextField(
                    controller: _controllerPassword,
                    decoration: const InputDecoration(
                        hintText: "Masukan password...",
                        labelText: "Password",
                        icon: Icon(Icons.lock)),
                  ),
                  const SizedBox(height: 10,),
                  (_message == "wrong input") ? const Text("Password atau Username anda salah", style: TextStyle(color: Colors.red)) : Text(_message, style: TextStyle(color: Colors.green),),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                      onPressed: (){
                        _callFuture(context, _controllerUsername.text, _controllerPassword.text);
                      },
                      child: Text("Log In")
                  )
                ],
              ),
            ),
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
