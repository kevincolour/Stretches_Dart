

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
      'bd' : 'Before practicing at driving range',
      'ld' : 'strengthen core',
      'es' : 'everyday stretching for hole in one',


      'minutes' : 'Minutes',
      'exercises' : 'exercises',

    },
    'ko': {
      'title': '재목',
      'stretchingExercisesString' : 'routine 재목',
      'bp' : '집애서 먼저',
      'bd' : '래인지 애서',
      'ld' : '코 업그래이드',
      'es' : '홀인원 잡기',

      'minutes' : '분',
      'exercises' : 'exercises?',
    },
  };

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }
  String get bp {
    return _localizedValues[locale.languageCode]['bp'];
  }
  String get bd {
    return _localizedValues[locale.languageCode]['bd'];
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

