import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart'  ;


class AudioPlayerController extends GetxController {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  Duration? du;
  Duration? po;


  @override
  void onInit() {
    po = Duration.zero;
    du = Duration.zero;
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed || state == PlayerState.stopped) {
          isPlaying = false;
      }
    });
    audioPlayer.onPositionChanged.listen((event) {
      po = event;
    });
    audioPlayer.onDurationChanged.listen((event) {
      // setState(() {
      du = event;
      // });
    });
    update();
    super.onInit();
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
}