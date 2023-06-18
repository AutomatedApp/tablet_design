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
  var creatfolder = TextEditingController();
  var searchfolder = TextEditingController();
  var namecontroller = TextEditingController();
  var pathcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var name,path,data;
  bool resume = false;
  bool show=false;
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

   constants.record_video(context: context, sshClient: _sshClient, stopWatch: _stopWatchTimer, name: name, path: path, namecontroller: namecontroller, pathcontroller: pathcontroller);
  }
  Future<void> _stopScript() async {
    Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
    if (_sshClient != null) {
      await _sshClient!.execute('kill \$(pgrep ffmpeg)');
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
                      data=response;
                      final lines = response!.split('\n');
                      final contents = lines.where((line) => line.isNotEmpty).toList();
                    }
                   constants.createAndDisplay_Folder(context: context, msg: 'to go the home directory type (.)', name: name, path: path, data: data, searchcontroller: searchfolder, creatcontroller: creatfolder, show: show, sshClient: _sshClient);
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

