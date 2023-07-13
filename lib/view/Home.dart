import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_test/main.dart';
import 'package:test_test/view/sign_in.dart';
import '../controller/Home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat.dart';



 Home_controller jj = Get.find();


class Home extends GetView<Home_controller> {
   String chatRoomId;
   Home({super.key,required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(actions: [
      IconButton(onPressed:()async{
          controller.out();
    
      }, icon: Icon(Icons.power_settings_new_outlined,color: Colors.black,))
    ],backgroundColor: Colors.white,centerTitle: true,title: Text('Home',style: 
    TextStyle(color: Colors.black),),),
    body: StreamBuilder(stream: controller.firb.where
    ('id',isNotEqualTo: FirebaseAuth.instance.currentUser!
    .uid).snapshots()
    
    ,builder:(context, snapshot) {
      return ListView.builder(itemCount: snapshot.data?.docs.length,itemBuilder:(context, index) {
        return ListTile(onTap: ()async {

          Get.toNamed('/chat',arguments: {
            'id2': snapshot.data!.docs[index].data()['id']
          });
           controller.idd();





        },title: Text('${snapshot.data?.docs[index].data()['n']}'),);
        
      },);
      

    },)


);
    
  }
}








  