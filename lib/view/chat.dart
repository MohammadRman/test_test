import 'dart:core';
import 'dart:core';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compress_images_flutter/compress_images_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_compressor/pdf_compressor.dart';
import 'package:record/record.dart';
import 'package:test_test/view/chatsn.dart';
import 'package:test_test/view/vo.dart';
import 'package:video_compress/video_compress.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:hijri/digits_converter.dart';
import 'package:hijri/hijri_array.dart';
import 'package:hijri/hijri_calendar.dart';

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
import 'package:test_test/view/chatsn.dart' as chu;
import 'package:flutter_document_picker/flutter_document_picker.dart';






Home_controller jj = Get.find();
chat_con ccx = Get.find();

class ChatRoom extends StatefulWidget {
  String chatRoomId;
  ChatRoom({super.key, required this.chatRoomId});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late Future<Duration?> futureDuration;

  ScrollController c = new ScrollController();
  TextEditingController con = TextEditingController();
  CompressImagesFlutter c1 = CompressImagesFlutter();

  // final LightCompressor compressor = LightCompressor();

  final fo = FocusNode();


  List items = [];
  List images = [];
  List imagePaths = [];
  final record = Record();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FilePickerResult? result;
  FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
      allowedUtiTypes: ['com.adobe.pdf'],
      allowedMimeTypes: ['application/pdf'],
  );





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
  final Connectivity _connectivity = Connectivity();

  bool? cx = false;
  bool? up = false;
  bool? up2 = false;
  List messages = [];
  final _audioPlayer = AudioPlayer();
  bool pl = false;





  final _gallerySetting = GallerySetting(
    enableCamera: true,
    maximumCount: 10,
    requestType: RequestType.all,
    // editorSetting: EditorSetting(colors: _colors, stickers: _stickers1),
    cameraSetting: const CameraSetting(
        videoDuration: Duration(seconds: 15),


    ),
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

  cc() {
    Jiffy.locale("ar");
  }

  final boxs = Hive.box("names");


  @override
  void initState() {
    super.initState();
    getm();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    ccx.gett();
    cc();


    // print(Jiffy(DateTime.now()).format('hh:mm a'));

    //Suppose current gregorian data/time is: Mon May 29 00:27:33  2018


    controller = GalleryController();
    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
          if (visible == false) {
            fo.unfocus();
          }
        });
  }

  String formatTime(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    final h = two(d.inHours);
    final m = two(d.inMinutes.remainder(60));
    final s = two(d.inSeconds.remainder(60));

    return [
      if(d.inHours > 0) h, m, s
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
    // استبدال AM بصباحًا و PM بمساءًا
    // formattedTime = formattedTime.replaceAll('AM', 'ص').replaceAll('PM', 'م');


    return WillPopScope(child:
    GetX<Home_controller>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(backgroundColor: cx == true ? Colors.blue : Colors.red
              , title: Text('${controller.id2.value}')),

          body: Column(children: [
            Expanded(
              child:
              StreamBuilder(
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
                    return SingleChildScrollView(reverse: true,
                        physics: BouncingScrollPhysics(),
                        child: Column(children: [
                          ListView(shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Column(mainAxisSize: MainAxisSize.min, children: [
                                Container(color: Colors.blue
                                  ,
                                  width: double.infinity,
                                  height: 60,
                                  child: Center(child:
                                  Text("${jj.dd}"),),)
                              ],),

                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  reverse: true,
                                  shrinkWrap: true,
                                  controller: c,
                                  itemCount: snapshot.data!.docs.length,
                                   // key: Key("${Random().nextDouble()}"),
                                  key: GlobalKey(),
                                  itemBuilder: (context, index) {
                                    bool isSameDate = false;
                                    String? newDate = '';


                                    final DateTime date = returnDateAndTimeFormat(
                                        snapshot.data!.docs[index]
                                            .data()['tim']);

                                    if (index == 0 &&
                                        snapshot.data!.docs.length == 1) {
                                      newDate = groupMessageDateAndTime(
                                          snapshot.data!.docs[index]
                                              .data()['tim'])
                                          .toString();
                                    } else if (index ==
                                        snapshot.data!.docs.length - 1) {
                                      newDate = groupMessageDateAndTime(
                                          snapshot.data!.docs[index]
                                              .data()['tim'])
                                          .toString();
                                    } else {
                                      final DateTime date = returnDateAndTimeFormat(
                                          snapshot.data!.docs[index]
                                              .data()['tim']);
                                      final DateTime prevDate = returnDateAndTimeFormat(
                                          snapshot.data!.docs[index + 1]
                                              .data()['tim']);
                                      isSameDate =
                                          date.isAtSameMomentAs(prevDate);

                                      if (kDebugMode) {
                                        print("$date $prevDate $isSameDate");
                                      }
                                      newDate = isSameDate
                                          ? ''
// jjj index -1
                                          : groupMessageDateAndTime(
                                          snapshot.data!.docs[index]
                                              .data()['tim'])
                                          .toString();
                                      jj.dd = newDate;
                                    }

                                    return 
                                      InkWell(onTap: (){
                                        _showBottomSheet(context,snapshot.data!.docs[index]
                                            .data()['son2'],);
                                      },
                                        child:
                                        Container(color: Colors.cyan,width: 40,height: 30,
                                          child: Center(child: Text('son2')),)
                                      );



                                    //   chats(
                                    //   mm: snapshot.data!.docs[index]
                                    //       .data()['mas'],
                                    //   idd: snapshot.data!.docs[index]
                                    //       .data()['id1'],
                                    //   newDate: newDate,
                                    //   t: snapshot.data!.docs[index].data()['t'],
                                    //   image:
                                    //   snapshot.data!.docs[index]
                                    //       .data()['images'],
                                    //   video: snapshot.data!.docs[index]
                                    //       .data()['video'],
                                    //   son: snapshot.data!.docs[index]
                                    //       .data()['son2'],
                                    //   pdd: snapshot.data!.docs[index]
                                    //       .data()['pdf'],
                                    //   fox: fo,
                                    //   msss: snapshot.data!.docs[index]
                                    //       .data()['msss'],
                                    //   titl: snapshot.data!.docs[index]
                                    //       .data()['titl'],
                                    //   titl2: snapshot.data!.docs[index]
                                    //       .data()['titl2'],
                                    //   msss2: snapshot.data!.docs[index]
                                    //       .data()['msss2'],
                                    //   id2: snapshot.data!.docs[index]
                                    //       .data()['id2'],
                                    //   so: snapshot.data!.docs[index]
                                    //       .data()['show'],
                                    //   now: snapshot.data!.docs[index]
                                    //       .data()['tim'],
                                    //
                                    //
                                    // );
                                  }),


                            ],),

                        ],));
                  }
                  return Container();
                },
              ),

            ),

            Expanded(
              flex: 0, child: GetBuilder<chat_con>(builder: (controllerr) {
              return Center(child:
              controllerr.isrr == true ? Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(mainAxisSize: MainAxisSize.max, children: [
                    IconButton(icon: Icon(Icons.cancel), onPressed: () {
                      controllerr.yyy(false);
                    },)
                  ],)


                  , Row(mainAxisSize: MainAxisSize.max, children: [
                    Container(margin: EdgeInsets.only(bottom: 10, right: 10),
                        child: Text("${controllerr.ms}"))
                  ],)
                ]
                  ,)

                , color: Colors.blue, width: double.infinity,)
                  : Center(),);
            },),)


            //
            , Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                  child: Row(
                    children: [
                      Expanded(child:
                      TextField(
                        controller: con,
                        focusNode: fo,
                      ),
                      ),


                      IconButton(
                          onPressed: () async {
                            if (ccx.isrr == true) {
                              zz.sendre(con.text, controller.id2.value, ccx.ms,
                                  FirebaseAuth.instance.currentUser!.uid);
                              ccx.yyy(false);
                              con.clear();
                            } else {
                              final connectivityResult = await (Connectivity()
                                  .checkConnectivity());
                              if (connectivityResult ==
                                  ConnectivityResult.wifi) {
                                zz.sendMessage(controller.id2.value, con.text,
                                    FirebaseAuth.instance.currentUser!.uid);
                                con.clear();
                              } else {
                                boxs.add({
                                  'id1': FirebaseAuth.instance.currentUser!.uid
                                  , 'id2': controller.id2.value
                                  , 'mas': con.text,
                                  'tim': DateTime
                                      .now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                  't': "te"
                                }).then((value) {
                                  con.clear();
                                  ccx.gett();
                                  print(FirebaseAuth.instance.currentUser!.uid);
                                  print(ccx.messages2);
                                });
                              }
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
                            if (ccx.isrr == true && zs == true) {
                              set_images2(context, controller.id2!.value);
                              ccx.yyy(false);
                            } else {
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
                          if (await record.hasPermission()) {
                            // //
                            await controller.voi();
                            
                            await RecordMp3.instance.start(
                                controller.voiceFilePath.value, (type) {});
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.stop),
                        onPressed: () async {
                          await RecordMp3.instance.stop();
                          messages.clear();

                          File fff = File(controller.voiceFilePath.value);
                          var r = Random().nextInt(1000);
                          var fir = FirebaseStorage.instance.ref(
                              "recording/$r");
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
                          //  sen(n);
                           zz.sendson(controller.id2!.value, n,FirebaseAuth.instance.currentUser!.uid);
                        },
                      ), IconButton(icon: Icon(Icons.picture_as_pdf),
                        onPressed: () async {
                          final paths = await FlutterDocumentPicker.openDocuments(params: params);

                          if (paths != null) {
                            paths!.forEach((element) {
                              pdf(controller.id2.value, element!);


                            });



                            // قم بمعالجة الملف هنا
                          } else {
                            print(
                                "=================================================");
                            print("nn");
                            // لم يتم اختيار أي ملف
                          }
                        },)


                    ],
                  )),
            ),


          ]),
        );
      },
    )
        ,
        onWillPop: () async {
          return true;
        });
  }

  Future set_images(context, String id2) async {
    final entities = await controller.pick(context, setting: _gallerySetting);
    if (entities.isNotEmpty ) {
      setState(() {
        up2 = true;
      });


      up2 == true ? Get.snackbar('','',snackPosition:SnackPosition.TOP,
        titleText: Text("يرجى ")
        ,messageText: Container(margin: EdgeInsets.only(top: 10),
            child: LinearProgressIndicator())
        ,borderRadius:20.0,
        duration: Duration(hours: 1),
        backgroundColor: Colors.white,


      ):Container();

      for (var entity in entities) {
        setState(() {
          cx = true;
        });

        print(cx);
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
          setState(() {
            up2 = true;
          });



          final file = await entity.originFile;
          var path = file!.path;
          if (path.isNotEmpty) {
            var y = entity.duration.seconds.inSeconds;
            // y <= 60 || y <= 120
            if (y <= 60) {
              // var tempDir = await getTemporaryDirectory();
              // var b = basename(path);
              // String outputPath = "${tempDir.path}/${b}";
              // await compressVideos([path],outputPath,id2);





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
          print(
              '-----------------------------------------------------------------------------------');

          final file = await entity.originFile;
          var path = file!.path;
          if (path != null) {
            var y = entity.duration.seconds.inSeconds;
            if (y <= 60 || y <= 120) {

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
    zz.sendimages(id2, n, FirebaseAuth.instance.currentUser!.uid).then((value){
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
      setState(() {
       up = false;
      });;

    });
    setState(() {
      cx = false;
    });
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
    zz.sendre2(n, id2, ccx.ms, FirebaseAuth.instance.currentUser!.uid);
    // i2.clear();
  }

  ///////////////////////////////////////////////////--------------------------kkkmmmlkhjnh\


  sen(String ao)async{
    await FirebaseFirestore.instance
        .collection('chat')
        .add({"s":ao}).catchError((){
      print("eeeeeeeeeeeeeeee");

    });
  }

  getm()async{
      await FirebaseFirestore.instance.collection('chat').snapshots().listen((event) {
        event.docs.forEach((element) {
          setState(() {
            messages.add(element.data()['s']);

          });
        });
      });


  }


  void _showBottomSheet(BuildContext context,String soo) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        barrierColor: Colors.transparent,
        isDismissible: false
        ,context: context, builder: (_){
      return Container(
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(margin: EdgeInsets.only(top: 6,right: 10),child: InkWell(
                  onTap: (){
                    Get.back();
                  },
                    child: Icon(Icons.close))),

              ],
            ),
            Row(
              children: [
                Container(child: AudioPlayerMessage(source: soo,key: UniqueKey(),id:'00999')),
              ],
            ),
          ],
        ),
      );
    });



  }









  //
  // Future<void> sendMessageupdii(String id2,String ph,now) async {
  //
  //   await FirebaseFirestore.instance
  //       .collection('chat/${zz.getConversationID(id2)}/messages').doc(now).update({'images': ph});
  //
  // }


