//
//  PlatformRouterImp.swift
//  FlutterTest
//
//  Created by weiwei.li on 2020/10/19.
//

import UIKit
import flutter_boost
class PlatformRouterImp: NSObject, FLBPlatform {
    func openNativeVC(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any]) {
        var animated = true;
        if let ret = exts["animated"] as? Bool {
            animated = ret
        }
        let vc = ViewControllerDemo()
        if let _ = urlParams["present"] as? Bool {
            navigationController()?.present(vc, animated: animated, completion: nil)
        } else {
            navigationController()?.pushViewController(vc, animated: animated)
        }
    }

    func open(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        if url == "native" {
            openNativeVC(url, urlParams: urlParams, exts: exts)
            return
        }
        var animated = true;
        if let ret = exts["animated"] as? Bool {
            animated = ret
        }
        let vc = FLTBaseViewController.init()
        vc.setName(url, params: urlParams)
        navigationController()?.pushViewController(vc, animated: animated)
        completion(true)
    }
    
    func present(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        var animated = false;
        if exts["animated"] != nil{
            animated = exts["animated"] as! Bool;
        }
        let vc = FLTBaseViewController.init();
        vc.setName(url, params: urlParams);
        navigationController()?.present(vc, animated: animated) {
            completion(true);
        };
    }
    
    func close(_ uid: String, result: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        var animated = false;
        if exts["animated"] != nil{
            animated = exts["animated"] as! Bool;
        }
        let presentedVC = self.navigationController()?.presentedViewController;
        let vc = presentedVC as? FLTBaseViewController;
        if vc?.uniqueIDString() == uid  {
            vc?.dismiss(animated: animated, completion: {
                completion(true);
            });
        }else if navigationController() == nil,
                 let vc = UIViewController.getTopViewController {
            vc.dismiss(animated: animated) {
                completion(true)
            }
        } else {
            self.navigationController()?.popViewController(animated: animated);
        }
    }
    
    func navigationController() -> UINavigationController? {
        
        return UIViewController.getTopViewController?.navigationController;
    }

}


extension UIViewController {
    public class var getTopViewController: UIViewController? {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        return getTopViewController(viewController: rootViewController)
    }
    
    public class func getTopViewController(viewController: UIViewController?) -> UIViewController? {
        
        if let presentedViewController = viewController?.presentedViewController {
            return getTopViewController(viewController: presentedViewController)
        }
        
        if let tabBarController = viewController as? UITabBarController,
            let selectViewController = tabBarController.selectedViewController {
            return getTopViewController(viewController: selectViewController)
        }
        
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return getTopViewController(viewController: visibleViewController)
        }
        
        if let pageViewController = viewController as? UIPageViewController,
            pageViewController.viewControllers?.count == 1 {
            return getTopViewController(viewController: pageViewController.viewControllers?.first)
        }
        
        for subView in viewController?.view.subviews ?? [] {
            if let childViewController = subView.next as? UIViewController {
                return getTopViewController(viewController: childViewController)
            }
        }
        return viewController
    }
}
