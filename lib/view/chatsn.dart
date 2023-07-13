import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_test/controller/chat_cont.dart';
import 'package:test_test/view/chat.dart';
import 'package:test_test/view/video.dart';
import 'package:just_audio/just_audio.dart';
import 'package:voice_message_package/voice_message_package.dart';
import '../controller/Home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipe_to/swipe_to.dart';


import '../main.dart';
Home_controller ii = Get.find();
chat_con f = Get.find();





class chats extends StatelessWidget {
  String? mm;
  String? idd;
  String? newDate;
  String? t;
  String? image;
  String? video;
  String? son;
  String? pdd;
  FocusNode fox;
  String? titl;
  String? msss;
  String? titl2;
  String? msss2;
  String? id2;
  bool? so;
  String? now;
   chats({super.key,required this.mm,required this.idd
   ,required this.newDate ,required this.t,required this.image
     ,required this.video,required this.son,
     required this.pdd,
     required this.fox,
     required this.titl,
     required this.msss,
     required this.titl2,
     required this.msss2,
     required this.id2,
     required this.so,
     required this.now});


  @override
  Widget build(BuildContext context) {
    return
       check(context);
      

  }



  Widget chat_text(){
    if(so == false){
      zz.sendMessageupd(idd!,now!);
    }
    return Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          crossAxisAlignment:
          idd ==
              FirebaseAuth.instance.currentUser!.uid
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            if (newDate!.isNotEmpty)
              Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffE3D4EE),
                          borderRadius:
                          BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(newDate!),
                      ))),
            idd ==
                FirebaseAuth.instance.currentUser!.uid
                ?  Padding(
              padding: const EdgeInsets.all(12.0),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: SwipeTo(child: Container(child:  Container(
    width: 80,
    decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
    bottomLeft:
    Radius.circular(16))),
    child: Center(child:  Text(
    "${mm}",

    style: TextStyle(
    color: Colors.white),
    ),)
    ,
    height: 50,
    ),) ,onRightSwipe: ()async {
                  print('Callback from Swipe To Right');
                  fox.requestFocus();
                  f.yyy(true);
                  f.yyy2(mm!);
                  print(f.ms);






                },),
              )


            )
                : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomRight:
                        Radius.circular(16))),
                child: Center(
                  child: Text(
                    "${mm}",
                    style: TextStyle(
                        color: Colors.white),
                  ),
                ),
                height: 50,
              ),
            )
          ],
        ),
      );

  }

  Widget chat_images(){
    return Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          crossAxisAlignment:
          idd ==
              FirebaseAuth.instance.currentUser!.uid
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            if (newDate!.isNotEmpty)
              Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffE3D4EE),
                          borderRadius:
                          BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(newDate!),
                      ))),
            idd ==
                FirebaseAuth.instance.currentUser!.uid
                ? image != null? Padding(
              padding: const EdgeInsets.all(12.0),
              child: SwipeTo(child:
    Container(
    width: 80,

    decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
    bottomLeft:
    Radius.circular(16))),
    child: Center(
    child: Image.network(image!)
    ),
    height: 80,
    ),
                onRightSwipe: ()async{
                  print('Callback from Swipe To Right');
                  fox.requestFocus();
                  f.yyy(true);
                  f.yyy2('صوره');


              },)
            ):Center(child:CircularProgressIndicator(color: Colors.black,) ,)
                : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomRight:
                        Radius.circular(16))),
                child: Center(
                  child: Image.network(image!)
                ),
                height: 80,
              ),
            )
          ],
        ),
      );

  }

  Widget chat_video(context){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment:
        idd ==
            FirebaseAuth.instance.currentUser!.uid
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          if (newDate!.isNotEmpty)
            Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffE3D4EE),
                        borderRadius:
                        BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(newDate!),
                    ))),
          idd ==
              FirebaseAuth.instance.currentUser!.uid
              ? video != null? Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 80,

              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft:
                      Radius.circular(16))),
              child: Center(
                  child: TextButton(child: Text('video'),onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return chat_vid(data: video!);

                    }));
                  } ,)
              ),
              height: 80,
            ),
          ):Center(child:CircularProgressIndicator(color: Colors.black,) ,)
              : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomRight:
                      Radius.circular(16))),
              child: Center(
                  child: Text("video")
              ),
              height: 80,
            ),
          )
        ],
      ),
    );

  }

  Widget chat_sound(context){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment:
        idd ==
            FirebaseAuth.instance.currentUser!.uid
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          if (newDate!.isNotEmpty)
            Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffE3D4EE),
                        borderRadius:
                        BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(newDate!),
                    ))),
          idd ==
              FirebaseAuth.instance.currentUser!.uid
              ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft:
                      Radius.circular(16))),
                  child: VoiceMessage(
                    audioSrc: son,
                    played: false, // To show played badge or not.
                    me: true, //
                    formatDuration: formatTime,

                    onPlay: ()async{
                    },
                      key: UniqueKey()
                  )

            ),
          )
              : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomRight:
                      Radius.circular(16))),
              child: Center(
                child:VoiceMessage(
                  audioSrc: son,
                  played: false, // To show played badge or not.
                  me: true, // S
                  duration:  Duration.zero,// et message side.
                  onPlay: ()async{


                  }, // Do something when voice played.
                )
              ),
              height: 50,
            ),
          )
        ],
      ),
    );

  }

  Widget chat_pdf(context){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment:
        idd ==
            FirebaseAuth.instance.currentUser!.uid
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          if (newDate!.isNotEmpty)
            Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffE3D4EE),
                        borderRadius:
                        BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(newDate!),
                    ))),
          idd ==
              FirebaseAuth.instance.currentUser!.uid
              ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft:
                      Radius.circular(16))),
              child: Center(
                  child: IconButton(icon: Icon(Icons.picture_as_pdf),onPressed:()async{
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return splash(pd: pdd,);

                    }));


                    ;

                  } ),
              ),
              height: 50,
            ),
          )
              : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomRight:
                      Radius.circular(16))),
              child: Center(
                child: IconButton(icon: Icon(Icons.picture_as_pdf),onPressed:(){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return splash(pd: pdd,);

                  }));
                } ),
              ),
              height: 50,
            ),
          )
        ],
      ),
    );

  }

  Widget chat_re(context){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment:
        idd ==
            FirebaseAuth.instance.currentUser!.uid
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          if (newDate!.isNotEmpty)
            Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffE3D4EE),
                        borderRadius:
                        BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(newDate!),
                    ))),
          idd ==
              FirebaseAuth.instance.currentUser!.uid
              ?  Padding(
              padding: const EdgeInsets.all(12.0),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(child:  Container(
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft:
                          Radius.circular(16))),
                  child: Column(mainAxisSize: MainAxisSize.min,children: [
                    Row(children: [Text(titl!)],),
                    Row(children: [Text(msss!)],)


                  ],)


                  ,
                  height: 50,
                ),)





              )


          )
              : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomRight:
                      Radius.circular(16))),
              child: Center(
                child: Text(
                  "${mm}",
                  style: TextStyle(
                      color: Colors.white),
                ),
              ),
              height: 50,
            ),
          )
        ],
      ),
    );

  }

  Widget chat_reimges(context){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment:
        idd ==
            FirebaseAuth.instance.currentUser!.uid
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          if (newDate!.isNotEmpty)
            Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffE3D4EE),
                        borderRadius:
                        BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(newDate!),
                    ))),
          idd ==
              FirebaseAuth.instance.currentUser!.uid
              ?  Padding(
              padding: const EdgeInsets.all(12.0),
              child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(child:  Container(
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft:
                            Radius.circular(16))),
                    child: Column(mainAxisSize: MainAxisSize.min,children: [
                      Row(children: [Text(titl2!)],),
                      Row(children: [Container(width: 50,height: 50,child:
                        Image.network(msss2!),)],)


                    ],)


                    ,
                    height: 50,
                  ),)





              )


          )
              : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomRight:
                      Radius.circular(16))),
              child: Center(
                child: Text(
                  "${mm}",
                  style: TextStyle(
                      color: Colors.white),
                ),
              ),
              height: 50,
            ),
          )
        ],
      ),
    );

  }
















  check(context){
     if(t == 'te'){
      return chat_text();
     }
     if(t == 'im'){
      return chat_images();
     }
     if(t == 'vd'){
       return chat_video(context);

     }
     if(t == 'so'){
        return chat_sound(context);
     }
     if(t == 'pd'){
       return chat_pdf(context);
     }
     if(t == 'ree'){
       return chat_re(context);
     }
     if(t == 'ree2'){
       return chat_reimges(context);
     }
  }


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






















