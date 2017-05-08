//
//  TRMyDetailsViewController.h
//  Tradiz2
//
//  Created by praveen on 5/9/17.
//  Copyright © 2017 com.xinmobile.Tradiz2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRMyDetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *ibFullNameTf;
@property (strong, nonatomic) IBOutlet UITextField *ibPhoneNumberTf;
@property (strong, nonatomic) IBOutlet UITextField *ibPasswordTf; 
@property (strong, nonatomic) IBOutlet UIView *ibBgView;

@property (strong, nonatomic) IBOutlet UIButton *ibNextStepBtn;
@property (strong, nonatomic) IBOutlet UIButton *ibPymbleBtn; 
@end
