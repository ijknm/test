//
//  BaseViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/9/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit
import Toaster


class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlertDialog(title: String!, message: String!, positive: String?, negative: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if (positive != nil) {
            
            alert.addAction(UIAlertAction(title: positive, style: .default, handler: nil))
        }
        
        if (negative != nil) {
            
            alert.addAction(UIAlertAction(title: negative, style: .default, handler: nil))
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func showLoadingView() {
        
        showLoadingViewWithTitle(title: "")
    }
    
    
    func showLoadingViewWithTitle(title: String) {
        
        if title == "" {
            
            ProgressHUD.show()
            
        } else {
            
            ProgressHUD.showWithStatus(string: title)
        }
    }
    
    // hide loading view
    func hideLoadingView() {
        
        ProgressHUD.dismiss()
    }
    
    //Toast
    func showToast(_ text:String) {
        
        Toast(text:text).show()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension String {
    func encodeString() -> String? {
        
        let customAllowedSet =  NSCharacterSet(charactersIn:"!*'();:@&=+$,/?%#[] ").inverted
        return addingPercentEncoding(withAllowedCharacters: customAllowedSet)
    }
}


public extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}


