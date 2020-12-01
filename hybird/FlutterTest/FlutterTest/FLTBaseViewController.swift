//
//  FLTBaseViewController.swift
//  FlutterTest
//
//  Created by weiwei.li on 2020/10/19.
//

import UIKit
import flutter_boost
import FDFullscreenPopGesture
class FLTBaseViewController: FLBFlutterViewContainer {
    //MethodChannel: 传递方法调用。Flutter主动调用Native的方法，并获取相应的返回值。比如获取系统电量，发起Toast等调用系统API，可以通过这个来完成。
    let methodChannel = FlutterMethodChannel(name: "flutter_native_channel", binaryMessenger: engineGlobal as! FlutterBinaryMessenger)
    // BasicMessageChannel: 用于传递数据。Flutter与原生项目的资源是不共享的，可以通过BasicMessageChannel来获取Native项目的图标等资源。
    let messageChannel = FlutterBasicMessageChannel(name: "flutter_native_message_channel", binaryMessenger: engineGlobal as! FlutterBinaryMessenger)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
        // Do any additional setup after loading the view.
        
        methodChannel.setMethodCallHandler { (call, result) in
            let method = call.method
            if method == "getPlatformVersion" {
                let version = UIDevice.current.systemVersion
                result(version)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    
        // 接受消息监听
        messageChannel.setMessageHandler { (message, callBack) in
            print(message)
            callBack("ios的callBack")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.send()
        }
    }
    
    func send() {
        // 主动给flutter发送消息
        methodChannel.invokeMethod("goback", arguments: ["number": 10]) { (result) in
            if let err = result as? FlutterError {
                print(err.code, err.details, err.message)
            }
            print(result)
        }
        
      
        // 发送消息
        messageChannel.sendMessage("ios数据") { (reply) in
            print(reply)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    deinit {
       print(self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
