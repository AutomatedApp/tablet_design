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
import 'package:lottie/lottie.dart';


class record extends StatefulWidget {
  static final ROUTE='video';
  static bool resume = true;
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
    name=constants.Name;
    path=constants.location;

    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
      if (_sshClient != null) {
        await _sshClient!.execute('ffmpeg -f v4l2 -i /dev/video0 -f alsa -i default -c:v libx264 -crf 24 -preset medium -c:a aac /media/pi/LECTURE/${path}/${name}.mp4 &');
      }else{
        constants.SnacMessage(context, 'no connection ');
      }
  }
  Future<void> _stopScript() async {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    Navigator.pushReplacementNamed(context, HomePage.ROUTE);
    if (_sshClient != null) {
      await _sshClient!.execute('kill \$(pgrep ffmpeg)');
    }
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor:AppColors.primary ,
      ),
      body: SingleChildScrollView(
        child: Container(
padding: EdgeInsets.only(top: 70),

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
                SizedBox(
                  child:record.resume? Image.asset(
                    ImageAssets.RecordinIcon,
                    scale: 2.3,
                  ):  Lottie.asset(ImageAssets.recording,width: 300,height: 170,) ,),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(radius: 30,
                        backgroundColor: AppColors.primary,
                        child: IconButton(onPressed:(){
                          setState(() {
                            record.resume=!record.resume;
                          });
                          _startScript();
                        } ,icon: Icon(Icons.play_arrow,color: Colors.white,)),
                      ),
                      SizedBox(width: 100,),
                      CircleAvatar(radius: 30,
                        backgroundColor: AppColors.primary,
                        child: IconButton(onPressed: _stopScript,icon: Icon(Icons.stop,color: Colors.white,)),
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

