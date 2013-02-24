//
//  LocateMyCarViewController.m
//  Parking
//
//  Created by Tonny on 5/25/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "LocateFreeSapceViewController.h"
#import "ParkingPoint.h"
#import "DataEnvironment.h"

@interface LocateFreeSapceViewController ()

@end

@implementation LocateFreeSapceViewController
@synthesize point;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _tipLbl.backgroundColor = APP_BACK_SHADOW_COLOR;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findMyCar)];
    [_meImgView addGestureRecognizer:tapGesture];
    
    _scrollView.contentSize = CGSizeMake(750, 700);
    _scrollView.contentOffset = CGPointMake(215, 142);
}

- (void)viewDidUnload
{
    _tipLbl = nil;
    _meImgView = nil;
    _pathImgView1 = nil;
    _pathImgView2 = nil;
    _pathImgView3 = nil;
    _scrollView = nil;
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)findMyCar{
    if(_hasFindMyCar) return;
    
    CGFloat speed = 120;
    ///////animation 1
    [UIView animateWithDuration:(62-13)/speed
                     animations:^{
                         _meImgView.left = 62;
                         _pathImgView1.frame = CGRectMake(71, _pathImgView1.top, 1, 4);
                     }completion:^(BOOL finished) {
                         [_pathImgView1 removeFromSuperview];
                         
                         ///////animation 2
                         [UIView animateWithDuration:(360-134)/speed
                                          animations:^{
                                              _meImgView.top = 134;
                                              _pathImgView2.frame = CGRectMake(_pathImgView2.left, 140, 3, 1);
                                          }completion:^(BOOL finished) {
                                              [_pathImgView2 removeFromSuperview];
                                              
                                              ///////animation 3
                                              [UIView animateWithDuration:(275-62)/speed
                                                               animations:^{
                                                                   _meImgView.left = 275;
                                                                   _pathImgView3.frame = CGRectMake(289, _pathImgView3.top, 1, 4);
                                                               }completion:^(BOOL finished) { [_pathImgView3 removeFromSuperview];
                                                                   _hasFindMyCar = YES;            }]; 
                                          }];
                         
                     }];
}

- (void)showFee{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"PriceView" owner:nil options:nil] objectAtIndex:0];
    view.frame = (CGRect){320, 180, view.frame.size};
    
    UIImageView *imgView = (UIImageView *)[view viewWithTag:1];
    imgView.image = [UIImage imageNamed:point.picture];
    
    UILabel *nameLbl = (UILabel *)[view viewWithTag:2];
    nameLbl.text = point.name;
    
    UILabel *priceLbl = (UILabel *)[view viewWithTag:3];
    
    CGFloat price = [[point.price substringFromIndex:1] floatValue];
    NSUInteger howlong = MAX(arc4random()%5, 1);
    priceLbl.text = [NSString stringWithFormat:@"停车%d小时,消费%.1f元", howlong, price*howlong];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    backView.backgroundColor = APP_BACK_SHADOW_COLOR;
    backView.alpha = 0;
    [self.navigationController.view addSubview:backView];
    
    [self.navigationController.view addSubview:view];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel:)];
    [view addGestureRecognizer:tapGesture];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         backView.alpha = 1;
                         view.left = 70;
                     }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)sure:(id)sender {
    [self showFee];
    
    [DataEnvironment sharedDataEnvironment].isParking = NO;
    [DataEnvironment sharedDataEnvironment].isMaskMe = NO;
}

@end
