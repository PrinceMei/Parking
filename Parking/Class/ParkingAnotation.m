//
//  ParkingAnotation.m
//  Parking
//
//  Created by Tonny on 5/23/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "ParkingAnotation.h"
#import "ParkingPoint.h"

@implementation ParkingAnotation
@synthesize isUserLocation;
@synthesize data;
@synthesize coordinate;


- (NSString *)title{
    if (self.isUserLocation) {
        return @"我在这儿";
    }
    return data.name;
}

- (NSString *)subtitle{
    if (self.isUserLocation) {
        return @"停车不再纠结";
    }
    return [NSString stringWithFormat:@"价格: %@ 空车位:%d", data.price, data.freeSpace];
}

- (CLLocationCoordinate2D)coordinate{
    if(coordinate.longitude != 0){
        return coordinate;
    }
    
    CLLocationCoordinate2D coordinateT;
    coordinateT.latitude = data.lat;
    coordinateT.longitude = data.lon;
    
    return coordinateT;
}

- (void)setCoordinate:(CLLocationCoordinate2D)coordinateT{
    NSLog(@"coordinate <%f, %f>", coordinateT.latitude, coordinateT.longitude);
    coordinate = coordinateT;
}

@end
