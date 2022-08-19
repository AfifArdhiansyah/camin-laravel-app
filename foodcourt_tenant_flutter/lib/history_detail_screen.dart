import 'package:flutter/material.dart';

class HistoryDetail extends StatelessWidget{
  HistoryDetail({Key? key, this.order});
  final order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Detail'),
      ),
      body: Padding(
          padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            Text(order['date_time']),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Nama'),
                Text(order['name']),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                  padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(order['order'][index]['name'] + ' x' + order['order'][index]['quantity'].toString()),
                              Text((order['order'][index]['price'] * order['order'][index]['quantity']).toString())
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index){
                          return SizedBox(height: 5,);
                        },
                        itemCount: order['order'].length
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(color: Colors.black),
                      height: 2,
                      child: null,
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total'),
                        Text(order['total'].toString()),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
  
}