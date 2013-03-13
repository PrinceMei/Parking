//
//  ParkingPoint.m
//  Parking
//
//  Created by Tonny on 5/23/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "ParkingPoint.h"

@implementation ParkingPoint
@synthesize lat,lon;
@synthesize freeSpace,totalSpace;
@synthesize address,promotions,price;
@synthesize time,picture,bigPicture;
@synthesize distance;

- (id) initWithValues:(float)inLat :(float)inLon {
    self = [super init];
    if(self) {
		lat = inLat;
        lon = inLon;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:NOTI_REFRESH_POINTS object:nil];
    }
    return(self);
}

#pragma mark - NSNotification

- (void)refresh:(NSNotification *)noti{
    self.freeSpace = MIN(MAX(self.freeSpace+arc4random()%10*(arc4random()%2==0?-1:1), 0), self.totalSpace);
}

- (void)dumpParkingPoint{
    NSLog(@"ParkingPoint: lat: %f, lon: %f\n", lat, lon);
    NSLog(@"\tfreeSpace: %d\n", freeSpace);
    NSLog(@"\ttotalSpace: %d\n", totalSpace);
    
    if (time) {NSLog(@"\ttime: %@\n", time);}
    [super dumpPathHeader];
    if (price) {NSLog(@"\tprice: %@\n", price);}
    if (picture) {NSLog(@"\tpicture: %@\n", picture);}
    if (address) {NSLog(@"\taddress: %@\n", address);}
    if (promotions) {NSLog(@"\tpromotions: %@\n", promotions);}
}

- (void)setFreeSpace:(int)freeSpaceT{
    if (self.totalSpace && freeSpaceT > self.totalSpace) {
        NSLog(@"错误 freeSpaceT>totalSpace point : %@", self.name);
        NSAssert(NO, @"");
        return;
    }
    freeSpace = freeSpaceT;
}

- (int)freeSpace{
    return freeSpace;
}

- (void)setTotalSpace:(int)totalSpaceT{
    if (self.freeSpace && totalSpaceT < self.freeSpace) {
        NSLog(@"错误 freeSpaceT>totalSpace point : %@", self.name);
        NSAssert(NO, @"");
        return;
    }
    totalSpace = totalSpaceT;
}

- (int)totalSpace{
    return totalSpace;
}

@end
