//
//  BaseViewController.swift
//  pm1
//
//  Created by Jean-Jean Wei on 2016-11-25.
//  Copyright © 2016 Jean-Jean Wei. All rights reserved.
//

import UIKit

class BaseViewController: ViewController
{
    @IBOutlet var a1: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        NumPad.instance.onTapped = { result in
            self.a1.setTitle(String(result), for: UIControlState.normal)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTapped(_ sender: UIButton)
    {
        NumPad.instance.popNumericPad(view: sender, topVC: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
