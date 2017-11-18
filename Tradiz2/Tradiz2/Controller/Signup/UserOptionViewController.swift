//
//  UserOptionViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/9/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyUserDefaults

class UserOptionViewController: BaseViewController {
    
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var bgView: UIView!
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
    
    @IBAction func yesAction(_ sender: Any) {
        
        IsTradeMan = true
        
        btnYes.backgroundColor = Constant.mainColor
        btnNo.backgroundColor = UIColor.clear
    }
    
    @IBAction func noAction(_ sender: Any) {
        
        IsTradeMan = false
        
        btnYes.backgroundColor = UIColor.clear
        btnNo.backgroundColor = Constant.mainColor
    }
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
        if IsTradeMan {
            
            gotoTradmenInfo()
            
        } else {
            doRegister()
        }
        
    }
    func doRegister() {
        
        let URL = Constant.REQ_REGISTER
        
        showLoadingView()
        
        let parameters: [String: Any] = [
            
            "CCNumber":"",
            "ExpiryMonth":"",
            "ExpiryYear": "",
            "CVC":"",
            "IsTradesman":IsTradeMan,
            "FullName":FullName,
            "Password":Password,
            "Address":Address,
            "Postcode":PostCode,
            "Suburb":Suburb,
            "State":State,
            "Country":CountryCode,
            "CurrentLat":CurLat,
            "CurrentLong":CurLong,
            "Email":Email,
            "ImageURL":ProfileImageUrl,
            
            "ABN":ABN,
            "Keywords":Keywords,            
            "ImageURL2":LogoImageUrl
        ]
        
        Alamofire.request(URL, method:.post, parameters: parameters, encoding: JSONEncoding.default, headers: [:])
            
            .responseJSON { response in
                
                print(response)
                
                if response.result.isFailure {
                    
                    self.hideLoadingView()
                    self.showToast(R.string.CONNECT_FAIL)
                    return
                }
                
                if let result = response.result.value  {
                    
                    self.hideLoadingView()
                    
                    let dict = JSON(result)
                    print("response dict")
                    print(dict)
                    
                    if dict[Constant.RES_SUCCESS].stringValue.characters.count != 0 {
                        
                        self.showToast(dict[Constant.RES_SUCCESS].stringValue)
                        self.createMenuView()
                        
                    } else {
                        self.showToast(dict[Constant.RES_MSG].stringValue)
                    }
                    
                    
                    self.perform(#selector(self.createMenuView), with: nil, afterDelay: 3.0)
                }
        }
    }
    
    func gotoTradmenInfo() {
        
        let trdmenInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "TradmanInfoViewController") as! TradmanInfoViewController
        
        self.navigationController?.pushViewController(trdmenInfoVC, animated: true)
    }

    func createMenuView() {
        
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainTabViewController") as! MainTabViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        let rightViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        UINavigationBar.appearance().barTintColor = Constant.barTintColor
        
        UINavigationBar.appearance().layer.shadowColor = UIColor.black.cgColor
        UINavigationBar.appearance().layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        
        UIApplication.shared.keyWindow?.rootViewController = slideMenuController
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        
        
    }
    
}
