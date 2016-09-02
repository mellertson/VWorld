//
//  WorldCoordinate.m
//  VWorld
//
//  Created by Michael Ellertson on 3/19/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#import "WorldCoordinate.h"

@implementation WorldCoordinate

@synthesize latitude;
@synthesize longitude;
@synthesize altitudeAGL;

#pragma mark - Class Methods
#pragma mark

/**
 *  Convenience method to initialize and return a new instance of WorldCoordinate.
 *
 *  @param newLatitude    Latitude to initialize returned object with.
 *  @param newLongitude   Longitude to initialize returned object with.
 *  @param newAltitudeAGL Altitude to initialize returned object with.
 *
 *  @return A WorldCoordinate object that has been initialized with the inputted paramaters.
 */
+(id)allocAndInitWithLatitude:(CLLocationDegrees)newLatitude Longitude:(CLLocationDegrees)newLongitude Altitude:(CLLocationDistance)newAltitudeAGL {
    // Completed: 05/28/2014: unit test written and successfully executed.
     return [[WorldCoordinate alloc] initWithLatitude:newLatitude Longitude:newLongitude Altitude:newAltitudeAGL];
}

#pragma mark - Initialize
#pragma mark
- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        
    }
    return self;
}

- (id)initWithLatitude:(CLLocationDegrees)newLatitude Longitude:(CLLocationDegrees)newLongitude Altitude:(CLLocationDistance)newAltitudeAGL {
    if (self == nil) {
        self = [self init];
    }
    
    if (self) {
        return [self updateWithLatitude:newLatitude Longitude:newLongitude Altitude:newAltitudeAGL];
    }
    
    return self;
}

#pragma mark - Methods
#pragma mark

- (id)updateWithLatitude:(CLLocationDegrees)newLatitude Longitude:(CLLocationDegrees)newLongitude Altitude:(CLLocationDistance)newAltitudeAGL {
    //  COMPLETED: 04/14/2014: Unit tested in test case "test_feetFromLocation"
    latitude = newLatitude;
    longitude = newLongitude;
    altitudeAGL = newAltitudeAGL;
    
    return self;
}

// COMPLETE: 04/14/2014: Unit test feetFromLocation
// Returns distance between location and the object's location in feet correcting for curvature of the earth.
- (WCDistance)feetFromLocation:(const WorldCoordinate *)location {
    //degrees to radians
    double lat1rad = [location latitude] * M_PI/180;
    double lon1rad = [location longitude] * M_PI/180;
    double lat2rad = [self latitude] * M_PI/180;
    double lon2rad = [self longitude] * M_PI/180;
    
    //deltas
    double dLat = lat2rad - lat1rad;
    double dLon = lon2rad - lon1rad;
    
    double a = sin(dLat/2) * sin(dLat/2) + sin(dLon/2) * sin(dLon/2) * cos(lat1rad) * cos(lat2rad);
    double c = 2 * asin(sqrt(a));
    double R = 6372.8;
    double distance = R * c;
    
    distance = distance * CONVERT_KILOMETERS_TO_FEET;
    
    return distance;
}


// COMPLETED: 05/29/2014: This class uses only primitive member variables.  The NSCopying protocol isn't needed, so I'm commenting out the copyWithZone: method.
//- (id)copyWithZone:(NSZone *)zone {
////    [self copyWithZone:zone];
//    
//    id copy = [[[self class] alloc] init];
//    if (copy) {
//        // Copy primitives
//        [copy setLatitude:self.latitude];
//        [copy setLongitude:self.longitude];
//        [copy setAltitudeAGL:self.altitudeAGL];
//    }
//
//    return copy;
//}

@end











