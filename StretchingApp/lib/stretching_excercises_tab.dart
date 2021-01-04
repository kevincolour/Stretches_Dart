import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_design/Stretch.dart';

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

  final _androidRefreshKey = GlobalKey<RefreshIndicatorState>();

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


    return SafeArea(
      top: false,
      bottom: false,
      child: PressableCard(
        onPressed: null,
        color: Colors.white30,
        flattenAnimation: AlwaysStoppedAnimation(1),
        child: Card(
          child: Container(
            height:100,
              child: Text(
          'test',
          style : TextStyle(
            fontSize: 24
          ),
          )

          )
        )

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
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async => await _androidRefreshKey.currentState.show(),
          ),
        ],
      ),
      drawer: widget.androidDrawer,
      body:  ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 12),
          itemBuilder: _listBuilder,
        ),
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
