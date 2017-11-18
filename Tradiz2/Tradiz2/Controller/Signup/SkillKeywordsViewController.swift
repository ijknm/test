//
//  SkillKeywordsViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/10/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyUserDefaults

class SkillKeywordsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var tfSearch: UITextField!
    
    @IBOutlet weak var tblSkills: UITableView!
    
    var g_keywords = [KeywordEntity]()

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
        
        tfSearch.returnKeyType = UIReturnKeyType.search
        tfSearch.delegate = self
        
        tfSearch.layer.borderColor = UIColor.white.cgColor
        
        bgView.layer.masksToBounds = false;
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        bgView.layer.shadowOpacity = 0.5
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func nextAction(_ sender: Any) {
        
        if isValid() {
            
            for one in g_keywords {
                
                if one._isSelected == 1 {
                    
                    Keywords += one._keyword + ","
                }
                
                //Keywords + ","
            }
            
            print(Keywords)
            
            gotoAboutUs()
        }
    }
    
    func isValid() -> Bool {
        
        var isSelected = false
        
        for select in g_keywords {
            
            if select._isSelected == 1 {
                isSelected = true
                return true
            }
        }
        
        if (!isSelected) {
            
            showAlertDialog(title: nil, message: R.string.SELECT_SKILL, positive: R.string.OK, negative: nil)
            return false
            
        }
    }
    
    func searchSkill() {
        
        g_keywords.removeAll()
        
        let keyword = tfSearch.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).encodeString()!
        
        let URL = Constant.REQ_SEARCHKEYWORD + "\(keyword)"
        
        showLoadingView()
        
       
        Alamofire.request(URL, method:.get)
            .responseJSON { response in
                
                if response.result.isFailure {
                    
                    self.hideLoadingView()
                    self.showToast(R.string.CONNECT_FAIL)
                    return
                }
                
                if let result = response.result.value  {
                    
                    self.hideLoadingView()
                    
                    let dict = JSON(result)
                    
                    let keywords = dict.arrayValue
                    
                    for one in keywords {
                        let keyword = KeywordEntity(dict:one)
                        
                        self.g_keywords.append(keyword)
                        
                    }
                    
                    self.tblSkills.reloadData()
                }                
        }
    }
    @IBAction func searchAction(_ sender: Any) {
        
        self.view.endEditing(true)
        if (tfSearch.text!.characters.count > 0) {
            searchSkill()
        }        
    }
    
    // MARK: - textfield delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        if (tfSearch.text!.characters.count > 0) {
            searchSkill()
        }
        
        return true
    }
    
    func gotoAboutUs() {
        
        let aboutUsVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
        
        self.navigationController?.pushViewController(aboutUsVC, animated: true)
    }
    
    // MARK: - tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return g_keywords.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell") as! SkillCell
        cell.lblSkill.text = g_keywords[indexPath.row]._keyword
        
        if (g_keywords[indexPath.row]._isSelected != 0) {
            cell.lblSkill.backgroundColor = Constant.mainColor
        } else {
            cell.lblSkill.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        
        if (g_keywords[indexPath.row]._isSelected != 0) {
            g_keywords[indexPath.row]._isSelected = 0
        } else {
            g_keywords[indexPath.row]._isSelected = 1
        }
        
        tblSkills.reloadData()
    }
}
