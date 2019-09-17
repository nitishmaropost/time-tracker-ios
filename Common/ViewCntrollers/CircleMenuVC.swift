//
//  CircleMenuVC.swift
//  Timely
//
//  Created by Marorpost India on 11/09/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
import CircleMenu
import Lottie

extension UIColor {
    static func color(_ red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        return UIColor(
            red: 1.0 / 255.0 * CGFloat(red),
            green: 1.0 / 255.0 * CGFloat(green),
            blue: 1.0 / 255.0 * CGFloat(blue),
            alpha: CGFloat(alpha))
    }
}

class CircleMenuVC: UIViewController {

    let items: [(icon: String, color: UIColor)] = [
        ("icon_home", UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)),
        ("icon_search", UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1)),
        ("notifications-btn", UIColor(red: 0.96, green: 0.23, blue: 0.21, alpha: 1)),
        ("settings-btn", UIColor(red: 0.51, green: 0.15, blue: 1, alpha: 1)),
        ("nearby-btn", UIColor(red: 1, green: 0.39, blue: 0, alpha: 1))
    ]
    
    var animationHand: AnimationView!
    @IBOutlet weak var button: CircleMenu!
    @IBOutlet weak var switchTheme: SwitchTheme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.delegate = self
        animationHand = AnimationView(name: "hand1")
        animationHand.frame = CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height/2 + 60, width: 150, height: 150)
        animationHand.contentMode = .scaleAspectFill
        view.addSubview(animationHand)
        animationHand.play()
    }
    
    @IBAction func switchThemeColor(_ sender: SwitchTheme) {
        if switchTheme.isOn {
            self.view.backgroundColor = UIColor(hexString: "#0D101D")
            self.switchTheme.thumbTintColor = UIColor(hexString: "#0D101D")
            self.button.backgroundColor = UIColor.white
        } else {
            self.view.backgroundColor = UIColor.white
            self.switchTheme.thumbTintColor = UIColor.white
            self.button.backgroundColor = UIColor(hexString: "#0D101D")
        }
    }
}

extension CircleMenuVC: CircleMenuDelegate {
    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
        
        // set highlited image
        let highlightedImage = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func circleMenu(_: CircleMenu, buttonWillSelected _: UIButton, atIndex: Int) {
    }
    
    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
    }
    
    func menuCollapsed(_ circleMenu: CircleMenu) {
        animationHand.isHidden = false
    }
    
    func menuOpened(_ circleMenu: CircleMenu) {
        animationHand.isHidden = true
    }
}
