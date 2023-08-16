import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compress_images_flutter/compress_images_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'dart:io';


class stories_contlooer extends GetxController{
  final audioPlayer = AudioPlayer();
  late StreamSubscription<PlayerState> playerStateChangedSubscription;
  late Future<Duration?> futureDuration;

  GlobalKey<FormState> e1 = GlobalKey<FormState>();
   String? title ;
   String? body;
   var image_picker = ImagePicker();
    CompressImagesFlutter c = CompressImagesFlutter();
   File? file ;
   var fir;
   var i;

   title1(String e){
     title = e;
    update();
  }

    body2(String e){
     body = e;
    update();
  }


   
  Future hh()async{
     i =await image_picker.getImage(source: ImageSource.gallery);
    if(image_picker != null){
    file = await c.compressImage(i!.path,quality: 90);

    }else{
    }
    
  }
     
 Future add()async{
  var v = e1?.currentState;
  if(v!.validate()&& i!= null){
    v.save();
     var r= Random().nextInt(1000);
    var ne = basename(i!.path);  
    var nn = "$r" + "$ne";
     fir = await FirebaseStorage.instance.ref("imaeges/$nn");
    await fir.putFile(file!).then((p0){
     Get.snackbar('','',snackPosition:SnackPosition.TOP,titleText: Text("storig",style: TextStyle(color: Colors.white)),messageText: Text("storig images",style: TextStyle(color: Colors.white))
    ,duration: Duration(seconds: 3),
    borderRadius:20.0,backgroundColor:Colors.blue,
  );
      });
      var n = await fir.getDownloadURL();

  Map<String,dynamic> m = {
    'id': FirebaseAuth.instance.currentUser!.uid,
    'title': title,
    'body' : body,
    'images' :  n

  };
    await FirebaseFirestore.instance.collection('test').add(m).then((value) =>
     Get.snackbar('','',snackPosition:SnackPosition.TOP,titleText: Text("storig",style: TextStyle(color: Colors.white)),messageText: Text("storig data",style: TextStyle(color: Colors.white))
    ,duration: Duration(seconds: 3),
    borderRadius:20.0,backgroundColor:Colors.blue,
  ) 
    ).catchError((error){
    });


  }else{

      Get.snackbar('','',snackPosition:SnackPosition.TOP,titleText: Text("Erorr",style: TextStyle(color: Colors.white)),messageText: Text("Erorr storig ",style: TextStyle(color: Colors.white))
    ,duration: Duration(seconds: 3),
    borderRadius:20.0,backgroundColor:Colors.red,
  );


  }
 
  }




  Future inch(String source)async{
    playerStateChangedSubscription =
        audioPlayer.playerStateStream.listen(playerStateListener);
    // futureDuration = _audioPlayer.setAudioSource(widget.source);
    futureDuration = audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(source))
    );
    // cacheAndPlayAudio(widget.source);
    update();

  }

  void playerStateListener(PlayerState state) async {
    if (state.processingState == ProcessingState.completed) {
      await reset();
    }
  }
  Future<void> reset() async {
    await audioPlayer.stop();
    return audioPlayer.seek(const Duration(milliseconds: 0));
  }

}



    









