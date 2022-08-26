import 'package:calltofix/constants/error_constants.dart';
import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/showSnackbar.dart';
import 'package:calltofix/provider_pages/about_work_page.dart';
import 'package:calltofix/provider_pages/select_city.dart';
import 'package:calltofix/provider_pages/select_profession.dart';
import 'package:calltofix/provider_pages/select_subcategory.dart';
import 'package:calltofix/provider_pages/service_managment_page.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:calltofix/widgets/custom_full_page_loader.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../functions/navigation_functions.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/appbar.dart';

// enum SingingCharacter { lafayette, jefferson, hour }
List workingHoursList = ['4','6', '8'];

class Add_Service_Page extends StatefulWidget {
  static const String id="Add_Service_Page";

  final String categoryId;
  final Map? category;

  const Add_Service_Page({Key? key, required this.categoryId, required this.category}) : super(key: key);

  @override
  State<Add_Service_Page> createState() => _Add_Service_PageState();
}

class _Add_Service_PageState extends State<Add_Service_Page> {
  TextEditingController serviceFeeController = TextEditingController();
  TextEditingController videoFeesController = TextEditingController();
  String? selectedWorkingHour = workingHoursList[0];
  bool isChecked = false;


  bool load = false;
  List subCategories = [];
  List selectedSubCategories = [];

  String getSubCategoriesText(){
    String text = '';
    selectedSubCategories.forEach((element) {
      if(text!=''){
        text += ', ';
      }
      text += element['title'];
    });
    return text;
  }
  getSubCategories()async{
    setState(() {
      load = true;
    });
    subCategories = await Webservices.getList(ApiUrls.get_sub_catagory_list + '?category_id=${widget.categoryId}');


   try{
     if(userData!=null){
       serviceFeeController.text = userData!['service_fee'];
       videoFeesController.text =  userData!['video_consult_fee'];
       selectedWorkingHour =  userData!['working_hour'];
       if(widget.categoryId==userData!['work_category']['id']){
         selectedSubCategories = userData!['work_sub_category'];

         print('the selected sub are $selectedSubCategories');
       }

     }
   }catch(e){
     print('Error in catch block sub categories 2123 $e');
   }
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSubCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: 'Add Service', appBarColor: MyColors.appbarcolor),
      body:
      // load?CustomLoader():
      Stack(
        children: [
          SingleChildScrollView(
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
                       vSizedBox2,

                       headingText(text: 'subcategory', fontSize: 16, fontFamily: 'medium',),
                       vSizedBox,
                       GestureDetector(
                         onTap: ()async{
                           List<Map>? subcategoriesTemp= await push(context: context, screen: Select_Subcategory_Page(subCategories: subCategories, selectedSubCategories: selectedSubCategories,));
                           if(subcategoriesTemp!=null){
                             selectedSubCategories = subcategoriesTemp;
                           }
                           setState(() {

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
                                   ParagraphText(text: 'Select subcategories',fontSize: 13, color: MyColors.textcolor,),
                                 ),
                                 Flexible(
                                     child: Image.asset(MyImages.arrow_down, height: 20,)
                                 ),
                               ],
                             )
                         ),
                       ),
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
                       onTap: ()async{
                         if(selectedSubCategories.length==0){
                           showSnackbar(MyErrorConstants.invalidselectSubCategory);
                         }else if(selectedWorkingHour==null){
                           showSnackbar(MyErrorConstants.invalidselectWorkingHours);
                         }else if(serviceFeeController.text==''){
                           showSnackbar(MyErrorConstants.emptyServiceFee);
                         }else if(serviceFeeController.text==''){
                           showSnackbar(MyErrorConstants.emptyVideoConsultFee);
                         }else{
                           FocusScope.of(context).requestFocus(new FocusNode());
                           print(' iskdnfkljsndf');

                           Map request = {
                             'service_fee': serviceFeeController.text,
                             'video_consult_fee': videoFeesController.text,
                             'working_hour': selectedWorkingHour,
                             'work_category': widget.categoryId,
                             'category': widget.category
                           };

                           for(int i = 0;i<selectedSubCategories.length;i++){
                             request['work_sub_category[$i]']=selectedSubCategories[i]['id'];
                           }
                           Navigator.pop(context);
                           Navigator.pop(context, request);
                         }



                       },
                       ),
                       vSizedBox2,
                     ],
              ),
            ),
          ),
          if(load)
            CustomFullPageLoader()
        ],
      ),
    );
  }
}
