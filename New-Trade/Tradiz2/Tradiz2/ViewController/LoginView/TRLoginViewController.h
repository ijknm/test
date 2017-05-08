//
//  TRLoginViewController.h
//  Tradiz2
//
//  Created by praveen on 5/8/17.
//  Copyright © 2017 com.xinmobile.Tradiz2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface TRLoginViewController : UIViewController<MBProgressHUDDelegate>

@property MBProgressHUD *progress;

@property (strong, nonatomic) IBOutlet UIView *ibEmailBgView;
@property (strong, nonatomic) IBOutlet UIButton *ibSignInBtn;
@property (strong, nonatomic) IBOutlet UIButton *ibSignUpBtn;
@property (strong, nonatomic) IBOutlet UITextField *ibEmailTF;

@end
