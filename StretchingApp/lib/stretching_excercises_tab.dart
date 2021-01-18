import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_design/Stretch.dart';
import 'package:platform_design/localization.dart';
import 'package:platform_design/strething_exercises_detail_tab.dart';


import 'utils.dart';
import 'widgets.dart';

class StretchingExercisesTab extends StatefulWidget {
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
    var stretch1 = StretchExercises(index,LocalizationsMap.of(context).bd, 15, 6);


    var stretch2 = StretchExercises(index,LocalizationsMap.of(context).bp, 1, 2);
    stretch1.Stretches.add(Stretch('1_1','BD_1_1',30, LocalizationsMap.of(context).bd_1_1));
    stretch1.Stretches.add(Stretch('1_2','BD_1_2',30, LocalizationsMap.of(context).bd_1_2));
    stretch1.Stretches.add(Stretch('2_1','BD_2_1',30, LocalizationsMap.of(context).bd_2_1));
    stretch1.Stretches.add(Stretch('2_2','BD_2_2',30, LocalizationsMap.of(context).bd_2_2));
    stretch1.Stretches.add(Stretch('3_1','BD_3_1',30, LocalizationsMap.of(context).bd_3_1));
    stretch1.Stretches.add(Stretch('3_2','BD_3_2',30, LocalizationsMap.of(context).bd_3_2));
    stretch1.Stretches.add(Stretch('4_1','BD_4_1',30, LocalizationsMap.of(context).bd_4_1));
    stretch1.Stretches.add(Stretch('4_2','BD_4_2',30, LocalizationsMap.of(context).bd_4_2));


    var stretch3 = StretchExercises(index,LocalizationsMap.of(context).es, 30, 5);
    var stretch4 = StretchExercises(index,LocalizationsMap.of(context).ld, 10, 3);


    return

      Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children :[
            Expanded(child:SafeArea(
              top: false,
              bottom: false,
              child: Hero(
                tag: index ,

                child: StretchingExercisesCard(
                  stretches : stretch1,
                  heroAnimation: AlwaysStoppedAnimation(0),
                  onPressed: () => Navigator.of(context).push<void>(
                    MaterialPageRoute(
                      builder: (context) => StretchingExercisesDetailTab(
                        id: index,
                        stretches: stretch1,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ),
            Expanded(child:SafeArea(
              top: false,
              bottom: false,
              child: Hero(
                tag: index + 1,

                child: StretchingExercisesCard(
                  stretches : stretch2,
                  heroAnimation: AlwaysStoppedAnimation(0),
                  onPressed: () => Navigator.of(context).push<void>(
                    MaterialPageRoute(
                      builder: (context) => StretchingExercisesDetailTab(
                        id: index + 1,
                        stretches: stretch2,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ),
            Expanded(child:SafeArea(
              top: false,
              bottom: false,
              child: Hero(
                tag: index + 2,

                child: StretchingExercisesCard(
                  stretches : stretch3,
                  heroAnimation: AlwaysStoppedAnimation(0),
                  onPressed: () => Navigator.of(context).push<void>(
                    MaterialPageRoute(
                      builder: (context) => StretchingExercisesDetailTab(
                        id: index + 2,
                        stretches: stretch3,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ),
            Expanded(child:SafeArea(
              top: false,
              bottom: false,
              child: Hero(
                tag: index + 3  ,

                child: StretchingExercisesCard(
                  stretches : stretch4,
                  heroAnimation: AlwaysStoppedAnimation(0),
                  onPressed: () => Navigator.of(context).push<void>(
                    MaterialPageRoute(
                      builder: (context) => StretchingExercisesDetailTab(
                        id: index + 3,
                        stretches: stretch4,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ),

          ]
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
        title: Text(LocalizationsMap.of(context).stretchingExercisesString),
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
