//
//  MyDetailsViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/9/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit

class MyDetailsViewController: BaseViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var imvProfile: UIImageView!
    
    var _imgprofile : String?
    
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
        
        self.navigationController?.navigationBar.isHidden = false;
        
        tfFullName.layer.borderColor = UIColor.white.cgColor
        tfPhoneNumber.layer.borderColor = UIColor.white.cgColor
        tfPassword.layer.borderColor = UIColor.white.cgColor
        tfAddress.layer.borderColor = UIColor.white.cgColor
        
        bgView.layer.masksToBounds = false;
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        bgView.layer.shadowOpacity = 0.5
        
        imvProfile.image = UIImage.init(contentsOfFile: _imgprofile!)
        lblEmail.text = "Email : " + Email
        tfAddress.text = Address
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
        if isValid() {
            
            FullName = tfFullName.text!
            PhoneNumber = tfPhoneNumber.text!
            Password = tfPassword.text!
            Address = tfAddress.text!
            
            gotoUserOption()
        }
    }
    
    func isValid() -> Bool {
        
        if tfFullName.text == nil || tfFullName.text?.characters.count == 0 {
            
            showAlertDialog(title: nil, message: R.string.INPUT_FULLNAME, positive: R.string.OK, negative: nil)
            return false
        }
        
        if tfPhoneNumber.text == nil || tfPhoneNumber.text?.characters.count == 0 {
            
            showAlertDialog(title: nil, message: R.string.INPUT_PHONE_NUMBER, positive: R.string.OK, negative: nil)
            return false
        }
        
        if tfPassword.text == nil || (tfPassword.text?.characters.count)! < 6 {
            
            showAlertDialog(title: nil, message: R.string.INPUT_PASSWORD, positive: R.string.OK, negative: nil)
            return false
        }
        
        if tfAddress.text == nil || tfAddress.text?.characters.count == 0 {
            
            showAlertDialog(title: nil, message: R.string.INPUT_ADDRESS, positive: R.string.OK, negative: nil)
            return false
        }
        
        return true
        
    }
    
    
    func gotoUserOption() {
        
        let userOptionVC = self.storyboard?.instantiateViewController(withIdentifier: "UserOptionViewController") as! UserOptionViewController
        self.navigationController?.pushViewController(userOptionVC, animated: true)
    }




}
