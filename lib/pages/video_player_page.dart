import 'package:calltofix/modals/videos_modal.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import '../widgets/appbar.dart';

class VideoPlayerPage extends StatefulWidget {
  final VideoModal videoModal;
  const VideoPlayerPage({Key? key, required this.videoModal}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {

  late VlcPlayerController _videoPlayerController;
  bool isPlaying = false;

  // Future<void> initializePlayer() async {}


  @override
  void initState() {
    // TODO: implement initState
    _videoPlayerController = VlcPlayerController.network(
      widget.videoModal.file,
      hwAcc: HwAcc.full,
      autoPlay: false,
      options: VlcPlayerOptions(

      ),
    );
    super.initState();
  }
  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    // await _videoViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.videoModal.file);
    return Scaffold(
      appBar: appBar(context: context),
      body:  Column(
        children: [
          ParagraphText(text:widget.videoModal.title),
          Container(
            height: MediaQuery.of(context).size.width*9/16,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.videoModal.thumbnail
                ),
                fit: BoxFit.fill
              )
            ),
            child: Stack(
              children: [
                VlcPlayer(
                  controller: _videoPlayerController,
                  aspectRatio: 16 / 9,
                  // virtualDisplay: true,
                  placeholder: Center(child: CustomLoader()),

                ),
                Center(
                  child: IconButton(onPressed: ()async{
                    print('kljdsflksj');
                    print('${_videoPlayerController.isPlaying()}');
                    isPlaying = (await _videoPlayerController.isPlaying())??false;
                    if(isPlaying){
                      _videoPlayerController.pause();
                    }else{
                      _videoPlayerController.play();
                    }
                    setState(() {

                    });
                  }, icon: Icon(!isPlaying? Icons.pause:Icons.play_arrow, color: Colors.white,size: 40,)),
                )
              ],
            ),

          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     IconButton(onPressed: ()async{
          //       print('kljdsflksj');
          //       print('${_videoPlayerController.isPlaying()}');
          //       isPlaying = (await _videoPlayerController.isPlaying())??false;
          //       if(isPlaying){
          //             _videoPlayerController.pause();
          //           }else{
          //         _videoPlayerController.play();
          //       }
          //           setState(() {
          //
          //       });
          //     }, icon: Icon(!isPlaying? Icons.pause:Icons.play_arrow))
          //   ],
          // ),
        ],
      ),
    );
  }
}
