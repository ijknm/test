//
//  QuoteRequestSubmitViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/14/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit

class QuoteRequestSubmitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }



}
