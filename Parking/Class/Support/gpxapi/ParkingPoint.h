//
//  ParkingPoint.h
//  Parking
//
//  Created by Tonny on 5/23/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gpx-api.h"

@interface ParkingPoint : PathHeader
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *bigPicture;
@property float lat;
@property float lon;
@property int freeSpace;    //fres
@property int totalSpace;   //ttls

@property (nonatomic, strong) NSString *time;         //time
@property (nonatomic, strong) NSString *price;      //prc ¥3/h
@property (nonatomic, strong) NSString *address;    //add
@property (nonatomic, strong) NSString *promotions; //pro

@property (nonatomic) NSUInteger distance; //distance

- (id)initWithValues: (float)inLat :(float)inLon;

- (void) dumpParkingPoint;
@end