import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class chat_vid extends StatefulWidget {
  final String data;

  const chat_vid({Key? key,required this.data}) : super(key: key);

  @override
  State<chat_vid> createState() => _chat_vidState();
}

class _chat_vidState extends State<chat_vid> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chewieController != null? AspectRatio(aspectRatio:videoPlayerController!.value.aspectRatio ,
      child: Chewie(controller: chewieController!),)
      :Container(child: CircularProgressIndicator()));
  }

  Future getVideo()async{

    final videoCache = await DefaultCacheManager().getSingleFile(
        widget.data
    );
    videoPlayerController = VideoPlayerController.file(videoCache)..initialize().then((value) {
      setState(() {
      });
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        looping: true,


        errorBuilder: (context, errorMessage) {
          return Center(child: CircularProgressIndicator(color:Colors.red,),);
        },
      );

    });
  }


  @override
  void initState() {
    getVideo();
    super.initState();
  }



  @override
  void dispose() {
    videoPlayerController!.dispose();
    chewieController!.dispose();
    super.dispose();
  }
}

// uuuuuu






