//
//  TRUserOptionViewController.m
//  Tradiz2
//
//  Created by praveen on 5/9/17.
//  Copyright © 2017 com.xinmobile.Tradiz2. All rights reserved.
//

#import "TRUserOptionViewController.h"

@interface TRUserOptionViewController ()

@end

@implementation TRUserOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initalization];
}
-(void)initalization{
    
    _ibYesBtn.layer.cornerRadius = 25;
    _ibYesBtn.clipsToBounds = YES;

    _ibNoBtn.layer.cornerRadius = 25;
    _ibNoBtn.clipsToBounds = YES;
    
    _ibNextStepBtn.layer.cornerRadius = 5;
    _ibNextStepBtn.clipsToBounds = YES;
    
    self.ibBgView.layer.masksToBounds = NO;
    self.ibBgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.ibBgView.layer.shadowOffset = CGSizeMake(-3.0f, -3.0f);
    self.ibBgView.layer.shadowOpacity = 0.5f;
}

-(IBAction)DidTapOnYesBtn:(id)sender{
    _ibYesBtn.backgroundColor = [UIColor blueColor];
    _ibNoBtn.backgroundColor = [UIColor clearColor];
    
}
-(IBAction)DidTapOnNoBtn:(id)sender{
    _ibYesBtn.backgroundColor = [UIColor clearColor];
    _ibNoBtn.backgroundColor = [UIColor blueColor];
}
-(IBAction)didTapOnNextBtn:(id)sender{
     [self performSegueWithIdentifier:@"nextStep" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
