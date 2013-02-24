//
//  MapViewController.h
//  Parking
//
//  Created by Tonny on 5/6/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h>

@interface MapViewController : UIViewController{
    NSMutableArray                  *_locations;
    
    
    __weak IBOutlet MKMapView       *_mapView;
}

@end
