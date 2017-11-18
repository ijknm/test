//
//  MainTabViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/11/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationBarItem()
        self.navigationItem.title = "TRADIZ"
        
        let btnSetting = UIBarButtonItem(image: UIImage(named: "icon_setting"), style: .plain, target: self, action: #selector(MainTabViewController.gotoSetting)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.rightBarButtonItem  = btnSetting
        
        
    }
    
    func gotoSetting() {
        
        print("goto setting")
        
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

}
