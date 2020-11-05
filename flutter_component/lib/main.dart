import 'package:flutter/material.dart';
import 'widgets/glass_style_demo.dart';
import 'widgets/keep_alive_demo.dart';
import 'widgets/search_bar_demo.dart';
import 'widgets/textfiled_focus_demo.dart';
import 'widgets/wrap_demo.dart';
import 'widgets/chip/chip_demo.dart';
import 'widgets/chip/action_chip.dart';
import 'widgets/chip/choice_chip_demo.dart';
import 'widgets/chip/filter_chip_demo.dart';
import 'widgets/chip/input_chip_demo.dart';
import 'widgets/expansion/expansion_tile.dart';
import 'widgets/expansion/expansion_tile_list.dart';
import 'widgets/sliver_screen_demo.dart';
import 'widgets/clipper_custom.dart';
import 'widgets/reorderble_list_demo.dart';
import 'widgets/splash/splash_screen_demo.dart';
import 'widgets/right_back_demo.dart';
import 'widgets/overlay/overlay_demo.dart';
import 'widgets/overlay/overlay_demo2.dart';
import 'widgets/overlay/overlay_demo3.dart';
import 'widgets/event_bus/tools/bus.dart';
import 'widgets/event_bus/first_screen.dart';
import 'widgets/event_bus/events/count_events.dart';
import 'widgets/animation/login_normal_demo.dart';
import 'widgets/animation/login_basic_animation_demo.dart';
import 'widgets/animation/login_delay_animation_demo.dart';
import 'widgets/animation/another_parent_demo.dart';
import 'widgets/animation/transform_animation_demo.dart';
import 'widgets/animation/value_change_demo.dart';
import 'widgets/animation/hidden_widge_demo.dart';
import 'widgets/hero/photo_hero.dart';
import 'widgets/animated/animated_container_demo.dart';
import 'widgets/animated/animated_cross_fade_demo.dart';
import 'widgets/bloc/rxdart/top_page.dart';
import 'widgets/bloc/single_global_instance/single_top_page.dart';
import 'widgets/flutter_bloc/counter_demo/counter_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/flutter_bloc/counter_demo/counter_observer.dart';
import 'widgets/flutter_bloc/ticker_demo/ticker_page_demo.dart';
import 'widgets/flutter_bloc/infinite_list/list_post.dart';
import 'dart:io';

class _LightColors {
  static final highlightColor = const Color(0x66BCBCBC);
  static final splashColor = const Color(0x66C8C8C8);
}

class _DarkColors {
  static final highlightColor = const Color(0x40CCCCCC);
  static final splashColor = const Color(0x40CCCCCC);
}

void main() {
  Bloc.observer = CounterObserver();
  runApp(MyApp());
  // 初始化事件值
//  behaviorBus.fire(CountEvent(0));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final ThemeData themeDataLight = ThemeData(
    //关键代码就这个：
    //iOS不需要水波纹
    highlightColor:
        Platform.isAndroid ? _LightColors.highlightColor : Colors.transparent,
    splashColor:
        Platform.isAndroid ? _LightColors.splashColor : Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
        // 全局去掉点击的水波纹效果
        theme: themeDataLight,
        // 高斯模糊
//      home: GlassStyleDemo(),
        // 界面存活
//      home: KeepAliveDemo(),
        // searchbar的使用
//      home: SearchBarDemo(),
        // input 对焦
//        home: TextFieldFocusDemo(),

        // 几种chip的使用
//      home: WrapDemo(),
//      home: ChipDemo(),
//      home: ActionChipDemo(),
//      home: ChoiceChipDemo(),
//      home: FilterChipDemo(),
//      home: InputChipDemo(),

        // expansion 展开
//      home: ExpansionTileDemo(),
//      home: ExpansionTileListDemo(),

        // sliver实例
//      home: SliverScreenDemo()
        // 简单实用贝塞尔曲线切割
//        home: ClipperCustomDemo()

        // 可拖动排序的listView
//        home: ReorderbleListDemo()

        // 应用启动前展示闪屏页的demo，这是一种通过animation实现的方式
//        home: SplashScreenDemo()

        //ios标准手势，右滑返回样例  CupertinoPageRoute push
//        home: RightBackDemo()
        // Overlay能够帮助你更加优雅高效的完成屏幕叠加。或者做一些浮动的控件。
//        home: OverlayDemo()
//        home: OverlayDemo2()
//        home: OverlayDemo3()

        // 使用EventBus在不同页面中同步状态的demo。这里使用rxdart扩展了bus的功能
//        home: EventBusFirstPage()

        //动画界面
//        home: LoginNormalDemo()
//        home: LoginBasicDemo()
//        home: LoginDelayDemo()
//        home: AnotherParentDemo()
//        home: TransformAnimationDemo()
//        home: ValueChangeAnimationDemo()
//        home: HiddenWidgeDemo()

        // hero动画
//        home: PhotoHeroDemo()

        // animated
//        home: AnimatedContainerDemo()
//        home: AnimatedCrossFadeDemo()

        // rxdart-bloc
//        home: TopPageDemo()
        // single-bloc
//        home: SingleTopPageDemo()

        // flutter_bloc
//        home: CounterApp()
        // bloc结合Steam
//        home: TickerPage());
        // bloc 列表请求数据
        home: PostsPage());
  }
}
