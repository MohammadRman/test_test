import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test_test/controller/Home_controller.dart';
import '../view/test_lo_fi.dart' as c;

import '../main.dart';
import '../view/test_lo_fi.dart';


class chat_con extends GetxController{
  String ms = '';
  RxString? id1;
   RxBool isLoading = false.obs;
  final au = AudioPlayer().obs;
  // final au = AudioPlayer().obs;
  bool isrr = false;
  List<Map<String,dynamic>> messages2 = [];
  final boxs = Hive.box("names");




  gett(){
  var g =  boxs.keys.map((e){
      final cu = boxs.get(e);
      return {
        'key' : e,
        'id1' : cu['id1'],
        'id2' : cu['id2'],
        'mas' : cu['mas'],
        'tim' : cu['tim'],
        't' : cu['t']
      };
    }).toList();
    messages2 = g.reversed.toList();
//     String sortField = 'tim';
// messages2.sort((a, b) => b[sortField].compareTo(a[sortField]));
    update();

  }












  yyy(bool n){
   isrr = n;
   update();
 }
  yyy2(String n){
    ms = n;
    update();
  }




  RxBool ispl = false.obs;
   Rx<Duration> du = Duration.zero.obs;
  Rx<Duration> pos = Duration.zero.obs;
  // int? maxSliderValue;
   RxBool bb = false.obs;



  

    z1(bool i1, bool i2){
      isLoading.value = i1;
      bb.value = i2;
    update();
  }

  z2(bool y){
    isLoading.value = y;
    update();
  }


  // get_mss(String m){
  //   ms!= m;
  //   update();
  // }

  get_id(String i){
    id1!.value = i;
    update();
  }

  @override
  void onInit() {
      print("=========================================== 222222222222==========================================");


    super.onInit();

  }



  // onPlayerStateChanged(){
  //    au.value.onPlayerStateChanged.listen((event) {
  //        ispl.value = event == PlayerState.playing;
  //    });
  // }

  // onDurationChanged(){
  //    au.value.onDurationChanged.listen((event) {
  //       du.value = event;
  //   });
  // }
  //
  // onPositionChanged(){
  //    au.value.onPositionChanged.listen((event) {
  //       pos.value = event;
  //   });
  //
  // }
  // onPlayerComplete(){
  //   au.value.onPlayerComplete.listen((event) {
  //       bb.value = false;
  //
  //   });
  //
  // }


  Future gg(var value)async{
    final pooo = Duration(seconds: value.toInt());
    await au.value.seek(pooo);
    // await au.value.resume();

  }

  Future d()async{
    
    ;

  }



    String formatTime(Duration d){
    String two(int n)=> n.toString().padLeft(2,'0');
    final h = two(d.inHours);
    final m = two(d.inMinutes.remainder(60));
    final s = two(d.inSeconds.remainder(60));

    return [
      if(d.inHours > 0) h,m,s
    ].join(":");

  }




  
   
    


}
  
  



 



