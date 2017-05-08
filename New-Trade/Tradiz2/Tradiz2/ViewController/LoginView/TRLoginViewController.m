//
//  TRLoginViewController.m
//  Tradiz2
//
//  Created by praveen on 5/8/17.
//  Copyright © 2017 com.xinmobile.Tradiz2. All rights reserved.
//

#import "TRLoginViewController.h"

@implementation TRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initalization];
}


#pragma mark- initalization
-(void)initalization{
    
       _progress.delegate = self;
    _ibSignInBtn.layer.cornerRadius = 5;
    _ibSignInBtn.clipsToBounds = YES;
    
    _ibSignUpBtn.layer.cornerRadius = 5;
    _ibSignUpBtn.clipsToBounds = YES;
    
    _ibEmailBgView.layer.borderWidth = 1;
    _ibEmailBgView.layer.cornerRadius = 5;
    _ibEmailBgView.layer.borderColor = [[UIColor whiteColor] CGColor];
}


#pragma mark- UIButton Action
-(IBAction)didTapOnSignInBtn:(UIButton *)sender{
    NSString *email = _ibEmailTF.text;
    if (email == nil || [email isEqualToString:@""]) {
        [self showErrorMessage:@"Enter the email id"];
        return;
    }
    else if (![self isValidEmail:email]){
        [self showErrorMessage:@"Enter Valid Email id"];
        return;
    }
    else{
           [self performSegueWithIdentifier:@"SignIn" sender:nil];
    }
}

-(IBAction)didTapOnSignUpBtn:(UIButton *)sender{
    NSString *email = _ibEmailTF.text;
    if (email == nil || [email isEqualToString:@""]) {
        [self showErrorMessage:@"Enter the email id"];
        return;
    }
    else if (![self isValidEmail:email]){
        [self showErrorMessage:@"Enter Valid Email id"];
          return;
    }
    else{
        [self performSegueWithIdentifier:@"SignIn" sender:nil];
    }
}

#pragma mark- Valid Email
- (BOOL)isValidEmail:(NSString *)email
{
    NSString *regex1 = @"\\A[a-z0-9]+([-._][a-z0-9]+)*@([a-z0-9]+(-[a-z0-9]+)*\\.)+[a-z]{2,4}\\z";
    NSString *regex2 = @"^(?=.{1,64}@.{4,64}$)(?=.{6,100}$).*";
    NSPredicate *test1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex1];
    NSPredicate *test2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    return [test1 evaluateWithObject:email] && [test2 evaluateWithObject:email];
}

#pragma mark- MBProgressBar
-(void)showLoading{
    _progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _progress.label.text = @"Loading";
}
-(void)hideLoading{
    [_progress hideAnimated:YES];
}
-(void)showErrorMessage:(NSString *)message{
    _progress   = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _progress.mode = MBProgressHUDModeText;
    _progress.detailsLabel.text = NSLocalizedString(message, @"HUD message title");
    _progress.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [_progress hideAnimated:YES afterDelay:3.f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
