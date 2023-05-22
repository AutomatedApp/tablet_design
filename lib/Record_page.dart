import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssh2/ssh2.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:tablet_design/SSH.dart';
import 'package:tablet_design/core/utils/app_colors.dart';
import 'package:tablet_design/core/utils/app_images.dart';
import 'package:tablet_design/home_page.dart';


class record extends StatefulWidget {
  static final ROUTE='video';
  const record( {Key? key}) : super(key: key);
  @override
  State<record> createState() => _recordState();
}

class _recordState extends State<record> {
  SSHClient? _sshClient;
  bool _isRunning = false;
  bool resume = false;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHours = true;
  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
  }

  Future<void> _startScript() async {
    if (_sshClient != null) {
      await _sshClient!.execute('ffmpeg -f v4l2 -i /dev/video0 -f alsa -i default -c:v libx264 -crf 23 -preset ultrafast -c:a aac les_test2.mp4 &');
      setState(() {
        _isRunning = true;
      });
    }
  }
  Future<void> _stopScript() async {
    if (_sshClient != null) {
      await _sshClient!.execute('kill \$(pgrep ffmpeg)');
      setState(() {
        _isRunning = false;
      });
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
      body: Container(


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
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          resume = !resume;
                          if (resume == false) {
                            _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                            _stopScript;
                          }
                          else {

                            _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                            _startScript;
                          }
                        });
                      },
                      child: Icon(
                         resume? Icons.pause_circle: Icons.play_circle,
                         color: AppColors.primary,
                          size: 90,

                      ),
                    ),
                    SizedBox(width: 100,),
                    GestureDetector(
                      onTap: (){
                     Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
                    },
                      child: Icon(
                          Icons.check_circle,
                              color: AppColors.primary,
                              size: 90),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

