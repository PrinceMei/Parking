//
//  MKMapView+ZoomLevel.h
//  Parking
//
//  Created by Tonny on 3/12/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

- (MKCoordinateRegion)regionFromLocations;

- (void)fitAllAnnotaions;
@end
