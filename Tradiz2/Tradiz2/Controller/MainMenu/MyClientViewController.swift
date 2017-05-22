//
//  MyClientViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/14/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit
import PopupDialog

class MyClientViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    weak var delegate: LeftMenuProtocol?
    
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
        bgView.layer.cornerRadius = 5.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.removeNavigationBarItem()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            guard let vc = (self.slideMenuController()?.mainViewController as? UINavigationController)?.topViewController else {
                return
            }
            if vc.isKind(of: MyClientViewController.self)  {
                self.slideMenuController()?.removeLeftGestures()
                self.slideMenuController()?.removeRightGestures()
            }
        })
    }
    
    @IBAction func didTouchToMain(_ sender: UIButton) {
        delegate?.changeViewController(LeftMenu.main)
    }
    
    @IBAction func callAction(_ sender: Any) {
        
        showInvoiceDialog()
    }
    
    @IBAction func sendInvoiceAction(_ sender: Any) {
        
        //showInvoiceDialog()
        
    }
    
    func showInvoiceDialog(_ animated: Bool = true) {
        
        let inoviceVC = self.storyboard?.instantiateViewController(withIdentifier: "InvoiceClientViewController") as! InvoiceClientViewController
        
        // Create the dialog
        let popup = PopupDialog(viewController: inoviceVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                gestureDismissal: true)
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }



    // MARK: - TableView Datasource & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyClientListCell") as! MyClientListCell
        return cell
    }

}
