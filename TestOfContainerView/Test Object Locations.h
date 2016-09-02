//
//  Test Object Locations.h
//  VWorld
//
//  Created by Michael Ellertson on 3/19/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#ifndef VWorld_Test_Object_Locations_h
#define VWorld_Test_Object_Locations_h

#import "Conversion Factors.h"

//////////////////////////////////////////////////
// +Latitude moves South
// -Latitude moves North
// +Longitude moves East
// -Longitude moves West
//////////////////////////////////////////////////

//#define LOC1LAT     33.71238
//#define LOC1LONG    -118.042334
//#define LOC1LAT     44.813485               // 163 5th Ave, Granite Falls, MN
//#define LOC1LONG    -95.538746
//#define LOC1LAT     33.712384               // Gene's House @ Seapine Circle
//#define LOC1LONG    -118.042353
//#define LOC1LAT     40.304130               // keara's back yard
//#define LOC1LONG   -111.676170              // keara's back yard

#define LOC1LAT     33.717369            // Pacific Shores Directly Behind BMW Parking
#define LOC1LONG   -117.993327           // Pacific Shores Directly Behind BMW Parking
#define LOC2LAT     33.717373       // 101.35 feet east
#define LOC2LONG    -117.992993

#define LOC3LAT     33.717407       // 55.18 feet east
#define LOC3LONG    -117.993151

#define LOC4LAT     33.717414       // 210.33 feet east
#define LOC4LONG    -117.992636
#define LOC5LAT     33.717416       // 81.92 feet west
#define LOC5LONG    -117.993591
#define LOC6LAT     33.717398       // 153.90 feet west
#define LOC6LONG    -117.993833

#define LOC7LAT     33.717395
#define LOC7LONG   -117.993151

//#define LOC7LAT     40.304323            // Keara's Front Living Room
//#define LOC7LONG   -111.676576           // Keara's Front Living Room

#define CAMERA_TEST_POSITION1LAT     LOC1LAT                                            // OpenGL Coordinate z=0
#define CAMERA_TEST_POSITION1LONG    LOC1LONG                                           // OpenGL Coordinate x=0
#define CAMERA_TEST_POSITION2LAT     LOC1LAT + GPS_QUANTITY_LATITUDE_1_FOOT * 20        // OpenGL Coordinate z=+20
#define CAMERA_TEST_POSITION2LONG    LOC1LONG                                           // OpenGL coordinate x=0
#define CAMERA_TEST_POSITION3LAT     LOC1LAT + GPS_QUANTITY_LATITUDE_1_FOOT * 20        // OpenGL Coordinate z=+20
#define CAMERA_TEST_POSITION3LONG    LOC1LONG - GPS_QUANTITY_LONGITUDE_1_FOOT * 60      // OpenGL Coordinate x=-60

// TODO: Fix the following two defines so they aren't based on LOC1's values
#define TC3_MAX_LONGITUDE LOC1LONG + GPS_QUANTITY_LONGITUDE_100_FEET
#define TC3_MIN_LONGITUDE LOC1LONG - GPS_QUANTITY_LONGITUDE_100_FEET

#define TC3_MAX_LATITUDE LOC1LAT + GPS_QUANTITY_LATITUDE_100_FEET
#define TC3_MIN_LATITUDE LOC1LAT - GPS_QUANTITY_LATITUDE_100_FEET


#endif
