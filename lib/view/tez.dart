import 'dart:io';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// اسم المربع في Hive لتخزين الرسائل
const String hiveBoxName = 'messagesBox';

// اسم المجموعة في Firestore لتخزين الرسائل
const String firestoreCollectionName = 'messagesCollection';

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  List<String> messages = [];
  bool isOnline = false;

  // يتم تهيئة Hive وفتح المربع عند تحميل الشاشة
  @override
  void initState() {
    super.initState();
    initHive();
    checkConnectivity();
  }

  // تهيئة Hive وفتح المربع
  Future<void> initHive() async {
    await Hive.openBox(hiveBoxName);
  }

  // التحقق من حالة الاتصال بالإنترنت
  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isOnline = true;
      });
      syncData();
    } else {
      setState(() {
        isOnline = false;
      });
      fetchOfflineData();
    }
  }

  // استرداد البيانات المخزنة في Hive عندما لا يكون هناك اتصال بالإنترنت
  Future<void> fetchOfflineData() async {
    var box = Hive.box(hiveBoxName);
    setState(() {
      messages = box.values.toList().cast<String>();
    });
  }

  // مزامنة البيانات مع Firestore عندما يكون هناك اتصال بالإنترنت
  Future<void> syncData() async {
    var box = Hive.box(hiveBoxName);
    var firestoreCollection =
    FirebaseFirestore.instance.collection(firestoreCollectionName);

    // قراءة البيانات من Hive
    List<String> offlineData = box.values.toList().cast<String>();

    for (String message in offlineData) {
      await firestoreCollection.add({'message': 'message'});
    }

    // حذف البيانات المخزنة في Hive بعد التزامن
    box.clear();
  }

  // عرض البيانات في ListView
  Widget buildListView() {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(messages[index],style: TextStyle(color: Colors.black),),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: isOnline ? buildListView() : Center(child: Text('Offline',style: TextStyle(color: Colors.black),)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var box = Hive.box(hiveBoxName);
          box.add('ooooooo');
          setState(() {
            messages = box.values.toList().cast<String>();
          });
          print(messages);
          // if (isOnline) {
          //   // إضافة رسالة إلى Firestore
          //   FirebaseFirestore.instance
          //       .collection(firestoreCollectionName)
          //       .add({'message': 'New Message'});
          // } else {
          //   // إضافة رسالة إلى Hive عندما لا يكون هناك اتصال بالإنترنت
          //   var box = Hive.box(hiveBoxName);
          //   box.add('ooooooo');
          //   setState(() {
          //     messages = box.values.toList().cast<String>();
          //   });
          //   print(messages);
          // }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}































//
// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:hive/hive.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import '../controller/chat_cont.dart';
// import '../main.dart';
//
// const String hiveBoxName = 'messagesBox';
//
//
//
//
//
//
//
//
// class test_lo extends StatefulWidget {
//   test_lo({Key? key}) : super(key: key);
//   @override
//   State<test_lo> createState() => _test_loState();
// }
//
// class _test_loState extends State<test_lo> {
//   TextEditingController cont = TextEditingController();
//   final StreamController<List<String>> _streamController =
//   StreamController<List<String>>.broadcast();
//   List<String> messages = [];
//   var xz;
//
//   final Connectivity _connectivity = Connectivity();
//   final StreamController<List<String>> _streamController2 =
//   StreamController<List<String>>.broadcast();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(backgroundColor: Colors.blue,
//         child: Icon(Icons.add),onPressed: (){
//           showModalBottomSheet(context: context, builder: (context) {
//             return Container(width: double.infinity,color: Colors.white,child:
//             Column(mainAxisSize: MainAxisSize.min,children: [
//               Expanded(child: TextFormField(controller: cont,)),
//               MaterialButton(child: Text("Send"),color: Colors.blue,onPressed: ()async{
//                 // _updateConnectionStatus2(cont.text);
//                 mybox!.add({'key1': cont.text, '42': 'life'}).then((addedKey) {
//                   setState(() {
//                     xz = mybox!.get(addedKey)['key1'];
//                   });
//                 });
//
//
//
//
//
//
//
//
//
//
//               },)
//
//
//             ],),);
//           },);
//
//         },) ,
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<List<String>>(
//               stream: _streamController.stream,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   // بيانات صالحة، عرضها في ListView
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ListTile(
//                         title: Text(snapshot.data![index]),
//                       );
//                     },
//                   );
//                 } else if (snapshot.hasError) {
//                   // حدث خطأ أثناء جلب البيانات
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else {
//                   // لا توجد بيانات بعد
//                   return Center(child: CircularProgressIndicator());
//                 }
//               },
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<List<String>>(
//               stream: _streamController2.stream,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   // بيانات صالحة، عرضها في ListView
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ListTile(
//                         title: Text(snapshot.data![index]),
//                       );
//                     },
//                   );
//                 } else if (snapshot.hasError) {
//                   // حدث خطأ أثناء جلب البيانات
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else {
//                   // لا توجد بيانات بعد
//                   return Center(child: CircularProgressIndicator());
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//
//     );
//
//
//   }
//
//
//
//
//   Future<void> initHive() async {
//     await Hive.openBox(hiveBoxName);
//   }
//   @override
//   void initState() {
//     initHive();
//     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//     fetchMessages().listen((messages) {
//       _streamController2.sink.add(messages);
//     });
//
//     super.initState();
//   }
//
// /////// noooo
//   void _updateConnectionStatus2(String x)async {
//     final connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.wifi) {
//       FirebaseFirestore firestore =await FirebaseFirestore.instance;
//       await firestore.collection('mss').add({'mssg': x});
//
//     } else {
//       var box = Hive.box(hiveBoxName);
//       box.add({"m": x});
//       setState(() {
//         messages = box.value.toList().cast<String>();
//       });
//       updateStream();
//       print(messages);
//
//
//     }
//   }
//
//
//
//
//
//
//   /// onn
//   Future<void> syncWithFirebase() async {
//     // var box = Hive.box(hiveBoxName);
//     List<String> offlineData = mybox!.values.toList().cast<String>();
//
//     for (String message1 in offlineData) {
//       // messages.clear();
//       FirebaseFirestore firestore =await FirebaseFirestore.instance;
//       await firestore.collection('mss').add({'mssg': message1}).then((value){
//         mybox!.clear();
//         setState(() {
//           messages.removeLast();
//         });
//
//       });
//       // messages.clear();
//
//       // مسح الكلمة من التخزين المحلي
//     }
//
//   }
//
//
//
//
//   void _updateConnectionStatus(ConnectivityResult connectivityResult) {
//     if (connectivityResult == ConnectivityResult.wifi) {
//       syncWithFirebase();
//       setState(() {
//         messages.removeLast();
//       });
//
//     } else {
//
//     }
//
//
//   }
//
//
//
//
//
//
//
//   ///on
//   void updateStream() {
//     var box = Hive.box(hiveBoxName);
//     setState(() {
//       messages = box!.values.toList().cast<String>();
//     });
//     _streamController.sink.add(messages);
//
//   }
//   /// onmm
//   void dispose() {
//     _streamController.close();
//     _streamController2.close();
//
//     super.dispose();
//   }
//   Stream<List<String>> fetchMessages() {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     Stream<QuerySnapshot> queryStream =
//     firestore.collection('mss').snapshots();
//     Stream<List<String>> messagesStream = queryStream.map((QuerySnapshot querySnapshot) {
//       return querySnapshot.docs.map((DocumentSnapshot documentSnapshot) {
//         return documentSnapshot.get('mssg') as String;
//       }).toList();
//     });
//     return messagesStream;
//   }
//
//
//
// }