import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodcourt_customer_flutter/checkout_screen.dart';
import 'package:foodcourt_customer_flutter/food_detail.dart';
import 'package:http/http.dart' as http;

class MenuScreen extends StatefulWidget{
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final String rawUrl = 'http://192.168.0.22:8000/';
  final String urlGetFoodApi = 'http://192.168.0.22:8000/api/food/find/';
  final String urlGetTenantApi = 'http://192.168.0.22:8000/api/tenants/all';

  // final String rawUrl = 'http://192.168.1.19:8000/';
  Future _getTenants() async{
    var response = await http.get(Uri.parse(urlGetTenantApi));
    return json.decode(response.body);
  }

  Future _getFoods(int tenant_id) async{
    var response = await http.get(Uri.parse(urlGetFoodApi + tenant_id.toString()));
    return json.decode(response.body);
  }

  final Map<String, int> orderItem = {};
  late int foodsLength = 0;
  bool checkItem = false;

  _checkOrder(int length){
    for(int i=1; i<=length; i++){
      if(orderItem['order' + i.toString()]! > 0) {
        checkItem = true;
        return;
      }
      else checkItem = false;
    }
  }

  _getOrder(int length){
    Map<String, int> order = {};
    for(int i=1; i<=length; i++){
      if(orderItem['order' + i.toString()]! > 0) {
        order[i.toString()] = orderItem['order' + i.toString()]!;
      }
    }
    return order;
  }

  late bool itemAdded;
  @override
  void initState() {
    itemAdded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foodcourt Menu'),
        // title: Text(checkItem.toString()),
      ),
      body: FutureBuilder(
        future: _getTenants(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> tenants) {
          if(tenants.hasData){
            return ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: 70, top: 10, left: 10, right: 10),
                shrinkWrap: true,
                  itemBuilder: (BuildContext context, int tenantIndex){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        Text(tenants.data['data'][tenantIndex]['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                        Container(height: 10),
                        FutureBuilder(
                          future: _getFoods(tenants.data['data'][tenantIndex]['id']),
                            builder: (BuildContext context, AsyncSnapshot<dynamic> foods){
                              if(foods.hasData){
                                // if(!itemAdded) orderItem['order'+foods.data['data'][tenantIndex]['id'].toString()] = 0;
                                  return GridView.count(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.7,
                                    children: List<Widget>.generate(
                                        foods.data['data'].length,
                                            (foodIndex) {
                                              if(!itemAdded) {
                                                orderItem['order${foods.data['data'][foodIndex]['id']}'] = 0;
                                                foodsLength++;
                                              }
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom: 2),
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (contexxt)=>FoodDetailScreen(food: foods.data['data'][foodIndex])));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                                    child: Column(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(flex: 10,child: Image.network('${rawUrl}storage/' + foods.data['data'][foodIndex]['img_path'])),
                                                        Expanded(flex: 3, child: Text(foods.data['data'][foodIndex]['name'],style: const TextStyle(color: Colors.black),textAlign: TextAlign.center,)),
                                                        Expanded(flex: 2,child: Text(foods.data['data'][foodIndex]['price'].toString(),style: const TextStyle(color: Colors.black),textAlign: TextAlign.center,)),
                                                        Expanded(
                                                          flex: 3,
                                                          child: (orderItem['order${foods.data['data'][foodIndex]['id']}']! > 0)?
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              IconButton(
                                                                  onPressed: (){
                                                                    setState(() {
                                                                      if(orderItem['order${foods.data['data'][foodIndex]['id']}']!>0) {
                                                                        orderItem['order${foods.data['data'][foodIndex]['id']}'] = (orderItem['order${foods.data['data'][foodIndex]['id']}']! - 1);
                                                                      }
                                                                      _checkOrder(foodsLength);
                                                                    });
                                                                  },
                                                                  icon: const Icon(Icons.remove),
                                                                color: Colors.green,
                                                              ),
                                                              Text(orderItem['order${foods.data['data'][foodIndex]['id']}'].toString(), style: const TextStyle(color: Colors.black),),
                                                              IconButton(
                                                                color: Colors.green,
                                                                  onPressed: (){
                                                                    setState(() {
                                                                      orderItem['order${foods.data['data'][foodIndex]['id']}'] = (orderItem['order${foods.data['data'][foodIndex]['id']}']! + 1);
                                                                      _checkOrder(foodsLength);
                                                                    });
                                                                  },
                                                                  icon: const Icon(Icons.add)
                                                              ),
                                                            ],
                                                          ) :
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  itemAdded = true;
                                                                  orderItem['order${foods.data['data'][foodIndex]['id']}'] = 1;
                                                                  _checkOrder(foodsLength);
                                                                });
                                                                },
                                                              child: const Text('Order')
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                    )
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
                            }
                        ),
                        const SizedBox(height: 10,)
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index){
                    return Container(height: 20);
                  },
                  itemCount: tenants.data['data'].length
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
      floatingActionButton: (checkItem)? SizedBox(
        width: MediaQuery.of(context).size.width*0.6,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckoutScreen(order: _getOrder(foodsLength))));
          },
          label: Row(
            children: const [
              Text('checkout'),
              SizedBox(width: 10,),
              Icon(Icons.shopping_basket_rounded)
            ],
          ),
        ),
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

  }
}