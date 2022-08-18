import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../data/firestore_provider.dart';
import 'admin_account/admin_login.dart';
import 'products_screen.dart';
import 'router/router.dart';
class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> addKey = GlobalKey();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepOrange,
          automaticallyImplyLeading: false,
          title:Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: (){
                  showDialog(context: AppRouter.navKey.currentContext!, builder: (context){
                    return AlertDialog(
                      content: Text('Are you Sure?'),
                      actions: [
                        TextButton(
                          onPressed: (){
                            AppRouter.popRoute();
                          },
                          child: const Text('Cancel',style: TextStyle(color: Colors.deepOrange),),
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                              return AdminLoginScreen();
                            }));
                          },
                          child: const Text('OK',style: TextStyle(color: Colors.deepOrange),),
                        ),
                      ],
                    );
                  });
                },
                icon:const Icon(Icons.logout,size: 25,),
              ),
              const Text('           '),
              Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: Text('Welcome Admin'.tr(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,),textAlign: TextAlign.center,)),
            ],
          ),
          bottom: const TabBar(
            tabs: [
              Text(
                'Add Clothes',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                'All Clothes',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
            unselectedLabelColor: Color.fromRGBO(227, 226, 226, 1.0),
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2,
          ),
        ),

        body: TabBarView(
          children: [
            Consumer<FireStoreProvider>(
              builder: (context,provider,x) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    alignment: Alignment.center,
                    child: Form(
                      key: addKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                              margin:const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                              child:const Text('Please Add Your Cloths Photo Here:',style: TextStyle(fontSize: 12),)
                          ),
                          InkWell(
                            onTap: (){
                              provider.selectImage();
                            },
                            child: provider.selectedImage == null?
                              Container(
                                width: 360.w,
                                height: 300.h,
                                alignment: Alignment.center,
                                margin:const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:const [
                                    Icon(Icons.add,),
                                    Text('There is no Image!!')
                                  ],
                                ),
                              ) :
                              Container(
                                width: 360.w,
                                height: 300.h,
                                margin:const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child:Image(image: FileImage(provider.selectedImage!),fit: BoxFit.cover,),
                              ),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              margin:const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                              child:const Text('Please Enter The Clothes Name Here:',style: TextStyle(fontSize: 12),)
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            child: TextFormField(
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Required *';
                                }
                              },
                              controller: provider.productNameController,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),

                                ),
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              margin:const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                              child:const Text('Please Enter The Clothes Price Here:',style: TextStyle(fontSize: 12),)
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            child: TextFormField(
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Required *';
                                }
                              },
                              controller: provider.productPriceController,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),

                                ),
                              ),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(height: 20,),
                          ElevatedButton(
                            onPressed: () async {
                              if(addKey.currentState!.validate()){
                                await provider.addNewProducts();
                                setState((){
                                  provider.selectedImage = null;
                                  provider.productNameController.text = '';
                                  provider.productPriceController.text = '';
                                });

                              }
                              else{
                                log('add required values');
                              }

                            },
                            child:const Text('Add Clothes'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.deepOrange),

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
            ProductScreen(),
          ],
        ),
      ),
    );
  }
}
