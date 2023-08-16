
import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';
import '../controller/audioPlayerController.dart';
import '../controller/stories_controller.dart';






class AudioPlayerMessage extends StatefulWidget {
  const AudioPlayerMessage({
    Key? key,
    required this.source,
    required this.id,
  }) : super(key: key);

  final String source;
  final String id;


  @override
  AudioPlayerMessageState createState() => AudioPlayerMessageState();
}

class AudioPlayerMessageState extends State<AudioPlayerMessage> {
  var d ;
  final _audioPlayer = AudioPlayer();
  late StreamSubscription<PlayerState> _playerStateChangedSubscription;
  late Future<Duration?> futureDuration;

  @override
  void initState() {
    super.initState();
    _playerStateChangedSubscription =
        _audioPlayer.playerStateStream.listen(playerStateListener);

    futureDuration = _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(
      widget.source
    )));

    cacheAndPlayAudio(
        widget.source
     );

        }

  void playerStateListener(PlayerState state) async {
    if (state.processingState == ProcessingState.completed) {
      await reset();
    }
  }



  @override
  void dispose() {
   _playerStateChangedSubscription.cancel();
   _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Duration?>(
      future: futureDuration,
      key:  GlobalKey(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _controlButtons(),
              _slider(snapshot.data),
            ],
          );
        }
        return  AudioLoadingMessage(key: UniqueKey(),);
      },
    );
  }

  Widget _controlButtons() {
    return StreamBuilder<bool>(
      stream: _audioPlayer.playingStream,
      builder: (context, _) {
        final color =
       _audioPlayer.playerState.playing ? Colors.black : Colors.black;
        final icon =
       _audioPlayer.playerState.playing ? Icons.pause : Icons.play_arrow;
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: () {
              if (_audioPlayer.playerState.playing) {
                pause();
              } else {
                play();
              }
            },
            child:
            SizedBox(
              width: 40,
              height: 40,
              child: Icon(icon, color: color, size: 30),
            ),



          ),
        );
      },
    );
  }

  Widget _slider(Duration? duration) {
    return StreamBuilder<Duration>(
      stream: _audioPlayer.positionStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && duration != null) {
          final currentPosition = snapshot.data!;
          final remainingTime = duration - currentPosition;

          return Row(
            children: [
              CupertinoSlider(
               activeColor: Colors.black,
                value: snapshot.data!.inMicroseconds / duration.inMicroseconds,
                onChanged: (val) {
                 _audioPlayer.seek(duration * val);
                },

              ),
              SizedBox(width: 10,),
              Text('${ formatTimea(remainingTime)}'),

            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Future<void> play() {
    return _audioPlayer.play();
  }

  Future<void> pause() {
    return _audioPlayer.pause();
  }

  Future<void> reset() async {
    await _audioPlayer.stop();
    return _audioPlayer.seek(const Duration(milliseconds: 0));
  }
  String formatTimea(Duration d){
    String two(int n)=> n.toString().padLeft(2,'0');
    final h = two(d.inHours);
    final m = two(d.inMinutes.remainder(60));
    final s = two(d.inSeconds.remainder(60));

    return [
      if(d.inHours > 0) h,m,s
    ].join(":");



  }

  Future<void> cacheAndPlayAudio(String audioUrl) async {
    final cacheManager = DefaultCacheManager();
    final file = await cacheManager.getSingleFile(audioUrl);

    if (file != null) {

      await _audioPlayer.setFilePath(file.path,);

    }
  }
}






class AudioLoadingMessage extends StatelessWidget {
  const AudioLoadingMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children:  [
                SizedBox(width: 12,),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 12,),
                CupertinoSlider(
                  activeColor: Colors.black,
                  value: 0.0,
                  onChanged: (val) {
                  },
                ),
                SizedBox(width: 10,),
                Text('00:00'),


              ],
            ),
          ],
        ),
      );


  }

}



//
// class AudioPlayerPage extends StatelessWidget {
// String? source;
// AudioPlayerPage({
//     Key? key,
//     required this.source,
//   }) : super(key: key);
//
// AudioPlayerController a = Get.put(AudioPlayerController());
//
// void _playPauseAudio(String audioUrl) {
//   if (a.isPlaying) {
//     a.audioPlayer.pause();
//   } else {
//     a.audioPlayer.play(UrlSource(source!));
//   }
//    a.isPlaying = !a.isPlaying;
// }
//
// @override
// Widget build(BuildContext context) {
//   return GetBuilder<AudioPlayerController>(builder: (controller) {
//     return    Center(
//       child: Container(color: Colors.cyan,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Text("${formatTimea(controller.po!)}"),
//               Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(controller.isPlaying ? Icons.pause : Icons.play_arrow),
//                     onPressed: ()async {
//                       if (controller.isPlaying) {
//                         controller.audioPlayer.pause();
//                       } else {
//                         controller.audioPlayer.play(UrlSource(source!));
//                       }
//                       controller.isPlaying = !a.isPlaying;
//
//                     },
//                   ),
//                   Slider(key: UniqueKey(),min: 0.0,max:controller.du!.inSeconds.toDouble()
//                     ,value:controller.po!.inSeconds.toDouble(),
//                     onChanged: (value) {
//                       var po2 = Duration(seconds: value.toInt());
//                       controller.audioPlayer.seek(po2);
//                       controller.audioPlayer.resume();
//                     },)
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   },);
//
//
// }
// String formatTimea(Duration d){
//   String two(int n)=> n.toString().padLeft(2,'0');
//   final h = two(d.inHours);
//   final m = two(d.inMinutes.remainder(60));
//   final s = two(d.inSeconds.remainder(60));
//
//   return [
//     if(d.inHours > 0) h,m,s
//   ].join(":");
//
// }
//
// }




