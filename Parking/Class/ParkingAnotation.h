//
//  ParkingAnotation.h
//  Parking
//
//  Created by Tonny on 5/23/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapkit/Mapkit.h>

@class ParkingPoint;

@interface ParkingAnotation : NSObject <MKAnnotation>

@property (nonatomic, strong) ParkingPoint *data;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic) BOOL isUserLocation;

@end
