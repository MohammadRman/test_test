import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/Home_controller.dart';
Home_controller cc = Get.find();


class Reset_password extends GetView<Home_controller> {
  const Reset_password({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Reset password',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Reset password',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Form(key: controller.f2,child:  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'isEmpty';
                      }else{
                        return null;
                      }
                    },
                    onSaved: (newValue) {
                      controller.emil(newValue!);
                      
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email'),
                  ),),
                  SizedBox(height: 18,)
               ,MaterialButton(onPressed:()async{
                controller.pp();
               },child: Text('create account'),color: Colors.blue,textColor: Colors.white,
               shape: StadiumBorder(),padding: EdgeInsets.symmetric(horizontal: 90,vertical: 13),) ],
              ),
            )
          ],
        ),
      ),
    );
  }
}




////======================================================================
///
///
///
///
///
// ///
// c.animateTo(
  //   c.position.maxScrollExtent,
  //   duration: const Duration(milliseconds: 300),
  //   curve: Curves.easeOut,
  // );




  // / return ListView.builder(
                     
                    //     controller: c,
                    //     shrinkWrap: true,
                      
                    //     itemCount: snapshot.data!.docs.length,
                    //     itemBuilder: (context, index) {
                    //       bool isSameDate = false;
                    //       String? newDate = '';
                    //
                    //       final DateTime date = returnDateAndTimeFormat(
                    //           snapshot.data!.docs[index].data()['tim']);
                    //
                    //       if (index == 0 && snapshot.data!.docs.length == 1) {
                    //         newDate = groupMessageDateAndTime(
                    //                 snapshot.data!.docs[index].data()['tim'])
                    //             .toString();
                    //       } else if (index == snapshot.data!.docs.length - 1) {
                    //         newDate = groupMessageDateAndTime(
                    //                 snapshot.data!.docs[index].data()['tim'])
                    //             .toString();
                    //       } else {
                    //         final DateTime date = returnDateAndTimeFormat(
                    //             snapshot.data!.docs[index].data()['tim']);
                    //         final DateTime prevDate = returnDateAndTimeFormat(
                    //             snapshot.data!.docs[index + 1].data()['tim']);
                    //         isSameDate = date.isAtSameMomentAs(prevDate);
                    //
                    //         if (kDebugMode) {
                    //           print("$date $prevDate $isSameDate");
                    //         }
                    //         newDate = isSameDate
                    //             ? ''
                    //             : groupMessageDateAndTime(snapshot
                    //                     .data!.docs[index - 1]
                    //                     .data()['tim'])
                    //                 .toString();
                    //       }
                    //
                    //       return Padding(
                    //         padding: const EdgeInsets.only(top: 0),
                    //         child: Column(
                    //           crossAxisAlignment:
                    //               snapshot.data!.docs[index].data()['id1'] ==
                    //                       FirebaseAuth.instance.currentUser!.uid
                    //                   ? CrossAxisAlignment.start
                    //                   : CrossAxisAlignment.end,
                    //           children: [
                    //             if (newDate.isNotEmpty)
                    //               Center(
                    //                   child: Container(
                    //                       decoration: BoxDecoration(
                    //                           color: Color(0xffE3D4EE),
                    //                           borderRadius:
                    //                               BorderRadius.circular(20)),
                    //                       child: Padding(
                    //                         padding: const EdgeInsets.all(10.0),
                    //                         child: Text(newDate),
                    //                       ))),
                    //             snapshot.data!.docs[index].data()['id1'] ==
                    //                     FirebaseAuth.instance.currentUser!.uid
                    //                 ? Padding(
                    //                     padding: const EdgeInsets.all(12.0),
                    //                     child: Container(
                    //                       width: 80,
                    //                       decoration: BoxDecoration(
                    //                           color: Colors.blue,
                    //                           borderRadius: BorderRadius.only(
                    //                               topLeft: Radius.circular(16),
                    //                               topRight: Radius.circular(16),
                    //                               bottomLeft:
                    //                                   Radius.circular(16))),
                    //                       child: Center(
                    //                         child: Text(
                    //                           "${snapshot.data!.docs[index].data()['mas']}",
                    //                           style: TextStyle(
                    //                               color: Colors.white),
                    //                         ),
                    //                       ),
                    //                       height: 50,
                    //                     ),
                    //                   )
                    //                 : Padding(
                    //                     padding: const EdgeInsets.all(12.0),
                    //                     child: Container(
                    //                       width: 80,
                    //                       decoration: BoxDecoration(
                    //                           color: Colors.red,
                    //                           borderRadius: BorderRadius.only(
                    //                               topLeft: Radius.circular(16),
                    //                               topRight: Radius.circular(16),
                    //                               bottomRight:
                    //                                   Radius.circular(16))),
                    //                       child: Center(
                    //                         child: Text(
                    //                           "${snapshot.data!.docs[index].data()['mas']}",
                    //                           style: TextStyle(
                    //                               color: Colors.white),
                    //                         ),
                    //                       ),
                    //                       height: 50,
                    //                     ),
                    //                    )
                    //           ],
                    //         ),
                    //       );
                    //     });


