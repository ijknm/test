//
//  TRMyDetailsViewController.m
//  Tradiz2
//
//  Created by praveen on 5/9/17.
//  Copyright © 2017 com.xinmobile.Tradiz2. All rights reserved.
//

#import "TRMyDetailsViewController.h"

@interface TRMyDetailsViewController ()

@end

@implementation TRMyDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initalization];
}

-(void)initalization{
    
    _ibFullNameTf.layer.cornerRadius = 5;
    _ibFullNameTf.clipsToBounds = YES;
    _ibFullNameTf.layer.borderWidth = 1;
    _ibFullNameTf.layer.borderColor = [[UIColor whiteColor] CGColor];

    _ibPasswordTf.layer.cornerRadius = 5;
    _ibPasswordTf.clipsToBounds = YES;
    _ibPasswordTf.layer.borderWidth = 1;
    _ibPasswordTf.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    _ibPhoneNumberTf.layer.cornerRadius = 5;
    _ibPhoneNumberTf.clipsToBounds = YES;
    _ibPhoneNumberTf.layer.borderWidth = 1;
    _ibPhoneNumberTf.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    _ibPhoneNumberTf.layer.cornerRadius = 5;
    _ibPhoneNumberTf.clipsToBounds = YES;
    
    _ibPymbleBtn.layer.cornerRadius = 5;
    _ibPymbleBtn.clipsToBounds = YES;
    
    _ibNextStepBtn.layer.cornerRadius = 5;
    _ibNextStepBtn.clipsToBounds = YES;
    
    self.ibBgView.layer.masksToBounds = NO;
    self.ibBgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.ibBgView.layer.shadowOffset = CGSizeMake(-3.0f, -3.0f);
    self.ibBgView.layer.shadowOpacity = 0.5f;
}

-(IBAction)didTapOnNextBtn:(id)sender{
        [self performSegueWithIdentifier:@"nextStep" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
