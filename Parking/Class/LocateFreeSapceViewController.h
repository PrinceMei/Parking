//
//  LocateMyCarViewController.h
//  Parking
//
//  Created by Tonny on 5/25/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ParkingPoint;

@interface LocateFreeSapceViewController : UIViewController{
    
    __weak IBOutlet UIScrollView    *_scrollView;
    __weak IBOutlet UILabel         *_tipLbl;
    
    __weak IBOutlet UIImageView     *_meImgView;
    __weak IBOutlet UIImageView     *_pathImgView1;
    __weak IBOutlet UIImageView     *_pathImgView2;
    __weak IBOutlet UIImageView     *_pathImgView3;

    BOOL    _hasFindMyCar;
}


@property (nonatomic, assign) ParkingPoint *point;

@end
