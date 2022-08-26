import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/modals/news_modal.dart';
import 'package:calltofix/pages/video_player_page.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:calltofix/widgets/custom_circular_image.dart';
import 'package:calltofix/widgets/video_popup_player.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../constants/dummyData.dart';
import '../constants/global_data.dart';
import '../constants/global_functions.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../modals/videos_modal.dart';
import '../provider_pages/news_detail.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class TrainingVideosPage extends StatefulWidget {

  const TrainingVideosPage({Key? key}) : super(key: key);

  @override
  _TrainingVideosPageState createState() => _TrainingVideosPageState();
}

class _TrainingVideosPageState extends State<TrainingVideosPage> {
  List<VideoModal> trainingVideos = [];
  bool load = false;
  getAllTrainingVideos({String lastId='', bool refresh = true})async{
    setState(() {
      load = true;
    });
    var request = {
      // 'limit': '2',
      'user_id': userData!['id'],
    };
    List temp = await Webservices.getListFromRequestParameters(ApiUrls.getTrainingVideos, request);
    temp.forEach((element) {trainingVideos.add(VideoModal.fromJson(element));});
    setState(() {
      load = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getAllTrainingVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Training Videos'),
      body:load?CustomLoader(): Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child:  ListView(
          // scrollDirection: Axis.horizontal,
          children: [
            if(trainingVideos.length==0)
              Container(
                height: MediaQuery.of(context).size.height-100,
                child: Center(
                  child: ParagraphText(text:'No Training Videos Found'),
                ),
              ),
            for(int i = 0;i<trainingVideos.length;i++)
              Column(
                children: [
                  GestureDetector(
                    onTap: ()async{
                      print('klsdhflksdhflkdhjasfklhdaslfkjdskldjasfkljasdfkljasfkas');
                      VlcPlayerController videoPlayerController =VlcPlayerController.network(
                        trainingVideos[i].file,
                        hwAcc: HwAcc.full,
                        autoPlay: true,
                        options: VlcPlayerOptions(),
                      );
                      bool isPlaying = false;
                      videoPlayerController.addListener(() async {
                        isPlaying = (await videoPlayerController.isPlaying()) ?? false;
                        setState(() {});
                      });
                      // Navigator.pushNamed(context, News_Detail_Page.id);
                      // push(context: context, screen: VideoPlayerPage(videoModal: trainingVideos[i]));
                      showDialog(context: context, builder: (context){
                        return CustomVideoPlayerPopUp(videoPlayerController: videoPlayerController, isPlaying: isPlaying,);
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        padding: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              boxShadow
                            ]
                          // border: Border.all(color: Colors.grey)
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                ),
                                child: Image.network(
                                  trainingVideos[i].thumbnail,
                                  fit: BoxFit.fitWidth,
                                  width: MediaQuery.of(context).size.width - 32,
                                  height: 170,
                                ),
                              ),
                              vSizedBox,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: ParagraphText(text: trainingVideos[i].title,
                                  fontSize: 13,
                                  fontFamily: 'regular',
                                  color: Colors.black,
                                ),
                              ),
                              vSizedBox,
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: ParagraphText(
                                  text: '${trainingVideos[i].location} ${timeAgo(trainingVideos[i].createdAt)}',
                                  fontSize: 9,
                                  fontFamily: 'regular',
                                  color:MyColors.textcolor,
                                ),
                              ),

                            ]
                        )
                    ),
                  )

                ],

              ),
            // Column(
            //   children: [
            //     GestureDetector(
            //       onTap: (){
            //         Navigator.pushNamed(context, News_Detail_Page.id);
            //       },
            //       child: Container(
            //         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            //           padding: EdgeInsets.only(bottom: 16),
            //           decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(15),
            //               boxShadow: [
            //                 boxShadow
            //               ]
            //             // border: Border.all(color: Colors.grey)
            //           ),
            //           child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children:[
            //                 ClipRRect(
            //                   borderRadius: BorderRadius.only(
            //                     topLeft: Radius.circular(15),
            //                     topRight: Radius.circular(15),
            //                     bottomLeft: Radius.circular(0),
            //                     bottomRight: Radius.circular(0),
            //                   ),
            //                   child: Image.asset(
            //                     MyImages.plumb,
            //                     fit: BoxFit.fitWidth,
            //                     width: MediaQuery.of(context).size.width - 32,
            //                     height: 170,
            //                   ),
            //                 ),
            //                 vSizedBox,
            //                 Padding(
            //                   padding: EdgeInsets.symmetric(horizontal: 16),
            //                   child: ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing',
            //                     fontSize: 13,
            //                     fontFamily: 'regular',
            //                     color: Colors.black,
            //                   ),
            //                 ),
            //                 vSizedBox,
            //                 Padding(
            //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //                   child: ParagraphText(
            //                     text: 'India 9 hr ago',
            //                     fontSize: 9,
            //                     fontFamily: 'regular',
            //                     color:MyColors.textcolor,
            //                   ),
            //                 ),
            //
            //               ]
            //           )
            //       ),
            //     )
            //
            //   ],
            //
            // ),
          ],
        ),
      ),
    );
  }
}
