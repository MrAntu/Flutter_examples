import 'package:flutter/material.dart';
import 'map/MapLocalizations.dart';
import 'intl/intlLocalizations.dart';
class I18nDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("I18nDemo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${locale.toString()}"),
            Text(
//              Localizations.of(context, MapLocalizations).title
//              MapLocalizations.of(context).title
              IntlLocations.of(context).title
            ),
            Text(
              IntlLocations.of(context).greet("sdfsf")
            )
          ],
        ),
      ),
    );
  }
}
