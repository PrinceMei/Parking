//
//  MapViewController.m
//  Parking
//
//  Created by Tonny on 5/6/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "MapViewController.h"
#import "ProfileViewController.h"
#import "ParkingAnotation.h"
#import "MKMapView+ZoomLevel.h"
#import "ParkingPoint.h"
#import "DataEnvironment.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.navigationItem.hidesBackButton = YES;
        
        _locations = [[DataEnvironment sharedDataEnvironment] parkingPoints];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 44);
    rightBtn.adjustsImageWhenHighlighted = NO;
    
    [rightBtn addTarget:self action:@selector(doRefresh) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *img = [UIImage imageNamed:@"btn_fresh"];
    [rightBtn setImage:img forState:UIControlStateNormal];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self addAnnotaions];
}

- (void)addAnnotaions{
    __block CLLocationCoordinate2D centerCoord;
    __block NSUInteger count = 0;
    [_locations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) { //only one
        ParkingAnotation *anotation = [[ParkingAnotation alloc] init];
        anotation.data = obj;
        
        [_mapView addAnnotation:anotation];
        
        centerCoord = anotation.coordinate;
        count = idx+1;
    }];
    
    if(count > 1){
        [_mapView fitAllAnnotaions];
    }else if(count == 1){
        [_mapView setCenterCoordinate:centerCoord zoomLevel:12 animated:NO];
    }
    
    ParkingAnotation *anotation = [[ParkingAnotation alloc] init];
    anotation.isUserLocation = YES;
    ParkingPoint *mePoint = [ParkingPoint alloc];
    mePoint.lat = 30.181539;
    mePoint.lon = 120.256988;
    anotation.data = mePoint;
    
    [_mapView addAnnotation:anotation];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setSubtitle:@"地图"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [self setSubtitle:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)doRefresh{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_POINTS object:nil];

    NSArray *array = [_mapView annotations];
    [_mapView removeAnnotations:array];
    [self addAnnotaions];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }

    ParkingAnotation *anotation = (ParkingAnotation *)annotation;
    if (anotation.isUserLocation){
        MKAnnotationView* customPinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MeLocationView"];
        customPinView.image = [UIImage imageNamed:@"carme.png"];
        customPinView.canShowCallout = YES;
//        customPinView.draggable = YES;
        
        return customPinView;
    }
    
    static NSString* ident = @"customPinView"; 
    MKAnnotationView* customPinView = [mapView dequeueReusableAnnotationViewWithIdentifier:ident];
    
    if (customPinView == nil) {
        customPinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"customPinView"];
//#ifdef DEBUG
//        customPinView.draggable = YES;
//#endif
        customPinView.canShowCallout = YES;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        customPinView.leftCalloutAccessoryView = imageView;
        
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:self action:@selector(doShowMap:) forControlEvents:UIControlEventTouchUpInside];
        customPinView.rightCalloutAccessoryView = rightButton;
    }else{
        customPinView.annotation = annotation;
    }
    
    ParkingAnotation *parkingAno = (ParkingAnotation *)annotation;
    ParkingPoint *point = parkingAno.data;
    NSInteger left = point.freeSpace;
    
    __block UIImage *image = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{    
            image = [self locationImageWithFreeSpace:left];
        dispatch_async(dispatch_get_main_queue(), ^{
            customPinView.image = image;
        });
    });
    
    UIImageView *imageView = (UIImageView *)customPinView.leftCalloutAccessoryView;
    NSString *imgString = point.picture;
    if(imgString){
        imageView.image = [UIImage imageNamed:imgString];
    }
    
    customPinView.rightCalloutAccessoryView.tag = [_locations indexOfObject:point];
    
    return customPinView;
}

- (void)doShowMap:(UIButton *)button{
    NSInteger index = button.tag;
    
    ParkingPoint *point = [_locations objectAtIndex:index];
    ProfileViewController *profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    profileVC.data = point;
    [self.navigationController pushViewController:profileVC animated:YES];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay{
    MKPolygonView* v = nil;
//    if ([overlay isKindOfClass:[MKPolygon class]]) {
//        
//    }
    v = [[MKPolygonView alloc] initWithPolygon:(MKPolygon*)overlay];
    v.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.1]; 
    v.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    v.lineWidth = 2;
    
    return v;
}

- (UIImage *)locationImageWithFreeSpace:(NSUInteger)space{
    UIImage *image = nil;
    if(space < 10){
        image = [UIImage imageNamed:@"location_re"];
    }else if(space < 20){
        image = [UIImage imageNamed:@"location_ye"];
    }else{
        image = [UIImage imageNamed:@"location_gr"];
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width, image.size.height), NO, 0.0);
    
    [image drawAtPoint:CGPointMake(0, 0)];
    NSString *string = [NSString stringWithFormat:@"%d", space];
    [RGBCOLOR(70, 70, 70) set];
    
    if(string.length == 2){
        [string drawInRect:CGRectMake(4, 2.5, 20, 20) withFont:[UIFont systemFontOfSize:14]];
    }else{
        [string drawInRect:CGRectMake(8, 2.5, 20, 20) withFont:[UIFont systemFontOfSize:14]];
    }
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

@end
