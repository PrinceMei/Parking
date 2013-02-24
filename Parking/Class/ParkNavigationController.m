//
//  ParkNavigationController.m
//  Parking
//
//  Created by Tonny on 5/19/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "ParkNavigationController.h"

@interface ParkNavigationController ()

@end

@implementation ParkNavigationController

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initial];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initial];
    }
    return self;
}

- (void)initial{
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg"] forBarMetrics:UIBarMetricsDefault];
    
#ifdef __IPHONE_5_0
    //        [self.navigationBar setTitleVerticalPositionAdjustment:1.0 forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:RGBCOLOR(37, 89, 130), UITextAttributeTextColor, RGBCOLOR(85, 165, 208), UITextAttributeTextShadowColor, [NSValue valueWithCGSize:CGSizeMake(1, 1)], UITextAttributeTextShadowOffset, [UIFont boldSystemFontOfSize:18], UITextAttributeFont, nil];
#endif
    
    _isExpand = NO;
    [[NSBundle mainBundle] loadNibNamed:@"ToolView" owner:self options:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startApplication:) name:NOTI_ENTER_INTO_APP object:nil];
    
    self.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _toolView.center = CGPointMake(160, self.view.height-_toolView.height/2);
    [self.view addSubview:_toolView];
}

- (void)viewDidUnload
{
    _toolView = nil;
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showMap:(id)sender {
    if(_showType == ShowMap) return;
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    _showType = ShowMap;
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [self pushViewController:viewController animated:NO];
}

- (IBAction)showList:(id)sender {
    if(_showType == ShowList) return;
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    _showType = ShowList;
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListTableViewController"];
    [self pushViewController:viewController animated:NO];
}

- (IBAction)showHistory:(id)sender {
    if(_showType == ShowHistory) return;
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    _showType = ShowHistory;
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HistoryTableViewController"];
    [self pushViewController:viewController animated:NO];
}

- (IBAction)toolTapped:(UIButton *)button{
    if(_isExpand){
        UIView *view = [_toolView viewWithTag:1];
        [UIView animateWithDuration:0.3f
                         animations:^{
                             button.transform = CGAffineTransformMakeRotation(M_PI_4);
                             view.top = _toolView.height;
                         }];
    }else{
        UIView *view = [_toolView viewWithTag:1];
        [UIView animateWithDuration:0.3f
                         animations:^{
                             view.top = 0;
                             button.transform = CGAffineTransformMakeRotation(-M_PI_4);
                         }];
    }
    
    _isExpand = !_isExpand;
}

- (void)startApplication:(NSNotification *)noti{
    _showType = ShowMap;
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         _toolView.alpha = 1; 
                     }completion:^(BOOL finished) {
                         _isExpand = YES;
                     }];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    BOOL showParent = [viewController isMemberOfClass:NSClassFromString(@"ListTableViewController")] || [viewController isMemberOfClass:NSClassFromString(@"MapViewController")] || [viewController isMemberOfClass:NSClassFromString(@"HistoryTableViewController")];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         _toolView.alpha = showParent; 
                     }];}

@end
