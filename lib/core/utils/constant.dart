import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ssh2/ssh2.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:tablet_design/core/utils/app_colors.dart';
class constants{
  static void record_video({required BuildContext context,required var sshClient,required StopWatchTimer stopWatch,required var name,required var path,required TextEditingController namecontroller,required TextEditingController pathcontroller}){
    var formKey = GlobalKey<FormState>();
     stopWatch= StopWatchTimer();
    showDialog(context: context, builder: (context)=>
        Form(
          key: formKey,
          child: AlertDialog(
            actions: [
              TextFormField(
                onChanged: (data){
                  name=data.trim();
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
                  labelText: 'name'.tr,
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
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'path must not be empty'.tr;
                  }

                  return null;
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'path'.tr,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){ Navigator.pop(
                    context,
                  );}, child: Text('Cansel',style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),)),
                  TextButton(onPressed: ()async{
                    stopWatch.onExecute.add(StopWatchExecute.start);
                    namecontroller.clear();
                    pathcontroller.clear();
                    if (sshClient != null) {
                      Navigator.pop(
                        context,
                      );
                      if (sshClient != null) {
                        await sshClient!.execute('ffmpeg -f v4l2 -i /dev/video0 -f alsa -i default -c:v libx264 -crf 24 -preset medium -c:a aac /media/pi/LECTURE/${path}/${name}.mp4 &');
                      }else{
                        constants.SnacMessage(context, 'no connection ');
                      }


                    }

                  }, child: Text('Ok',style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),))
                ],)
            ],
            backgroundColor: AppColors.homePage,
            title: Text('please put the correct name and path'),
            icon: Icon(Icons.file_copy,size: 40),
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
     constants.SnacMessage(context, 'no connection ');
   }

}
    showDialog(context: context, builder: (context)=>
        SingleChildScrollView(
          padding: EdgeInsets.only(top: 150),
          child: StatefulBuilder(builder:(context,setState)=>
              Form(
                key: formKey,
                child:AlertDialog(
                  title:Text(msg),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextFormField(
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
                              labelText: 'display folder'.tr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: IconButton(
                            icon: Icon(Icons.slideshow),
                            onPressed: ()async{
                              searchcontroller.clear();
                              setState((){
                                show = !show;
                              });
                              if (sshClient != null) {
                                data=(await sshClient!.execute('ls /media/pi/LECTURE/${path}&'))!;
                              }else{
                                data='no connection to raspberry pi';
                                constants.SnacMessage(context, 'no connection ');
                                 }

                              if(show==false){
                                path='';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Visibility(
                        visible: show,
                        child: Center(child: Text('${data}'))
                    ),
                    SizedBox(height: 20,),
                    Row(children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          onChanged: (value){
                            name=value.trim();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name must not be empty'.tr;
                            }

                            return null;
                          },
                          controller: creatcontroller,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'creat folder'.tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.create_new_folder),
                          onPressed: create_folder,
                        ),
                      ),
                    ],)
                    ,
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
                      ],)
                  ],
                  backgroundColor: AppColors.homePage,
                  icon: Icon(Icons.file_copy,size: 40),
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

