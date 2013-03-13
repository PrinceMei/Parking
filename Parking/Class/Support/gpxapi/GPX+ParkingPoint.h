//
//  GPX+ParkingPoint.h
//  Parking
//
//  Created by Tonny on 5/23/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "gpx-api.h"

@class ParkingPoint;

@interface GPX (ParkingPoint)

- (void)addParkingPoint:(ParkingPoint *)parkingPoint;

@end
