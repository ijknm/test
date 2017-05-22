//
//  WelcomeViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/8/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var fieldView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initView()
    }
    
    func initView() {
        
        self.navigationController?.navigationBar.isHidden = true;
        
        fieldView.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func isVaild() -> Bool {
        
        if tfEmail.text == nil || tfEmail.text?.characters.count == 0 {
            
            showAlertDialog(title: nil, message: R.string.INPUT_EMAIL, positive: R.string.OK, negative: nil)
            return false
        }
        
        if !isValidEmail(testStr: tfEmail.text!) {
            
            showAlertDialog(title: nil, message: R.string.INVALID_EMAIL, positive: R.string.OK, negative: nil)
            return false
        }
        
        return true
    }
    
    @IBAction func signupAction(_ sender: Any) {
        
        if isVaild() {
            Email = tfEmail.text!
            gotoProfile()
        }
    }
    
    @IBAction func signinAction(_ sender: Any) {
        
        if isVaild() {
            Email = tfEmail.text!
            gotoProfile()
        }
    }
    
    func gotoProfile() {
        
        let cpVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateProfileViewController") as! CreateProfileViewController
        self.navigationController?.pushViewController(cpVC, animated: true);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
