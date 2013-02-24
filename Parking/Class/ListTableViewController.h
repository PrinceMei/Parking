//
//  ListTableViewController.h
//  Parking
//
//  Created by Tonny on 5/6/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SortNone,
    SortByFreeSpace,
    SortByPrice,
    SortByDistance,
}SortType;

@interface ListTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray         *_dataSource;
    __weak IBOutlet UITableView *_tableView;
    
    SortType            _sortType;
}

@end
