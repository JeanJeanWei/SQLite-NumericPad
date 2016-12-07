//
//  NumPad.swift
//  pm1
//
//  Created by Jean-Jean Wei on 2016-12-06.
//  Copyright © 2016 Jean-Jean Wei. All rights reserved.
//

import UIKit


class NumPad
{
    static let instance = NumPad()
    
    //This prevents others from using the default '()' initializer for this class.
    private init()
    {
        keyMap = [1, 2, 3, 4, 5, 6, 7, 8, 9, X_SIGN, 0, CLEAR_SIGN]
        VIEW_WIDTH = BUTTON_SIDE * 3 + MARGIN * 4
        VIEW_HEIGHT = BUTTON_SIDE * 4 + MARGIN * 5
        buildNumericPad()
    }
    
    // Event Handler callbacks
    var onTapped: ((_ result: Int)->())?
    
    let CLEAR_SIGN: Int = 101
    let X_SIGN: Int = 102
    private let BUTTON_SIDE: Int = 60
    private let MARGIN: Int = 15
    private let VIEW_WIDTH: Int!
    private let VIEW_HEIGHT: Int!
    private let keys: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "x", "0", "C"]
    private let keyMap: [Int]!
    private var buttons = [UIButton]()
    
    private var poppy: UIPopoverPresentationController!
    private var keypad: UIView!
    private var viewController: UIViewController!
    
    func popNumericPad(view: UIView, topVC: UIViewController)
    {
        viewController.modalPresentationStyle = UIModalPresentationStyle.popover
        topVC.present(viewController, animated: true, completion:nil)
        poppy = viewController.popoverPresentationController
        viewController.view.frame = keypad.frame
        viewController.preferredContentSize = CGSize(width: VIEW_WIDTH, height: VIEW_HEIGHT)
        poppy.permittedArrowDirections = UIPopoverArrowDirection.any
        poppy.sourceRect = view.bounds
        poppy.sourceView = view
    }
    private func buildNumericPad()
    {
        keypad = UIView(frame: CGRect(x: 0, y: 0, width: VIEW_WIDTH, height: VIEW_HEIGHT))
        viewController = UIViewController()
        viewController?.view.addSubview(keypad!)
        buildNumericButtons()
    }

    private func buildNumericButtons()
    {
        var pos_x = -BUTTON_SIDE
        var pos_y = -BUTTON_SIDE
        
        for i in 0..<12
        {
            switch (i % 3)
            {
                case 0:
                    pos_y += BUTTON_SIDE + MARGIN
                    pos_x = MARGIN
                
                case 2, 1:
                    pos_x += BUTTON_SIDE + MARGIN
            
                default:
                    break
            }
            let button_frame = CGRect(x: pos_x, y: pos_y, width: BUTTON_SIDE, height: BUTTON_SIDE)
            let button = UIButton(frame: button_frame)
            button.layer.borderWidth = 2;
            button.layer.cornerRadius = (CGFloat)(BUTTON_SIDE / 2)
            button.layer.borderColor = UIColor.black.cgColor
            button.setTitleColor(UIColor.black, for: UIControlState.normal)
            
            let tag = keyMap[i]
            let btnTitle = keys[i]
            if (tag == X_SIGN)
            {
                button.layer.borderColor = UIColor.blue.cgColor
            }
            else if (tag == CLEAR_SIGN)
            {
                button.layer.borderColor = UIColor.red.cgColor
            }
            button.tag = tag
            button.setTitle(btnTitle, for: UIControlState.normal)
            buttons.append(button)
            keypad?.addSubview(button)
            button.addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
        }
    }

    @objc func pressed(sender: UIButton)
    {
        onTapped?(sender.tag)
//        switch (sender.tag)
//        {
//            
//        }
    }
    
    
}
