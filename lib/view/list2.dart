import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/chat_cont.dart';

class list2 extends StatefulWidget {
  const list2({Key? key}) : super(key: key);

  @override
  State<list2> createState() => _list2State();
}

class _list2State extends State<list2> {
  List<String> names = ['أحمد', 'محمد', 'نور', 'لينا', 'سارة'];
  List<int> ages = [25, 30, 22, 28, 35];
  chat_con cx = Get.put(chat_con());


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: Column(children: [
            Container(color: Colors.blue,width: double.infinity,height: 50,),
            TabBar(tabs: [
              Tab(icon: Icon(Icons.add,color: Colors.cyan,),),
              Tab(icon: Icon(Icons.add,color: Colors.cyan,),),
            ]),
            Expanded(
              child: TabBarView(children: [
                Container(color: Colors.cyanAccent,),
                Container(color: Colors.black,),
              ]),
            ),

            Container(width: double.infinity,height: 100,color: Colors.red,)
            
          ],)

      ),
    );
  }
}

