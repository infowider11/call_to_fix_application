import 'dart:io';

import 'package:calltofix/constants/category.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
// import 'package:calltofix/pages/select_service.dart';
import 'package:calltofix/provider_pages/about_work_page.dart';
import 'package:calltofix/provider_pages/select_city.dart';
import 'package:calltofix/provider_pages/select_profession.dart';
import 'package:calltofix/provider_pages/select_service.dart';
import 'package:calltofix/provider_pages/select_subcategory.dart';
import 'package:calltofix/provider_pages/service_managment_page.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../constants/error_constants.dart';
import '../constants/global_data.dart';
import '../functions/image_picker.dart';
import '../functions/showSnackbar.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/appbar.dart';
import '../widgets/custom_circular_image.dart';
List workingHoursList = ['4','6', '8'];
enum SingingCharacter { lafayette, jefferson, hour }
List items = CatList;
String dropdownvalue = 'Item 1';
class Edit_Package_Page extends StatefulWidget {
  static const String id="Add_Package_Page";
  final Map<String, dynamic> data;
  const Edit_Package_Page({Key? key,required this.data}) : super(key: key);

  @override
  State<Edit_Package_Page> createState() => _Edit_Package_PageState();
}

class _Edit_Package_PageState extends State<Edit_Package_Page> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController serviceFeeController = TextEditingController();
  TextEditingController videoFeesController = TextEditingController();
  String? selectedWorkingHour = workingHoursList[0];
  TextEditingController namecontroller = TextEditingController();
  SingingCharacter? _character = SingingCharacter.lafayette;
  String? categoryId;
  bool isChecked = false;
  List subCategories = [];
  List selectedSubCategories = [];
  bool load =false;
  File? image;

  @override
  initState()  {
    print("initStateinitState");
    // TODO: implement initState
    getServices();
    autofill();
    super.initState();
  }
  autofill()async{
    print("autofill data--------"+widget.data.toString());
    titleController.text=widget.data['title'];
    descriptionController.text=widget.data['description'];
    // categoryId=widget.data['category_data']['id'];
    selectedWorkingHour=widget.data['working_hour'];
    serviceFeeController.text=widget.data['service_fee'];
    videoFeesController.text=widget.data['video_consult_fee'];
    selectedSubCategories = widget.data['services'];
    getServices();
    getSubCategoriesText();
    // image=widget.data['cover_image'];
    // image=File(widget.data['cover_image'])as File?;
    // selectedSubCategories=widget.data['service_ids'];

    // print("imageeee"+image.toString());
  }
  String getSubCategoriesText(){
    print("getSubCategoriesText---------------");
    String text = '';
    selectedSubCategories.forEach((element) {
      if(text!=''){
        text += ', ';
      }
      text += element['title'];
    });
    return text;
  }
  // getSubCategories()async{
  //   setState(() {
  //     load = true;
  //   });
  //   subCategories = await Webservices.getList(ApiUrls.get_sub_catagory_list + '?category_id=${categoryId}');
  //   print('the userData sub userData are $subCategories');
  //
  //
  //
  //   setState(() {
  //     load = false;
  //   });
  // }
  getServices()async{
    print("object ----------------");
    setState(() {
      load = true;
    });
    Map<String,dynamic>request={
      'user_id':userData!['id'],
    };
    subCategories = await Webservices.getListFromRequestParameters(ApiUrls.serviceList, request);
    print('the userData sub userData are $subCategories');



    setState(() {
      load = false;
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
      appBar: appBar(context: context, title: 'Edit Package', appBarColor: MyColors.appbarcolor),
      body: Container(
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
              vSizedBox,
              GestureDetector(
                onTap:  () async {
                  File? tempImage = await pickImage(true);
                  image=tempImage;
                  print(image);
                  if (tempImage != null) {
                    // Navigator.pop(context);
                    setState(() {
                      load = true;
                    });
                  }

                },
                child: CustomCircularImage(
                  imageUrl:widget.data['cover_image'],
                  image: image,
                  height: 95,
                  fileType: image==null?CustomFileType.network:CustomFileType.file,
                  width: 95,

                ),
              ),
              vSizedBox4,
              headingText(text: 'Title', fontSize: 16, fontFamily: 'medium',),
              vSizedBox,
              CustomTextField(
                controller: titleController,
                hintText: 'Enter a title...',
                // keyboardType: TextInputType.number,

              ),
              vSizedBox2,
              headingText(text: 'Description', fontSize: 16, fontFamily: 'medium',),
              vSizedBox,
              CustomTextField(
                controller: descriptionController,
                hintText: 'Enter a description...',
                // keyboardType: TextInputType.number,
              ),
              // vSizedBox4,
              vSizedBox2,
              // headingText(text: 'Category', fontSize: 16, fontFamily: 'medium',),
              vSizedBox,
              // GestureDetector(
              //   onTap: (){
              //     Navigator.pushNamed(context, Select_Profession_Page.id);
              //   },
              //   child: Container(
              //       height: 50,
              //       padding: EdgeInsets.only(left:16,top: 0,right: 16,bottom: 0),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(15),
              //           color: Colors.white,
              //           boxShadow: [
              //             boxShadow
              //           ]
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           DropdownButton<dynamic>(
              //             underline:Container(),
              //
              //             value:categoryId,
              //             iconDisabledColor: Colors.white,
              //             iconEnabledColor: Colors.white,
              //             // icon: Image.asset(MyImages.arrow_down, height: 20,),
              //             items: items.map((e){
              //               return DropdownMenuItem(
              //                 value: e['id'],
              //
              //                 child: Text(e['title'].toString()),
              //               );
              //             }).toList(),
              //             onChanged:( newValue) {
              //               setState(() {
              //                 categoryId = newValue!;
              //                 getSubCategories();
              //               });
              //             },
              //           ),
              //           // Flexible(
              //           //   child: ParagraphText(text: 'Select Category',fontSize: 13, color: MyColors.textcolor,),
              //           // ),
              //           Flexible(
              //               child: Image.asset(MyImages.arrow_down, height: 20,)
              //           ),
              //         ],
              //       )
              //   ),
              // ),
              // vSizedBox2,
              headingText(text: 'services', fontSize: 16, fontFamily: 'medium',),
              vSizedBox,
              GestureDetector(
                onTap: ()async{

                  List<Map>? subcategoriesTemp= await push(context: context, screen: Select_Services_Page(service:subCategories, selectedSubCategories: selectedSubCategories,));
                  if(subcategoriesTemp!=null){
                    print(selectedSubCategories);
                    selectedSubCategories = subcategoriesTemp;
                  }
                  setState(() {
                    print(selectedSubCategories);
                    getSubCategoriesText();
                  });

                },
                child: Container(
                    height: 50,
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
                        Flexible(
                          child:
                          selectedSubCategories.length!=0?
                          ParagraphText(text: getSubCategoriesText()):
                          ParagraphText(text: 'Select services',fontSize: 13, color: MyColors.textcolor,),
                        ),
                        Flexible(
                            child: Image.asset(MyImages.arrow_down, height: 20,)
                        ),
                      ],
                    )
                ),
              ),
              // GestureDetector(
              //   onTap: (){
              //     // push(context: context, screen: Select_Subcategory_Page(subCategories: subCategories));
              //     // Navigator.pushNamed(context, Select_Subcategory_Page.id);
              //   },
              //   child: Container(
              //       height: 50,
              //       padding: EdgeInsets.all(16),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(15),
              //           color: Colors.white,
              //           boxShadow: [
              //             boxShadow
              //           ]
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Flexible(
              //             child: ParagraphText(text: 'Subcategory',fontSize: 13, color: MyColors.textcolor,),
              //           ),
              //           Flexible(
              //               child: Image.asset(MyImages.arrow_down, height: 20,)
              //           ),
              //         ],
              //       )
              //   ),
              // ),
              vSizedBox2,
              headingText(text: 'Select Working hours', fontSize: 16, fontFamily: 'medium',),
              vSizedBox,
              Row(
                children: [
                  for(int i = 0;i<workingHoursList.length;i++)
                    Row(
                      children: [
                        Radio<String?>(
                          value: workingHoursList[i],
                          groupValue: selectedWorkingHour,
                          onChanged: (String? value) {
                            setState(() {
                              selectedWorkingHour = value;
                            });
                          },
                        ),
                        ParagraphText(text: '${workingHoursList[i]} hours', fontSize: 13,)
                      ],
                    ),
                  // Row(
                  //   children: [
                  //     Radio<SingingCharacter>(
                  //       value: SingingCharacter.jefferson,
                  //       groupValue: _character,
                  //       onChanged: (SingingCharacter? value) {
                  //         setState(() {
                  //           _character = value;
                  //         });
                  //       },
                  //     ),
                  //     ParagraphText(text: '6 hours', fontSize: 13,)
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Radio<SingingCharacter>(
                  //       value: SingingCharacter.hour,
                  //       groupValue: _character,
                  //       onChanged: (SingingCharacter? value) {
                  //         setState(() {
                  //           _character = value;
                  //         });
                  //       },
                  //     ),
                  //     ParagraphText(text: '8 hours', fontSize: 13,)
                  //   ],
                  // ),
                ],
              ),
              vSizedBox2,
              headingText(text: 'Service Fee', fontSize: 16, fontFamily: 'medium',),
              vSizedBox,
              CustomTextField(
                controller: serviceFeeController,
                hintText: '\$300',
                keyboardType: TextInputType.number,
              ),
              vSizedBox2,
              headingText(text: 'Video Consult Fee', fontSize: 16, fontFamily: 'medium',),
              vSizedBox,
              CustomTextField(
                controller: videoFeesController,
                hintText: '\$200',
                keyboardType: TextInputType.number,

              ),
              vSizedBox4,
              RoundEdgedButton(text: 'Update', textColor: Colors.white,
                onTap: () async {
                  if (titleController.text == '') {
                    showSnackbar(MyErrorConstants.title);
                  } else if (descriptionController.text == '') {
                    showSnackbar(MyErrorConstants.description);
                  }   else if (selectedSubCategories.length == 0) {
                    showSnackbar(MyErrorConstants.invalidselectSubCategory);
                  }
                  else if (selectedWorkingHour == null) {
                    showSnackbar(MyErrorConstants.invalidselectWorkingHours);
                  } else if (serviceFeeController.text == '') {
                    showSnackbar(MyErrorConstants.emptyServiceFee);
                  } else if (videoFeesController.text == '') {
                    showSnackbar(MyErrorConstants.emptyVideoConsultFee);
                  } else {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    print(' iskdnfkljsndf');

                    Map<String,dynamic>request = {
                      'id':widget.data['id'],
                      'user_id':userData!['id'],
                      'title': titleController.text,
                      'description': descriptionController.text,
                      'service_fee': serviceFeeController.text,
                      'video_consult_fee': videoFeesController.text,
                      'working_hour': selectedWorkingHour,
                      // 'category_id': categoryId,
                      // 'cover_image':image.toString()
                      // 'category': widget.category
                    };
                    for (int i = 0; i < selectedSubCategories.length; i++) {
                      request['service_ids[$i]'] =
                      selectedSubCategories[i]['id'];
                    }


                    Map<String,dynamic>files = {
                      // 'cover_image':image,
                    };


                    if(image!=null){
                      files["cover_image"]=image;

                    }
                    print("mappp--------" + request.toString());
                    // };
                    print("mappp----image----" + files.toString());

                    setState(() {
                      load = true;
                    });
                    var jsonResponse = await Webservices.postDataWithImageFunction(body: request, files: files,context: context,apiUrl: ApiUrls
                        .editPackage,);
                    if(jsonResponse['status'].toString()=='1'){
                      Navigator.pop(context);
                    }
                    setState(() {
                      load = false;
                    });
                    // Navigator.pushNamed(context, Service_managment_Page.id);
                  };

                },
              ),
              vSizedBox2,
            ],
          ),
        ),
      ),
    );
  }
}
