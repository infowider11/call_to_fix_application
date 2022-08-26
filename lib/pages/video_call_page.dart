import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

import '../../widgets/CustomTexts.dart';
import '../../widgets/customLoader.dart';
import '../constants/global_data.dart';
import '../functions/showSnackbar.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';



// const token =
//     '006ddbba166ad844f609413dedd53a01253IABcwDPCbMCU2TcOTpZinGUDvJ73Z/9BmfC63ymHhh5b11Aq764AAAAAEACXhJCZnnmtYgEAAQCfea1i';


class VideoCallScreen extends StatefulWidget {
  final String userId;
  final String name;
  final String bookingId;

  // static const String id = 'video_call_screen';
  const VideoCallScreen({Key? key, required this.userId, required this.bookingId, required this.name}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {

  static const String appId = '19b5c3689459408683d08b11e477c40c';
  int? _remoteUid;
  bool? isSpeakerEnabled;
  bool isBackCameraEnabled = true;
  bool isAudioEnabled = true;
  bool isVideoEnabled = false;

  RtcEngine? _engine;

  bool load = false;
  String? token;
  String channelName = '';
  Future<void> initForAgora() async {



    setState((){
      load = true;
    });
    var request = {
      "user_id": userData!['id'],
      "client_id": widget.userId,
      "booking_id": widget.bookingId,
      "user_type": userData!['user_type']
    };
    var jsonResponse = await Webservices.postData(apiUrl: ApiUrls.startCall, body: request, context: context);

    if(jsonResponse['status']==1){
      token = null;
      // token = widget.bookingId;
      channelName = widget.bookingId + 'psalm';
    }else{
      showSnackbar( 'Some Error Occured');
      Navigator.pop(context);
      return;
    }
    await [Permission.microphone, Permission.camera].request();
    setState(() {
      load = false;
    });

    // creates the engine
    _engine = await RtcEngine.create(appId);

    print('the engine is created');

    _engine!.setEventHandler(RtcEngineEventHandler(cameraReady: () {
      print('fsdddd');
    },localAudioStateChanged: (ss, error){
       _engine!.isSpeakerphoneEnabled().then((value){
         isSpeakerEnabled = value;
        try{
          setState(() {

          });
        }catch(e){
          print('Error in catch block 2343 $e');
        }
       });
    },
        localVideoStats: (df) {
      print('local video stats');
      print(df.captureBrightnessLevel);
    }, joinChannelSuccess: (String channel, int uid, int elapsed) {
      print('Local user $uid joined');
      setState(() {});
    },rejoinChannelSuccess: (string, int1, int2){
      print('rejoined fffff');
    },
        userEnableVideo: (a, isenbla) {
      print('The user ghass enabled $a $isenbla');
    }, userJoined: (int uid, int elapsed) {
      print('Remote user $uid joined');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) async{
      print('Remote user $uid left');
      _remoteUid = null;
      // await Webservices.postData(apiUrl: ApiUrls.endCall, body: request, context: context);
      await _engine!.leaveChannel();
      Navigator.pop(context);
      setState(() {
        _remoteUid = null;
      });
    }));


    print('about to join channel with name $channelName and token $token');

    await joinChannel();
    setState((){
      load = false;
    });
  }

  Widget _renderRemoteView() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid!,
        channelId: channelName,
      );
    } else {
      return Center(child: ParagraphText(text: 'Please Wait Till The Other Member Joins', color: Colors.white,),);
    }
  }

  Widget _renderLocalPreview() {
    return Container(
      height: 160,
        width: 160,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: RtcLocalView.SurfaceView(),

    );
  }

  joinChannel() async {
    try {
      await _engine!.joinChannel(
        token,
        channelName,
        null,
        0,
      );
      await _engine!.setCameraAutoFocusFaceModeEnabled(true);
      await _engine!.enableRemoteSuperResolution(_remoteUid!, true);
    } catch (e) {
      print('inside catch block234 $e');
      await _engine!.leaveChannel();
      await _engine!.joinChannel(token,channelName, null, 0);
      await _engine!.setCameraAutoFocusFaceModeEnabled(true);
      // await _engine!.enableRemoteSuperResolution(_remoteUid!, true);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    initForAgora();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: appBar(context: context, title: 'Manish Talreja'),
      body:load?CustomLoader(): SafeArea(
        child: Container(
          child:Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Stack(
              children: [
                _renderRemoteView(),
                // Container(),
                Positioned(
                  top: 30,
                  right: 20,
                  child: _renderLocalPreview(),
                ),
                Positioned(
                  top: 10,
                  right: 16,
                  left: 16,
                  child:AppBar(
                    toolbarHeight: 70,
                    automaticallyImplyLeading: false,
                    titleSpacing: 16,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title:  AppBarHeadingText(
                      text: '${widget.name}',color: Colors.white,
                    ),
                    // leading: implyLeading
                    //     ? IconButton(
                    //   icon: const Icon(
                    //     Icons.chevron_left_outlined,
                    //     color: Colors.black,
                    //     size: 30,
                    //   ),
                    //   onPressed: onBackButtonTap != null
                    //       ? onBackButtonTap
                    //       : () {
                    //     Navigator.pop(context);
                    //   },
                    // )
                    //     : null,

                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 16,
                  left: 16,
                  child:Container(
                    height: 100,
                    // width: 200,
                    margin: EdgeInsets.only(left:16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(60)
                          ),
                          child: IconButton(
                            onPressed: () async{
                              // await joinChannel();

                              isSpeakerEnabled = await _engine!.isSpeakerphoneEnabled();
                              print('the speaker is $isSpeakerEnabled');
                              await _engine!.setEnableSpeakerphone(!isSpeakerEnabled!);
                              isSpeakerEnabled = await _engine!.isSpeakerphoneEnabled();
                              print('the speaker new  is $isSpeakerEnabled');
                              setState(() {

                              });
                            },
                            icon: Icon(
                              isSpeakerEnabled!=true?Icons.volume_off:Icons.volume_down,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(60)
                          ),
                          child: IconButton(
                            onPressed: () async{
                              // await joinChannel();

                              await _engine!.switchCamera();
                              isBackCameraEnabled = !isBackCameraEnabled;
                              setState(() {

                              });
                            },
                            icon: Icon(
                              isBackCameraEnabled==true?Icons.video_camera_back_rounded:Icons.video_camera_front_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(60)
                          ),
                          child: IconButton(
                            onPressed: ()async {
                              bool? result = await showDialog(
                                  context:
                                  context,
                                  builder:
                                      (context) {
                                    return AlertDialog(
                                      insetPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                                      contentPadding:EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                                      buttonPadding: EdgeInsets.symmetric(horizontal: 32,),
                                      title: SubHeadingText(
                                        text: 'Are you sure?',
                                      ),
                                      actions: [
                                        GestureDetector(
                                          child: SubHeadingText(text: 'No'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        GestureDetector(
                                          child: SubHeadingText(text: 'Yes'),
                                          onTap: () async {
                                            Navigator.pop(context, true);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              // if(_remoteUid!=null){
                              //   await _engine!.leaveChannel();
                              //   _remoteUid = null;
                              //
                              // }
                              // else{
                              //   await joinChannel();
                              // }
                              // // if(_engine.)
                              // setState(() {
                              //
                              // });
                             if(result==true){
                               try{
                                 if(_remoteUid!=null){

                                   var request = {
                                     'booking_id': widget.bookingId
                                   };
                                   await Webservices.postData(apiUrl: ApiUrls.endCall, body: request, context: context);
                                   await _engine!.leaveChannel();
                                   _remoteUid = null;


                                 }else{
                                   try{
                                     await _engine!.leaveChannel();
                                   }catch(e){
                                     print('Error in catch block 32 $e');
                                   }
                                 }

                                 Navigator.pop(context);

                               }catch(e){
                                 print('Error in catch block34 $e');
                               }
                             }
                            },
                            icon: Icon(
                              Icons.call_end,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(60)
                          ),
                          child: IconButton(
                            onPressed: () async{
                              // await joinChannel();

                              if(!isAudioEnabled){
                                await _engine!.enableAudio();
                                isAudioEnabled = true;
                              }else{
                                await _engine!.disableAudio();
                                isAudioEnabled = false;
                              }
                              setState(() {

                              });
                            },
                            icon: Icon(
                              isAudioEnabled==true?Icons.mic_none:Icons.mic_off,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // IconButton(
                        //   onPressed: () async {
                        //     await _engine!.leaveChannel();
                        //   },
                        //   icon: Icon(
                        //     Icons.circle,
                        //     size: 100,
                        //   ),
                        //   color: Colors.green,
                        // ),

                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(60)
                          ),
                          child: IconButton(
                            onPressed: () async {
                              // await joinChannel();
                              print('video enable');

                              if(!isVideoEnabled){
                                await _engine!.enableVideo();
                                isVideoEnabled = true;
                              }else{
                                await _engine!.disableVideo();
                                isVideoEnabled = false;
                              }
                              setState(() {

                              });
                            },
                            icon: Icon(
                              isVideoEnabled?Icons.videocam:Icons.videocam_off,
                              size: 30,
                              color: Colors.white,
                            ),
                            // color: Colors.green,
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () async {
                        //     // await joinChannel();
                        //     print('video enable');
                        //     await _engine!.enableLocalVideo(true);
                        //     await _engine!.enableVideo();
                        //     // await _engine!.enableVirtualBackground(true, VirtualBackgroundSource(color:20));
                        //     print('video ${_engine}');
                        //     // await _engine!.video
                        //   },
                        //   icon: Icon(
                        //     Icons.video_call,
                        //     size: 60,
                        //   ),
                        //   color: Colors.green,
                        // ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          // child: Stack(
          //   children: [
          //
          //
          //     // Positioned(
          //     //   bottom: 30,
          //     //   right: 40,
          //     //   child: _renderRemoteView(),
          //     // ),
          //     Positioned(
          //       top: 30,
          //       right: 40,
          //       child: _renderLocalPreview(),
          //     ),
          //     Positioned(
          //       top: 10,
          //       right: 16,
          //       left: 16,
          //       child:appBar(context: context, title: 'Manish Talreja'),
          //     ),
          //     Positioned(
          //       bottom: 20,
          //       right: 16,
          //       left: 16,
          //       child:Container(
          //         height: 100,
          //         width: 200,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             IconButton(
          //               onPressed: () {},
          //               icon: Icon(
          //                 Icons.volume_off,
          //                 size: 60,
          //               ),
          //             ),
          //
          //             IconButton(
          //               onPressed: ()async {
          //                 if(_remoteUid!=null){
          //                   await _engine!.leaveChannel();
          //                   _remoteUid = null;
          //
          //                 }
          //                 else{
          //                   await joinChannel();
          //                 }
          //                 // if(_engine.)
          //                 setState(() {
          //
          //                 });
          //               },
          //               icon: Icon(
          //                 Icons.call_end,
          //                 size: 60,
          //                 color: Colors.red,
          //               ),
          //             ),
          //
          //             // IconButton(
          //             //   onPressed: () async {
          //             //     await _engine!.leaveChannel();
          //             //   },
          //             //   icon: Icon(
          //             //     Icons.circle,
          //             //     size: 100,
          //             //   ),
          //             //   color: Colors.green,
          //             // ),
          //
          //             IconButton(
          //               onPressed: () async {
          //                 // await joinChannel();
          //                 print('video enable');
          //                 // await _engine!.enableLocalVideo(true);
          //                 await _engine!.enableVideo();
          //                 print('video ${_engine}');
          //                 // await _engine!.video
          //               },
          //               icon: Icon(
          //                 Icons.video_call,
          //                 size: 60,
          //               ),
          //               color: Colors.green,
          //             ),
          //             // IconButton(
          //             //   onPressed: () async {
          //             //     // await joinChannel();
          //             //     print('video enable');
          //             //     await _engine!.enableLocalVideo(true);
          //             //     await _engine!.enableVideo();
          //             //     // await _engine!.enableVirtualBackground(true, VirtualBackgroundSource(color:20));
          //             //     print('video ${_engine}');
          //             //     // await _engine!.video
          //             //   },
          //             //   icon: Icon(
          //             //     Icons.video_call,
          //             //     size: 60,
          //             //   ),
          //             //   color: Colors.green,
          //             // ),
          //             SizedBox(
          //               width: 20,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //
          //   ],
          // ),
        ),
      ),
    );
  }
}
