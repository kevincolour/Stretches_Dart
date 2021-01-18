
import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_design/Stretch.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:platform_design/finish_exercises_tab.dart';
import 'widgets.dart';


class StartExercisesTab extends StatefulWidget {

  const StartExercisesTab({Key key, this.stretches}) : super(key: key);
  final StretchExercises stretches;



  @override
  _StartExercisesTabState createState() => _StartExercisesTabState(stretches: stretches);
}

class _StartExercisesTabState extends State<StartExercisesTab> {

  _StartExercisesTabState({this.stretches});



  final StretchExercises stretches;
  Stretch currentStretch;
  int start;
  int index;
  bool paused = false;
  AudioPlayer player;

  @override
  void initState() {
    super.initState();
    currentStretch = stretches.Stretches.first;
    start = currentStretch.duration;
    index = 0;
    startTimer();
    playBGM();
  }


  Timer _timer;
  void playBGM(){
    var cache = AudioCache();
    cache.play('BGM.mp3').then((value) {

      player = value;
      player.setVolume(.4);
    });

  }
  void finishScreen(){

  }

  void nextStretch(){
    index++;
    //reached final stretch in the list
    if (index >= stretches.Stretches.length){
        finishScreenNavigation();
    }
    else{
      currentStretch = stretches.Stretches.elementAt(index);
      start = currentStretch.duration;
      _timer.cancel();
      setState(() {

        startTimer();
      });
    }



  }
  void previousStretch() {
    index--;
    //reached final stretch in the list
    if (index < 0) {
      return;
    }
    currentStretch = stretches.Stretches.elementAt(index);
    start = currentStretch.duration;
    setState(() {
      _timer.cancel();
      startTimer();
    });
  }
  void pauseStretch() {
    paused = true;
    player.pause();
    setState(() {
      _timer.cancel();
    });
  }
  void resumeStretch() {
    paused = false;
    player.resume();
    setState(() {
      startTimer();
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (timer) {
        if (start == 0) {
          nextStretch();
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  Widget _buildBottomSheet(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (index != 0)
          IconButton(
              iconSize: 50,
              icon: Icon(Icons.keyboard_arrow_left, color:Colors.grey),
              onPressed: previousStretch
          )
        else
          IconButton(
              iconSize: 50,
              icon: Icon(Icons.keyboard_arrow_left,color:Colors.grey.withOpacity(.4)),
              onPressed: null,

          ),
        _buildPauseResumeButton(),
        IconButton(
            iconSize: 50,
            icon: Icon(Icons.keyboard_arrow_right, color:Colors.grey),
            onPressed: nextStretch
        ),
      ],
    );
  }
  Widget _buildPauseResumeButton(){
    if (!paused) {
      return IconButton(
          iconSize: 50,
          icon: Icon(Icons.pause, color: Colors.grey),
          onPressed: pauseStretch
      );
    }
    else{
      return IconButton(
          iconSize: 50,
          icon: Icon(Icons.play_arrow, color: Colors.grey),
          onPressed: resumeStretch
      );
    }
  }

  void finishScreenNavigation(){
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => FinishExercisesTab(
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    player.stop();
    super.dispose();
  }
        // ===========================================================================
  // Non-shared code below because:
  // - Android and iOS have different scaffolds
  // - There are differenc items in the app bar / nav bar
  // - Android has a hamburger drawer, iOS has bottom tabs
  // - The iOS nav bar is scrollable, Android is not
  // - Pull-to-refresh works differently, and Android has a button to trigger it too
  //
  // And these are all design time choices that doesn't have a single 'right'
  // answer.
  // ===========================================================================
  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            LinearProgressIndicator(
              value: (index / stretches.Stretches.length),
              minHeight: 50,
              backgroundColor: Colors.black,

            ),
            Text(
              currentStretch.name,
              style: TextStyle(
                fontSize: 24
              ),
            ),

            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(currentStretch.image), fit: BoxFit.cover)),
              height:300,
              width: double.infinity,
            )
            ,
            Container(height:120,

              child : Padding(
                padding: EdgeInsets.symmetric(horizontal:30, vertical: 20),
            child: Text(currentStretch.description, style: TextStyle(fontSize: 20),)
          )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    start.toString(),
                    style: TextStyle(
                        fontSize: 70,
                      color: Colors.green

                    ),
                ),
                Text(
                '/' + currentStretch.duration.toString(),
            style: TextStyle(
                fontSize: 40
            ),)
              ],
            ),
            LinearProgressIndicator(
              value: 1 - (start / currentStretch.duration),
              minHeight: 10,
            ),
          ],
        ),
    /*bottomNavigationBar:  BottomNavigationBar(
      selectedItemColor: Colors.white24,
      unselectedItemColor: Colors.white24,
      currentIndex: 1,
      onTap:  parseNavigationValue,
          items: [
           BottomNavigationBarItem(
          icon:  Icon(Icons.keyboard_arrow_left),
          ),
           BottomNavigationBarItem(
          icon:  Icon(Icons.keyboard_arrow_right),
          ),
      ],
    )*/
      bottomSheet: _buildBottomSheet(),
      appBar: AppBar(title: Text(currentStretch.name),backgroundColor: Colors.red,),

    );
  }

  void parseNavigationValue(int value){
      if (value == 0){
        previousStretch();
      }
      else if(value == 1){
        nextStretch();
      }
  }

  Widget _buildIos(BuildContext context) {
    return CustomScrollView(

    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
