import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssh2/ssh2.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:tablet_design/SSH.dart';
import 'package:tablet_design/core/utils/app_colors.dart';
import 'package:tablet_design/core/utils/app_images.dart';
import 'package:tablet_design/core/utils/constant.dart';
import 'package:tablet_design/home_page.dart';


class record extends StatefulWidget {
  static final ROUTE='video';
  const record( {Key? key}) : super(key: key);
  @override
  State<record> createState() => _recordState();
}

class _recordState extends State<record> {
  SSHClient? _sshClient;
  var formKey = GlobalKey<FormState>();
  var name,path,folder;
  bool resume = false;
  bool show=true;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHours = true;

  @override
  void initState() {
    super.initState();
    _connectToRaspberryPi();
  }
  @override
  void dispose() {
    _sshClient?.disconnect();
    super.dispose();
    _stopWatchTimer.dispose();
  }
  Future<void> _connectToRaspberryPi() async {
    final sshHelper = SshHelper(
      host: '192.168.1.50',
      username: 'pi',
      password: 'yasser',
    );
    _sshClient = await sshHelper.connect();
  }
  Future<void> _startScript() async {
    name='lecture1';
    path='robotics';
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
                    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                    if (_sshClient != null) {
                      Navigator.pop(
                        context,
                      );
                      await _sshClient!.execute('ffmpeg -f v4l2 -i /dev/video0 -f alsa -i default -c:v libx264 -crf 24 -preset medium -c:a aac /media/pi/LECTURE/${path}/${name}.mp4 &');

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
  Future<void> _stopScript() async {
    Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
    if (_sshClient != null) {
      await _sshClient!.execute('kill \$(pgrep ffmpeg)');
    }
  }
  Future<void> create_folder() async {
    if (_sshClient != null) {
      await _sshClient!.execute('mkdir /media/pi/LECTURE/${name}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


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
        backgroundColor:AppColors.primary ,
      ),
      body: SingleChildScrollView(
        child: Container(


          child: Center(
            child: Column(


              children:[
                SizedBox(height: 150,),
                StreamBuilder<int>(

                    stream: _stopWatchTimer.rawTime,
                    initialData:  _stopWatchTimer.rawTime.value,
                    builder: (context, snapshot) {
                      final value = snapshot.data;
                      final displayTime = StopWatchTimer.getDisplayTime(value!, hours: _isHours);
                      return Text(displayTime,
                        style: TextStyle(
                            fontSize: 40,
                            color:AppColors.primary,
                            fontWeight: FontWeight.bold
                        ),);
                    }
                ),
                SizedBox(height: 40,),
                Image.asset(ImageAssets.RecordinIcon,scale: 2.3,),
                SizedBox(height: 40,),
                ElevatedButton.icon(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  onPressed: ()async{
                    if (_sshClient != null) {
                      var response=await _sshClient!.execute('ls /media/pi/LECTURE &');
                      final lines = response!.split('\n');
                      final contents = lines.where((line) => line.isNotEmpty).toList();
                      showDialog(context: context, builder: (context)=>
                          StatefulBuilder(builder:(context,setState)=>
                            Form(
                              key: formKey,
                              child:SingleChildScrollView(
                                child: AlertDialog(
                                  actions: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: TextFormField(
                                            onChanged: (data){
                                              path=data.trim();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'name must not be empty'.tr;
                                              }

                                              return null;
                                            },
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
                                              setState((){
                                                show = !show;
                                              });
                                              response=await _sshClient!.execute('ls /media/pi/LECTURE/${path}&');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Visibility(
                                      visible: show,
                                        child: Center(child: Text(response!))
                                    ),
                                    SizedBox(height: 20,),
                                    Row(children: [
                                      Expanded(
                                        flex: 5,
                                        child: TextFormField(
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

                  },
                  icon: Icon(Icons.folder_copy_sharp),
                  label: Text('display item and folder'),
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(

                        onPressed:_startScript,
                        icon: Icon(Icons.play_arrow,),
                        label: Text('Start'),
                      ),
                      SizedBox(width: 100,),

                      ElevatedButton.icon(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        onPressed: _stopScript,
                        icon: Icon(Icons.stop),
                        label: Text('Stop'),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

