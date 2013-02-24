//
//  RootViewController.m
//  Parking
//
//  Created by Tonny on 5/19/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController


- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden = YES;
    
    [super viewDidLoad];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    imgView.image = [UIImage imageNamed:@"Default"];
    imgView.contentMode = UIViewContentModeBottom;
    [self.view addSubview:imgView];

    UIImageView *carView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 145, 60, 30)];
    carView.image = [UIImage imageNamed:@"car"];
    [self.view addSubview:carView];
    
    [UIView animateWithDuration:1.0f
                     animations:^{
                         carView.left = 150;
                     }completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.4f
                                          animations:^{
                                              carView.left = 100;
                                          }completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.6f
                                                               animations:^{
                                                                   carView.left = 130;
                                                               }completion:^(BOOL finished) {
                                                                   UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
                                                                   [self.navigationController pushViewController:viewController animated:NO];
                                                                   
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_ENTER_INTO_APP object:nil];
                                                               }]; 
                                          }]; 
                     }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
