import 'package:calltofix/modals/videos_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import 'customLoader.dart';

class CustomVideoPlayerPopUp extends StatelessWidget {
  // final VideoModal videoModal;
  final VlcPlayerController videoPlayerController;
  bool isPlaying;
  CustomVideoPlayerPopUp({
    Key? key,
    // required this.videoModal,
    required this.videoPlayerController,
    required this.isPlaying
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 160),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 250,
            // padding: EdgeInsets.symmetric(vertical: 20),
            child: Stack(
              children: [
                CustomLoader(),
                Center(
                  child: VlcPlayer(
                    controller: videoPlayerController,
                    aspectRatio: 16 / 9,
                    // virtualDisplay: true,
                    placeholder: Center(child: CustomLoader()),

                  ),
                ),
                Center(
                  child: IconButton(onPressed: ()async{
                    print('kljdsflksj');
                    print('${videoPlayerController.isPlaying()}');
                    isPlaying = (await videoPlayerController.isPlaying())??false;
                    if(isPlaying){
                      videoPlayerController.pause();
                    }else{
                      videoPlayerController.play();
                    }
                    setState(() {

                    });
                  }, icon: Opacity(
                    opacity: 0,
                      child: Icon(!isPlaying? Icons.pause:Icons.play_arrow, color: Colors.white,size: 40,))),
                ),
                Positioned(
                  top: 20,
                  right: 10,

                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white,size: 40,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
