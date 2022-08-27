import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget{
  CheckoutScreen({super.key, required this.order});
  final order;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final String urlGetFoodApi = 'http://192.168.0.22:8000/api/foods/all';

  // final String rawUrl = 'http://192.168.1.19:8000/';
  late int totals;
  var requested = false;
  Future _getFoods() async{
    totals = 0;
    var response = await http.get(Uri.parse(urlGetFoodApi));
    var foods = json.decode(response.body);
    List <Map> orderedFoods = [];
    foods['data'].forEach((value) {
      if(widget.order.containsKey(value['id'].toString())){
        orderedFoods.add(value);
        totals = (totals + value['price'] * widget.order[value['id'].toString()]) as int;
      }
    });
    requested = true;
    return orderedFoods;
  }

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerNote = TextEditingController();

  final isSelected = <bool>[false, false, true];
  final option = 3;

  Future<Transaction>? _futureTransaction;

  @override
  Widget build(BuildContext context) {
    // debugPrint(widget.order.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            TextField(
              controller: _controllerName,
              decoration: const InputDecoration(
                  hintText: "Masukan nama anda...",
                  labelText: "Name*",
                  icon: Icon(Icons.person)),
            ),
            const SizedBox(height: 20,),
            const Text('Your Order', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            const SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10)
              ),
              child: FutureBuilder(
                future: (!requested)? _getFoods() : null,
                  builder: (BuildContext context, AsyncSnapshot<dynamic> foods){
                    if(foods.hasData){
                      // int? totals = 0;
                      return Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index){
                              // totals = (totals! + foods.data[index]['price'] * widget.order[foods.data[index]['id'].toString()]) as int?;
                              return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(foods.data[index]['name'] + ' x ' + widget.order[foods.data[index]['id'].toString()].toString()),
                                    Text((foods.data[index]['price'] * widget.order[foods.data[index]['id'].toString()]).toString()),
                                  ],
                                );
                              },
                              separatorBuilder: (BuildContext context, int index){
                                return const SizedBox(height: 5,);
                              },
                              itemCount: foods.data.length
                          ),
                          const SizedBox(height: 5,),
                          Container(height: 1, decoration: const BoxDecoration(color: Colors.black),),
                          const SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total'),
                              Text(totals.toString())
                            ],
                          )
                        ],
                      );
                    }
                    else{
                      return SizedBox();
                    }
                  }
              ),
            ),
            TextField(
              controller: _controllerNote,
              decoration: const InputDecoration(
                  hintText: "Tulis catatan pesanan...",
                  labelText: "Note (opsional)",
                  icon: Icon(Icons.edit)),
            ),
            const SizedBox(height: 20,),
            const Text('choose payment method'),
            const SizedBox(height: 20,),
            ToggleButtons(
              borderRadius: BorderRadius.circular(10),
                isSelected: isSelected,
                onPressed: (index) {
                  setState(() {
                    for(int i=0; i<option; i++){
                      if(isSelected[i] && i!=index) isSelected[i] = !isSelected[i];
                    }
                    if(!isSelected[index]) isSelected[index] = !isSelected[index];

                  });
                },
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/option-10,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Go Pay'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/option-10,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('OVO'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/option-10,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Cashier (cash)'),
                    ),
                  ),
                ]
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            var paid = false;
            if(!isSelected[option-1]) paid = true;
            createTransasction(context, _controllerName.text, widget.order, paid, _controllerNote.text);
          });
        },
        label: Row(
          children: const [
            Text('order'),
            SizedBox(width: 10,),
            Icon(Icons.payment)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

const String urlStoreTransactionApi = 'http://192.168.0.22:8000/api/store-transaction';

Future<Transaction> createTransasction(BuildContext context,String name, Map order, bool paid, [String note = '']) async {
  final response = await http.post(
    Uri.parse(urlStoreTransactionApi),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      'note': note,
      'order': order,
      'paid': paid
    }),
  );

  if (response.statusCode == 201) {
    Navigator.pop(context);
    return Transaction.fromJson(jsonDecode(response.body));
  } else {
    Navigator.pop(context);
    throw Exception('Failed to create transaction.');
  }
}

class Transaction {
  final int id;
  final int total;

  const Transaction({required this.id, required this.total});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      total: json['total'],
    );
  }
}