//
//  QuoteRequestViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/13/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit
import PopupDialog

class QuoteRequestViewController: UIViewController {
    
    weak var delegate: LeftMenuProtocol?

    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView();
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
            if vc.isKind(of: QuoteRequestViewController.self)  {
                self.slideMenuController()?.removeLeftGestures()
                self.slideMenuController()?.removeRightGestures()
            }
        })
    }
    
    @IBAction func didTouchToMain(_ sender: UIButton) {
        delegate?.changeViewController(LeftMenu.main)
    }
    
    @IBAction func quoteAction(_ sender: Any) {
        
        showSubmitDialig()
        
    }
    
    func showSubmitDialig(_ animated: Bool = true) {
        
        let visitReqVC = self.storyboard?.instantiateViewController(withIdentifier: "QuoteRequestSubmitViewController") as! QuoteRequestSubmitViewController
        
        // Create the dialog
        let popup = PopupDialog(viewController: visitReqVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                gestureDismissal: true)
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
