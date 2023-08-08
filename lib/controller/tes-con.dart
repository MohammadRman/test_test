import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkController extends GetxController {
  // final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    // _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // void _updateConnectionStatus(ConnectivityResult connectivityResult) {
  //
  //   if (connectivityResult == ConnectivityResult.none) {
  //     Get.rawSnackbar(
  //         messageText: const Text(
  //             'PLEASE CONNECT TO THE INTERNET',
  //             style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 14
  //             )
  //         ),
  //         isDismissible: false,
  //         duration: const Duration(days: 1),
  //         backgroundColor: Colors.red[400]!,
  //         icon : const Icon(Icons.wifi_off, color: Colors.white, size: 35,),
  //         margin: EdgeInsets.zero,
  //         snackStyle: SnackStyle.GROUNDED
  //     );
  //   } else {
  //     syncWithFirebase();
  //
  //   }
  // }
  //
  // Future<void> syncWithFirebase() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String word22 =await prefs.getString('word').toString();
  //   if (word22 != 'null') {
  //     // حفظ الكلمة في Firebase
  //     FirebaseFirestore firestore =await FirebaseFirestore.instance;
  //     await firestore.collection('words').add({'word': word22});
  //
  //     // مسح الكلمة من التخزين المحلي
  //     await prefs.remove('word');
  //   }
  //
  // }

}




