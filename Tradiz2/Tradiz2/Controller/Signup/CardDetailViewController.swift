//
//  CardDetailViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/11/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit
import AKMaskField
import ActionSheetPicker
import Alamofire
import SwiftyJSON
import SwiftyUserDefaults

class CardDetailViewController: BaseViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfCardNumber: AKMaskField!
    @IBOutlet weak var tfCcv: AKMaskField!
    @IBOutlet weak var tfExpireDate: UITextField!
    
    @IBOutlet weak var lblMaster: UILabel!
    @IBOutlet weak var lblVisa: UILabel!
    @IBOutlet weak var lblExpress: UILabel!
    @IBOutlet weak var lblDiscover: UILabel!
    @IBOutlet weak var lblAgree: UILabel!
    
    var year:String = "0000"
    var month :  String = "00"
    
    var isAgreed : Bool = false
    
    var isCorrectCardInfo : Bool = false
    
    private var cardProgrammatically: AKMaskField!
    private var vccProgramatically:AKMaskField!
    
    private var card: AKMaskField {
        return cardProgrammatically ?? tfCardNumber
    }
    
    private var vcc: AKMaskField {
        return vccProgramatically ?? tfCcv
    }
    
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
        
        isAgreed = false
        lblAgree.isHidden = true
        lblVisa.isHidden = true
        lblExpress.isHidden = true
        lblDiscover.isHidden = true
        
        tfFullName.layer.borderColor = UIColor.white.cgColor
        tfCardNumber.layer.borderColor = UIColor.white.cgColor
        tfCcv.layer.borderColor = UIColor.white.cgColor
        tfExpireDate.layer.borderColor = UIColor.white.cgColor
        
        bgView.layer.masksToBounds = false;
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        bgView.layer.shadowOpacity = 0.5
        
        card.maskDelegate = self
        vcc.maskDelegate = self
    }

    @IBAction func masterCdAction(_ sender: Any) {
    
        lblMaster.isHidden = false
        lblVisa.isHidden = true
        lblExpress.isHidden = true
        lblDiscover.isHidden = true
    }
    
    @IBAction func visaCdAction(_ sender: Any) {
        
        lblMaster.isHidden = true
        lblVisa.isHidden = false
        lblExpress.isHidden = true
        lblDiscover.isHidden = true
    
    }
    @IBAction func expressCdAction(_ sender: Any) {
        
        lblMaster.isHidden = true
        lblVisa.isHidden = true
        lblExpress.isHidden = false
        lblDiscover.isHidden = true
    
    }
    
    @IBAction func discoverCdAction(_ sender: Any) {
        
        lblMaster.isHidden = true
        lblVisa.isHidden = true
        lblExpress.isHidden = true
        lblDiscover.isHidden = false
    }
    
    @IBAction func agreeAction(_ sender: Any) {
        
        if (isAgreed) {
            lblAgree.isHidden = true
        } else {
            lblAgree.isHidden = false
        }
        isAgreed = !isAgreed
    }
    
    @IBAction func selectDateAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
    
        let datePicker = ActionSheetDatePicker(title: "Expired Date:", datePickerMode: UIDatePickerMode.date, selectedDate: NSDate() as Date! , doneBlock: {
            picker, value, index in
            
            //2017-05-18 11:51:02 +0000
            
            let dateStr = String(describing: value!)
            
            self.year = dateStr.components(separatedBy: "-")[0]
            self.month = dateStr.components(separatedBy: "-")[1]
            
            print(self.year)
            print(self.month)
            
            self.tfExpireDate.text = self.month + " / " + self.year
            
            return

        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as
            AnyObject).superview!?.superview)

        datePicker?.show()
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startAction(_ sender: Any) {
        
        if isValid() {
        
            doRegister()
            //createMenuView()
        }
    }
    
    func isValid() -> Bool {
        
        if tfFullName.text == nil || tfFullName.text?.characters.count == 0 {
            
            showAlertDialog(title: nil, message: R.string.INPUT_FULLNAME, positive: R.string.OK, negative: nil)
            return false
        }
        
        if tfCardNumber.text == nil || tfCardNumber.text?.characters.count == 0 {
            
            showAlertDialog(title: nil, message: R.string.INPUT_CARD_NUMBER, positive: R.string.OK, negative: nil)
            return false
        }
        
        if tfExpireDate.text == nil || (tfExpireDate.text?.characters.count)! < 6 {
            
            showAlertDialog(title: nil, message: R.string.INPUT_PASSWORD, positive: R.string.OK, negative: nil)
            return false
        }
        
        if tfCcv.text == nil || tfCcv.text?.characters.count == 0 {
            
            showAlertDialog(title: nil, message: R.string.INPUT_CCV, positive: R.string.OK, negative: nil)
            return false
        }
        
        if !isCorrectCardInfo {
            
            showAlertDialog(title: nil, message: R.string.WRONG_CARDINFO, positive: R.string.OK, negative: nil)
            return false
        }
        
        if !isAgreed {
            
            showAlertDialog(title: nil, message: R.string.AGREE_TERM, positive: R.string.OK, negative: nil)
            return false
        }
        
        return true
    }
    
    func doRegister() {
        
        let URL = Constant.REQ_REGISTER
        
        showLoadingView()
        
        let parameters: [String: Any] = [

            "CCNumber":tfCardNumber.text!,
            "ExpiryMonth":self.month,
            "ExpiryYear": self.year,
            "CVC":tfCcv.text!,
            "IsTradesman":IsTradeMan,
            "FullName":FullName,
            "ABN":ABN,
            "Email":Email,
            "Address":Address,
            "Postcode":PostCode,
            "Suburb":Suburb,
            "State":State,
            "Country":CountryCode,
            "CurrentLat":CurLat,
            "CurrentLong":CurLong,
            "Password":Password,
            "Keywords":Keywords,
            "ImageURL":ProfileImageUrl,
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
                        self.perform(#selector(self.createMenuView), with: nil, afterDelay: 3.0)
                        
                    } else {
                        self.showToast(dict[Constant.RES_MSG].stringValue)
                    }
                }
        }
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

//  MARK: - AKMaskFieldDelegate

extension CardDetailViewController: AKMaskFieldDelegate {
    
    func maskField(_ maskField: AKMaskField, didChangedWithEvent event: AKMaskFieldEvent) {
        
        var statusColor, eventColor: UIColor!
        
        // Status
        
        switch maskField.maskStatus {
        case .clear      : statusColor = UIColor.lightGray
        case .incomplete : statusColor = UIColor.blue
        case .complete   : statusColor = UIColor.green
        }
        
        if maskField.maskStatus == .complete {
            
            isCorrectCardInfo = true
        } else {
            isCorrectCardInfo = false
        }
        
        print(statusColor)
        
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: { () -> Void in
//            self.indicators[maskField.tag].backgroundColor = statusColor
//        })
        
        // Event
        
        switch event {
        case .insert  : eventColor = UIColor.lightGray
        case .replace : eventColor = UIColor.brown
        case .delete  : eventColor = UIColor.orange
        case .error   : eventColor = UIColor.red
        }
        
        UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseIn, animations: { () -> Void in
            
            maskField.backgroundColor = eventColor.withAlphaComponent(0.2)
        }) { (Bool) -> Void in
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                
                maskField.backgroundColor = UIColor.clear
            })
        }
    }
}
