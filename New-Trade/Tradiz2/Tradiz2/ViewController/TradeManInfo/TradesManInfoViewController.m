//
//  TradesManInfoViewController.m
//  Tradiz2
//
//  Created by praveen on 5/9/17.
//  Copyright © 2017 com.xinmobile.Tradiz2. All rights reserved.
//

#import "TradesManInfoViewController.h"

@interface TradesManInfoViewController ()

@end

@implementation TradesManInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initalization];
}

-(void)initalization{
    
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
