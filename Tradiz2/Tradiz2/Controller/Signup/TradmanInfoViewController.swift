//
//  TradmanInfoViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/9/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit
import ActionSheetPicker
import Alamofire

class TradmanInfoViewController: BaseViewController, UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var tfABN: UITextField!
    @IBOutlet weak var tfBusinessName: UITextField!
    @IBOutlet weak var imvLogo: UIImageView!
    @IBOutlet weak var tfBusinessContactNo: UITextField!
    @IBOutlet weak var tfWebAddress: UITextField!
    
    @IBOutlet weak var lblSelected: UILabel!
    let _picker: UIImagePickerController = UIImagePickerController()
    var _imgLogo : String?
    
    var _isSelected : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self._picker.delegate = self
        _picker.allowsEditing = true
        
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
        tfABN.layer.borderColor = UIColor.white.cgColor
        tfBusinessName.layer.borderColor = UIColor.white.cgColor
        tfBusinessContactNo.layer.borderColor = UIColor.white.cgColor
        tfWebAddress.layer.borderColor = UIColor.white.cgColor
        
        bgView.layer.masksToBounds = false;
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        bgView.layer.shadowOpacity = 0.5
        
        checkWebsite()
    }
    
    @IBAction func isHaveAction(_ sender: Any) {
        
        checkWebsite()
    }
    
    func checkWebsite() {
        
        if (!_isSelected) {
            
            lblSelected.isHidden = false
            tfWebAddress.isEnabled = false
            tfWebAddress.backgroundColor = UIColor.gray
            
        } else {
            lblSelected.isHidden = true
            tfWebAddress.isEnabled = true
            tfWebAddress.backgroundColor = UIColor.clear
        }
        
        _isSelected = !_isSelected
    }
    
    @IBAction func abnSearchAction(_ sender: Any) {
    
        self.view.endEditing(true)
    }
    
    @IBAction func gotoNext(_ sender: Any) {
    
        if isValid() {
            
            ABN = tfABN.text!
            BusinessName = tfBusinessName.text!
            BusinessContactNo = tfBusinessContactNo.text!
            WebSite = tfWebAddress.text!
            
            upload()
        }
    }
    
    func isValid() -> Bool {
        
        if tfABN.text == nil || tfABN.text?.characters.count == 0 {
            
            showAlertDialog(title: nil, message: R.string.INPUT_ABN, positive: R.string.OK, negative: nil)
            return false
        }
        
        if tfBusinessName.text == nil || tfBusinessName.text?.characters.count == 0 {
            
            showAlertDialog(title: nil, message: R.string.INPUT_BUSINESS_NAME, positive: R.string.OK, negative: nil)
            return false
        }
        
        if tfBusinessContactNo.text == nil || tfBusinessContactNo.text?.characters.count == 0 {
            
            showAlertDialog(title: nil, message: R.string.INPUT_BUSINESS_CONTACT_NUMBER, positive: R.string.OK, negative: nil)
            return false
        }
        
        if (_imgLogo != "") {
            
            upload()
            
        } else {
            
            showAlertDialog(title: nil, message: R.string.SELECT_PHOTO, positive: R.string.OK, negative: nil)
            
            return false
        }

        
        if !_isSelected {
            
            if tfWebAddress.text == nil || tfWebAddress.text?.characters.count == 0 {
                
                showAlertDialog(title: nil, message: R.string.INPUT_WEBSITE_ADDRESS, positive: R.string.OK, negative: nil)
                return false
            }
        }
        
        return true
        
    }
    
    func upload() {
        
        showLoadingView()
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(URL(fileURLWithPath:self._imgLogo!), withName: "file")
                
        },
            to: Constant.REQ_UPLOAD,
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                    
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        
                        self.hideLoadingView()
                        print("post response : ", response)
                        
                        if let result = response.result.value {
                            
                            let JSON = result as! NSDictionary
                            
                            
                            if JSON[Constant.RES_URL] as! String != "" {
                                
                                LogoImageUrl = JSON[Constant.RES_URL] as! String
                                //self.showToast("Upload success")
                                
                                self.gotoSkilllVC()
                                //self.perform(#selector(self.gotoSkilllVC), with: nil, afterDelay: 3.0)
                                print("Logo Image url : " + LogoImageUrl)
                                
                            } else  {
                                
                                self.hideLoadingView()
                                self.showAlertDialog(title: R.string.ERROR, message: String(describing: JSON), positive: R.string.OK, negative: nil)
                                
                            }
                            
                        } else  {
                            
                            self.hideLoadingView()
                            self.showAlertDialog(title: R.string.ERROR, message: R.string.CONNECT_FAIL, positive: R.string.OK, negative: nil)
                        }
                        
                    }
                    
                case .failure:
                    
                    self.showAlertDialog(title: R.string.ERROR, message: R.string.CONNECT_FAIL, positive: R.string.OK, negative: nil)
                    
                    self.hideLoadingView()
                    
                    return
                    
                }
        }
        )
    }
    
    func gotoSkilllVC() {
        
        let skillVC = self.storyboard?.instantiateViewController(withIdentifier: "SkillKeywordsViewController") as! SkillKeywordsViewController
        
        self.navigationController?.pushViewController(skillVC, animated: true)
    }

    
    @IBAction func attachAction(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            let photoSourceAlert: UIAlertController = UIAlertController(title: R.string.PHOTO_SOURCE, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let cameraAction: UIAlertAction = UIAlertAction(title: R.string.CAMERA, style: UIAlertActionStyle.default, handler: {
                (photoSourceAlert) -> Void in
                self._picker.sourceType = UIImagePickerControllerSourceType.camera
                self.present(self._picker, animated: true, completion: nil)
            })
            
            let albumAction: UIAlertAction = UIAlertAction(title: R.string.PHOTO_ALBUMS, style: UIAlertActionStyle.default, handler: {
                (photoSourceAlert) -> Void in
                self._picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.present(self._picker, animated: true, completion: nil)
            })
            
            photoSourceAlert.addAction(cameraAction)
            photoSourceAlert.addAction(albumAction)
            photoSourceAlert.addAction(UIAlertAction(title: R.string.CANCEL, style: UIAlertActionStyle.cancel, handler: nil))
            
            self.present(photoSourceAlert, animated: true, completion: nil);
        }
        else
        {
            _picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            let photoSourceAlert: UIAlertController = UIAlertController(title: R.string.PHOTO_SOURCE, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let albumAction: UIAlertAction = UIAlertAction(title: R.string.PHOTO_ALBUMS, style: UIAlertActionStyle.default, handler: {
                (photoSourceAlert) -> Void in self._picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.present(self._picker, animated: true, completion: nil)
            })
            
            
            photoSourceAlert.addAction(albumAction)
            photoSourceAlert.addAction(UIAlertAction(title: R.string.CANCEL, style: UIAlertActionStyle.cancel, handler: nil))
            
            self.present(photoSourceAlert, animated: true, completion: nil);
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            self.imvLogo.image = pickedImage
            _imgLogo = saveToFile(image: pickedImage, filePath: Constant.SAVE_ROOT_PATH, fileName: "co_logo.png")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        _imgLogo = ""
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
