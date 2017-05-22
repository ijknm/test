//
//  AppDelegate.swift
//  Tradiz2
//
//  Created by JIS on 5/7/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit
import PopupDialog
import CoreLocation
import IQKeyboardManagerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , CLLocationManagerDelegate{

    var window: UIWindow?
    var locationManager = CLLocationManager()
    var geoCoder = CLGeocoder()
    
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    
    var g_user = UserEntity()
    
    static var singleton : AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        locationManager.delegate = self
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        
        ProgressHUD.initHUD()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        findMyLocation()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //--- Find Address of Current Location ---//
    func findMyLocation()  {
        
        //        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
//        let location = self.locationManager.location
//        
//        latitude = location!.coordinate.latitude
//        longitude = location!.coordinate.longitude
//        
//        print("current latitude :: \(latitude)")
//        print("current longitude :: \(longitude)")
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //--- CLGeocode to get address of current location ---//
        if let lastLocation = locations.first {
            latitude = lastLocation.coordinate.latitude
            longitude = lastLocation.coordinate.longitude

        
        geoCoder.reverseGeocodeLocation(lastLocation, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil)
            {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0
            {
                let pm = placemarks?[0]
                self.displayLocationInfo(placemark: pm)
            }
            else
            {
                print("Problem with the data received from geocoder")
            }
        })
        }
        
    }
    
    func displayLocationInfo(placemark: CLPlacemark?)
    {
        if let containsPlacemark = placemark
        {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            ///let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            let thoroughfare = (containsPlacemark.thoroughfare != nil) ? containsPlacemark.thoroughfare : ""
            let sublocality = (containsPlacemark.subLocality != nil) ? containsPlacemark.subLocality : ""
            let countryCode = (containsPlacemark.isoCountryCode != nil) ? containsPlacemark.isoCountryCode : ""
            
            
            /*
            print(locality ?? "")
            print(sublocality ?? "")
            print(thoroughfare ?? "")
            print(postalCode ?? "")
            print(administrativeArea ?? "")
            print(country ?? "")
            print(countryCode ?? "")
            */
            
            Address = thoroughfare! + ", " + locality!
            Suburb = sublocality!
            PostCode = postalCode!
            State = administrativeArea!
            CountryCode = countryCode!
            CurLat = latitude
            CurLong = longitude
            
            print("Current address : " + Address)
            print("Current latitude : \(CurLat)")
            print("Current longitude : \(CurLong)")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error while updating location " + error.localizedDescription)
    }

    class func getUser() -> UserEntity {
        
        let App : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return App.g_user;
    }
    
    class func setUser(user: UserEntity) {
        let App : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        App.g_user = user
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        // Print message ID.
        //        if let messageID = userInfo[gcmMessageIDKey] {
        //            print("Message ID: \(messageID)")
        //        }
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        //        if let messageID = userInfo[gcmMessageIDKey] {
        //            print("Message ID: \(messageID)")
        //        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}

