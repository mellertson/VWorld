//
//  WorldCoordinate.h
//  VWorld
//
//  Created by Michael Ellertson on 3/19/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Conversion Factors.h"
#import "Unit Conversions.h"
#import "Haversine.h"

typedef double WCDistance;

// COMPLETED: 05/29/2014: Removing adoption of NSCopying protocol, because this class only uses primitive member variables.
@interface WorldCoordinate : NSObject
{
    CLLocationDegrees latitude;
    CLLocationDegrees longitude;
    CLLocationDegrees altitudeAGL;
}

- (id)init;

#pragma mark - Methods
#pragma mark
- (id)updateWithLatitude:(CLLocationDegrees)newLatitude Longitude:(CLLocationDegrees)newLongitude Altitude:(CLLocationDistance)newAltitudeAGL;
- (id)initWithLatitude:(CLLocationDegrees)newLatitude Longitude:(CLLocationDegrees)newLongitude Altitude:(CLLocationDistance)newAltitudeAGL;
- (WCDistance)feetFromLocation:(const WorldCoordinate *)location;
//- (id)copyWithZone:(NSZone *)zone;
+(id)allocAndInitWithLatitude:(CLLocationDegrees)newLatitude Longitude:(CLLocationDegrees)newLongitude Altitude:(CLLocationDistance)newAltitudeAGL;

#pragma mark - Properties
#pragma mark
@property (nonatomic) CLLocationDegrees  latitude;
@property (nonatomic) CLLocationDegrees  longitude;
@property (nonatomic) CLLocationDistance altitudeAGL;


@end
