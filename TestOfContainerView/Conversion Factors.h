//
//  Conversion Factors.h
//  VWorld
//
//  Created by Michael Ellertson on 3/25/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#ifndef VWorld_Conversion_Factors_h
#define VWorld_Conversion_Factors_h

#pragma mark - Convert Angles
#define CONVERT_DEGREES_TO_RADIANS      0.0174532925
#define CONVERT_RADIANS_TO_DEGREES      57.2957795

#pragma mark - Convert Distances
#define CONVERT_KILOMETERS_TO_MILES     .62137
#define CONVERT_MILES_TO_KILOMETERS     1.609344
#define CONVERT_METERS_TO_FEET          3.2808
#define CONVERT_FEET_TO_METERS          0.3048
#define CONVERT_KILOMETERS_TO_FEET      3280.8399

#pragma mark - Constant Distances
#define EARTH_RADIUS_KILOMETERS         6371
#define EARTH_RADIUS_KILOMETERS_EQUATOR 6378.16
#define EARTH_RADIUS_KILOMETERS_POLES   6357.715
#define EARTH_DIAMETER_KILOMETERS       12742
#define EARTH_RADIUS_MILES              3958
#define EARTH_DIAMETER_MILES            7917
#define EARTH_RADIUS_FEET               20903520            // TODO: double check this conversion factor to make sure it's accurate.
#define EARTH_DIAMETER_FEET             41807040
#define FEET_IN_A_MILE                  5280

#pragma mark - GPS to Distance Quantities
#define GPS_QUANTITY_LATITUDE_100_FEET   0.000164576371665739    // Add/subtract this value to a GPS Latitude to increment/decrement GPS coordinate by 100 feet
#define GPS_QUANTITY_LATITUDE_1_FOOT     0.000001645763716657    // Add/subtract this value to a GPS Latitude to increment/decrement GPS coordinate by 1 foot
#define GPS_QUANTITY_LONGITUDE_100_FEET  0.000196233889332871    // Add/subtract this value to a GPS Longitude to increment/decrement GPS coordinate by 100 feet
#define GPS_QUANTITY_LONGITUDE_1_FOOT    0.000001962338893328    // Add/subtract this value to a GPS Longitude to increment/decrement GPS coordinate by 1 foot


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Other global defines, couldn't find the right place to put these, so I put them here.
#define M_180_OVER_PI 57.29577951308233         // 180 degrees divided by PI.  Number of degrees in 1 radian

#define DEFAULT_VIEWABLE_RADIUS_F     100.0f    // 100 feet
#define DEFAULT_VIEWABLE_RADIUS_D     100.0     // 100 feet
#define DEFAULT_VIEWABLE_RADIUS_I     100       // 100 feet


#endif