////// ===========================================================================================
///
///
///
///
/// 
//   StreamBuilder(
//                 stream: databaseReference.onValue,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: Center()
//                     );
//                   }
//                   if (snapshot.hasData) {
//
//
//
//
//
//
//
//                     // return ListView.builder(
//                     //
//                     //     controller: c,
//                     //     itemCount: snapshot.data!.snapshot.children.length,
//                     //     itemBuilder: (context, index) {
//                     //     return ListTile(title: Text("${ls[index]['mas']}"));
//                     //
//                     //     },
//
//                         // itemCount: snapshot.data!.docs.length,
//                         // itemBuilder: (context, index) {
//                         //   var now1 = snapshot.data!.docs[index].data()['now'];
//
//
//
//
//
//                           // return snapshot.data!.docs[index].data()['id1'] ==
//                           //               FirebaseAuth.instance.currentUser!.uid
//                           //           ? Padding(
//                           //               padding: const EdgeInsets.all(12.0),
//                           //               child: Container(
//                           //                 width: 80,
//                           //                 decoration: BoxDecoration(
//                           //                     color: Colors.blue,
//                           //                     borderRadius: BorderRadius.only(
//                           //                         topLeft: Radius.circular(16),
//                           //                         topRight: Radius.circular(16),
//                           //                         bottomLeft:
//                           //                             Radius.circular(16))),
//                           //                 child: Center(
//                           //                   child: Text(
//                           //                     "${snapshot.data!.docs[index].data()['mas']}",
//                           //                     style: TextStyle(
//                           //                         color: Colors.white),
//                           //                   ),
//                           //                 ),
//                           //                 height: 50,
//                           //               ),
//                           //             )
//                           //           : Padding(
//                           //               padding: const EdgeInsets.all(12.0),
//                           //               child: Container(
//                           //                 width: 80,
//                           //                 decoration: BoxDecoration(
//                           //                     color: Colors.red,
//                           //                     borderRadius: BorderRadius.only(
//                           //                         topLeft: Radius.circular(16),
//                           //                         topRight: Radius.circular(16),
//                           //                         bottomRight:
//                           //                             Radius.circular(16))),
//                           //                 child: Center(
//                           //                   child: Text(
//                           //                     "${snapshot.data!.docs[index].data()['mas']}",
//                           //                     style: TextStyle(
//                           //                         color: Colors.white),
//                           //                   ),
//                           //                 ),
//                           //                 height: 50,
//                           //               ),
//                           //              );
//                           bool isSameDate = false;
//                           String? newDate = '';
//
//                           final DateTime date = returnDateAndTimeFormat(
//                               snapshot.data!.docs[index].data()['tim']);
//
//                           if (index == 0 && snapshot.data!.docs.length == 1) {
//                             newDate = groupMessageDateAndTime(
//                                     snapshot.data!.docs[index].data()['tim'])
//                                 .toString();
//                           } else if (index == snapshot.data!.docs.length - 1) {
//                             newDate = groupMessageDateAndTime(
//                                     snapshot.data!.docs[index].data()['tim'])
//                                 .toString();
//                           } else {
//                             final DateTime date = returnDateAndTimeFormat(
//                                 snapshot.data!.docs[index].data()['tim']);
//                             final DateTime prevDate = returnDateAndTimeFormat(
//                                 snapshot.data!.docs[index + 1].data()['tim']);
//                             isSameDate = date.isAtSameMomentAs(prevDate);
//
//                             if (kDebugMode) {
//                               print("$date $prevDate $isSameDate");
//                             }
//                             newDate = isSameDate
//                                 ? ''
//                                 : groupMessageDateAndTime(snapshot
//                                         .data!.docs[index - 1]
//                                         .data()['tim'])
//                                     .toString();
//                           }
//
//                           return Padding(
//                             padding: const EdgeInsets.only(top: 0),
//                             child: Column(
//                               crossAxisAlignment:
//                                   snapshot.data!.docs[index].data()['id1'] ==
//                                           FirebaseAuth.instance.currentUser!.uid
//                                       ? CrossAxisAlignment.start
//                                       : CrossAxisAlignment.end,
//                               children: [
//                                 if (newDate.isNotEmpty)
//                                   Center(
//                                       child: Container(
//                                           decoration: BoxDecoration(
//                                               color: Color(0xffE3D4EE),
//                                               borderRadius:
//                                                   BorderRadius.circular(20)),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(10.0),
//                                             child: Text(newDate),
//                                           ))),
//                                 snapshot.data!.docs[index].data()['id1'] ==
//                                         FirebaseAuth.instance.currentUser!.uid
//                                     ? Padding(
//                                         padding: const EdgeInsets.all(12.0),
//                                         child: Container(
//                                           width: 80,
//                                           decoration: BoxDecoration(
//                                               color: Colors.blue,
//                                               borderRadius: BorderRadius.only(
//                                                   topLeft: Radius.circular(16),
//                                                   topRight: Radius.circular(16),
//                                                   bottomLeft:
//                                                       Radius.circular(16))),
//                                           child: Center(
//                                             child: Text(
//                                               "${snapshot.data!.docs[index].data()['mas'] + "${zz.gett(context: context, tt: now1)}"}",
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             )
//                                           ),
//                                           height: 50,
//                                         ),
//                                       )
//                                     : Padding(
//                                         padding: const EdgeInsets.all(12.0),
//                                         child: Container(
//                                           width: 80,
//                                           decoration: BoxDecoration(
//                                               color: Colors.red,
//                                               borderRadius: BorderRadius.only(
//                                                   topLeft: Radius.circular(16),
//                                                   topRight: Radius.circular(16),
//                                                   bottomRight:
//                                                       Radius.circular(16))),
//                                           child: Center(
//                                             child: Text(
//                                               "${snapshot.data!.docs[index].data()['mas']}",
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                           height: 50,
//                                         ),
//                                        )
//                               ],
//                             ),
//                            );
//                         );
//                   }
//
//
//                   return Container();
//                 },
//               )),




