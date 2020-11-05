import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class BaseConstant {
  static const String packageBase = 'base_library';

  static const String keyShowGuide = 'show_guide';
  static const String keyUserName = 'user_name';
  static const String keyUserModel = 'user_model';
  static const String keyAppToken = 'app_token';

  static const String routeMain = 'route_main';
  static const String routeLogin = 'route_login';
}

class Constant {
  static const String keyLanguage = 'key_language';

  static const int status_success = 0;

  static const String wan_android = "https://www.wanandroid.com/";

  static const String server_address = wan_android;

  static const int type_sys_update = 1;
  static const int type_refresh_all = 5;

  static const String key_theme_color = 'key_theme_color';
  static const String key_guide = 'key_guide';
  static const String key_splash_model = 'key_splash_models';
}

class AppConfig {
  static const String appId = 'com.thl.flutterwanandroid';
  static const String appName = 'flutter_wanandroid';
  static const String version = '0.2.5';
  static const bool isDebug = kDebugMode;
}

class LoadStatus {
  static const int fail = -1;
  static const int loading = 0;
  static const int success = 1;
  static const int empty = 2;
}

class Dimens {
  static const double font_sp10 = 10;
  static const double font_sp12 = 12;
  static const double font_sp14 = 14;
  static const double font_sp16 = 16;
  static const double font_sp18 = 18;
  static const double font_sp20 = 20;

  static const double gap_dp3 = 3;
  static const double gap_dp5 = 5;
  static const double gap_dp10 = 10;
  static const double gap_dp12 = 12;
  static const double gap_dp15 = 15;
  static const double gap_dp16 = 16;
  static const double gap_dp20 = 20;
  static const double gap_dp25 = 25;
  static const double gap_dp30 = 30;

  static const double btn_h_48 = 48;
  static const double item_h_42 = 42;

  static const double border_width = 0.33;
}

class TextStyles {
  static TextStyle listTitle = TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colours.text_dark,
    fontWeight: FontWeight.bold,
  );
  static TextStyle listTitle2 = TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colours.text_dark,
  );
  static TextStyle listContent = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_normal,
  );
  static TextStyle listContent2 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_gray,
  );
  static TextStyle listExtra = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.text_gray,
  );
  static TextStyle listExtra2 = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.text_normal,
  );
  static const TextStyle appTitle = TextStyle(
    fontSize: Dimens.font_sp18,
    color: Colours.text_dark,
  );
}

class Decorations {
  static Decoration bottom = BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.33, color: Colours.divider)));
}

/// 间隔
class Gaps {
  /// 水平间隔
  static Widget hGap5 = new SizedBox(width: Dimens.gap_dp5);
  static Widget hGap10 = new SizedBox(width: Dimens.gap_dp10);
  static Widget hGap12 = new SizedBox(width: Dimens.gap_dp12);
  static Widget hGap15 = new SizedBox(width: Dimens.gap_dp15);
  static Widget hGap30 = new SizedBox(width: Dimens.gap_dp30);

  /// 垂直间隔
  static Widget vGap5 = new SizedBox(height: Dimens.gap_dp5);
  static Widget vGap10 = new SizedBox(height: Dimens.gap_dp10);
  static Widget vGap15 = new SizedBox(height: Dimens.gap_dp15);
  static Widget vGap20 = new SizedBox(height: Dimens.gap_dp20);
  static Widget vGap25 = new SizedBox(height: Dimens.gap_dp25);

  static Widget getHGap(double w) {
    return SizedBox(width: w);
  }

  static Widget getVGap(double h) {
    return SizedBox(height: h);
  }
}
