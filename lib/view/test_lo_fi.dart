import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../controller/chat_cont.dart';
import '../main.dart';

const String hiveBoxName = 'messagesBox';








class test_lo extends StatefulWidget {
   test_lo({Key? key}) : super(key: key);
   @override
  State<test_lo> createState() => _test_loState();
}

class _test_loState extends State<test_lo> {
  TextEditingController cont = TextEditingController();
  List messages = [];
  var xz;

  final Connectivity _connectivity = Connectivity();
  final boxs = Hive.box("names");
   String? key;
  StreamController<List<Map<String, dynamic>>> _streamController =
  StreamController<List<Map<String, dynamic>>>();
  ScrollController _scrollController = ScrollController();

  chat_con cx = Get.put(chat_con());
  List mergedList = []
  ;List list1 = [12,3];



  List list2 = [4, 5, 6];





  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body:
      Column(
        children: [
          Expanded(
            child: GetBuilder<chat_con>(builder: (controller) {


              return

                         ListView.builder(
                          itemCount: controller.messages2.length | list1.length,
                          itemBuilder: (context, index) {
                            return ListTile(
              title: Text('رسالة: ${controller.messages2[index]['mas']}'),
                              subtitle: Text("${list1}"),
              );
                          }
                        );



                // ListView.builder(
                //   itemCount:controller.messages2.length,
                //   itemBuilder: (context, index) {
                //     mergedList =  controller.messages2 + list1;
                //     return ListTile(
                //       tileColor: Colors.red,
                //       leading: IconButton(icon: Icon(Icons.desktop_windows),onPressed: ()async{
                //         FirebaseFirestore firestore =await FirebaseFirestore.instance;
                //         await firestore.collection('mss').add({
                //           "mas": mergedList[index]['mas']
                //
                //         }).then((value) {
                //            _deleteAllData(index)    ;
                //           print('============================================1222=======================================');
                //         });
                //
                //
                //       },),
                //
                //       title: Text('${mergedList[index]['mas']}'),
                //
                //     );
                //   },
                // );

            },),
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance.collection('mss').snapshots(),
// // initialData: [FirebaseFirestore.instance.collection('mss').snapshots(),],
//               builder: (context, snapshot){
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
// // استخدم snapshot.data للوصول إلى البيانات المستلمة من Firestore
//                   return SingleChildScrollView(reverse: true,physics: BouncingScrollPhysics(),child: Column(children: [
//                     ListView(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),children: [
//                       ListView.builder(
//                         shrinkWrap: true,physics: NeverScrollableScrollPhysics(),reverse: true,
//                         itemCount: snapshot.data!.docs.length,
//                         itemBuilder: (context, index) {
//                           Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
//                           return ListTile(
//                             tileColor: Colors.blue,
//                             title: Text('${data["ss"]}'),
//                           );
//                         },
//                       ),
//
//
//                     ],)
//
//                   ],),);
//                 }
//               },
//
//
//             ),
          ),
          Expanded(flex: 0,child: Container(width: double.infinity,height: 70,color: Colors.white,child:
          Row(children: [
            Expanded(child: TextFormField(controller: cont,)),
            GetBuilder<chat_con>(builder: (controller) {
              return  IconButton(onPressed:()async{
                 // boxs.clear();
                boxs.add({'mas':cont.text}).then((value){
                  controller.gett();
                });

              }, icon: Icon(Icons.add));
            },)
          ],),))
        ],
      ),








    );




    }









  //
  // Future<void> syncWithFirebase() async {
  //   for (var map in cx.messages2) {
  //     FirebaseFirestore firestore =await FirebaseFirestore.instance;
  //     await firestore.collection('mss').add({'n': map['n'],'ag': map['ag']}).then((value) {
  //       _deleteAllData()    ;
  //       print('============================================1222=======================================');
  //     });
  //   }
  //
  // }


  @override
  void initState() {
      // fetchMessages();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    cx. gett();
    print(mergedList);


    super.initState();
  }



  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi) {
      // syncWithFirebase();


    } else {

    }


   }
  // void fetchMessages() {
  //   FirebaseFirestore.instance.collection('mss').snapshots().listen((snapshot) {
  //     if (snapshot.docs.isNotEmpty) {
  //       // مسح البيانات القديمة قبل تحديثها بالبيانات الجديدة
  //     cx.messages2.clear();
  //
  //       // حلقة لتحويل البيانات من DocumentSnapshot إلى Map وتخزينها في القائمة
  //       snapshot.docs.forEach((document) {
  //       list2.add(document.data() as Map<String,dynamic>);
  //       print(document.data());
  //       });
  //
  //       // إعادة بناء واجهة التطبيق لعرض البيانات المحدثة
  //       setState(() {});
  //     }
  //   });
  // }
  void _deleteAllData(int k) async {
    final box = Hive.box("names"); // الحصول على المخزّن بالاسم "names"
    await box.deleteAt(k);
   await cx.gett();
  }



  }





