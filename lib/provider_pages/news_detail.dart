import 'dart:developer';
import 'dart:io';

import 'package:calltofix/constants/error_constants.dart';
import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/global_functions.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/showSnackbar.dart';
import 'package:calltofix/modals/news_modal.dart';
import 'package:calltofix/provider_pages/about_work_page.dart';
import 'package:calltofix/provider_pages/select_profession.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/custom_circular_image.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../functions/image_picker.dart';
import '../functions/navigation_functions.dart';
import '../widgets/appbar.dart';
import '../widgets/avatar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_share/flutter_share.dart';

import '../widgets/customLoader.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class News_Detail_Page extends StatefulWidget {
  final NewsModal newsDetail;
  const News_Detail_Page({Key? key, required this.newsDetail})
      : super(key: key);

  @override
  State<News_Detail_Page> createState() => _News_Detail_PageState();
}

class _News_Detail_PageState extends State<News_Detail_Page> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController experienceController = TextEditingController();

  Future<void> share() async {
    await FlutterShare.share(
      title: '${widget.newsDetail.title}',
      text: '${widget.newsDetail.title}',
      // linkUrl: 'https://flutter.dev/',
      // chooserTitle: 'Example Chooser Title'
    );
  }

  List<NewsModal> relatedNews = [];
  bool relatedNewsLoad = false;
  getRelatedNews({String lastId = '', bool refresh = true}) async {
    setState(() {
      relatedNewsLoad = true;
    });
    var request = {
      'news_id': widget.newsDetail.id,
      'limit': '5',
    };
    List temp = await Webservices.getListFromRequestParameters(
        ApiUrls.getRelatedNews, request);
    temp.forEach((element) {
      relatedNews.add(NewsModal.fromJson(element));
    });
    setState(() {
      relatedNewsLoad = false;
    });
  }

  File? resume;
  bool load = false;
  bool isChecked = false;

  initializeFormData() {
    log(userData!.toString());
    fullNameController.text = userData!['full_name'] ?? 'd;lsk';
    mobileNumberController.text = userData!['phone'] ?? 'dsd';
    emailController.text = userData!['email'] ?? 'inccc';
  }

  late VlcPlayerController _videoPlayerController;
  bool isPlaying = false;

  initializeVideo() async {
    if (widget.newsDetail.fileType == NewsFileType.video) {
      print('initializing controller');
      _videoPlayerController = VlcPlayerController.network(
        widget.newsDetail.file,
        hwAcc: HwAcc.full,
        autoPlay: true,
        options: VlcPlayerOptions(),
      );
      _videoPlayerController.addListener(() async {
        isPlaying = (await _videoPlayerController.isPlaying()) ?? false;
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getRelatedNews();
    initializeVideo();

    initializeFormData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.newsDetail.id);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Container(
            width: MediaQuery.of(context).size.width,
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
                  Color(0xFFF1F4F8),
                  Color(0xFFF1F4F8).withOpacity(0.50),
                ],
              ),
              // color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        child: Image.network(
                          widget.newsDetail.fileType == NewsFileType.video
                              ? widget.newsDetail.thumbnail
                              : widget.newsDetail.file,
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),

                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 200, left: 16, right: 16),
                      child: Text(
                        widget.newsDetail.title,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins-Medium',
                            overflow: TextOverflow.ellipsis,
                            fontSize: 24,
                            letterSpacing: -0.23999999463558197,
                            fontWeight: FontWeight.normal,
                            height: 1.1764705882352942),
                      ),
                    ),
                    appBar(
                        context: context,
                        title: 'Detail',
                        titleColor: Colors.white,
                        appBarColor: Colors.transparent,
                        actions: [
                          IconButton(
                              onPressed: () async {
                                await share();
                              },
                              icon: Icon(Icons.share)),
                        ]),

                    if(widget.newsDetail.fileType==NewsFileType.video)
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        // color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child:  VlcPlayer(
                        controller: _videoPlayerController,
                        aspectRatio: 16 / 9,
                        // virtualDisplay: true,
                        placeholder: Center(child: CustomLoader()),

                      ),
                    ),
                    if(widget.newsDetail.fileType==NewsFileType.video)
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: GestureDetector(
                            onTap: ()async{
                              print('button pressed');
                              if(isPlaying){
                                _videoPlayerController.pause();
                              }else{
                                _videoPlayerController.play();
                              }
                              setState(() {

                              });
                            },
                            child: Icon(
                              isPlaying?Icons.pause:Icons.play_arrow,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 16),
                //   child: ListTile(
                //
                //     leading:CircleAvatar(
                //       radius: 30.0,
                //       backgroundImage:
                //       AssetImage(MyImages.plumb),
                //       backgroundColor: Colors.transparent,
                //     ),
                //     title: Text('John Smith', style: TextStyle(color: Colors.black, fontSize: 16, fontFamily:'Poppins-Medium'),),
                //     subtitle: Text('Nov 24, 2021 ,  1:08 PM', style: TextStyle(color: Colors.black, fontSize: 12),),
                //     // trailing:
                //     // GestureDetector(
                //     //   onTap: (){
                //     //
                //     //   },
                //     //   child: Image.asset(MyImages.bookmark,
                //     //     height: 30,
                //     //     width: 30,
                //     //   ),
                //     // ),
                //
                //   ),
                // ),
                vSizedBox,
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Html(
                    data: widget.newsDetail.description,
                  ),
                ),
                //
                // Padding(
                //   padding: EdgeInsets.all(16),
                //   child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                //     style: TextStyle(color: MyColors.textcolor, fontSize: 14, height: 1.6),),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(16),
                //   child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                //     style: TextStyle(color: MyColors.textcolor, fontSize: 14, height: 1.6),),
                // ),
                // Row(
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.all(16),
                //       child: Image.asset(MyImages.fb,
                //         height: 30,
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.all(10),
                //       child: Image.asset(MyImages.twitter,
                //         height: 30,
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.all(10),
                //       child: Image.asset(MyImages.insta,
                //         height: 30,
                //       ),
                //     ),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Related News',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'medium',
                      fontSize: 17,
                    ),
                  ),
                ),
                Container(
                  height: 130,
                  child: relatedNewsLoad
                      ? CustomLoader()
                      : relatedNews.length == 0
                          ? Center(
                              child:
                                  ParagraphText(text: 'No Related News Found.'),
                            )
                          : ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (int i = 0; i < relatedNews.length; i++)
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          push(
                                              context: context,
                                              screen: News_Detail_Page(
                                                  newsDetail: relatedNews[i]));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 15, left: 10),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 16),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
                                              boxShadow: [boxShadow]),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                flex: 9,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 0),
                                                      child: ParagraphText(
                                                        text: relatedNews[i]
                                                            .title,
                                                        fontSize: 13,
                                                        fontFamily: 'regular',
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    py3,
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 0),
                                                          child: ParagraphText(
                                                            text:
                                                                '${relatedNews[i].location} ${timeAgo(relatedNews[i].createdAt)}',
                                                            fontSize: 9,
                                                            fontFamily:
                                                                'regular',
                                                            color: MyColors
                                                                .textcolor,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              vSizedBox,
                                              Flexible(
                                                  flex: 3,
                                                  child: Stack(
                                                    children: [
                                                      CustomCircularImage(
                                                        imageUrl: relatedNews[i]
                                                            .thumbnail,
                                                        height: 70,
                                                        width: 61,
                                                        fit: BoxFit.fitHeight,
                                                        borderRadius: 15,
                                                      ),
                                                      Container(
                                                        height: 70,
                                                        width: 61,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: Colors.black
                                                              .withOpacity(0.3),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              MyImages.Play,
                                                              width: 24,
                                                              height: 24,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                // Column(
                                //   children: [
                                //     GestureDetector(
                                //       onTap: (){
                                //         // Navigator.pushNamed(context, News_Detail_Page.id);
                                //       },
                                //       child: Container(
                                //         margin: EdgeInsets.only(top: 15, left: 10),
                                //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                //         width: MediaQuery.of(context).size.width - 100,
                                //         height: 100,
                                //         decoration: BoxDecoration(
                                //             borderRadius: BorderRadius.circular(15),
                                //             color: Colors.white,
                                //             boxShadow: [
                                //               boxShadow
                                //             ]
                                //         ),
                                //         child: Row(
                                //           children: [
                                //             Flexible(
                                //               flex: 9,
                                //               child: Column(
                                //                 crossAxisAlignment: CrossAxisAlignment.start,
                                //                 children: [
                                //                   Padding(
                                //                     padding: EdgeInsets.only(left: 0),
                                //                     child: ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing',
                                //                       fontSize: 13,
                                //                       fontFamily: 'regular',
                                //                       color: Colors.black,
                                //                     ),
                                //                   ),
                                //                   py3,
                                //                   Row(
                                //                     children: [
                                //                       Padding(
                                //                         padding: EdgeInsets.only(left: 0),
                                //                         child: ParagraphText(
                                //                           text: 'India 9 hr ago',
                                //                           fontSize: 9,
                                //                           fontFamily: 'regular',
                                //                           color:MyColors.textcolor,
                                //                         ),
                                //                       ),
                                //                     ],
                                //                   )
                                //                 ],
                                //               ),
                                //             ),
                                //             vSizedBox,
                                //             Flexible(
                                //                 flex: 3,
                                //                 child: Stack(
                                //                   children: [
                                //                     CircleAvatarcustom(
                                //                       imageUrl: MyImages.plumb,
                                //                       bgcolor: Colors.transparent,
                                //                       height: 70,
                                //                       width: 61,
                                //                       fit: BoxFit.fitHeight,
                                //                       borderradius: 15,
                                //                     ),
                                //                     Container(
                                //                       height: 70,
                                //                       width: 61,
                                //                       decoration: BoxDecoration(
                                //                         borderRadius: BorderRadius.circular(15),
                                //                         color: Colors.black.withOpacity(0.3),
                                //                       ),
                                //                       child: Column(
                                //                         crossAxisAlignment: CrossAxisAlignment.center,
                                //                         mainAxisAlignment: MainAxisAlignment.center,
                                //                         children: [
                                //                           Image.asset(MyImages.Play, width: 24,height: 24,)
                                //                         ],
                                //
                                //                       ),
                                //                     )
                                //                   ],
                                //                 )
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     )
                                //   ],
                                // ),
                              ],
                            ),
                ),
                vSizedBox8
              ],
            ),
          )),
          // if(widget.newsDetail.containsJob==true)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: RoundEdgedButton(
                text: ' Apply Now',
                textColor: Colors.white,
                onTap: () {
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Container(
                              height: MediaQuery.of(context).size.height / 1.3,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF1F4F8),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  )),
                              child: Scaffold(
                                // resizeToAvoidBottomInset: false
                                body: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // vSizedBox2,
                                      headingText(
                                        text: 'Apply Job',
                                        fontSize: 16,
                                        fontFamily: 'medium',
                                      ),
                                      vSizedBox2,
                                      CustomTextField(
                                        controller: fullNameController,
                                        hintText: 'Full Name',
                                        borderradius: 15,
                                      ),
                                      vSizedBox,
                                      CustomTextField(
                                        controller: mobileNumberController,
                                        hintText: 'Mobile Number',
                                        borderradius: 15,
                                        keyboardType: TextInputType.number,
                                      ),
                                      vSizedBox,
                                      CustomTextField(
                                        controller: emailController,
                                        hintText: 'Email Address',
                                        borderradius: 15,
                                      ),
                                      vSizedBox,
                                      CustomTextField(
                                        controller: skillsController,
                                        hintText: 'Enter Your Skills here...',
                                        borderradius: 15,
                                        height: 120,
                                        maxLines: 4,
                                      ),
                                      vSizedBox,
                                      CustomTextField(
                                        controller: experienceController,
                                        hintText: 'Experience',
                                        borderradius: 15,
                                        keyboardType: TextInputType.number,
                                      ),
                                      vSizedBox,

                                      GestureDetector(
                                        onTap: () async {
                                          File? tempResume =
                                              await pickImage(true);
                                          if (tempResume != null) {
                                            resume = tempResume;
                                          }
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (resume == null)
                                                Text(
                                                  'Upload Resume',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: MyColors.textcolor,
                                                      fontFamily: 'regular'),
                                                )
                                              else
                                                ParagraphText(
                                                  text: 'Uploaded',
                                                  color: Colors.green,
                                                ),
                                              // hSizedBox,
                                              if (resume == null)
                                                Image.asset(
                                                  MyImages.upload,
                                                  height: 26,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // CustomTextField(
                                      //   controller: TextEditingController(),
                                      //   hintText: 'Upload Resume',
                                      //   borderradius: 15,
                                      //   enabled: false,
                                      //   prefixIcon: MyImages.upload,
                                      //   left: 0,
                                      // ),
                                      vSizedBox2,
                                      RoundEdgedButton(
                                        text: 'APPLY',
                                        textColor: Colors.white,
                                        letterspace: 1,
                                        onTap: () async {
                                          if (fullNameController.text == '') {
                                            showSnackbar(
                                                MyErrorConstants.invalidName);
                                          } else if (mobileNumberController
                                                  .text.length <
                                              9) {
                                            showSnackbar(MyErrorConstants
                                                .invalidMobileNumber);
                                          } else if (!RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(emailController.text)) {
                                            showSnackbar(MyErrorConstants
                                                .invalidEmailAddress);
                                          } else if (skillsController.text ==
                                              '') {
                                            showSnackbar(
                                                'Please Enter your skills');
                                          } else if (experienceController
                                                  .text ==
                                              '') {
                                            showSnackbar(
                                                'Please Enter your Experience');
                                          } else if (resume == null) {
                                            showSnackbar(
                                                'Please upload your resume');
                                          } else {
                                            var request = {
                                              'user_id': userData!['id'],
                                              'news_id': widget.newsDetail.id,
                                              'full_name':
                                                  fullNameController.text,
                                              'number':
                                                  mobileNumberController.text,
                                              'email': emailController.text,
                                              'skills': skillsController.text,
                                              'experience':
                                                  experienceController.text,
                                            };
                                            var files = {
                                              'resume': resume,
                                            };
                                            var jsonResponse = await Webservices
                                                .postDataWithImageFunction(
                                                    body: request,
                                                    files: files,
                                                    context: context,
                                                    apiUrl:
                                                        ApiUrls.applyForJob);
                                            if (jsonResponse['status']
                                                    .toString() ==
                                                '1')
                                              showSnackbar(
                                                  'Thank you for applying for this job, we will get back to you soon');
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                      // vSizedBox,
                                    ],
                                  ),
                                ),
                              ));
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
