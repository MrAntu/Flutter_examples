import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'custom_localizations.dart';

/// 推荐使用IntlUtil获取字符串.
class IntlUtil {
  static String getString(BuildContext context, String id,
      {String languageCode, String countryCode, List<Object> params}) {
    return CustomLocalizations.of(context).getString(id,
        languageCode: languageCode, countryCode: countryCode, params: params);
  }
}
