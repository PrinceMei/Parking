//
//  DataEnvironment.m
//  Parking
//
//  Created by Tonny on 5/24/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <libxml/xmlreader.h>
#import "DataEnvironment.h"
#import "SINGLETONGCD.h"
#import "gpx-api.h"

@implementation DataEnvironment
@synthesize parkingPoints;
@synthesize historyRecord;
@synthesize isParking;
@synthesize isMaskMe;

SINGLETON_GCD(DataEnvironment);

- (NSArray *)historyRecord{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"HistoryFilePath"];
    
    historyRecord = [[NSArray alloc] initWithContentsOfFile:filePath];
    if(historyRecord == nil){
        NSArray *array = self.parkingPoints;
        NSInteger count = array.count;
        
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"2011.10.12\n12:12", @"time", [NSNumber numberWithInt:arc4random()%count], @"point", @"1", @"howlong", nil];        
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"2011.11.04\n10:50", @"time", [NSNumber numberWithInt:arc4random()%count], @"point", @"2", @"howlong", nil];
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"2011.12.02\n09:00", @"time", [NSNumber numberWithInt:arc4random()%count], @"point", @"2", @"howlong", nil];        
        NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"2012.01.03\n15:20", @"time", [NSNumber numberWithInt:arc4random()%count], @"point", @"1", @"howlong", nil];
        NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:@"2011.03.20\n12:00", @"time", [NSNumber numberWithInt:arc4random()%count], @"point", @"4", @"howlong", nil];        
        NSDictionary *dic6 = [NSDictionary dictionaryWithObjectsAndKeys:@"2011.05.04\n15:50", @"time", [NSNumber numberWithInt:arc4random()%count], @"point", @"3", @"howlong", nil];
        NSDictionary *dic7 = [NSDictionary dictionaryWithObjectsAndKeys:@"2011.05.07\n18:10", @"time", [NSNumber numberWithInt:arc4random()%count], @"point", @"7", @"howlong", nil];
        
        historyRecord = [[NSArray alloc] initWithObjects:dic7, dic6, dic5, dic4, dic3, dic2, dic1, nil];
        [historyRecord writeToFile:filePath atomically:YES];
    }
    
    return historyRecord;
}

- (NSMutableArray *)parkingPoints{
    if(parkingPoints){
        return parkingPoints;
    }
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Location" ofType:@"gpx"];
    const char* filename = [path UTF8String];
    
    xmlDocPtr doc = NULL;
    xmlNode *root_element = NULL;
    doc = xmlReadFile(filename, NULL, 0);
    root_element = xmlDocGetRootElement(doc); 
    //        traverse_elements(root_element); // must be previously defined xmlFreeDoc(doc);
    
    GPX *gpx = [[GPX alloc] init];
    parse_gpx(root_element, gpx);
    
    xmlCleanupParser();
    
    [gpx dumpGPX];
    
    parkingPoints = gpx.parkingPoints;
    return parkingPoints;
}

@end
