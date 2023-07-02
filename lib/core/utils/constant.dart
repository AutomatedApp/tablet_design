import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tablet_design/Record%20Page/Record_page.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:tablet_design/core/utils/app_colors.dart';

class constants{
  static var Name;
  static var location;
  static void record_video({required BuildContext context,required var sshClient,required var name,required var path,required var data,}){
    var createfolder = TextEditingController();
    var searchfolder = TextEditingController();
    var namecontroller = TextEditingController();
    var pathcontroller = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var name,path,data;
    bool show=false;
    showDialog(
        context: context, builder: (context)=>
        StatefulBuilder(
          builder:(context,setState)=> Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 150),
              child: AlertDialog(

                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(children: [
                      TextFormField(
                        onChanged: (data){
                          name=data.trim();
                          Name=data.trim();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty'.tr;
                          }

                          return null;
                        },
                        keyboardType: TextInputType.name,
                        controller: namecontroller,
                        decoration: InputDecoration(

                          labelText: 'Record name'.tr,
                          labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: pathcontroller,
                        onChanged: (data){
                          path=data.trim();
                          location=data.trim();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'path must not be empty'.tr;
                          }

                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
                          labelText: 'Write/Choose the path location '.tr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:  MaterialStateProperty.all(AppColors.primary)),
                            onPressed: ()async{
                              if (sshClient != null) {
                                var response=await sshClient!.execute('ls /media/pi/LECTURE &');
                                data=response;
                                final lines = response!.split('\n');
                                final contents = lines.where((line) => line.isNotEmpty).toList();
                              }
                              constants.createAndDisplay_Folder(context: context, msg: '\t \t \t \t To go the home directory type (.)\t \t \t \t \t \t ', name: name, path: path, data: data, searchcontroller: searchfolder, creatcontroller: createfolder, show: show, sshClient: sshClient);
                            }, icon: Icon(Icons.folder_copy_sharp,color: Colors.white,), label: Text(
                            "Browse/Create folder".tr,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:Colors.white,
                            ),
                          ),),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: (){ Navigator.pop(
                            context,
                          );}, child: Text('Cancel',style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),)),
                          TextButton(onPressed: ()async{
                            if (formKey.currentState!.validate()){
                            namecontroller.clear();
                            pathcontroller.clear();
                            Navigator.pushReplacementNamed(context, record.ROUTE);
                            record.resume=true;
                            }
                          }, child: Text('Ok',style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),))
                        ],)
                    ],),
                  )
                ],
                backgroundColor: Colors.white.withOpacity(.8),
                title: Text('\t\t\t   Where Will You Put This Record      \t\t\t\t',style: TextStyle(color: AppColors.primary,fontSize: 25,fontWeight: FontWeight.bold),),
                icon: Icon(Icons.file_copy,size: 40),
              ),
            ),
          ),
        ));
  }
  static void createAndDisplay_Folder({required BuildContext context,required var sshClient,required var msg,required var name,required var path,required var data,required TextEditingController searchcontroller,required TextEditingController creatcontroller,required bool show}){
    var formKey = GlobalKey<FormState>();
Future<void> create_folder() async {
   if (sshClient != null) {
   creatcontroller.clear();
   await sshClient!.execute('mkdir /media/pi/LECTURE/${name}');
}else{
     constants.SnacMessage(context, 'No connection ');
   }

}
    showDialog(context: context, builder: (context)=>
        SingleChildScrollView(
          padding: EdgeInsets.only(top: 150),
          child: StatefulBuilder(builder:(context,setState)=>
              Form(
                key: formKey,
                child:AlertDialog(
                  titlePadding: EdgeInsets.symmetric(horizontal: 20),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title:Text(msg,),
                  actions: [
                    TextFormField(
                      onChanged: (value){
                        path=value.trim();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty'.tr;
                        }

                        return null;
                      },

                      controller: searchcontroller,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.slideshow),
                          onPressed: ()async{
                            searchcontroller.clear();
                            setState((){
                              show = !show;
                            });
                            if (sshClient != null) {
                              data=(await sshClient!.execute('ls /media/pi/LECTURE/${path}&'))!;
                            }else{
                              data='No connection to raspberry pi';
                              constants.SnacMessage(context, 'No connection ');
                            }

                            if(show==false){
                              path='';
                            }
                          },
                        ),
                        labelText: 'Display folder'.tr,
                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Visibility(
                        visible: show,
                        child: Center(child: Text('${data}'))
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      onChanged: (value){
                        name=value.trim();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name must not be empty'.tr;
                        }

                        return null;
                      },
                      controller: creatcontroller,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.create_new_folder),
                          onPressed: create_folder,
                        ),
                        labelText: 'Create folder'.tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.0,
                          ),
                        ),
                      ),
                    )
                    ,
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){ Navigator.pop(
                          context,
                        );}, child: Text('Done',style: TextStyle(
                          fontSize: 20.0,
                          color: AppColors.primary,
                        ),)),
                      ],)
                  ],
                  backgroundColor:Colors.white.withOpacity(.8),

                  icon:Center(child: Text('Create new folder'.tr,style: TextStyle(color: AppColors.primary,fontSize: 30),)),
                ),
              ),
          ),
        ));
  }
  static void ShowDialog({required BuildContext context,required var msg,}){
    var formKey = GlobalKey<FormState>();
    showDialog(context: context, builder: (context)=>
        Form(
          key: formKey,
          child: AlertDialog(
            actions: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){
                    Navigator.pop(
                      context,
                    );
                  }, child: Text('Ok',style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),))
                ],)
            ],
            backgroundColor: AppColors.homePage,
            title: Text(msg),
            icon: Icon(Icons.file_copy,size: 40),
          ),
        ));
  }
  static void ShowList({required BuildContext context,required var msg,required var path,required List content}){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          actions: [
            Container(
              child: DropdownButton(
                isExpanded: true,
                hint: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'display content',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Microsoft PhagsPa',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006782),
                    ),
                  ),
                ),
                items:content.map((AcademicYear) => DropdownMenuItem(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 20),
                    child: Text(
                      "${AcademicYear}",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Microsoft PhagsPa',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006782),
                      ),
                    ),
                  ),
                  value: AcademicYear,
                )).toList(),
                onChanged: (val) {
                  path = val;

                },
                value: path,
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(
                    context,
                  );
                }, child: Text('Ok',style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),))
              ],)
          ],
          backgroundColor: AppColors.homePage,
          title: Text('folder'),
          icon: Icon(Icons.file_copy,size: 40),
        ));
  }
  static void Dialog({required BuildContext context,required var msg,}){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: AppColors.homePage,
          shape:Border.symmetric() ,
          actions: [
            SizedBox(height: 10,),
            Center(child: Text(msg)),
          ],

        ));
  }
  static void messageDialog({required BuildContext context,required String msg,required String path}){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: AppColors.homePage,
          shape:Border.symmetric() ,
          actions: [
            SizedBox(height: 10,),
            Center(child: Text(msg,style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),)),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              TextButton(onPressed: (){ Navigator.pop(
                context,
              );}, child: Text('Cansel',style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),)),
              TextButton(onPressed: (){
              }, child: Text('Ok',style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),))
            ],)
          ],

        ));
  }
  static void showToast({required String msg, Color? color, ToastGravity? gravity}){
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor:color?? AppColors.primary,
          gravity: gravity?? ToastGravity.BOTTOM
      );

      }
  static void SnacMessage(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 300,
        action: SnackBarAction(
            label: "Undo ", onPressed: (){ }),
        behavior:SnackBarBehavior.floating ,
        backgroundColor:AppColors.primary,
        content: Container( height: 30,width: 30,

            margin:EdgeInsetsDirectional.only(bottom: 10),child: Center(child: Text('$message',maxLines: 1,style: TextStyle(fontSize: 20,fontFamily: 'Segoe Print'),))),
      ),
    );
  }
}
String? token;

