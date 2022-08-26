import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/provider-detail.dart';
import 'package:calltofix/pages/shop.dart';
import 'package:calltofix/pages/videocall.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../constants/image_urls.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/buttons.dart';
import '../widgets/customLoader.dart';
import '../widgets/customtextfield.dart';
import '../widgets/lists.dart';
import '../widgets/search_res.dart';
import 'notification_page.dart';

class searchResultPage extends StatefulWidget {
  static const String id = "Search_Result_Page";
  final String? categoryId;
  final String? subCategoryId;
  final String? serviceType;
  final String? search_val;
  // final Map data;
  const searchResultPage(
      {Key? key,
      this.categoryId,
      this.subCategoryId,
      this.serviceType,
      this.search_val})
      : super(key: key);

  @override
  State<searchResultPage> createState() => _searchResultPageState();
}

class _searchResultPageState extends State<searchResultPage> {
  TextEditingController search = TextEditingController();
  List searchList = [];
  String? filter;
  bool load = false;
  List CategoriesList = [];
  List SubcategoriesList = [];
  String? dropdown_cateId;
  String? dropdown_subcateId;

  getSearch() async {
    Map<String, dynamic> request = {
      'keyword': search.text,
      'filter': filter,
      'category_id':dropdown_cateId??'',
      'sub_category':dropdown_subcateId??'',
      'service_type':widget.serviceType,
    };
    setState(() {
      load = true;
    });
    // if (widget.categoryId != null) {
    //   request['category_id'] = widget.categoryId;
    //   request['sub_category'] = widget.subCategoryId;
    //   request['service_type'] = widget.serviceType;
    // }
    searchList = await Webservices.getListFromRequestParameters(
        ApiUrls.searchUserServices, request);
    print("search list----${searchList.toString()}");
    setState(
      () {
        load = false;
      },
    );
  }

  get_catgories() async {
    CategoriesList = await Webservices.getListFromRequestParameters(
        ApiUrls.getProfessions, {});
    print('categoriesList---------$CategoriesList');
  }

  get_subcatgories(String id) async {
    SubcategoriesList=[];
    setState(() {

    });
    Map<String, dynamic> request = {"category_id": id};
    List subcate = await Webservices.getListFromRequestParameters(
        ApiUrls.get_sub_catagory_list, request);
      setState(() {
        SubcategoriesList=subcate;
      });
    print("subCategorysubCategory$SubcategoriesList");
    setState(() {

    });
    // print('categoriesList---------$CategoriesList');
  }

