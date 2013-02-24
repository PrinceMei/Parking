//
//  CONSTANTS.h
//  Parking
//
//  Created by Tonny on 5/19/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#ifndef Parking_CONSTANTS_h
#define Parking_CONSTANTS_h

#define RGBCOLOR(r,g,b)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define APP_BACK_SHADOW_COLOR       RGBACOLOR(0, 0, 0, 0.35f)
#define TEXT_COLOR_2                RGBCOLOR(132, 81, 12)

#define NOTI_ENTER_INTO_APP         @"enter_into_application"
#define NOTI_REFRESH_POINTS         @"refresh_parking_point"

typedef void(^FinishedBlock)(id viewController, id object);

#endif