// StreamBuilder(
// stream: FirebaseFirestore.instance.collection('mss').snapshots(),
// // initialData: [FirebaseFirestore.instance.collection('mss').snapshots(),],
// builder: (context, snapshot){
// if (snapshot.connectionState == ConnectionState.waiting) {
// return CircularProgressIndicator();
// } else if (snapshot.hasError) {
// return Text('Error: ${snapshot.error}');
// } else {
// // استخدم snapshot.data للوصول إلى البيانات المستلمة من Firestore
// return ListView.builder(
// shrinkWrap: true,physics: NeverScrollableScrollPhysics(),reverse: true,
// itemCount: snapshot.data!.docs.length,
// itemBuilder: (context, index) {
// Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
// return ListTile(
// tileColor: Colors.blue,
// title: Text('${data['n']}'),
// );
// },
// );
// }
// },
//
//
// ),


////////////////////////////////////////////


//
//
// Column(
// children: [
// Expanded(
// child: StreamBuilder(
// stream: FirebaseFirestore.instance.collection('mss').snapshots(),
// // initialData: [FirebaseFirestore.instance.collection('mss').snapshots(),],
// builder: (context, snapshot){
// if (snapshot.connectionState == ConnectionState.waiting) {
// return CircularProgressIndicator();
// } else if (snapshot.hasError) {
// return Text('Error: ${snapshot.error}');
// } else {
// // استخدم snapshot.data للوصول إلى البيانات المستلمة من Firestore
// return SingleChildScrollView(physics: BouncingScrollPhysics(),child: Column(children: [
// ListView(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),children: [
// ListView.builder(
// shrinkWrap: true,physics: NeverScrollableScrollPhysics(),reverse: true,
// itemCount: snapshot.data!.docs.length,
// itemBuilder: (context, index) {
// Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
// return ListTile(
// tileColor: Colors.blue,
// title: Text('${data['n']}'),
// );
// },
// ),
// GetBuilder<chat_con>(builder: (controller) {
// return    ListView.builder( controller: _scrollController,
//
// shrinkWrap: true,reverse: false,
// itemCount:controller.messages2.length,
// itemBuilder: (context, index) {
// return ListTile(
// tileColor: Colors.red,
// title: Text('${controller.messages2[index]['n']}'),
// // snapshot.data![index]['n']
// );
// },
// );
// },)
//
// ],)
//
// ],),);
// }
// },
//
//
// ),
// ),
// Expanded(flex: 0,child: Container(width: double.infinity,height: 70,color: Colors.white,child:
// Row(children: [
// Expanded(child: TextFormField(controller: cont,)),
// GetBuilder<chat_con>(builder: (controller) {
// return  IconButton(onPressed:()async{
// scrollToBottom();
// boxs.add({'n':cont.text,'ag':'20'}).then((value){
// controller.gett();
// });
//
// }, icon: Icon(Icons.add));
// },)
// ],),))
// ],
// ),

