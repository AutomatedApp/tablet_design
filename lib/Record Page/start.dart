import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssh2/ssh2.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:tablet_design/core/utils/app_colors.dart';
import 'package:tablet_design/core/utils/app_images.dart';
import 'package:tablet_design/core/utils/app_strings.dart';
import 'package:tablet_design/Record%20Page/Record_page.dart';
import 'package:tablet_design/core/utils/constant.dart';


class record_page extends StatelessWidget
{
  SSHClient? _sshClient;
  static final ROUTE='Recordpage';
  var creatfolder = TextEditingController();
  var searchfolder = TextEditingController();
  var namecontroller = TextEditingController();
  var pathcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var name,path,data;
  bool resume = false;
  bool show=false;
  final _isHours = true;



  @override
  Widget build(BuildContext context) {
    Future<void> _startScript() async {
      if (_sshClient != null) {
        //await _sshClient!.execute('ffmpeg -f v4l2 -i /dev/video0 -f alsa -i default -c:v libx264 -crf 24 -preset medium -c:a aac /media/pi/LECTURE/${path}/${name}.mp4 &');
        constants.record_video(context: context, sshClient: _sshClient, name: name, path: path,data:data);
      }else{
        constants.SnacMessage(context, 'no connection ');
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,

     appBar: AppBar(
       title: Row(

         children: [


            Text(
           'Record'.tr,
           style: TextStyle(color: Colors.white,
           fontSize: 30), //<-- SEE HERE
         ),
           const SizedBox(
             width: 4,
           ),

           Image.asset(
             ImageAssets.upperRecord,
             scale: 2.3,
           ),

         ],
       ),
       backgroundColor:AppColors.primary,
     ),
      body: Container(


        child: Center(
          child: Column(

            children:
            [
              Image(image:AssetImage( ImageAssets.RecordPage),width: 570,height: 500,),

             Column(children: [
               InkWell(child:Image.asset(
                 ImageAssets.startRecord,
                 scale: 2.5,
               )
                 ,onTap: (){
                   _startScript();
                 },)
               ,
               SizedBox(
                 height: 10,
               ),
               Text('Start'.tr,style: TextStyle(
                   fontSize: 25,color: AppColors.primary,
                   fontFamily: AppStrings.primaryFont
               ),
               )
             ],)

                      ],

                    ),
        ),
                ),
              );
  }
}