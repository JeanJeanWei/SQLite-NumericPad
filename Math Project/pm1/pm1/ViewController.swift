//
//  ViewController.swift
//  pm1
//
//  Created by Jean-Jean Wei on 2016-11-27.
//  Copyright © 2016 Jean-Jean Wei. All rights reserved.
//
// All view controllers should inherited from this class for loading proper nib files

import UIKit

class ViewController: UIViewController
{
    override func loadView()
    {
        var xibType = ""
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
        {
            xibType = "iPhone"
        }
        else
        {
            xibType = "iPad"
        }
        let classString : String = NSStringFromClass(self.classForCoder)
        let xibName = String(format:"%@-%@", (classString.components(separatedBy: ".")).last!, xibType)
        //let xibName = "BaseViewController-iPhone"
        let path = self.nibBundle?.path(forResource: xibName, ofType: "nib")
        
        if (path != nil)
        {
            Bundle.main.loadNibNamed(xibName, owner: self, options: nil)
        }
        else
        {
            Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