  void initState() {
    search.text = widget.search_val ?? '';
    getSearch();
    get_catgories();
  }

  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Color(0xFFF1F4F8),
            Color(0xFFF1F4F8).withOpacity(0.5),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(
            implyLeading: false,
            context: context,
            title: 'Providers',
            appBarColor: MyColors.appbarcolor,
            leading: IconButton(
              visualDensity: VisualDensity(horizontal: -4),
              onPressed: () {
                Navigator.pop(context);
              },
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                  visualDensity: VisualDensity(horizontal: 0),
                  onPressed: () {
                    Navigator.pushNamed(context, Notification_page.id);
                  },
                  padding: EdgeInsets.all(0),
                  icon: Image.asset(
                    MyImages.Notification,
                    width: 17,
                  )),
              IconButton(
                visualDensity: VisualDensity(horizontal: 0),
                onPressed: () {
                  _settingModalBottomSheet(context);
                  // Navigator.pushNamed(context, Notification_page.id);
                },
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: MyColors.blackcolor70,
                ),
              )
            ]),
        body: Container(
          height: MediaQuery.of(context).size.height,
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
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: search,
                  hintText: 'Search',
                  onChanged: (st) {
                    getSearch();
                  },
                  prefixIcon: MyImages.search,
                  left: 0,
                ),
                vSizedBox2,
                if (load)
                  Center(
                    child: CircularProgressIndicator(
                      color: MyColors.primaryColor,
                      strokeWidth: 1.5,
                    ),
                  ),
                for (var i = 0; i < searchList.length; i++)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (Provider_Detail_Page(
                                  providerId: searchList[i]['id']))));
                      // Navigator.pushNamed(context, Provider_list_page.id);
                    },
                    child: SearchList(
                      text: searchList[i]['full_name'],
                      subtext: searchList[i]['city']['name'],
                      horizontalpadding: 0,
                      color: Color(0xFF2C3A4B).withOpacity(0.50),
                      fontSize: 9,
                      fontFamily: 'regular',
                      // image:Image.network('https://picsum.photos/250?image=9'),
                      // image:Image.network([src]:searchList![i]!['image']),
                      image: searchList[i]['image'],
                      heightimg: 55,
                      widthimg: 55,
                      button: true,
                      // btntext: 'Completed',
                      btntextcolor: Color(0xFF34A853),
                      btnradius: 5,
                      btncolor: Color(0xFF34A853).withOpacity(0.34),
                      btnfontsize: 10,
                      providerId: searchList[i]['id'],
                    ),
                  ),
                if (searchList.length == 0 && !load)
                  Center(
                    child: new Text('No Data Found.'),
                  ),
                // GestureDetector(
                //   onTap: (){
                //     Navigator.pushNamed(context, VideoCall_Page.id);
                //   },
                //   child: Booking_List(
                //     text: 'Ac Service',
                //     subtext: 'Sat, 23 Apr,  2022  at  10:30 AM',
                //     horizontalpadding: 0,
                //     color: Color(0xFF2C3A4B).withOpacity(0.50),
                //     fontSize: 9,
                //     fontFamily: 'regular',
                //     image: MyImages.plumb,
                //     heightimg: 55,
                //     widthimg: 55,
                //     button:true,
                //     btntext: 'Pending',
                //     btntextcolor: MyColors.primaryColor,
                //     btnradius: 5,
                //     btncolor: MyColors.primaryColor.withOpacity(0.34),
                //     btnfontsize: 10,
                //     videobtn: true,
                //   ),
                // ),
                // GestureDetector(
                //   onTap: (){
                //     // Navigator.pushNamed(context, Provider_list_page.id);
                //   },
                //   child: Booking_List(
                //     text: 'Ac Service',
                //     subtext: 'Sat, 23 Apr,  2022  at  10:30 AM',
                //     horizontalpadding: 0,
                //     color: Color(0xFF2C3A4B).withOpacity(0.50),
                //     fontSize: 9,
                //     fontFamily: 'regular',
                //     image: MyImages.plumb,
                //     heightimg: 55,
                //     widthimg: 55,
                //     button:true,
                //     btntext: 'Payment Failed',
                //     btntextcolor: Colors.red,
                //     btnradius: 5,
                //     btncolor: Colors.red.withOpacity(0.34),
                //     btnfontsize: 10,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    filter = 'newest';
                    getSearch();
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text('Newest'),
                    leading: Icon(Icons.new_releases),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    filter = 'oldest';
                    getSearch();
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text('Oldest'),
                    leading: Icon(Icons.new_releases_outlined),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    filter = 'high';
                    getSearch();
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text('High'),
                    leading: Icon(Icons.highlight_outlined),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    filter = 'low';
                    getSearch();
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text('Low'),
                    leading: Icon(Icons.low_priority),
                  ),
                ),
                // vSizedBox,
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(16.0),
                    child: ParagraphText(
                      text: 'Category Search',
                      fontSize: 18,
                      color: MyColors.blackcolor70,
                    )),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    children: [
                      // ParagraphText(
                      //   text: 'Category',
                      //   fontSize: 18,
                      //   color: MyColors.blackcolor70,
                      // ),
                      Column(
                        children: [
                          DropdownButton(
                            hint: Text('Select Category'),
                            value: dropdown_cateId,
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: CategoriesList.map((dynamic items) {
                              return DropdownMenuItem(
                                value: items['id'].toString(),
                                child: Text(items['title']),
                              );
                            }).toList(),
                            onChanged: (String? newValue) async{
                              print('value------$newValue');
                              dropdown_subcateId = null;
                              setState(() {
                                dropdown_cateId = newValue!;
                              });
                              await get_subcatgories(dropdown_cateId.toString());
                              setState((){});
                            },
                          ),
                        ],
                      ),
                      hSizedBox2,
                      if(SubcategoriesList.length>0)
                      Column(
                        children: [
                          DropdownButton(
                            hint: Text('Select Sub-category'),
                            value: dropdown_subcateId,
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: SubcategoriesList.map((dynamic subcate) {
                              return DropdownMenuItem(
                                value: subcate['id'].toString(),
                                child: Text(subcate['title']),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              print('value------$newValue');
                              setState(() {
                                dropdown_subcateId = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(0.0),
                          child: RoundEdgedButton(

                            text: 'Filter',
                            textColor: Colors.white,
                            width: 150,
                            height: 50,
                            onTap: dropdown_cateId!=null?(){
                              print('working----');
                              getSearch();
                              Navigator.pop(context);
                              setState(() {

                              });
                            }:null,
                          ),
                        ),
                      ],
                    ),
                    hSizedBox,
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(0.0),
                          child: RoundEdgedButton(

                            text: 'Reset',
                            textColor: Colors.white,
                            width: 150,
                            height: 50,
                            onTap: (){
                              print('reset----');
                              dropdown_cateId=null;
                              dropdown_subcateId=null;
                              search.text='';
                              filter='';
                              getSearch();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
