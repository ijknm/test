//
//  AboutUsViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/10/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var tvAboutYou: UITextView!
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
        
        bgView.layer.masksToBounds = false;
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        bgView.layer.shadowOpacity = 0.5
    }
    
    func isValid() -> Bool {
        
        if tvAboutYou.text == nil || tvAboutYou.text?.characters.count == 0 {
            
            showAlertDialog(title: nil, message: R.string.INPUT_ABOUTYOU, positive: R.string.OK, negative: nil)
            return false
        }
        
        return true
    }
    
    @IBAction func gotoNext(_ sender: Any) {
        
        if isValid() {
            
            AboutYou = tvAboutYou.text!
            
            let cardVC = self.storyboard?.instantiateViewController(withIdentifier: "CardDetailViewController") as! CardDetailViewController
            self.navigationController?.pushViewController(cardVC, animated: true)
        }
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

}
