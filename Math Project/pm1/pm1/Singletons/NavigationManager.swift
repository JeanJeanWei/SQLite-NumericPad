//
//  NavigationManager.swift
//  pm1
//
//  Created by Jean-Jean Wei on 2016-11-29.
//  Copyright © 2016 Jean-Jean Wei. All rights reserved.
//

import Foundation
import UIKit

class NavigationManager
{
    static let instance = NavigationManager()
    //This prevents others from using the default '()' initializer for this class.
    private init()
    {
    }
    
    private var _rootViewController: BaseViewController?
    private var _navigationController: UINavigationController?
    
    func setRootViewController(rootViewController: BaseViewController) -> UIViewController
    {
        _rootViewController = rootViewController
        _navigationController = UINavigationController(rootViewController: _rootViewController!)
        _navigationController?.isNavigationBarHidden = true
        return _navigationController!
    }
}
