//
//  GPX+ParkingPoint.m
//  Parking
//
//  Created by Tonny on 5/23/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "GPX+ParkingPoint.h"
#import "ParkingPoint.h"

@implementation GPX (ParkingPoint)

- (void)addParkingPoint:(ParkingPoint *)parkingPoint{
    if (self.parkingPoints == nil) {
        self.parkingPoints = [[NSMutableArray alloc] init];
    }
    parkingPoint.distance = arc4random()%100;
    
    [self.parkingPoints addObject:parkingPoint];    
}

@end
