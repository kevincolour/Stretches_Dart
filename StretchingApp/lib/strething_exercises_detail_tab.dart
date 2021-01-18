import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_design/Stretch.dart';
import 'package:platform_design/localization.dart';
import 'package:platform_design/start_exercises_tab.dart';

import 'widgets.dart';

/// Page shown when a card in the songs tab is tapped.
///
/// On Android, this page sits at the top of your app. On iOS, this page is on
/// top of the songs tab's content but is below the tab bar itself.
class StretchingExercisesDetailTab extends StatelessWidget {
  const StretchingExercisesDetailTab({this.id, this.stretches});

  final int id;
  final StretchExercises stretches;

  Widget _buildBody() {
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: id,
            child: StretchingExercisesCard(
              stretches: stretches,
              heroAnimation: AlwaysStoppedAnimation(1),
            ),
            // This app uses a flightShuttleBuilder to specify the exact widget
            // to build while the hero transition is mid-flight.
            //
            // It could either be specified here or in SongsTab.
            flightShuttleBuilder: (context, animation, flightDirection,
                fromHeroContext, toHeroContext) {
              return StretchingExercisesCard(
                stretches: stretches,
                heroAnimation: animation,
              );
            },
          ),
          Divider(
            height: 0,
            color: Colors.grey,
          ),
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  for ( var stretch in stretches.Stretches) StretchesDetailTile(stretch: stretch)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // Non-shared code below because we're using different scaffolds.
  // ===========================================================================

/*  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(stretches.name)),
      body: _buildBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 100.0,
        width: 200.0,
        child: FittedBox(
          fit: BoxFit.contain,
          child:  FloatingActionButton(
              elevation: 0.0,
              child: Container(
                  width: 100,
                  height: 50,
                  child:Center(
                      child: Text('Start')
                  )
              ),
              backgroundColor: Colors.lightGreen,
              onPressed: (){}
          )
        ),
      ),
    );
  }*/
  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:  Container(
      height: 50.0,
      width: 150.0,
      child: FloatingActionButton.extended(
                  elevation: 0.0,
                  label: Text(LocalizationsMap.of(context).start),
                  backgroundColor: Colors.lightGreen,
                  onPressed: () => Navigator.of(context).push<void>(
                    MaterialPageRoute(
                      builder: (context) => StartExercisesTab(stretches: stretches,
                      ),
                    ),
                  ),
              )
      )
    );
  }


  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(stretches.name),
        previousPageTitle: 'Songs',
      ),
      child: _buildBody(),
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
