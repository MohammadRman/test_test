import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_test/controller/stories_controller.dart';
import 'package:test_test/view/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../firebase_options.dart';
import '../main.dart';
import '../view/sign_in.dart';
import 'chat_cont.dart';

class Home_controller extends GetxController{
  GlobalKey<FormState> f1  = GlobalKey<FormState>();
  GlobalKey<FormState> f2  = GlobalKey<FormState>();
   GlobalKey<FormState> f3  = GlobalKey<FormState>();
   var firb =  FirebaseFirestore.instance.collection('test');
  RxString kkk = ''.obs ;

  String? em;
 String? pas ;
 // String? id2;
  RxString id2 = ''.obs;
 String? mss;
 String? idss;
 String? nam;
 RxString voiceFilePath = ''.obs;
  // final fo = FocusNode().obs;

 Future voi()async{
  final appDocumentsDir =await getApplicationDocumentsDirectory();
 voiceFilePath.value ='${appDocumentsDir.path}/recording.aac';
 }




 get_n(String z){
  nam = z;
  update();
}

  s(String fd){
    kkk.value = fd;

  }

get_mss(String z){
  mss = z;
  update();
}

get_idss(String ss){
  idss = ss;
  update();
}

 idd(){
  id2.value = Get.arguments['id2'];
  update();
 }


 dele(String url)async{
  await FirebaseStorage.instance.refFromURL(url).delete();
 }

 
  emil(String e){
     em = e;
    update();
  }
  password(String p){
     pas = p;
     update();
  }

   Future cr()async{
    var ff = f3?.currentState;
    if(ff!.validate()){
      ff.save();
          try {
     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: em!,
    password: pas!,
  ).then((value) => {
    add(nam!),
    Get.offNamed('/Home'),
     Get.snackbar('','',snackPosition:SnackPosition.TOP,titleText: Text(''),messageText: Text("Home",style: TextStyle(color: Colors.white),)
    ,duration: Duration(seconds: 3),
    borderRadius:20.0,backgroundColor:Colors.blue,
  )
    

  });
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');

    Get.snackbar('','',snackPosition:SnackPosition.TOP,titleText: Text("weak-password",style: TextStyle(color: Colors.white),),messageText: Text("The password provided is too weak.",style: TextStyle(color: Colors.white))
    ,duration: Duration(seconds: 3),
    borderRadius:20.0,backgroundColor:Colors.red,
  );
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    Get.snackbar('','',snackPosition:SnackPosition.TOP,titleText: Text("email-already-in-use",style: TextStyle(color: Colors.white)),messageText: Text("The account already exists for that email.",style: TextStyle(color: Colors.white))
    ,duration: Duration(seconds: 3),
    borderRadius:20.0,backgroundColor:Colors.red,
  );
    
  }
} catch (e) {
  print(e);
}
   }

    }
    

    Future si()async{
  var fff = f1.currentState;
  if(fff != null){
    if(fff.validate()){
    fff.save();
    try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: em!,
    password: pas!
  ).then((value) => Get.offNamed('/Home'));
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
    Get.snackbar('','',snackPosition:SnackPosition.TOP,titleText: Text("user-not-found",style: TextStyle(color: Colors.white)),messageText: Text("No user found for that email.",style: TextStyle(color: Colors.white))
    ,duration: Duration(seconds: 3),
    borderRadius:20.0,backgroundColor:Colors.red,
  );
    

  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
      Get.snackbar('','',snackPosition:SnackPosition.TOP,titleText: Text("wrong-password",style: TextStyle(color: Colors.white)),messageText: Text("Wrong password provided for that user.",style: TextStyle(color: Colors.white))
    ,duration: Duration(seconds: 3),
    borderRadius:20.0,backgroundColor:Colors.red,
  );
   
  }
}
  }
  }
}
Future pp()async{
  var v = f2?.currentState;
  if(v!.validate()){
    v.save();
    try {
      await FirebaseAuth.instance
    .sendPasswordResetEmail(email: em!);
     Get.snackbar('','',snackPosition:SnackPosition.TOP,titleText: Text(""),messageText: Text("TT",style: TextStyle(color: Colors.white))
    ,duration: Duration(seconds: 3),
    borderRadius:20.0,backgroundColor:Colors.blue,
  );
     
    

} catch(e){
    print('e.message');


}on FirebaseAuthException catch (e) {
  print('e.message');

}
  }
}

Future out()async{
    await FirebaseAuth.instance.signOut().then((value) {
      return Get.offAllNamed('/');
    });
}





}


class bi extends Bindings{
  @override
  void dependencies() {
    Get.put(Home_controller());
   Get.put(stories_contlooer());
    Get.put(chat_con());
   

  }

}

class midd extends GetMiddleware{
 
  @override
  RouteSettings? redirect(String? route) {
    if(FirebaseAuth.instance.currentUser != null){
      return RouteSettings(name: '/Home');
    }
    return null;
  }


}



  
  Future add(String nz)async{
    Map<String,dynamic> m = {'n':nz,'id':FirebaseAuth.instance.currentUser!.uid};
    await FirebaseFirestore.instance.collection('test').doc(FirebaseAuth.instance.currentUser!.uid).set(m).then((value) => null).catchError((error){
    });
  }








 