//
//  SplashVC.swift
//  Timely
//
//  Created by maropost on 20/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
import Lottie

class SplashVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setGradientColor(topColor: TimelyColors.shared.kColorThemeSplash, bottomColor: UIColor.white)
        let animationViewClock = AnimationView(name: "stopwatch")
        animationViewClock.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationViewClock.center = self.view.center
        animationViewClock.contentMode = .scaleAspectFill
        
        view.addSubview(animationViewClock)
        
        animationViewClock.play { (success) in
            self.performSegue(withIdentifier: TimelyConstants.shared.segue_splash_to_login, sender: nil)
        }
        
        let animationViewWave = AnimationView(name: "wave")
        animationViewWave.backgroundColor = UIColor.clear
        animationViewWave.frame = CGRect(x: 0, y: self.view.frame.size.height - 80, width: 150, height: 30)
        animationViewWave.center = CGPoint(x: self.view.center.x, y: animationViewWave.center.y)
        animationViewWave.contentMode = .scaleAspectFill
        animationViewWave.play()
        
        view.addSubview(animationViewWave)
        
    }
}
