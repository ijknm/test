//
//  WelcomeViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/8/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var fieldView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
        fieldView.layer.borderColor = UIColor.white.cgColor
        
    }

}
