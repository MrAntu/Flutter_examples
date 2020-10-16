//
//  ViewController.swift
//  flutter_pod
//
//  Created by weiwei.li on 2020/9/24.
//

import UIKit
import Flutter
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func action(_ sender: Any) {
        
        let vc = FlutterViewController()
        vc.setInitialRoute("route1")
//        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

