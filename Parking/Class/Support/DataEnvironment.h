//
//  DataEnvironment.h
//  Parking
//
//  Created by Tonny on 5/24/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataEnvironment : NSObject

@property (nonatomic, strong) NSMutableArray *parkingPoints;
@property (nonatomic, strong) NSArray *historyRecord;
@property (nonatomic) BOOL isParking;
@property (nonatomic) BOOL isMaskMe;

+ (DataEnvironment *)sharedDataEnvironment;

@end
