import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tablet_design/Record%20Page/Record_page.dart';
import 'package:tablet_design/Record%20Page/start.dart';
import 'package:tablet_design/moduls/speechAPI.dart';
import 'package:tablet_design/splash_screen/splash_screen.dart';
import 'package:tablet_design/weather/model/weather.dart';
import 'package:tablet_design/weather/services/weather_service.dart';
import 'package:tablet_design/core/network/local_network.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'core/utils/app_strings.dart';

class HomePage extends StatefulWidget {
  static final ROUTE='home';
  const HomePage({Key? key}) : super(key: key);


  static Future<bool> logoutuser() async {

    var email= cashNetwork.getCashData(key: "email");
    var token= cashNetwork.getCashData(key: "token");
    if(email!=null && token!=null){
      cashNetwork.removeFromCash(key: "email");
      cashNetwork.removeFromCash(key: "token");
      return true;
    }else{
      return false;
    }
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState(){
    AlanVoice.addButton("1625ac6f283b3da012f90ce4ae02065d2e956eca572e1d8b807a3e2338fdd0dc/stage",buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT,);
    AlanVoice.onCommand.add((command)=>handel_command(command.data));

  }

  String path = '192.168.107.71';

  bool led1 = false;
  bool led2 = false;
  bool led3 = false;
  bool led4 = false;
  bool led5 = false;
  bool led6 = false;
  bool fan1 = false;
  bool fan2 = false;
  bool fan3 = false;
  bool projector = false;
  bool board = false;
  bool camera = false;

  WeatherService weatherService = WeatherService();
  Weather weather = Weather();

  String currentWeather = "";
  double tempC = 0;
  int tempF = 0;

  bool isListening = false;
  String text = '';

  @override
  void initState() {
    super.initState();
    getWeather();
  }
  @override
  void dispose() {
    super.dispose();
  }
  void handel_command(Map<String,dynamic>command)async{
    switch(command['command']){
      case'forward':
        Navigator.pushNamed(context,record.ROUTE);
        break;
      case'back':
        Navigator.pop(context);
        break;
      case 'led1':
        setState(() {
          led1 = true;
        });
       var url=Uri.http(path, '/on1');
        await http.get(url);
        break;
      case'off1':
          setState(() {
            led1 = false;
          });
          var url=Uri.http(path, '/off1');
          await http.get(url);
          break;
      case 'led2':
        setState(() {
          led2 = true;
        });
        var url= Uri.http(path, '/on2');
        await http.get(url);
        break;
      case'off2':
        setState(() {
          led2 = false;
        });
        var url=Uri.http(path, '/off2');
        await http.get(url);
        break;
      case 'led3':
        setState(() {
          led3 = true;
        });

        var url=Uri.http(path, '/on3');
        await http.get(url);
        break;
      case'off3':
        setState(() {
          led3 = false;
        });
        var url=Uri.http(path, '/off3');
        await http.get(url);
        break;
      case 'led4':
        setState(() {
          led4 = true;
        });
        var url=Uri.http(path, '/on4');
        await http.get(url);
        break;
      case'off4':
        setState(() {
          led4 = false;
        });
        var url=Uri.http(path, '/off4');
        await http.get(url);
        break;
      case 'led5':
        setState(() {
          led5 = true;
        });

        var url=Uri.http(path, '/on5');
        await http.get(url);
        break;
      case'off5':
        setState(() {
          led5 = false;
        });
        var url= Uri.http(path, '/off5');
        await http.get(url);
        break;
      case 'led6':
        setState(() {
          led6 = true;
        });
        var url= Uri.http(path, '/on6');
        await http.get(url);
        break;
      case'off6':
        setState(() {
          led6 = false;
        });
        var url=Uri.http(path, '/off6');
        await http.get(url);
        break;
      case 'fan1':
        setState(() {
          fan1 = true;
        });

        var url=Uri.http(path, '/f_on1');
        await http.get(url);
        break;
      case'off7':
        setState(() {
          fan1 = false;
        });
        var url= Uri.http(path, '/f_off1');
        await http.get(url);
        break;
      case 'fan2':
        setState(() {
          fan2 = true;
        });
        var url=Uri.http(path, '/f_on2');
        await http.get(url);
        break;
      case'off8':
        setState(() {
          fan2 = false;
        });
        var url=Uri.http(path, '/f_off2');
        await http.get(url);
        break;
      case 'fan1':
        setState(() {
          fan3 = true;
        });

        var url=Uri.http(path, '/f_on3');
        await http.get(url);
        break;
      case'off9':
        setState(() {
          fan3 = false;
        });
        var url= Uri.http(path, '/f_off3');
        await http.get(url);
        break;
      case'on all':
          setState(() {
            led1 = true;
            led2 = true;
            led3 = true;
            led4 = true;
            led5 = true;
            led6 = true;
          });
          var url=Uri.http(path, '/on1');
          await http.get(url);
          var url2=Uri.http(path, '/on2');
          await http.get(url2);
          var url3=Uri.http(path, '/on3');
          await http.get(url3);
          var url4=Uri.http(path, '/on4');
          await http.get(url4);
          var url5=Uri.http(path, '/on5');
          await http.get(url5);
          var url6=Uri.http(path, '/on6');
          await http.get(url6);
        break;
      case'off all':
          setState(() {
            led1 = false;
            led2 = false;
            led3 = false;
            led4 = false;
            led5 = false;
            led6 = false;
          });
          var url=Uri.http(path, '/off1');
          await http.get(url);
          var url1=Uri.http(path, '/off2');
          await http.get(url1);
          var url2=Uri.http(path, '/off3');
          await http.get(url2);
          var url3=Uri.http(path, '/off4');
          await http.get(url3);
          var url4=Uri.http(path, '/off5');
          await http.get(url4);
          var url5=Uri.http(path, '/off6');
          await http.get(url5);
        break;
    }

  }
  Future toggleRecording() => SpeechAPI.toggleRecording(
    onResult: (text) => setState(() => this.text =text),
    onListening: (isListening) {
      setState(() => this.isListening = isListening);
      if(!isListening){
        Future.delayed(Duration(seconds: 1,), (){
          _handleVoiceCommand(text);
        });

      }
    },
  );
  Future<void> _handleVoiceCommand(String command) async {
    // Implement your logic to handle the recognized voice command
    var text = command.toLowerCase();
    if(text.contains('light one on')||text.contains('light 1 on')||text.contains('open light one')){
      setState(() {
        led1 = true;
      });
      var url=Uri.http(path, '/on1');
      await http.get(url);
    }
    if(text.contains('light one of')||text.contains('light 1 of')||text.contains('close light one')){
      setState(() {
        led1 = false;
      });
      var url=Uri.http(path, '/off1');
      await http.get(url);
    }
    if(text.contains('light two on')||text.contains('light 2 on')||text.contains('open light two')){
      setState(() {
        led2 = true;
      });
      var url2=Uri.http(path, '/on2');
      await http.get(url2);
    }
    if(text.contains('light two of')||text.contains('light 2 of')||text.contains('close light two')){
      setState(() {
        led2 = false;
      });
      var url1=Uri.http(path, '/off2');
      await http.get(url1);
    }
    if(text.contains('light three on')||text.contains('light 3 on')||text.contains('open light three')){
      setState(() {
        led3 = true;
      });
      var url3=Uri.http(path, '/on3');
      await http.get(url3);
    }
    if(text.contains('light three of')||text.contains('light 3 of')||text.contains('close light three')){
      setState(() {
        led3 = false;
      });
      var url2=Uri.http(path, '/off3');
      await http.get(url2);
    }
    if(text.contains('light for on')||text.contains('light four on')||text.contains('light 4 on')||text.contains('open light four')){
      setState(() {
        led4 = true;
      });
      var url4=Uri.http(path, '/on4');
      await http.get(url4);
    }
    if(text.contains('light for of')||text.contains('light four of')||text.contains('light 4 of')||text.contains('close light four')){
      setState(() {
        led4 = false;
      });
      var url3=Uri.http(path, '/off4');
      await http.get(url3);
    }
    if(text.contains('light five on')||text.contains('light 5 on')||text.contains('open light five')){
      setState(() {
        led5 = true;
      });
      var url5=Uri.http(path, '/on5');
      await http.get(url5);
    }
    if(text.contains('light five of')||text.contains('light 5 of')||text.contains('close light five')){
      setState(() {
        led5 = false;
      });
      var url4=Uri.http(path, '/off5');
      await http.get(url4);
    }
    if(text.contains('light six on')||text.contains('light 6 on')||text.contains('open light sex')){
      setState(() {
        led6 = true;
      });
      var url6=Uri.http(path, '/on6');
      await http.get(url6);
    }
    if(text.contains('light six of')||text.contains('light 6 of')||text.contains('close light sex')){
      setState(() {
        led6 = false;
      });
      var url5=Uri.http(path, '/off6');
      await http.get(url5);
    }
    if(text.contains('fan one on')||text.contains('fan 1 on')||text.contains('open fan one')){
      setState(() {
        fan1 = true;
      });
      var u=Uri.http(path, '/f_on1');
      await http.get(u);
    }
    if(text.contains('fan one of')||text.contains('fan 1 of')||text.contains('close fan one')){
      setState(() {
        fan1 = false;
      });
      var u=Uri.http(path, '/f_off1');
      await http.get(u);
    }
    if(text.contains('fan too on')||text.contains('fan 2 on')||text.contains('fan two on')||text.contains('open fan two')){
      setState(() {
        fan2 = true;
      });
      var u=Uri.http(path, '/f_on2');
      await http.get(u);

    }
    if(text.contains('fan too of')||text.contains('fan 2 of')||text.contains('fan two of')||text.contains('close fan two')){
      setState(() {
        fan2 = false;
      });
      var u=Uri.http(path, '/f_off2');
      await http.get(u);
    }
    if(text.contains('fan three on')||text.contains('fan 3 on')||text.contains('open fan three')){
      setState(() {
        fan3 = true;
      });
      var u=Uri.http(path, '/f_on3');
      await http.get(u);
    }
    if(text.contains('fan three of')||text.contains('fan 3 of')||text.contains('close fan three')){
      setState(() {
        fan3 = false;
      });
      var u=Uri.http(path, '/f_off3');
      await http.get(u);
    }
    if(text.contains('open all light')||text.contains('turn on all light')){
      setState(() {
        led1 = true;
        led2 = true;
        led3 = true;
        led4 = true;
        led5 = true;
        led6 = true;
      });
      var url=Uri.http(path, '/on1');
      await http.get(url);
      var url2=Uri.http(path, '/on2');
      await http.get(url2);
      var url3=Uri.http(path, '/on3');
      await http.get(url3);
      var url4=Uri.http(path, '/on4');
      await http.get(url4);
      var url5=Uri.http(path, '/on5');
      await http.get(url5);
      var url6=Uri.http(path, '/on6');
      await http.get(url6);
    }
    if(text.contains('close all light')||text.contains('turn off all light')){
      setState(() {
        led1 = false;
        led2 = false;
        led3 = false;
        led4 = false;
        led5 = false;
        led6 = false;
      });
      var url=Uri.http(path, '/off1');
      await http.get(url);
      var url1=Uri.http(path, '/off2');
      await http.get(url1);
      var url2=Uri.http(path, '/off3');
      await http.get(url2);
      var url3=Uri.http(path, '/off4');
      await http.get(url3);
      var url4=Uri.http(path, '/off5');
      await http.get(url4);
      var url5=Uri.http(path, '/off6');
      await http.get(url5);
    }
    print('Voice Command: $command');
  }
  void getWeather() async {
    weather = await weatherService.getWeatherData("zagazig");

    setState(() {
      currentWeather = weather.condition;
      tempF = weather.temperatureF;
      tempC = weather.temperatureC;
    });
    print(weather.temperatureC);
    print(weather.temperatureF);
    print(weather.condition);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D596D),
        // increase the height of the app bar by setting preferredSize
        // to a custom Size object with a greater height
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                color: Color(0xFF0D596D),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/user.png",
                              height: 40,
                            ),
                          ),
                          Text(
                            'My Hall',
                            style: TextStyle(fontSize: 40, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/logo.png",
                            height: 85,
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/Event.png",
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "Event",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/lectureW.png",
                                height: 50,
                              ),
                              Text(
                                "Lecture",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          TextButton.icon(

                            icon: Icon(Icons.logout_outlined,color: Colors.white,),
                            onPressed: (){
                              HomePage.logoutuser();
                              Navigator.pushNamedAndRemoveUntil(context,SplshScreen.ROUTE,(route)=>false);
                            },
                            label: Text(
                              "LogOut".tr,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppStrings.primaryFont,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 800,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Color(0xFF0D596D),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello Dr.Osama,",
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        Text(
                          "Welcome to the Automated Hall",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.water_drop,
                                  size: 60,
                                  color: Colors.white,
                                ),
                                Text(tempC.toString(),
                                    style: TextStyle(
                                        fontSize: 28, color: Colors.white)),
                                // Text('17',
                                //   style: TextStyle(
                                //       fontSize: 28,
                                //       color: Colors.white
                                //   ),)
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.thermostat,
                                  size: 60,
                                  color: Colors.white,
                                ),
                                Text(tempF.toString(),
                                    style: TextStyle(
                                        fontSize: 28, color: Colors.white)),
                                // Text('23',
                                //   style: TextStyle(
                                //       fontSize: 28,
                                //       color: Colors.white
                                //   ),)
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.cloud_queue_sharp,
                                  size: 60,
                                  color: Colors.white,
                                ),
                                Text(
                                  currentWeather,
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white),
                                )
                              ],
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  width: 410,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Color(0xFF0D596D),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AvatarGlow(
                          animate: isListening,
                          endRadius: 75,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Color(0xFF0D596D),
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                )),
                            child: IconButton(
                              onPressed:  toggleRecording,
                              icon:Icon(isListening? Icons.mic :Icons.mic_none,size:60,color: Colors.white,)
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Voice Control',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ],
                  )),
            ],
          ),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 10.0, left: 20, right: 20),
                child: Container(
                  width: 1230,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Color(0xFF0D596D),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: GridView.count(
                      crossAxisCount: 6, // number of columns
                      crossAxisSpacing: 25.0, // spacing between columns 
                      mainAxisSpacing: 25.0, // spacing between rows

                      children: <Widget>[
                        // List of items in the GridView
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              led1 = !led1;
                            });
                            if (led1 == true) {
                              var url = Uri.http(path, '/on1');
                              var res = await http.get(url);
                            } else {
                              var url = Uri.http(path, '/off1');
                              var res = await http.get(url);
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF133E49),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset("assets/light-bulb.png",
                                  // height: 150,
                                  // ),
                                  Icon(
                                    Icons.lightbulb,
                                    shadows: [
                                      BoxShadow(
                                        color: led1
                                            ? Colors.white
                                            : Color(0xFF133E49),
                                        spreadRadius: 30,
                                        blurRadius: 73,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Light 1',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              led2 = !led2;
                            });
                            if (led2 == true) {
                              var url = Uri.http(path, '/on2');
                              await http.get(url);
                            } else {
                              var url = Uri.http(path, '/off2');
                              var res = await http.get(url);
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF133E49),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lightbulb,
                                    shadows: [
                                      BoxShadow(
                                        color: led2
                                            ? Colors.white
                                            : Color(0xFF133E49),
                                        spreadRadius: 30,
                                        blurRadius: 73,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Light 2',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              led3 = !led3;
                            });

                            if (led3 == true) {
                              var url = Uri.http(path, '/on3');
                              var res = await http.get(url);
                            } else {
                              var url = Uri.http(path, '/off3');
                              var res = await http.get(url);
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF133E49),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset("assets/light-bulb.png",
                                  // height: 150,
                                  // ),
                                  Icon(
                                    Icons.lightbulb,
                                    shadows: [
                                      BoxShadow(
                                        color: led3
                                            ? Colors.white
                                            : Color(0xFF133E49),
                                        spreadRadius: 30,
                                        blurRadius: 73,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Light 3',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              led4 = !led4;
                            });
                            if (led4 == true) {
                              var url = Uri.http(path, '/on4');
                              var res = await http.get(url);
                            } else {
                              var url = Uri.http(path, '/off4');
                              var res = await http.get(url);
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF133E49),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lightbulb,
                                    shadows: [
                                      BoxShadow(
                                        color: led4
                                            ? Colors.white
                                            : Color(0xFF133E49),
                                        spreadRadius: 30,
                                        blurRadius: 73,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Light 4',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              led5 = !led5;
                            });
                            if (led5 == true) {
                              var url = Uri.http(path, '/on5');
                              var res = await http.get(url);
                            } else {
                              var url = Uri.http(path, '/off5');
                              var res = await http.get(url);
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF133E49),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset("assets/light-bulb.png",
                                  // height: 150,
                                  // ),
                                  Icon(
                                    Icons.lightbulb,
                                    shadows: [
                                      BoxShadow(
                                        color: led5
                                            ? Colors.white
                                            : Color(0xFF133E49),
                                        spreadRadius: 30,
                                        blurRadius: 73,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Light 5',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              led6 = !led6;
                            });
                            if (led6 == true) {
                              var url = Uri.http(path, '/on6');
                              var res = await http.get(url);
                            } else {
                              var url = Uri.http(path, '/off6');
                              var res = await http.get(url);
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF133E49),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset("assets/light-bulb.png",
                                  // height: 150,
                                  // ),
                                  Icon(
                                    Icons.lightbulb,
                                    shadows: [
                                      BoxShadow(
                                        color: led6
                                            ? Colors.white
                                            : Color(0xFF133E49),
                                        spreadRadius: 30,
                                        blurRadius: 73,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Light 6',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  )
                                ],
                              )),
                        ),
                        //fans begin
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              fan1 = !fan1;
                            });
                            if (fan1 == true) {
                              var url = Uri.http(path, '/f_on1');
                              var res = await http.get(url);
                            } else {
                              var url = Uri.http(path, '/f_off1');
                              var res = await http.get(url);
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF133E49),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset("assets/light-bulb.png",
                                  // height: 150,
                                  // ),
                                  Icon(
                                    Icons.wind_power,
                                    shadows: [
                                      BoxShadow(
                                        color: fan1
                                            ? Colors.white
                                            : Color(0xFF133E49),
                                        spreadRadius: 30,
                                        blurRadius: 73,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Fan 1',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              fan2 = !fan2;
                            });
                            if (fan2 == true) {
                              var url = Uri.http(path, '/f_on2');
                              var res = await http.get(url);
                            } else {
                              var url = Uri.http(path, '/f_off2');
                              var res = await http.get(url);
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF133E49),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset("assets/light-bulb.png",
                                  // height: 150,
                                  // ),
                                  Icon(
                                    Icons.wind_power,
                                    shadows: [
                                      BoxShadow(
                                        color: fan2
                                            ? Colors.white
                                            : Color(0xFF133E49),
                                        spreadRadius: 30,
                                        blurRadius: 73,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Fan 2',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              fan3 = !fan3;
                            });
                            if (fan3 == true) {
                              var url = Uri.http(path, '/f_on3');
                              var res = await http.get(url);
                            } else {
                              var url = Uri.http(path, '/f_off3');
                              var res = await http.get(url);
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF133E49),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset("assets/light-bulb.png",
                                  // height: 150,
                                  // ),
                                  Icon(
                                    Icons.wind_power,
                                    shadows: [
                                      BoxShadow(
                                        color: fan3
                                            ? Colors.white
                                            : Color(0xFF133E49),
                                        spreadRadius: 30,
                                        blurRadius: 73,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Fan 3',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  )
                                ],
                              )),
                        ),
                        //fans ends
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              projector = !projector;
                            });
                            if (projector == true) {
                              var url = Uri.http(path, '/p_on');
                              var res = await http.get(url);
                            } else {
                              var url = Uri.http(path, '/p_off');
                              var res = await http.get(url);
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF133E49),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.developer_board,
                                    shadows: [
                                      BoxShadow(
                                        color: projector
                                            ? Colors.white
                                            : Color(0xFF133E49),
                                        spreadRadius: 30,
                                        blurRadius: 73,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Projector',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              board = !board;
                            });
                            if (board == true) {
                              var url = Uri.http(path, '/bo_on');
                              var res = await http.get(url);
                            } else {
                              var url = Uri.http(path, '/bo_off');
                              var res = await http.get(url);
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF133E49),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset("assets/light-bulb.png",
                                  // height: 150,
                                  // ),
                                  Icon(
                                    Icons.panorama_wide_angle_select,
                                    shadows: [
                                      BoxShadow(
                                        color: board
                                            ? Colors.white
                                            : Color(0xFF133E49),
                                        spreadRadius: 30,
                                        blurRadius: 73,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Whiteboard',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.pushNamed(context, record_page.ROUTE);
                            setState(() {
                              camera = !camera;
                            });
                            if (camera == true) {
                              var url =
                              Uri.http(path, '/on6');
                              var res=await http.get(url);
                            }
                            else {
                              var url =
                              Uri.http(path, '/off6');
                              var res=await http.get(url);
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF133E49),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset("assets/light-bulb.png",
                                  // height: 150,
                                  // ),
                                  Icon(
                                    Icons.video_camera_front_outlined,
                                    shadows: [
                                      BoxShadow(
                                        color: camera
                                            ? Colors.white
                                            : Color(0xFF133E49),
                                        spreadRadius: 30,
                                        blurRadius: 73,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Record',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  )
                                ],
                              )),
                        ),
                       /* Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF133E49),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Image.asset("assets/light-bulb.png",
                                // height: 150,
                                // ),
                                Icon(
                                  Icons.add,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'Other',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 25),
                                )
                              ],
                            )),*/
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
