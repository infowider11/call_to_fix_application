import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/modals/news_modal.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:calltofix/widgets/custom_circular_image.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../constants/dummyData.dart';
import '../constants/global_functions.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../provider_pages/news_detail.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';

class TrendingNewsPage extends StatefulWidget {
  final String newsCategory;
  const TrendingNewsPage({Key? key, required this.newsCategory}) : super(key: key);

  @override
  _TrendingNewsPageState createState() => _TrendingNewsPageState();
}

class _TrendingNewsPageState extends State<TrendingNewsPage> {
  List<NewsModal> trendingNews = [];
  bool load = false;
  getAllTrendingNews({String lastId='', bool refresh = true})async{
    setState(() {
      load = true;
    });
    var request = {
      'news_category': widget.newsCategory,
      'news_type':'1',
    };
    List temp = await Webservices.getListFromRequestParameters(ApiUrls.getNews, request);
    temp.forEach((element) {trendingNews.add(NewsModal.fromJson(element));});
    setState(() {
      load = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getAllTrendingNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Trending News'),
      body:load?CustomLoader(): Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child:  ListView(
          // scrollDirection: Axis.horizontal,
          children: [
            if(trendingNews.length==0)
              Container(
                height: MediaQuery.of(context).size.height-100,
                child: Center(
                  child: ParagraphText(text:'No Trending News Found'),
                ),
              ),
            for(int i = 0;i<trendingNews.length;i++)
              Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      // Navigator.pushNamed(context, News_Detail_Page.id);
                      push(context: context, screen: News_Detail_Page(newsDetail: trendingNews[i]));
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
                                  trendingNews[i].fileType==NewsFileType.video?trendingNews[i].thumbnail:trendingNews[i].file,
                                  fit: BoxFit.fitWidth,
                                  width: MediaQuery.of(context).size.width - 32,
                                  height: 170,
                                ),
                              ),
                              vSizedBox,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: ParagraphText(text: trendingNews[i].title,
                                  fontSize: 13,
                                  fontFamily: 'regular',
                                  color: Colors.black,
                                ),
                              ),
                              vSizedBox,
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: ParagraphText(
                                  text: '${trendingNews[i].location} ${timeAgo(trendingNews[i].createdAt)}',
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
