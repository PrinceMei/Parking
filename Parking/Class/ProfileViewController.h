//
//  ProfileViewController.h
//  Parking
//
//  Created by Tonny on 5/6/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ParkingActionSheet.h"
//#import "ParkingCameraViewController.h"

@class ParkingPoint;

@interface ProfileViewController : UIViewController <UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>{
    BOOL            _isBelowParking;
    
    BOOL            _showPopView;
    
    UIView          *_popView;
    
    UIButton        *_rightNavigationBarBtn;
    
    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet UIImageView *_barImgView;
    __weak IBOutlet UIImageView *_headImgView;
    __weak IBOutlet UIImageView *_imgView;
    __weak IBOutlet UILabel     *_priceLbl;
    __weak IBOutlet UILabel     *_timeLbl;
    __weak IBOutlet UILabel     *_addressLbl;
    __weak IBOutlet UILabel     *_infoLbl;
    __weak IBOutlet UILabel     *_promoLbl;
    
    NSArray         *_comments;
    NSArray         *_commentPhotos;
}

@property (nonatomic, strong) ParkingPoint *data;

@end
