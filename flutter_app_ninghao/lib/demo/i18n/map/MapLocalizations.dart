import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class MapLocalizations {

  final Locale locale;

  MapLocalizations(this.locale);

  static MapLocalizations of(BuildContext context) {
    return Localizations.of(context, MapLocalizations);
  }

  static Map<String, Map<String,String>> _localized = {
    'en': {
      'title': 'hello',
    },

    'zh': {
      'title': '你好'
    }
  };

  String get title {
    return _localized[locale.languageCode]['title'];
  }

}

class MapLocalizationsDelegate extends LocalizationsDelegate<MapLocalizations> {
  MapLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return true;
  }

  @override
  Future<MapLocalizations> load(Locale locale) {
    // TODO: implement load
    return SynchronousFuture<MapLocalizations>(MapLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<MapLocalizations> old) {
    // TODO: implement shouldReload
    return false;
  }

}