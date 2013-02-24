//
//  ParkNavigationController.h
//  Parking
//
//  Created by Tonny on 5/19/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ShowMap,
    ShowList,
    ShowHistory,
}ShowType;

@interface ParkNavigationController : UINavigationController <UINavigationControllerDelegate>{
    IBOutlet UIView         *_toolView;
    
    BOOL                    _isExpand;
    
    ShowType                _showType;
}

@end
