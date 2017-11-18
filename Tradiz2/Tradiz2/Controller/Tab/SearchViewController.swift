//
//  SearchViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/12/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var btnRank: UIButton!
    @IBOutlet weak var btnRate: UIButton!
    @IBOutlet weak var btnAvailability: UIButton!
    @IBOutlet weak var btnDistance: UIButton!
    
    @IBOutlet weak var imvRank: UIImageView!
    @IBOutlet weak var imvRate: UIImageView!
    @IBOutlet weak var imvAvailability: UIImageView!
    @IBOutlet weak var imvDistance: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func initView() {
        
        tfSearch.returnKeyType = UIReturnKeyType.search
        tfSearch.delegate = self
        
        tfSearch.layer.masksToBounds = false;
        tfSearch.layer.shadowColor = UIColor.black.cgColor
        tfSearch.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        tfSearch.layer.shadowOpacity = 0.5
        //tfSearch.layer.masksToBounds = true
        tfSearch.layer.cornerRadius = 15
        
        btnRank.layer.borderColor = UIColor.white.cgColor
        btnRate.layer.borderColor = UIColor.white.cgColor
        btnAvailability.layer.borderColor = UIColor.white.cgColor
        btnDistance.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        tfSearch.text = ""
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("ok");
        self.view.endEditing(true)
        tfSearch.text = ""
        return true
    }
    
    
    
    // MARK: - tableview datasource & delegate

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchItemCell") as! SearchItemCell
        
        return cell
    }
    
    



}
