

// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// A simple "rough and ready" example of localizing a Flutter app.
// Spanish and English (locale language codes 'en' and 'es') are
// supported.

// The pubspec.yaml file must include flutter_localizations in its
// dependencies section. For example:
//
// dependencies:
//   flutter:
//     sdk: flutter
//   flutter_localizations:
//     sdk: flutter

// If you run this app with the device's locale set to anything but
// English or Spanish, the app's locale will be English. If you
// set the device's locale to Spanish, the app's locale will be
// Spanish.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class LocalizationsMap {
  LocalizationsMap(this.locale);

  final Locale locale;

  static LocalizationsMap of(BuildContext context) {
    return Localizations.of<LocalizationsMap>(context, LocalizationsMap);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Stretching App',
      'stretchingExercisesString' : 'Stretching Exercises',
      'bp' : 'Before leaving home to play golf',

        'bp_1_1' : '허리를 펴고 고개와 어깨선을 수평으로 유지하면서 머리에 손을 얹은 후 옆으로 천천히 당긴다.  ',
        'bp_1_2' : '허리를 펴고 고개와 어깨선을 수평으로 유지하면서 머리에 손을 얹은 후 옆으로 천천히 당긴다.  ',
        'bp_2_1' : '오른팔을 왼쪽 어깨쪽으로 쭉 펴고 왼팔을 위쪽으로 굽혀 오른팔꿈치 부분을 감싼 후, 오른팔은 바깥쪽으로 힘을 주고 왼팔은 몸쪽으로 힘을 주어 밀어준다',
        'bp_2_2' : '왼팔을 오른쪽 어깨쪽으로 쭉 펴고 오른팔을 위쪽으로 굽혀 왼팔꿈치 부분을 감싼 후, 왼팔은 바깥쪽으로 힘을 주고 오른팔은 몸쪽으로 힘을 주어 밀어준다',
        'bp_3_1' : '팔을 머리 위로 올리고 팔꿈치를 구부려 손을 등 뒤로 넘기고, 반대 손으로 팔꿈치를 잡고 부드럽게 당긴다.',
        'bp_3_2' : '팔을 머리 위로 올리고 팔꿈치를 구부려 손을 등 뒤로 넘기고, 반대 손으로 팔꿈치를 잡고 부드럽게 당긴다.',
        'bp_4_1' : '오른쪽 다리를 펴고 왼쪽 다리는 구부린 상태에서 상체를 숙인다',
        'bp_4_2' : '왼쪽 다리를 펴고 오른쪽 다리는 구부린 상태에서 상체를 숙인다',
        'bp_5_1' : '한손으로 반대편 다리를 눌러주면서 고개를 돌리며서 몸을 비튼다',
        'bp_5_2' : '한손으로 반대편 다리를 눌러주면서 고개를 돌리며서 몸을 비튼다',
        'bp_6' : '어깨와 팔꿈치를 편 상태로 상체를 뒤로 눌러준다.',


      'bd' : 'Before practicing at driving range',
      'ld' : 'strengthen core',
      'es' : 'everyday stretching for hole in one',

      'start' : 'Start',
      'minutes' : 'Minutes',
      'exercises' : 'exercises',

    },
    'ko': {
      'title': '재목',
      'stretchingExercisesString' : 'routine 재목',
      'bp' : '집애서 먼저',

        'bp_1_1' : '허리를 펴고 고개와 어깨선을 수평으로 유지하면서 머리에 손을 얹은 후 옆으로 천천히 당긴다.  ',
        'bp_1_2' : '허리를 펴고 고개와 어깨선을 수평으로 유지하면서 머리에 손을 얹은 후 옆으로 천천히 당긴다.  ',
        'bp_2_1' : '오른팔을 왼쪽 어깨쪽으로 쭉 펴고 왼팔을 위쪽으로 굽혀 오른팔꿈치 부분을 감싼 후, 오른팔은 바깥쪽으로 힘을 주고 왼팔은 몸쪽으로 힘을 주어 밀어준다',
        'bp_2_2' : '왼팔을 오른쪽 어깨쪽으로 쭉 펴고 오른팔을 위쪽으로 굽혀 왼팔꿈치 부분을 감싼 후, 왼팔은 바깥쪽으로 힘을 주고 오른팔은 몸쪽으로 힘을 주어 밀어준다',
        'bp_3_1' : '팔을 머리 위로 올리고 팔꿈치를 구부려 손을 등 뒤로 넘기고, 반대 손으로 팔꿈치를 잡고 부드럽게 당긴다.',
        'bp_3_2' : '팔을 머리 위로 올리고 팔꿈치를 구부려 손을 등 뒤로 넘기고, 반대 손으로 팔꿈치를 잡고 부드럽게 당긴다.',
        'bp_4_1' : '오른쪽 다리를 펴고 왼쪽 다리는 구부린 상태에서 상체를 숙인다',
        'bp_4_2' : '왼쪽 다리를 펴고 오른쪽 다리는 구부린 상태에서 상체를 숙인다',
        'bp_5_1' : '한손으로 반대편 다리를 눌러주면서 고개를 돌리며서 몸을 비튼다',
        'bp_5_2' : '한손으로 반대편 다리를 눌러주면서 고개를 돌리며서 몸을 비튼다',
        'bp_6' : '어깨와 팔꿈치를 편 상태로 상체를 뒤로 눌러준다.',
        


      'bd' : '래인지 애서',
      'ld' : '코 업그래이드',
      'es' : '홀인원 잡기',

      
      'start' : '시작',
      'minutes' : '분',
      'exercises' : 'exercises?',
    },
  };

  Map<String, Map<String, String>> get localizedValues{
    return _localizedValues;
  }

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }
  String get bp {
    return _localizedValues[locale.languageCode]['bp'];
  }



  String get bd {
    return _localizedValues[locale.languageCode]['bd'];
  }
  String get bd_1_1 {
    return _localizedValues[locale.languageCode]['bd_1_1'];
  }
  String get bd_1_2 {
    return _localizedValues[locale.languageCode]['bd_1_2'];
  }
  String get bd_2_1 {
    return _localizedValues[locale.languageCode]['bd_2_1'];
  }
  String get bd_2_2 {
    return _localizedValues[locale.languageCode]['bd_2_2'];
  }
  String get bd_3_1 {
    return _localizedValues[locale.languageCode]['bd_3_1'];
  }
  String get bd_3_2 {
    return _localizedValues[locale.languageCode]['bd_3_2'];
  }
  String get bd_4_1 {
    return _localizedValues[locale.languageCode]['bd_4_1'];
  }
  String get bd_4_2 {
    return _localizedValues[locale.languageCode]['bd_4_2'];
  }
  String get bd_5_1 {
    return _localizedValues[locale.languageCode]['bd_5_1'];
  }
  String get bd_5_2 {
    return _localizedValues[locale.languageCode]['bd_5_2'];
  }
  String get bd_6 {
    return _localizedValues[locale.languageCode]['bd_6'];
  }



  String get ld {
    return _localizedValues[locale.languageCode]['ld'];
  }
  String get es {
    return _localizedValues[locale.languageCode]['es'];
  }
  String get stretchingExercisesString {
    return _localizedValues[locale.languageCode]['stretchingExercisesString'];
  }



  String get start {
    return _localizedValues[locale.languageCode]['start'];
  }
  String get minutes {
    return _localizedValues[locale.languageCode]['minutes'];
  }
  String get exercises {
    return _localizedValues[locale.languageCode]['exercises'];
  }
}

class LocalizationsMapDelegate extends LocalizationsDelegate<LocalizationsMap> {
  const LocalizationsMapDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ko'].contains(locale.languageCode);

  @override
  Future<LocalizationsMap> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of LocalizationsMap.
    return SynchronousFuture<LocalizationsMap>(LocalizationsMap(locale));
  }

  @override
  bool shouldReload(LocalizationsMapDelegate old) => false;
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationsMap.of(context).title),
      ),
      body: Center(
        child: Text(LocalizationsMap.of(context).title),
      ),
    );
  }
}

/*
class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => LocalizationsMap.of(context).title,
      localizationsDelegates: [
        const LocalizationsMapDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
      ],
      // Watch out: MaterialApp creates a Localizations widget
      // with the specified delegates. LocalizationsMap.of()
      // will only find the app's Localizations widget if its
      // context is a child of the app.
      home: DemoApp(),
    );
  }
}

void main() {
  runApp(Demo());
}
*/

