//
//  MenuViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/11/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit
import PopupDialog

enum LeftMenu: Int {
    case main = 0
    case profile
    case my_jobs
    case my_quote
    case my_client
    case callback_request
    case site_visit_request
    case calendar_booking_requests
    case quote_request
    case notifications
    case invite_friend
    case update
    case about_it
//    case main
}
protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}


class MenuViewController: UIViewController, LeftMenuProtocol{
    
    @IBOutlet weak var tableView: UITableView!
    
    var menuNames = ["Profile", "My Jobs", "My Quote", "My Clients", "Callback Requests", "Site Visit Requests", "Calendar Booking Requests", "Quote Requests", "Notifications", "Invite a Friends", "Check for Update", "About This App"]
    
    var menuIcons = ["ic_menu_profile", "ic_menu_my_jobs", "ic_menu_my_quote", "ic_menu_my_clients", "ic_menu_callback_request", "ic_menu_site_request", "ic_menu_calender_request", "ic_menu_quote_request", "ic_menu_notification", "ic_menu_invite_friend", "ic_menu_update", "ic_menu_about_it"]
    
    var mainViewController: UIViewController!
    var profileViewController: UIViewController!
    var myClientViewController: UIViewController!
    var myQuoteViewController: UIViewController!
    var myJobsViewController: UIViewController!
    var quoteRequestViewController: UIViewController!
    //var imageHeaderView: ImageHeaderView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        
//        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileViewController.delegate = self
        self.profileViewController = UINavigationController(rootViewController: profileViewController)
        
        let myQuoteViewController = storyboard.instantiateViewController(withIdentifier: "MyQuotesViewController") as! MyQuotesViewController
        myQuoteViewController.delegate = self
        self.myQuoteViewController = UINavigationController(rootViewController: myQuoteViewController)
        
        let myJobsViewController = storyboard.instantiateViewController(withIdentifier: "MyJobViewController") as! MyJobViewController
        myJobsViewController.delegate = self
        self.myJobsViewController = UINavigationController(rootViewController: myJobsViewController)
        
        let quoteRequestViewController = storyboard.instantiateViewController(withIdentifier: "QuoteRequestViewController") as! QuoteRequestViewController
        quoteRequestViewController.delegate = self
        self.quoteRequestViewController = UINavigationController(rootViewController: quoteRequestViewController)
        
        let myClientViewController = storyboard.instantiateViewController(withIdentifier: "MyClientViewController") as! MyClientViewController
        myClientViewController.delegate = self
        self.myClientViewController = UINavigationController(rootViewController: myClientViewController)
        
        let mainTabViewController = storyboard.instantiateViewController(withIdentifier: "MainTabViewController") as! MainTabViewController
        self.mainViewController = UINavigationController(rootViewController: mainTabViewController)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func changeViewController(_ menu: LeftMenu) {
        
        print(menu);
        
        switch menu {
            
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
            
        case .profile:
            self.slideMenuController()?.changeMainViewController(self.profileViewController, close: true)
        case .quote_request:
            self.slideMenuController()?.changeMainViewController(self.quoteRequestViewController, close: true)
            
        case .my_client:
            self.slideMenuController()?.changeMainViewController(self.myClientViewController, close: true)
        case .my_quote :
            self.slideMenuController()?.changeMainViewController(self.myQuoteViewController, close: true)
        case .my_jobs :
            self.slideMenuController()?.changeMainViewController(self.myJobsViewController, close: true)
            
        case .invite_friend :           
            self.perform(#selector(showCustomDialog(_:)), with: nil, afterDelay: 0.1)
            
        case .callback_request :
            self.perform(#selector(showCallBackReqDialig(_:)), with: nil, afterDelay: 0.1)
            
        case .site_visit_request :
            self.perform(#selector(showVisitReqDialig(_:)), with: nil, afterDelay: 0.1)
            
        case .calendar_booking_requests:
            self.perform(#selector(showCalendarBookingReqDialig(_:)), with: nil, afterDelay: 0.1)
            
            
        default :
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
            
        }
    }
    
    func showCustomDialog(_ animated: Bool = true) {
        
        // Create a custom view controller
        //let inviteFriendVC = InviteViewController(nibName: "InviteViewController", bundle: nil)
        let inviteFriendVC = self.storyboard?.instantiateViewController(withIdentifier: "InviteFriendViewController") as! InviteFriendViewController
        
        // Create the dialog
        let popup = PopupDialog(viewController: inviteFriendVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                gestureDismissal: true)
        
        //(transitionStyle: .bounceUp(durationIn: 0.6, durationOut: 0.22)
        
        // Create first button
        //        let buttonOne = CancelButton(title: "CANCEL", height: 60) {
        //            //self.label.text = "You canceled the rating dialog"
        //        }
        ////
        ////        // Create second button
        //        let buttonTwo = DefaultButton(title: "RATE", height: 60) {
        //            //self.label.text = "You rated \(ratingVC.cosmosStarRating.rating) stars"
        //        }
        //        
        //        // Add buttons to dialog
        //        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
        /*
        if let rootVC = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController {
            rootVC.present(popup, animated: animated, completion: nil)
        } */
    }
    
    func showCallBackReqDialig(_ animated: Bool = true) {
        
        let callbackReqVC = self.storyboard?.instantiateViewController(withIdentifier: "CallbackRequestViewController") as! CallbackRequestViewController
        
        // Create the dialog
        let popup = PopupDialog(viewController: callbackReqVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                gestureDismissal: true)
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }
    
    func showVisitReqDialig(_ animated: Bool = true) {
        
        let visitReqVC = self.storyboard?.instantiateViewController(withIdentifier: "VisitRequestViewController") as! VisitRequestViewController
        
        // Create the dialog
        let popup = PopupDialog(viewController: visitReqVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                gestureDismissal: true)
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }
    
    func showCalendarBookingReqDialig(_ animated: Bool = true) {
        
        let visitReqVC = self.storyboard?.instantiateViewController(withIdentifier: "CalendarBookingRequestViewController") as! CalendarBookingRequestViewController

        let popup = PopupDialog(viewController: visitReqVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                gestureDismissal: true)

        self.present(popup, animated: animated, completion: nil)
    }
}

extension MenuViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 40.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row+1) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension MenuViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellCell") as! MenuCellCell
        
        cell.setData(menuIcons[indexPath.row], menuName: menuNames[indexPath.row])
        return cell
    }
    
}
