import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_design/Stretch.dart';
import 'package:platform_design/news_tab.dart';

import 'utils.dart';
import 'widgets.dart';

class StretchingExercisesTab extends StatefulWidget {
  static const title = 'Stretching Exercises';
  static const androidIcon = Icon(Icons.arrow_forward);
  static const iosIcon = Icon(CupertinoIcons.music_note);

  const StretchingExercisesTab({Key key, this.androidDrawer}) : super(key: key);

  final Widget androidDrawer;

  @override
  _StretchingExercisesTab createState() => _StretchingExercisesTab();
}

class _StretchingExercisesTab extends State<StretchingExercisesTab> {
  static const _itemsLength = 50;

  List<MaterialColor> colors;
  List<Stretch> stretches;
  List<String> songNames;

  @override
  void initState() {
    _setData();
    super.initState();
  }

  void _setData() {
    colors = getRandomColors(_itemsLength);
    stretches = getRandomStretches(_itemsLength);
  }

  Future<void> _refreshData() {
    return Future.delayed(
      // This is just an arbitrary delay that simulates some network activity.
      const Duration(seconds: 2),
          () => setState(() => _setData()),
    );
  }

  Widget _listBuilder(BuildContext context, int index) {
    if (index >= _itemsLength) return null;

    // Show a slightly different color palette. Show poppy-ier colors on iOS
    // due to lighter contrasting bars and tone it down on Android.
    final color = Colors.white24;

    return SafeArea(
      top: false,
      bottom: false,
      child: AnimatedBuilder(
        animation: AlwaysStoppedAnimation(1),
          builder: (context,child){
            return PressableCard(
              color: color,
                onPressed: () => Navigator.of(context).push<void>(
                MaterialPageRoute(
                builder: (context) => NewsTab(

                ))),
                flattenAnimation: AlwaysStoppedAnimation(1),

                child: Card(
                    child: Container(
                        height:100,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Morning Warmup',
                              style : TextStyle(
                                  fontSize: 24
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.access_time, size:16),
                                    Text(
                                      ' 15 Minutes',
                                      style : TextStyle(
                                          fontSize: 15
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Icon(Icons.lightbulb_outline, size:16),
                                    Text(
                                      ' 6 Exercises',
                                      style : TextStyle(
                                          fontSize: 15
                                      ),
                                    ),

                                  ]


                              )

                            )


                          ]
                        )


                    )
                )

            );
          }

      )

    );
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
      appBar: AppBar(
        title: Text(StretchingExercisesTab.title),
        actions: [

        ],
      ),
      drawer: widget.androidDrawer,
      body:  _listBuilder(context, 0)
    );
  }

  Widget _buildIos(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(CupertinoIcons.shuffle),
          ),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: _refreshData,
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(_listBuilder),
            ),
          ),
        ),
      ],
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
