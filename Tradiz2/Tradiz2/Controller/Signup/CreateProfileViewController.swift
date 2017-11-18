//
//  CreateProfileViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/9/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit
import Alamofire

class CreateProfileViewController: BaseViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var _imgProfile : String?

    @IBOutlet weak var imvProfile: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    let _picker: UIImagePickerController = UIImagePickerController()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //findMyLocation()
    }
    
    func initView() {
        
        _imgProfile = "";
        
        self.navigationController?.navigationBar.isHidden = false;
        
        bgView.layer.masksToBounds = false;
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        bgView.layer.shadowOpacity = 0.5
    }
   
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
        
        self._picker.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(self._picker, animated: true, completion: nil)
        }
    }
   
    @IBAction func galleryAction(_ sender: Any) {
        
        self._picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(self._picker, animated: true, completion: nil)
    }
  
    @IBAction func gotoNext(_ sender: Any) {
        
        if (_imgProfile != "") {
            
            ProfileImageUrl = _imgProfile!
            
            upload()

        } else {
            
            showAlertDialog(title: nil, message: R.string.SELECT_PHOTO, positive: R.string.OK, negative: nil)
        }
        
    }
    
    func gotoMyDetail() {
        
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "MyDetailsViewController") as! MyDetailsViewController
        destVC._imgprofile = _imgProfile
        self.navigationController?.pushViewController(destVC, animated: true)
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            self.imvProfile.image = pickedImage
            _imgProfile = saveToFile(image: pickedImage, filePath: Constant.SAVE_ROOT_PATH, fileName: "profile.png")

        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func upload() {
        
        showLoadingView()
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(URL(fileURLWithPath:self._imgProfile!), withName: "file")
                
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
                            
                                ProfileImageUrl = JSON[Constant.RES_URL] as! String
                                self.showToast("Upload success")
                                self.perform(#selector(self.gotoMyDetail), with: nil, afterDelay: 3.0)
                                
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
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! MyDetailsViewController
        destVC._imgprofile = _imgProfile
    }
    */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        _imgProfile = ""
        
        dismiss(animated: true, completion: nil)
    }

}