//   Future<void> syncWithFirebase() async {
//     for (var map in ccx.messages2) {
//       FirebaseFirestore firestore =await FirebaseFirestore.instance;
//       firestore.collection('chat/${zz.getConversationID(map['id2'])}/messages').
//       doc(DateTime.now().microsecondsSinceEpoch.toString())
//           .set({
//         'id1': map['id1'],
//         'id2': map['id2'],
//         'mas': map['mas'],
//         'tim': map['tim'],
//         'now': map['tim'],
//         'tim2': map['tim'],
//         't': map['t'],
//         'show' : true
//
//       }).then((value) {
//
//          _deleteAllData();
//
//       });
//     }
//
//
//
// }

  void _deleteAllData(int key) async {
    final box = Hive.box("names"); // الحصول على المخزّن بالاسم "names"
    await box.delete(key);
    await ccx.gett();
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi) {
      // syncWithFirebase();


    } else {

    }
  }

  Future<void> compressVideo(String inputPath, String outputPath) async {
    final FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
     var arguments = ["-i", "$inputPath", "-c:v", "mpeg4", "$outputPath"];
    await flutterFFmpeg.executeWithArguments(arguments);
  }
  Future<void> compressVideos(List<String> inputPaths, String outputPath,String id2) async {
    final List<Future<dynamic>> compressionTasks = [];
    final List<String> outputPaths = [];
    for (int i = 0; i < inputPaths.length; i++) {
      final String inputPath = inputPaths[i];
      outputPaths.add(outputPath);
      final compressionTask = compressVideo(inputPath, outputPath);
      compressionTasks.add(compressionTask);
    }
    await Future.wait(compressionTasks);
    print('All Videos Compressed Successfully:');
      up_v(id2, outputPath);

  }


  void deleteOutputFile(String outputPath) {
    try {
      File outputFile = File(outputPath);
      outputFile.deleteSync();
      print("تم حذف الملف بنجاح.");
    } catch (e) {
      print("فشل في حذف الملف: $e");
    }
  }







  up_v(String id2,String fl)async{

    var r = Random().nextInt(1000);
    final storageRef =
    FirebaseStorage.instance.ref().child("video/$r");
    await storageRef.putFile(File(fl)).then(
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
    zz.sendvideo(id2, getDo, FirebaseAuth.instance.currentUser!.uid).then((value){
      deleteOutputFile(fl);

      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    });
  }

  pdf(String id2,String im)async{


    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
   //  final outputFilePath = "${appDocumentsDirectory
   //      .path}/compressed.pdf";
   //  await PdfCompressor.compressPdfFile(
   // im , outputFilePath,
   //  CompressQuality.MEDIUM);
    var r = Random().nextInt(1000);
    final storageRef =
    FirebaseStorage.instance.ref().child("pdf/$r");
    await storageRef.putFile(File(im)).then(
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
    zz.sendpdf(id2, getDo,
        FirebaseAuth.instance.currentUser!.uid);



  }

  }



class zz {
  static String gett(String tt) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(tt));
    // String pattern = (Get.deviceLocale == 'ar') ? 'hh:mm a' : 'h:mm a';
    // DateFormat formatter = DateFormat(pattern);
    // formatter.format(dateTime);
    return Jiffy(dateTime).format('h:mm a');


  }

  static String getConversationID(String id2) =>
      FirebaseAuth.instance.currentUser!.uid.hashCode <= id2.hashCode
          ? '${FirebaseAuth.instance.currentUser!.uid}_$id2'
          : '${id2}_${FirebaseAuth.instance.currentUser!.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      String id2) {
    return FirebaseFirestore.instance
        .collection('chat/${getConversationID(id2)}/messages')
        .orderBy('tim', descending: true)
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
        .set(m).catchError((){
          print("eeeeeeeeeeeeeeee");

    });
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
        .collection('chat/${getConversationID(id2)}/messages').doc(nn)
        .set(m);
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

   static Future<void> sendson(String id2, String s,String id1) async {
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


    // await FirebaseFirestore.instance
    //     .collection('chat').doc(tim)
    //     .set(m);
    await FirebaseFirestore.instance
        .collection('chat/${getConversationID(id2)}/messages').doc(nn)
        .set(m);

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


//
// Expanded(child:  GetBuilder<chat_con>(builder: (controller) {
// return  ListView.builder(
// shrinkWrap: true,reverse: true,physics: NeverScrollableScrollPhysics(),
// itemCount:controller.messages2.length,
// itemBuilder: (context, index) {
//
// bool isSameDate = false;
// String? newDate = '';
//
// final DateTime date = returnDateAndTimeFormat(
// controller.messages2[index]['tim']);
//
// if (index == 0 && controller.messages2.length == 1) {
// newDate = groupMessageDateAndTime(
// controller.messages2[index]['tim'])
//     .toString();
// } else if (index == controller.messages2.length  - 1) {
// newDate = groupMessageDateAndTime(
// controller.messages2[index]['tim'])
//     .toString();
// } else {
// final DateTime date = returnDateAndTimeFormat(
// controller.messages2[index]['tim']);
// final DateTime prevDate = returnDateAndTimeFormat(
// controller.messages2[index + 1]['tim']);
// isSameDate = date.isAtSameMomentAs(prevDate);
//
// if (kDebugMode) {
// print("$date $prevDate $isSameDate");
// }
// newDate = isSameDate
// ? ''
// // jjj index -1
//     : groupMessageDateAndTime(
// controller.messages2[index]['tim'])
//     .toString();
//
// }
// return controller.messages2[index]['id2'] == jj.id2.value &&
// controller.messages2[index]['id1'] == FirebaseAuth.instance.currentUser!.uid?
// Padding(padding: const EdgeInsets.only(top: 0),child:
// Column(children: [
// if (newDate!.isNotEmpty)
// Center(
// child: Container(
// decoration: BoxDecoration(
// color: Color(0xffE3D4EE),
// borderRadius:
// BorderRadius.circular(20)),
// child: Padding(
// padding: const EdgeInsets.all(10.0),
// child:zz.gett(jj.id2.value) != null?
// Text(""):Text(newDate)
// ))),
// ListTile(
// tileColor: Colors.red,
// leading: IconButton(icon: Icon(Icons.desktop_windows),onPressed: ()async{
// FirebaseFirestore firestore =await FirebaseFirestore.instance;
// firestore.collection('chat/${zz.getConversationID(
// controller.messages2[index]['id2'])}/messages').
// doc(DateTime.now().microsecondsSinceEpoch.toString())
//     .set({
// 'id1': controller.messages2[index]['id1'],
// 'id2': controller.messages2[index]['id2'],
// 'mas': controller.messages2[index]['mas'],
// 'tim': controller.messages2[index]['tim'],
// 'now': controller.messages2[index]['tim'],
// 'tim2': controller.messages2[index]['tim'],
// 't': controller.messages2[index]['t'],
// 'show' : false
//
// }).then((value) {
// _deleteAllData(controller.messages2[index]['key']);
//
// });
//
//
// },),
//
// title: Text('${controller.messages2[index]['mas']}'),
//
// )
// ],),):Container(width: 0,height: 0,);
//
//
// },
// );
// },)
// ),





