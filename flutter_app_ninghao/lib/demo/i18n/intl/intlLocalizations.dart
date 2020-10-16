import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intlLocalizations_messages_all.dart';


// 生成intl指令
// 1.flutter pub run intl_translation:extract_to_arb --output-dir=lib/demo/i18n/intl/ lib/demo/i18n/intl/intlLocalizations.dart
// 2.flutter pub run intl_translation:generate_from_arb --generated-file-prefix=intlLocalizations_ --output-dir=lib/demo/i18n/intl/ --no-use-deferred-loading lib/demo/i18n/intl/intlLocalizations.dart lib/demo/i18n/intl/intl_*.arb
class IntlLocations {

  static IntlLocations of(BuildContext context) {
    return Localizations.of(context, IntlLocations);
  }

  static Future<IntlLocations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return IntlLocations();
    });
  }

  String get title => Intl.message(
    'hello',
    name: 'title',
    desc: 'demo localizations',
  );

  String greet(String name) => Intl.message(
    'hello ${name}',
    name: 'greet',
    desc: 'great someone',
    args: [name],
  );
}

class IntlLocationsDelegate extends LocalizationsDelegate<IntlLocations> {
  IntlLocationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return true;
  }

  @override
  Future<IntlLocations> load(Locale locale) {
    // TODO: implement load
    return IntlLocations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<IntlLocations> old) {
    // TODO: implement shouldReload
    return false;
  }

}