//
//  TRProfileImageViewController.m
//  Tradiz2
//
//  Created by praveen on 5/8/17.
//  Copyright © 2017 com.xinmobile.Tradiz2. All rights reserved.
//

#import "TRProfileImageViewController.h"

@interface TRProfileImageViewController ()

@end

@implementation TRProfileImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initalization];
}


-(void)initalization{
    
    _ibTakePhoto.layer.cornerRadius = 5;
    _ibTakePhoto.clipsToBounds = YES;
    
    _ibChooseGallery.layer.cornerRadius = 5;
    _ibChooseGallery.clipsToBounds = YES;
    
    _ibNext.layer.cornerRadius = 5;
    _ibNext.clipsToBounds = YES;

    self.ibBgView.layer.masksToBounds = NO;
    self.ibBgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.ibBgView.layer.shadowOffset = CGSizeMake(-3.0f, -3.0f);
    self.ibBgView.layer.shadowOpacity = 0.5f;
}

-(IBAction)didTapOnTakePhoto:(UIButton *)sender{
    
}
-(IBAction)didTapOnPicFromGallary:(UIButton *)sender{
    
}
-(IBAction)didTapOnNextStep:(UIButton *)sender{
    [self performSegueWithIdentifier:@"nextStep" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
