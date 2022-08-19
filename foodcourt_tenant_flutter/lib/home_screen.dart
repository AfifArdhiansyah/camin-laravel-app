import 'package:flutter/material.dart';
import 'package:foodcourt_tenant_flutter/history_screen.dart';
import 'package:foodcourt_tenant_flutter/menu_screen.dart';
import 'package:foodcourt_tenant_flutter/new_menu_screen.dart';
import 'package:foodcourt_tenant_flutter/queue_screen.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key, this.data}) : super(key: key);
  final data;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var dataTenant = widget.data;
    return Scaffold(
      appBar: AppBar(
        title: Text(dataTenant["name"]),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
              ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QueueScreen(tenantId: dataTenant['id'],)));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(Icons.emoji_people_rounded, size: 80, color: Colors.black,),
                    Text('Queue', style: TextStyle(color: Colors.black),),
                  ],
                )
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MenuScreen(tenantId: dataTenant['id'],)));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(Icons.menu_book_rounded, size: 80, color: Colors.black,),
                    Text('Menu', style: TextStyle(color: Colors.black),),
                  ],
                )
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryScreen(tenantId: dataTenant['id'])));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(Icons.history, size: 80, color: Colors.black,),
                    Text('History', style: TextStyle(color: Colors.black),),
                  ],
                )
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NewMenuScreen(tenantId: dataTenant['id'],)));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(Icons.add_shopping_cart_rounded, size: 80, color: Colors.black,),
                    Text('New Menu', style: TextStyle(color: Colors.black),),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}