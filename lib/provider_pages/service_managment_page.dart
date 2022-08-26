import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/provider_pages/add_service.dart';
import 'package:calltofix/provider_pages/edit_service.dart';
import 'package:calltofix/provider_pages/personal_information_page.dart';
import 'package:calltofix/provider_pages/select_profession.dart';
import 'package:calltofix/provider_pages/service_manage_add.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/avatar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/custom_circular_image.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../constants/global_data.dart';
import '../widgets/appbar.dart';
import '../widgets/customLoader.dart';

enum SingingCharacter { one, two, three, four, five, six, seven, }

class Service_managment_Page extends StatefulWidget {
  static const String id="Service_managment_Page";
  const Service_managment_Page({Key? key}) : super(key: key);

  @override
  State<Service_managment_Page> createState() => _Service_managment_PageState();
}

class _Service_managment_PageState extends State<Service_managment_Page> {
  TextEditingController namecontroller = TextEditingController();
  SingingCharacter? _character = SingingCharacter.one;
  bool isChecked = false;
  List? serviceList=[];
  bool load=false;


  @override
   initState()  {
    // TODO: implement initState
     getServiceList();
    super.initState();
  }

  Future<void> _showMyDialog(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete service'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want  to delete your service?'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(child: const Text('Delete'),
        onPressed: () async {
              var res=await Webservices.getMap(ApiUrls.deleteService,request: {'id':id});
              if (res['status'].toString()=='1'){
                getServiceList();
                Navigator.of(context).pop();
              }
              setState(() {

              });
        // Navigator.of(context).pop();
        },
        ),

          ],
        );
      },
    );
  }
  getServiceList()async{
    Map<String,dynamic>request={
      'user_id':userData!['id'],
    };
    setState(() {
      load = true;
    });
    serviceList = await Webservices.getListFromRequestParameters(ApiUrls.serviceList, request);
    setState(() {
      load = false;
    });
    print("service list ---------"+serviceList.toString());
    setState(() {

    });
  }
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return MyColors.primaryColor;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: 'Services Managment', appBarColor: MyColors.appbarcolor),
      body:load?CustomLoader():SingleChildScrollView(
        child: Container(
          padding: pad_horizontal,
          width: MediaQuery.of(context).size.width,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // headingText(text: 'What work do you do?', fontSize: 20, fontFamily: 'medium',),
              // ParagraphText(text: 'Select your profession', fontFamily: 'regular',fontSize: 16,color: MyColors.textcolor,),
              vSizedBox4,
              // if(serviceList!.length>0)
              for(var i=0; i<serviceList!.length; i++ )

                Container(
                  margin: EdgeInsets.only(left:0,top:0,right:0,bottom: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        boxShadow
                      ]
                  ),

            child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 12,
                        child: Row(
                          children: [
                            Flexible(
                                child: CustomCircularImage(
                                  imageUrl:serviceList![i]['cover_image'],
                                  fileType:CustomFileType.network,
                                  // imageUrl: MyImages.plumb,
                                  height: 55,
                                  width: 55,
                                )
                            ),
                            hSizedBox,
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  ParagraphText(
                                    // text:'ttle',
                                    text: serviceList![i]['title']==''?serviceList![i]['category_data']['title'] :serviceList![i]['title'],
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'semibold',
                                  ),
                                  ParagraphText(
                                    // text:'description hjh',

                                    text: serviceList![i]['description'],
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontFamily: 'regular',
                                  ),
                                  py3,
                                  ParagraphText(
                                    // text: '\$200',
                                    text: '\$'+serviceList![i]['service_fee'],
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'semibold',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: RoundEdgedButton(
                          textColor: Colors.white,
                          text: 'Edit',
                          verticalPadding: 0,
                          horizontalPadding: 0,
                          height: 20,
                          fontSize: 10,
                          letterspace: 0,
                          borderRadius: 5,
                          onTap: () async {
                            print("dataaaa----"+serviceList![i].toString());
                          await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  Edit_Service_Page(data: serviceList![i])),

                            );
                            setState(() async {
                              await getServiceList();
                            });


                            // Navigator.pushNamed(context, Edit_Service_Page.id);
                          },
                        )

                      ),
                      hSizedBox,
                      if(serviceList![i]['is_first'].toString()!="1")
                      Expanded(
                          flex: 2,
                          child: RoundEdgedButton(
                            textColor: Colors.white,
                            text: 'Delete',
                            verticalPadding: 0,
                            horizontalPadding: 0,
                            height: 20,
                            fontSize: 10,
                            letterspace: 0,
                            borderRadius: 5,
                            onTap: (){
                              _showMyDialog(serviceList![i]['id']);
                              // print("dataaaa----"+serviceList![i].toString());
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) =>  Edit_Service_Page(data: serviceList![i])),
                              // );
                              // Navigator.pushNamed(context, Edit_Service_Page.id);
                            },
                          )

                      ),
                    ],
                  ),

              ),
              vSizedBox,
            ],
          ),

        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add your onPressed code here!

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Add_Service_Page(categoryId: 'categoryId', category: {})),
          // );

            await Navigator.pushNamed(context, Services_Add_Page.id);
            setState(() async {
              await getServiceList();
            });

        },
        backgroundColor: MyColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
