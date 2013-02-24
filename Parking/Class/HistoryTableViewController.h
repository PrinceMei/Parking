//
//  HistoryTableViewController.h
//  Parking
//
//  Created by Tonny on 5/6/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewController : UITableViewController{
    UIView      *_popView;
    
    BOOL        _showPopView;

    NSArray     *_dataSource;
}

@end
