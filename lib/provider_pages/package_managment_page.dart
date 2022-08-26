import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/provider_pages/add_service.dart';
import 'package:calltofix/provider_pages/edit_package.dart';
import 'package:calltofix/provider_pages/edit_service.dart';
import 'package:calltofix/provider_pages/personal_information_page.dart';
import 'package:calltofix/provider_pages/select_profession.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/avatar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../constants/global_data.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/appbar.dart';
import '../widgets/customLoader.dart';
import '../widgets/custom_circular_image.dart';
import 'add_new_package.dart';

enum SingingCharacter { one, two, three, four, five, six, seven, }

class Package_Managment_Page extends StatefulWidget {
  static const String id="Package_Managment_Page";
  const Package_Managment_Page({Key? key}) : super(key: key);

  @override
  State<Package_Managment_Page> createState() => _Package_Managment_PageState();
}

class _Package_Managment_PageState extends State<Package_Managment_Page> {
  TextEditingController namecontroller = TextEditingController();
  SingingCharacter? _character = SingingCharacter.one;
  bool isChecked = false;
  List serviceList=[];
  List packageList=[];

  bool load=false;


  @override
  initState()  {
    // TODO: implement initState
    getServiceList();
    getPackageList();
    print("userData"+userData.toString());
    super.initState();
  }
  Future<void> _showDialogueForDeletePackage(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete package'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want  to delete this package?'),
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
                setState(() {
                  load = true;
                });
                print("res fghgf cfgf detkj");
                var res=await Webservices.getMap(ApiUrls.deletePackage,request: {'id':id});
                print("res detkj"+res.toString());
                setState(() {
                  load = false;
                });
                if (res['status'].toString()=='1'){
                  getPackageList();
                  Navigator.pop(context);
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
  Future<void> _showDialogue() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Atleast two services should be added on your account.'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
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
  }
  getPackageList()async{
    Map<String,dynamic>request={
      'user_id':userData!['id'],
    };
    setState(() {
      load = true;
    });
   packageList  = await Webservices.getListFromRequestParameters(ApiUrls.packageList, request);
   print(packageList);
    setState(() {
      load = false;
    });
    print("packageList list ---------"+packageList.toString());
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
      appBar: appBar(context: context, title: 'Package Managment', appBarColor: MyColors.appbarcolor),
      body: load?CustomLoader():Container(
        margin: EdgeInsets.only(left:0,top:0,right:0,bottom: 16),
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
        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              if(packageList.length==0)
                Center(
        
                  child: Container(
                    margin: EdgeInsets.all(120),
                    // margin: EdgeInsets.all(10),
                      child: ParagraphText(text:'No Data Found')),
                ),
              // headingText(text: 'What work do you do?', fontSize: 20, fontFamily: 'medium',),
              // ParagraphText(text: 'Select your profession', fontFamily: 'regular',fontSize: 16,color: MyColors.textcolor,),
              vSizedBox4,
              for(var i=0; i<packageList.length; i++ )
              Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(left:0,top:0,right:0,bottom: 16),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        boxShadow
                      ]
                  ),
                  child: Column(

                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 12,
                            child: Row(
                              children: [
                                Flexible(
                                    child: CustomCircularImage(
                                      imageUrl:packageList[i]['cover_image'],
                                      height: 55,
                                      width: 55,
                                      fileType:CustomFileType.network,
                                    )
                                ),
                                hSizedBox,
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ParagraphText(
                                        text: packageList[i]['title'],
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontFamily: 'semibold',
                                      ),
                                      ParagraphText(text: packageList[i]['working_hour']+' Hours , '+userData!['city']['name'],)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RoundEdgedButton(
                                  textColor: Colors.white,
                                  text: 'Edit',
                                  verticalPadding: 0,
                                  horizontalPadding: 0,
                                  height: 20,
                                  fontSize: 10,
                                  letterspace: 0,
                                  borderRadius: 5,
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  Edit_Package_Page(data:packageList[i],)),
                                    );
                                    setState(() async {
                                      await getPackageList();
                                    });
                                    // Navigator.pushNamed(context, Edit_Service_Page.id);
                                  },
                                ),
                              ],
                            )
                          ),
                          hSizedBox,
                          Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RoundEdgedButton(
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    text: 'Delete',
                                    verticalPadding: 0,
                                    horizontalPadding: 0,
                                    height: 20,
                                    fontSize: 10,
                                    letterspace: 0,
                                    borderRadius: 5,
                                    onTap: ()  {
                                      _showDialogueForDeletePackage(packageList[i]['id']);
                                    },
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                      vSizedBox2,
                      for(var j=0; j<packageList[i]['services'].length; j++ )
                      Container(
                        margin: EdgeInsets.only(left:0,top:0,right:0,bottom: 16),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,


                          children: [
                            Image.asset(MyImages.check, width: 24,),
                            hSizedBox,
                            Expanded(
                                child: ParagraphText(
                                  text: packageList[i]['services'][j]['title'],
                                )
                            )
                          ],
                        ),
                      ),
                      vSizedBox,
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Image.asset(MyImages.check, width: 24,),
                      //     hSizedBox,
                      //     Expanded(
                      //         child: ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',)
                      //     )
                      //   ],
                      // ),
                      // vSizedBox,
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Image.asset(MyImages.check, width: 24,),
                      //     hSizedBox,
                      //     Expanded(
                      //         child: ParagraphText(text: 'General Service',)
                      //     )
                      //   ],
                      // ),
                      // vSizedBox,
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Image.asset(MyImages.check, width: 24,),
                      //     hSizedBox,
                      //     Expanded(
                      //         child: ParagraphText(text: 'Lorem Ipsum is simply dummy text of',)
                      //     )
                      //   ],
                      // ),
                      vSizedBox,
                      Divider(
                        color: Colors.black.withOpacity(0.2),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ParagraphText(
                            text: 'Total Cost',
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'semibold',
                          ),
                          ParagraphText(
                            text: '\$'+packageList[i]['service_fee'],
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'semibold',
                          ),
                        ],
                      ),

                    ],
                  )
              ),
              vSizedBox,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(serviceList.length>1){
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Add_Package_Page()),
            );
            setState(() async {
              await getPackageList();
            });
          }
         else{
            _showDialogue();
          }
          // Add your onPressed code here!
          //   Navigator.push(context, Add_Package_Page(categoryId: '', category: {}));
        },
        backgroundColor: MyColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
