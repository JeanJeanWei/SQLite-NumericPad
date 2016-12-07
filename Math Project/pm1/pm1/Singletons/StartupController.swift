//
//  StartupController.swift
//  pm1
//
//  Created by Jean-Jean Wei on 2016-12-02.
//  Copyright © 2016 Jean-Jean Wei. All rights reserved.
//

import Foundation
import UIKit

class StartupController
{
    static let instance = StartupController()
    //This prevents others from using the default '()' initializer for this class.
    private init()
    {
    }
    
    func startingViewController() -> UIViewController
    {
        let rootViewController = BaseViewController()
        
        let navigationController = NavigationManager.instance.setRootViewController(rootViewController: rootViewController)
        return navigationController
        
    }
}
