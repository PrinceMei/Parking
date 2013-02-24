//
//  HistoryTableViewController.m
//  Parking
//
//  Created by Tonny on 5/6/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "SuggestViewController.h"
#import "ParkNavigationController.h"
#import "DataEnvironment.h"
#import "ParkingPoint.h"
#import "ProfileViewController.h"

@interface HistoryTableViewController ()

@end

@implementation HistoryTableViewController

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.navigationItem.hidesBackButton = YES;
        
        _dataSource = [[DataEnvironment sharedDataEnvironment] historyRecord];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setSubtitle:@"历史纪录"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self setSubtitle:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HistoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

//    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_cell_acc"]];
    
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:1];
    UILabel *titleLbl = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *subLbl = (UILabel *)[cell.contentView viewWithTag:3];
    UILabel *timeLbl = (UILabel *)[cell.contentView viewWithTag:4];
    
    NSInteger row = indexPath.row;
    NSDictionary *dic = [_dataSource objectAtIndex:row];
    
    ParkingPoint *point = [[[DataEnvironment sharedDataEnvironment] parkingPoints] objectAtIndex:[[dic objectForKey:@"point"] intValue]];
    
    imgView.image = [UIImage imageNamed:point.picture];
    NSString *name = point.name;
    titleLbl.text = name;
    CGFloat price = [[point.price substringFromIndex:1] floatValue];
    NSUInteger howlong = [[dic objectForKey:@"howlong"] intValue];
    subLbl.text = [NSString stringWithFormat:@"停车%d小时,消费%.1f元", howlong, price*howlong];
    timeLbl.text = [dic objectForKey:@"time"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    NSDictionary *dic = [_dataSource objectAtIndex:index];
    ProfileViewController *profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    
    NSInteger pindex = [[dic objectForKey:@"point"] intValue];
    profileVC.data = [[DataEnvironment sharedDataEnvironment].parkingPoints objectAtIndex:pindex];
    [self.navigationController pushViewController:profileVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(_showPopView){
        _showPopView = NO;
        [_popView removeFromSuperview]; _popView = nil;
    }
}

- (void)doSuggest{
    SuggestViewController *suggestVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SuggestViewController"];
    ParkNavigationController *naVC = [[ParkNavigationController alloc] initWithRootViewController:suggestVC];
    [self presentModalViewController:naVC animated:YES];
    
    [self doSetting:nil];
}

- (void)doAbout{
    [self doSetting:nil];    
}

- (IBAction)doSetting:(id)sender {
    if(!_showPopView){
        _showPopView = YES;
        
        _popView = [[[NSBundle mainBundle] loadNibNamed:@"PopoverView" owner:self options:nil] objectAtIndex:0];
//        _popView.alpha = 0;
        _popView.right = 320;
        _popView.bottom = 0;
        [self.view addSubview:_popView];
        
        UIButton *button1 = (UIButton *)[_popView viewWithTag:1];
        [button1 addTarget:self action:@selector(doSuggest) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *button2 = (UIButton *)[_popView viewWithTag:2];
        [button2 addTarget:self action:@selector(doAbout) forControlEvents:UIControlEventTouchUpInside];
        
        [UIView animateWithDuration:0.3f
                         animations:^{
//                             _popView.alpha = 1;
                             _popView.top = 0;
                         }];
    }else{
        _showPopView = NO;
        [UIView animateWithDuration:0.3f
                         animations:^{
//                             _popView.alpha = 0;
                             _popView.bottom = 0;
                         }completion:^(BOOL finished) {
                             [_popView removeFromSuperview]; _popView = nil;
                         }];
    }
}

@end
