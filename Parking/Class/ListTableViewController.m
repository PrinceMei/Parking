//
//  ListTableViewController.m
//  Parking
//
//  Created by Tonny on 5/6/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "ListTableViewController.h"
#import "ProfileViewController.h"
#import "ParkingPoint.h"
#import "DataEnvironment.h"

@interface ListTableViewController ()

@end

@implementation ListTableViewController

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.navigationItem.hidesBackButton = YES;
        
        _dataSource = [[DataEnvironment sharedDataEnvironment] parkingPoints];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    _tableView = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setSubtitle:@"列表"];
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
    static NSString *CellIdentifier = @"ListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_cell_acc"]];
    
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:1];
    UILabel *titleLbl = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *subLbl = (UILabel *)[cell.contentView viewWithTag:3];
    UIView *proView = [cell.contentView viewWithTag:4];
    
    NSInteger row = indexPath.row;
    ParkingPoint *point = [_dataSource objectAtIndex:row];
    imgView.image = [UIImage imageNamed:point.picture];
    NSString *name = point.name;
    titleLbl.text = name;
    subLbl.text = [NSString stringWithFormat:@"距离:%dm  价格:%@  空车位:%d", point.distance, point.price, point.freeSpace];
    proView.alpha = (point.promotions != nil);
    proView.left = titleLbl.left+[name sizeWithFont:[UIFont systemFontOfSize:17]].width+5;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    ParkingPoint *point = [_dataSource objectAtIndex:index];
    ProfileViewController *profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    profileVC.data = point;
    [self.navigationController pushViewController:profileVC animated:YES];
}

- (IBAction)sortByFreeSapce:(id)sender {
    if(_sortType == SortByFreeSpace) return;
    _sortType = SortByFreeSpace;
    
    [_dataSource sortUsingComparator:^NSComparisonResult(ParkingPoint *obj1, ParkingPoint *obj2) {
        if(obj1.freeSpace > obj2.freeSpace){
            return NSOrderedDescending;
        }else{
            return NSOrderedAscending;
        }
    }];
    
    [_tableView reloadData];
}

- (IBAction)sortByPrice:(id)sender {
    if(_sortType == SortByPrice) return;
    _sortType = SortByPrice;
    
    [_dataSource sortUsingComparator:^NSComparisonResult(ParkingPoint *obj1, ParkingPoint *obj2) {
        NSString *price1 = [obj1.price substringFromIndex:1];
        NSString *price2 = [obj2.price substringFromIndex:1];
        
        if(price1.floatValue > price2.floatValue){
            return NSOrderedDescending;
        }else{
            return NSOrderedAscending;
        }
    }];
    
    [_tableView reloadData];
}

- (IBAction)sortByDistance:(id)sender {
    if(_sortType == SortByDistance) return;
    _sortType = SortByDistance;
    
    [_dataSource sortUsingComparator:^NSComparisonResult(ParkingPoint *obj1, ParkingPoint *obj2) {
        if(obj1.distance > obj2.distance){
            return NSOrderedDescending;
        }else{
            return NSOrderedAscending;
        }
    }];
    
    [_tableView reloadData];
}

- (IBAction)refresh:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_POINTS object:nil];
    
    if(_sortType == SortByFreeSpace){
        [_dataSource sortUsingComparator:^NSComparisonResult(ParkingPoint *obj1, ParkingPoint *obj2) {
            if(obj1.freeSpace > obj2.freeSpace){
                return NSOrderedDescending;
            }else{
                return NSOrderedAscending;
            }
        }];
    }
    
    [_tableView reloadData];
}

@end
