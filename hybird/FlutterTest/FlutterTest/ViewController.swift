//
//  ViewController.swift
//  FlutterTest
//
//  Created by weiwei.li on 2020/10/16.
//

import UIKit
import Flutter
import flutter_boost

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func action(_ sender: Any) {
//        let vc = FlutterViewController()
//        vc.setInitialRoute("route1")
////        vc.modalPresentationStyle = .fullScreen
//        navigationController?.pushViewController(vc, animated: true)
//        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
//        let flutterViewController =
//            FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
//        flutterViewController.setInitialRoute("router1")
//        navigationController?.pushViewController(flutterViewController, animated: true)
    }
    
    
    @IBAction func pushAction(_ sender: Any) {
        FlutterBoostPlugin.open("first", urlParams: [kPageCallBackId: "MycallbackId#1"], exts: ["animated": true]) { (result) in
            print("call me when page finished, and your result")
            print(result)
        } completion: { (ret) in
            print(String(format:"page is opened"));
            print(ret)
        }

    }
    
    @IBAction func presentAction(_ sender: Any) {
        FlutterBoostPlugin.present("second", urlParams:[kPageCallBackId:"MycallbackId#2"], exts: ["animated":true], onPageFinished: { (_ result:Any?) in
            print(String(format:"call me when page finished, and your result is:%@", result as! CVarArg));
        }) { (f:Bool) in
            print(String(format:"page is presented"));
        }
    }
    
    @IBAction func pushEmbededAction(_ sender: Any) {
        let vc = NativeController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    deinit {
        print(self)
    }
    
}

