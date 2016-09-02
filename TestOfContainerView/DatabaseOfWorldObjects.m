//
//  DatabaseOfWorldObjects.m
//  VWorld
//
//  Created by Michael Ellertson on 5/29/14.
//  Copyright (c) 2014 AR Games. All rights reserved.
//

#import "DatabaseOfWorldObjects.h"


@implementation NSMutableDictionary (DatabaseOfWorldObjects)

- (id)populateWithDatabaseObjects
{
//    [self setObject:[object updateWithLatitude:LOC1LAT Longitude:LOC1LONG Altitude:0] forKey:@"OBJECT 1"];   // this is the camera's location for testing
    [self setObject:[WorldCoordinate allocAndInitWithLatitude:LOC2LAT Longitude:LOC2LONG Altitude:0] forKey:@"OBJECT 2"];
    [self setObject:[WorldCoordinate allocAndInitWithLatitude:LOC3LAT Longitude:LOC3LONG Altitude:0] forKey:@"OBJECT 3"];
    [self setObject:[WorldCoordinate allocAndInitWithLatitude:LOC4LAT Longitude:LOC4LONG Altitude:0] forKey:@"OBJECT 4"];
    [self setObject:[WorldCoordinate allocAndInitWithLatitude:LOC5LAT Longitude:LOC5LONG Altitude:0] forKey:@"OBJECT 5"];
    [self setObject:[WorldCoordinate allocAndInitWithLatitude:LOC6LAT Longitude:LOC6LONG Altitude:0] forKey:@"OBJECT 6"];
//    [self setObject:[WorldCoordinate coordinateWithLatitude:LOC7LAT Longitude:LOC7LONG Altitude:0] forKey:@"OBJECT 7"];
    
    return self;
}

@end
