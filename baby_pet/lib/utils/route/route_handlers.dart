import 'package:fluro/fluro.dart';
import '../../pages/home/home_page.dart';
import '../../pages/main/main_page.dart';
import '../../pages/login/login_page.dart';
import '../../pages/mine/setting_page.dart';
import '../../pages/home/grass_detail_page.dart';
import '../../models/grass_model.dart';
import '../../pages/home/pet_add_page.dart';
import '../../models/pet_model.dart';
import '../../pages/find/find_detail_page.dart';

Handler mainHandler = Handler(handlerFunc: (context, params) {
  return MainPage();
});

Handler homeHandler = Handler(handlerFunc: (context, params) {
  // final args = context.settings.arguments as String;
  return HomePage();
});

Handler loginHandler = Handler(handlerFunc: (context, params) {
  // final args = context.settings.arguments as String;
  return LoginPage();
});

Handler settingHandler = Handler(handlerFunc: (context, params) {
  // final args = context.settings.arguments as String;
  return SettingPage();
});

Handler grassDetailHandler = Handler(handlerFunc: (context, params) {
  final map = context.settings.arguments as Map<String, dynamic>;
  int trialId = 0;
  if (map.containsKey('trialId')) {
    trialId = map['trialId'] as int;
  }
  void Function(GrassModel grassModel) callBack;
  if (map.containsKey('callBack')) {
    callBack = map['callBack'];
  }
  return GrassDetailPage(trialId: trialId, callback: callBack);
});

Handler petAddHandler = Handler(handlerFunc: (context, params) {
  final model = context.settings.arguments as PetModel;
  return PetAddPage(model: model);
});

Handler findDetailHandler = Handler(handlerFunc: (context, params) {
  final messgeId = context.settings.arguments as int;
  return FindDetailPage(messageId: messgeId);
});
