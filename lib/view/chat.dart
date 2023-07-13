import 'dart:core';
import 'dart:core';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compress_images_flutter/compress_images_flutter.dart';
import 'package:drishya_picker/drishya_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_compressor/pdf_compressor.dart';
import 'package:record/record.dart';
import 'package:test_test/view/chatsn.dart';
import 'package:video_compress/video_compress.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../controller/Home_controller.dart';
import '../controller/chat_cont.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'package:just_audio/just_audio.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:async';




Home_controller jj = Get.find();
chat_con ccx = Get.find();

class ChatRoom extends StatefulWidget {
  String chatRoomId;
  ChatRoom({super.key, required this.chatRoomId});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  ScrollController c = new ScrollController();
  TextEditingController con = TextEditingController();
  CompressImagesFlutter c1 = CompressImagesFlutter();
  // final LightCompressor compressor = LightCompressor();
  final fo = FocusNode();



  List items = [];
  List images = [];
  List imagePaths = [];
  final record = Record();



  File? f;
  var u;
  late final GalleryController controller;
     bool isLoading = false;
  final au = AudioPlayer();
  bool ispl = false;
   Duration du = Duration.zero;
  Duration pos = Duration.zero;
  int? maxSliderValue;
  late bool bb;
  String? q;
  bool zs = true;


  

  final _gallerySetting = GallerySetting(
    enableCamera: true,
    maximumCount: 10,
    requestType: RequestType.all,
    // editorSetting: EditorSetting(colors: _colors, stickers: _stickers1),
    cameraSetting: const CameraSetting(
        enableGallery: false, videoDuration: Duration(seconds: 11)),
    cameraTextEditorSetting: EditorSetting(
        // backgrounds: _defaultBackgrounds,
        // colors: _colors.take(4).toList(),
        // stickers: _stickers2,
        ),
    cameraPhotoEditorSetting: EditorSetting(
        // colors: _colors.skip(4).toList(),
        // stickers: _stickers3,
        ),
  );

  final _gallerySetting2 = GallerySetting(
    enableCamera: true,
    maximumCount: 2,
    requestType: RequestType.all,
    // editorSetting: EditorSetting(colors: _colors, stickers: _stickers1),
    cameraSetting: const CameraSetting(
        enableGallery: false, videoDuration: Duration(seconds: 11)),
    cameraTextEditorSetting: EditorSetting(
      // backgrounds: _defaultBackgrounds,
      // colors: _colors.take(4).toList(),
      // stickers: _stickers2,
    ),
    cameraPhotoEditorSetting: EditorSetting(
      // colors: _colors.skip(4).toList(),
      // stickers: _stickers3,
    ),
  );
  late StreamSubscription<bool> keyboardSubscription;


