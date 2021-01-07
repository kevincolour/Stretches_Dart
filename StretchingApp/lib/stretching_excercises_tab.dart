import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_design/Stretch.dart';
import 'package:platform_design/strething_exercises_detail_tab.dart';

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
    var stretch1 = StretchExercises(index,'test');
    return SafeArea(
      top: false,
      bottom: false,
      child: Hero(
        tag: index,

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
