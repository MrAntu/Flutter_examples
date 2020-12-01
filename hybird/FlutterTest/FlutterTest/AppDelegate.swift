//
//  AppDelegate.swift
//  FlutterTest
//
//  Created by weiwei.li on 2020/10/16.
//

import UIKit
import Flutter
import FlutterPluginRegistrant
import flutter_boost

var engineGlobal: FlutterEngine?
@main
class AppDelegate: FlutterAppDelegate {
//    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        flutterEngine.run();
//        GeneratedPluginRegistrant.register(with: self);
        
        let router = PlatformRouterImp()
        FlutterBoostPlugin.sharedInstance().startFlutter(with: router) { (engine) in
            // 注册MethodChannel，监听flutter侧的getPlatformVersion调用
            print(engine)
            engineGlobal = engine
//            //MethodChannel: 传递方法调用。Flutter主动调用Native的方法，并获取相应的返回值。比如获取系统电量，发起Toast等调用系统API，可以通过这个来完成。
//            let methodChannel = FlutterMethodChannel(name: "flutter_native_channel", binaryMessenger: engine.binaryMessenger)
//            methodChannel.setMethodCallHandler { (call, result) in
//                let method = call.method
//                if method == "getPlatformVersion" {
//                    let version = UIDevice.current.systemVersion
//                    result(version)
//                } else {
//                    result(FlutterMethodNotImplemented)
//                }
//            }
//            // BasicMessageChannel: 用于传递数据。Flutter与原生项目的资源是不共享的，可以通过BasicMessageChannel来获取Native项目的图标等资源。
//            let messageChannel = FlutterBasicMessageChannel(name: "flutter_native_message_channel", binaryMessenger: engine.binaryMessenger)
//            // 发送消息
//            messageChannel.sendMessage("ios数据") { (reply) in
//                print(reply)
//            }
//            // 接受消息监听
//            messageChannel.setMessageHandler { (message, callBack) in
//                print(message)
//                callBack("ios的callBack")
//            }
            
//            • EventChannel: 传递事件。这里是Native将事件通知到Flutter。比如Flutter需要监听网络情况，这时候MethodChannel就无法胜任这个需求了。EventChannel可以将Flutter的一个监听交给Native，Native去做网络广播的监听，当收到广播后借助EventChannel调用Flutter注册的监听，完成对Flutter的事件通知。
            
           // MethodChannel用通俗的语言来描述它的作用就是，当你像在flutter端调用native功能的时候，可以用它。
            // EventChannel用通俗的语言来描述就是，当native想通知flutter层一些消息的时候，可以用它。
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }

    // MARK: UISceneSession Lifecycle

    override func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    override func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