  @override
  void initState() {
    super.initState();
    controller = GalleryController();
    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
          if (visible == false) {
            fo.unfocus();
          }

        });
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

  String groupMessageDateAndTime(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    var originalDate = DateFormat('MM/dd/yyyy').format(dt);

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    String difference = '';
    final aDate = DateTime(dt.year, dt.month, dt.day);

    if (aDate == today) {
      difference = "Today";
    } else if (aDate == yesterday) {
      difference = "Yesterday";
    } else {
      difference = DateFormat.yMMMd().format(dt).toString();
    }

    return difference;
  }

  static DateTime returnDateAndTimeFormat(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    var originalDate = DateFormat('MM/dd/yyyy').format(dt);
    return DateTime(dt.year, dt.month, dt.day);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child:
    GetX<Home_controller>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text('chat')),
          body: Column(children: [
            Expanded(
                child: StreamBuilder(
                  //
                  stream: zz.getAllMessages(controller.id2.value!),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Center());
                    }
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          controller: c,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var now1 = snapshot.data!.docs[index].data()['now'];

                            bool isSameDate = false;
                            String? newDate = '';

                            final DateTime date = returnDateAndTimeFormat(
                                snapshot.data!.docs[index].data()['tim']);

                            if (index == 0 && snapshot.data!.docs.length == 1) {
                              newDate = groupMessageDateAndTime(
                                  snapshot.data!.docs[index].data()['tim'])
                                  .toString();
                            } else if (index == snapshot.data!.docs.length - 1) {
                              newDate = groupMessageDateAndTime(
                                  snapshot.data!.docs[index].data()['tim'])
                                  .toString();
                            } else {
                              final DateTime date = returnDateAndTimeFormat(
                                  snapshot.data!.docs[index].data()['tim']);
                              final DateTime prevDate = returnDateAndTimeFormat(
                                  snapshot.data!.docs[index + 1].data()['tim']);
                              isSameDate = date.isAtSameMomentAs(prevDate);

                              if (kDebugMode) {
                                print("$date $prevDate $isSameDate");
                              }
                              newDate = isSameDate
                                  ? ''
                              // jjj index -1
                                  : groupMessageDateAndTime(
                                  snapshot.data!.docs[index].data()['tim'])
                                  .toString();
                            }

                            return chats(
                              mm: snapshot.data!.docs[index].data()['mas'],
                              idd: snapshot.data!.docs[index].data()['id1'],
                              newDate: newDate,
                              t: snapshot.data!.docs[index].data()['t'],
                              image:
                              snapshot.data!.docs[index].data()['images'],
                              video: snapshot.data!.docs[index].data()['video'],
                              son: snapshot.data!.docs[index].data()['son2'] ,
                              pdd: snapshot.data!.docs[index].data()['pdf']  ,
                              fox: fo,
                              msss: snapshot.data!.docs[index].data()['msss'] ,
                              titl: snapshot.data!.docs[index].data()['titl'],
                              titl2: snapshot.data!.docs[index].data()['titl2'],
                              msss2: snapshot.data!.docs[index].data()['msss2'] ,
                              id2: snapshot.data!.docs[index].data()['id2'] ,
                              so: snapshot.data!.docs[index].data()['show'],
                              now: snapshot.data!.docs[index].data()['now'],



                            );
                          });


                    }
                    return Container();
                  },
                )),
            Expanded(flex: 0,child:  GetBuilder<chat_con>(builder: (controllerr) {
              return Center(child:
              controllerr.isrr == true? Container(margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(mainAxisSize: MainAxisSize.min,children: [
                  Row(mainAxisSize: MainAxisSize.max,children: [
                    IconButton(icon: Icon(Icons.cancel),onPressed: (){
                      controllerr.yyy(false);
                    },)
                  ],)


              , Row(mainAxisSize: MainAxisSize.max,children: [
                 Container(margin: EdgeInsets.only(bottom: 10,right: 10),
                     child: Text("${controllerr.ms}"))
               ],) ]
                  ,)

                ,color: Colors.blue,width: double.infinity,)
                  :Center(),);
            },),)


            //
            ,Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                  child: Row(
                    children: [
                          Expanded( child:
                               TextField(
                                  controller: con,
                                  focusNode: fo,
                                ),
                            ),


                      IconButton(
                          onPressed: () async {
                            if(ccx.isrr == true){
                              zz.sendre(con.text,controller.id2.value,ccx.ms,FirebaseAuth.instance.currentUser!.uid);
                              ccx.yyy(false);
                              con.clear();
                            }else{
                              zz.sendMessage(controller.id2.value, con.text,
                                  FirebaseAuth.instance.currentUser!.uid);
                              con.clear();
                            }


                            // c.animateTo(
                            //   c.position.minScrollExtent,
                            //   duration: const Duration(milliseconds: 300),
                            //   curve: Curves.easeOut,
                            // );
                          },
                          icon: Icon(Icons.send)),
                      IconButton(
                          onPressed: () async {
                            if(ccx.isrr == true && zs == true){
                              set_images2(context, controller.id2!.value);
                              ccx.yyy(false);
                            }else{
                              set_images(context, controller.id2!.value);
                            }


                          },
                          icon: Icon(
                            Icons.image,
                            color: Colors.black,
                          )),
                      IconButton(
                        icon: Icon(Icons.fiber_manual_record),
                        onPressed: () async {
                          if(await record.hasPermission()){
                            // //
                            await controller.voi();
                            await RecordMp3.instance.start(controller.voiceFilePath.value, (type) {
                            });
//                         await record.start(
//                           path: controller.voiceFilePath.value,
//                           encoder: AudioEncoder.AAC_HE, // by default
//                         );
                          }

                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.stop),
                        onPressed: ()async {
                          await RecordMp3.instance.stop();
                          File fff = File(controller.voiceFilePath.value);
                          var r = Random().nextInt(1000);
                          var fir = FirebaseStorage.instance.ref("recording/$r");
                          await fir.putFile(fff!).then((p0) {
                            Fluttertoast.showToast(
                                msg: 'تم رفع recording',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          });
                          var n = await fir.getDownloadURL();
                          ///
                          zz.sendson(controller.id2!.value, n, FirebaseAuth.instance.currentUser!.uid);

                        },
                      ), IconButton(icon: Icon(Icons.picture_as_pdf),onPressed:()async{
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                        );

                        if (result != null) {

                          final appDocumentsDirectory = await getApplicationDocumentsDirectory();
                          final outputFilePath = "${appDocumentsDirectory.path}/compressed.pdf";
                          await PdfCompressor.compressPdfFile(result.files.single.path!, outputFilePath, CompressQuality.HIGH);
                          var r = Random().nextInt(1000);
                          final storageRef =
                          FirebaseStorage.instance.ref().child("pdf/$r");
                          await storageRef.putFile(File(outputFilePath)).then(
                                (p0) {
                              Fluttertoast.showToast(
                                  msg: 'تم رفع pdf',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              // //
                            },
                          );
                          var getDo = await storageRef.getDownloadURL();
                          zz.sendpdf(controller.id2.value, getDo, FirebaseAuth.instance.currentUser!.uid);


                          // قم بمعالجة الملف هنا
                        } else {
                          print("=================================================");
                          print("nn");
                          // لم يتم اختيار أي ملف
                        }


                      } ,)


                    ],
                  )),
            ),





          ]),
        );
      },
    )
        ,
      onWillPop:()async{
        return true;

      } );

  }

  Future set_images(context, String id2) async {
    final entities = await controller.pick(context, setting: _gallerySetting);
    if (entities != null) {
      for (var entity in entities) {
        if (entity.type.name == 'image') {
          final file = await entity.originFile;
          print("images");
          if (file != null) {
            var path = file?.path;
            if (path != null) {
              images_fir(path, id2,);


              // if(ccx.isrr == true){
              //   images_fir2(path, id2,);
              //   ccx.yyy(false);
              // }else{
              //   images_fir(path, id2,);
              //
              // }



            }
          }
          ;
        } else if (entity.type.name == 'video') {
          final file = await entity.originFile;
          var path = file!.path;
          if (path != null) {
            var y = entity.duration.seconds.inSeconds;
            if (y <= 60 || y <= 120) {
              var r = Random().nextInt(1000);
              final storageRef =
                  FirebaseStorage.instance.ref().child("video/$r");
              await storageRef.putFile(await video_compress(path)).then(
                (p0) {
                  Fluttertoast.showToast(
                      msg: 'تم رفع video',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  // //
                },
              );
              var getDo = await storageRef.getDownloadURL();
              zz.sendvideo(id2, getDo, FirebaseAuth.instance.currentUser!.uid);
            } else {}

          }
        } else if (entity.type.name == 'audio') {
          print('=========================================================');
          print('object');
        }
      }
      entities.clear();
    }
  }

  Future set_images2(context, String id2) async {
    final entities = await controller.pick(context, setting: _gallerySetting2);
    if (entities != null) {
      for (var entity in entities) {
        if (entity.type.name == 'image') {
          final file = await entity.originFile;
          print("images");
          if (file != null) {
            var path = file?.path;
            if (path != null) {
              setState(() {
                zs = true;
              });
              images_fir2(path, id2,);
              setState(() {
                zs = false;
              });



              // if(ccx.isrr == true){
              //   images_fir2(path, id2,);
              //   ccx.yyy(false);
              // }else{
              //   images_fir(path, id2,);
              //
              // }



            }
          }
          ;
        } else if (entity.type.name == 'video') {
          final file = await entity.originFile;
          var path = file!.path;
          if (path != null) {
            var y = entity.duration.seconds.inSeconds;
            if (y <= 60 || y <= 120) {
              var r = Random().nextInt(1000);
              final storageRef =
              FirebaseStorage.instance.ref().child("video/$r");
              await storageRef.putFile(await video_compress(path)).then(
                    (p0) {
                  Fluttertoast.showToast(
                      msg: 'تم رفع video',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  // //
                },
              );
              var getDo = await storageRef.getDownloadURL();
              zz.sendvideo(id2, getDo, FirebaseAuth.instance.currentUser!.uid);
            } else {}

          }
        } else if (entity.type.name == 'audio') {
          print('=========================================================');
          print('object');
        }
      }
      entities.clear();
    }
  }

  Future images_fir(String imageData, String id2) async {
    var r = Random().nextInt(1000);
    var ne1 = "${"$r"}";
    var fir = FirebaseStorage.instance.ref("imaeges/$ne1");
    var result = await FlutterImageCompress.compressWithFile(
     imageData,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,

    );
    Uint8List? compressedImage = result;
    await fir.putData(compressedImage!).then((p0) {
      Fluttertoast.showToast(
          msg: 'تم رفع الصوره',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    var n = await fir.getDownloadURL();
    zz.sendimages(id2, n, FirebaseAuth.instance.currentUser!.uid);
    // i2.clear();
  }


  Future images_fir2(String imageData, String id2) async {
    var r = Random().nextInt(1000);
    var ne1 = "${"$r"}";
    var fir = FirebaseStorage.instance.ref("imaeges/$ne1");
    var result = await FlutterImageCompress.compressWithFile(
      imageData,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,

    );
    Uint8List? compressedImage = result;
    await fir.putData(compressedImage!).then((p0) {
      Fluttertoast.showToast(
          msg: 'تم رفع الصوره',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    var n = await fir.getDownloadURL();
    zz.sendre2(n,id2,ccx.ms,FirebaseAuth.instance.currentUser!.uid);
    // i2.clear();
  }






  Future video_compress(String images2) async {
    var mediaInfo = await VideoCompress.compressVideo(images2,
        quality: VideoQuality.LowQuality, duration: 0, frameRate: 30);
    return mediaInfo?.file;
  }






}

class zz {
  static String gett({required BuildContext context, required String tt}) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(tt));
    String pattern = (Get.deviceLocale == 'ar') ? 'hh:mm a' : 'h:mm a';
    DateFormat formatter = DateFormat(pattern);
    return formatter.format(dateTime);
  }

  static String getConversationID(String id2) =>
      FirebaseAuth.instance.currentUser!.uid.hashCode <= id2.hashCode
          ? '${FirebaseAuth.instance.currentUser!.uid}_$id2'
          : '${id2}_${FirebaseAuth.instance.currentUser!.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      String id2) {
    return FirebaseFirestore.instance
        .collection('chat/${getConversationID(id2)}/messages')
        .orderBy('tim2', descending: true)
        .snapshots();
  }

  static Future<void> sendMessage(String id2, String mass, String id1) async {
    var ti = DateTime.now();
    String formattedTime = ti.toUtc().toIso8601String();

    var nn = DateTime.now().microsecondsSinceEpoch.toString();
    var tim = DateTime.now().microsecondsSinceEpoch.toString();
    var ss = DateTime.now();
    String yearMonth = '${ss.year}-${ss.month}';
    Map<String, dynamic> m = {
      'id1': id1,
      'id2': id2,
      'mas': mass,
      'tim': tim,
      'now': nn,
      'tim2': formattedTime,
      't': "te",
      'show' : false
    };

    await FirebaseFirestore.instance
        .collection('chat/${getConversationID(id2)}/messages').doc(nn)
        .set(m);
  }

  static Future<void> sendimages(String id2, String imag, String id1) async {
    var ti = DateTime.now();
    String formattedTime = ti.toUtc().toIso8601String();

    var nn = DateTime.now().microsecondsSinceEpoch.toString();
    var tim = DateTime.now().microsecondsSinceEpoch.toString();
    var ss = DateTime.now();
    String yearMonth = '${ss.year}-${ss.month}';
    Map<String, dynamic> m = {
      'id1': id1,
      'id2': id2,
      'images': imag,
      'tim': tim,
      'now': nn,
      'tim2': formattedTime,
      't': 'im'
    };

    await FirebaseFirestore.instance
        .collection('chat/${getConversationID(id2)}/messages')
        .add(m);
  }

  static Future<void> sendvideo(String id2, String video, String id1) async {
    var ti = DateTime.now();
    String formattedTime = ti.toUtc().toIso8601String();

    var nn = DateTime.now().microsecondsSinceEpoch.toString();
    var tim = DateTime.now().microsecondsSinceEpoch.toString();
    var ss = DateTime.now();
    String yearMonth = '${ss.year}-${ss.month}';
    Map<String, dynamic> m = {
      'id1': id1,
      'id2': id2,
      'video': video,
      'tim': tim,
      'now': nn,
      'tim2': formattedTime,
      't': 'vd'
    };

    await FirebaseFirestore.instance
        .collection('chat/${getConversationID(id2)}/messages')
        .add(m);
  }

   static Future<void> sendson(String id2, String s, String id1) async {
    var ti = DateTime.now();
    String formattedTime = ti.toUtc().toIso8601String();

    var nn = DateTime.now().microsecondsSinceEpoch.toString();
    var tim = DateTime.now().microsecondsSinceEpoch.toString();
    var ss = DateTime.now();
    String yearMonth = '${ss.year}-${ss.month}';
    Map<String, dynamic> m = {
      'id1': id1,
      'id2': id2,
      'son2': s,
      'tim': tim,
      'now': nn,
      'tim2': formattedTime,
      't': 'so'
    };

    await FirebaseFirestore.instance
        .collection('chat/${getConversationID(id2)}/messages')
        .add(m);
  }

  static Future<void> sendpdf(String id2, String pdf, String id1) async {
    var ti = DateTime.now();
    String formattedTime = ti.toUtc().toIso8601String();

    var nn = DateTime.now().microsecondsSinceEpoch.toString();
    var tim = DateTime.now().microsecondsSinceEpoch.toString();
    var ss = DateTime.now();
    String yearMonth = '${ss.year}-${ss.month}';
    Map<String, dynamic> m = {
      'id1': id1,
      'id2': id2,
      'pdf': pdf,
      'tim': tim,
      'now': nn,
      'tim2': formattedTime,
      't': 'pd'
    };

    await FirebaseFirestore.instance
        .collection('chat/${getConversationID(id2)}/messages')
        .add(m);
  }


  static Future<void> sendre(String msss,String id2, String titl, String id1) async {
    var ti = DateTime.now();
    String formattedTime = ti.toUtc().toIso8601String();

    var nn = DateTime.now().microsecondsSinceEpoch.toString();
    var tim = DateTime.now().microsecondsSinceEpoch.toString();
    var ss = DateTime.now();
    String yearMonth = '${ss.year}-${ss.month}';
    Map<String, dynamic> m = {
      'id1': id1,
      'id2': id2,
      'titl': titl,
      "msss" : msss,
      'tim': tim,
      'now': nn,
      'tim2': formattedTime,
      't': 'ree'
    };

    await FirebaseFirestore.instance
        .collection('chat/${getConversationID(id2)}/messages')
        .add(m);
  }

  static Future<void> sendre2(String msss,String id2, String titl, String id1) async {
    var ti = DateTime.now();
    String formattedTime = ti.toUtc().toIso8601String();

    var nn = DateTime.now().microsecondsSinceEpoch.toString();
    var tim = DateTime.now().microsecondsSinceEpoch.toString();
    var ss = DateTime.now();
    String yearMonth = '${ss.year}-${ss.month}';
    Map<String, dynamic> m = {
      'id1': id1,
      'id2': id2,
      'titl2': titl,
      "msss2" : msss,
      'tim': tim,
      'now': nn,
      'tim2': formattedTime,
      't': 'ree2'
    };

    await FirebaseFirestore.instance
        .collection('chat/${getConversationID(id2)}/messages')
        .add(m);
  }

  static Future<void> sendMessageupd(String id2,String c) async {
    var ti = DateTime.now();
    String formattedTime = ti.toUtc().toIso8601String();

    var nn = DateTime.now().microsecondsSinceEpoch.toString();
    var tim = DateTime.now().microsecondsSinceEpoch.toString();
    var ss = DateTime.now();
    String yearMonth = '${ss.year}-${ss.month}';


    await FirebaseFirestore.instance
        .collection('chat/${getConversationID(id2)}/messages').doc(c).update({'show': true});

  }


}
