
import 'package:flutter/material.dart';

class FoodDetailScreen extends StatelessWidget{
  FoodDetailScreen({super.key, required this.food});
  final food;
  final String rawUrl = 'http://192.168.0.22:8000/';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(alignment: Alignment.center ,child: Image.network('${rawUrl}storage/' + food['img_path'], width: width*0.9,)),
            SizedBox(height: 20,),
            Text(food['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            SizedBox(height: 20,),
            Flexible(child: Text(food['description'])),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Harga'),
                Text(food['price'].toString())
              ],
            )
          ],
        ),
      ),
    );
  }
  
}