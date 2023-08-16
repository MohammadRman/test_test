import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_test/view/Create_account.dart';
import 'package:test_test/view/Home.dart';
import 'package:test_test/view/Reset%20password.dart';
import 'package:test_test/view/chat.dart';
import 'package:test_test/view/chatsn.dart';
import 'package:test_test/view/list2.dart';
import 'package:test_test/view/sign_in.dart';
import 'package:test_test/view/stories.dart';
import 'package:test_test/view/test_lo_fi.dart';
import 'package:test_test/view/tez.dart';
import 'controller/Home_controller.dart';
import 'controller/initializeApp.dart';
import 'controller/tes-con.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:compress_images_flutter/compress_images_flutter.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';





File? file;
String? url;

void main() async {
 await initsat();
 await Hive.initFlutter();
 await Hive.openBox("names");
 if(url != null){

 }


 runApp(MyApp());




}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      locale: Get.deviceLocale,
        // home: list2(),


     
      
      getPages: [
        GetPage(name: '/', page:()=> Sign_in(),middlewares: [midd()],bindings: [bi()] ),
        GetPage(name: '/Home', page:()=> Home(chatRoomId: '',),bindings: [bi()]),
        GetPage(name: '/Create', page:()=> Create_account(),bindings: [bi()]),
        GetPage(name: '/Reset', page:()=> Reset_password(),bindings: [bi()]),
        GetPage(name: '/stories', page:()=> stories(),bindings: [bi()]),
        GetPage(name: '/splash', page:()=> splash(pd: ''),bindings: [bi()]),
        GetPage(name: '/chat', page:()=> ChatRoom(chatRoomId:  '',),bindings: [bi()]),
        GetPage(name: '/chats', page:()=> chats(mm: '',idd: '',newDate: '',image: "",t: "",video: '',son: '',pdd: '',fox: null!
            ,msss: '',titl: '',msss2: "",titl2: "",id2: "",so: null,now: ''),bindings: [bi()],),



      ],
    ); 

     
  }
}


class splash extends StatefulWidget {
  String? pd;
   splash ({Key? key,required this.pd});

  @override
  State<splash> createState() =>splash_State();
}

class splash_State extends State<splash> {
  // file = DefaultCacheManager().getFileStream().first;



  @override
Widget build(BuildContext context) {
return Scaffold(
body:
PDF().cachedFromUrl(
  widget.pd!,
placeholder: (progress) => Center(child: Text('$progress %')),
errorWidget: (error) => Center(child: Text(error.toString())),
)

);

}

@override
  void initState() {
  url = widget.pd!;

    super.initState();
  }


}




kk([String? cc]){
  return cc!;
}















































