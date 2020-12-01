//
//  NativeController.swift
//  FlutterTest
//
//  Created by weiwei.li on 2020/10/19.
//

import UIKit
import flutter_boost
class NativeController: UIViewController {

   let flutterContainer = FLBFlutterViewContainer()
    override func viewDidLoad() {
        super.viewDidLoad()
        flutterContainer.setName("embeded", params: [String: String]())
        
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        flutterContainer.view.frame = view.bounds.inset(by: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30))
        view.addSubview(flutterContainer.view)
        addChild(flutterContainer)
    }
    
    deinit {
        print(self)
    }
    
    override func didMove(toParent parent: UIViewController?) {
        flutterContainer.didMove(toParent: parent)
        super.didMove(toParent: parent)
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