// List<Asset> resultList1 = [];
// resultList1 = await MultiImagePicker.pickImages(
//   selectedAssets: images,
//
//   cupertinoOptions: CupertinoOptions(
//
//     doneButton: UIBarButtonItem(title: 'Confirm', tintColor: Colors.blue),
//     cancelButton: UIBarButtonItem(title: 'Cancel', tintColor: Colors.red),
//     albumButtonColor: Theme.of(context).colorScheme.primary,
//   ),
//   materialOptions: const MaterialOptions(
//       maxImages: 300,
//       enableCamera: false,
//       textOnNothingSelected: 'pppp',
//       actionBarColor: Colors.blue,
//       allViewTitle: "images",
//       statusBarColor: Colors.blue,
//       startInAllView: true,
//       useDetailsView: true,
//       autoCloseOnSelectionLimit: false,
//       selectCircleStrokeColor: Colors.black
//
//
//   ),
// );
// setState(() {
//   images = resultList1;
// });

// if (resultList1 != null) {
//   for (int i = 0; i < images.length; i++) {
//     String fileName = DateTime.now().millisecondsSinceEpoch.toString(); // اسم الملف ليكون فريدًا
//     var imageData = await (await resultList1[i].getByteData()).buffer.asUint8List();
//     Reference reference = FirebaseStorage.instance.ref().child('images/$fileName');
//    var f2= await FlutterImageCompress.compressWithList(
//       imageData,
//       quality: 88,
//     );//
//     UploadTask uploadTask = reference.putData(
//       f2
//     );
//
//     TaskSnapshot taskSnapshot = await uploadTask.whenComplete((){
//       Fluttertoast.showToast(
//           msg: 'تم رفع الصوره',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.blue,
//           textColor: Colors.white,
//           fontSize: 16.0
//       );
//
//
//     });
//     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//     zz.sendimages(id2, downloadUrl, FirebaseAuth.instance.currentUser!.uid);
//
//   }
//   resultList1.clear();
// }

