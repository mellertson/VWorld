//
//  Cube and GPS Locations.h
//  VWorld
//
//  Created by Michael Ellertson on 3/1/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#ifndef VWorld_Cube_and_GPS_Locations_h
#define VWorld_Cube_and_GPS_Locations_h


//---------------------------------------------------------------------------
//----- Normalization factor for cube locations, GPS and Cube Locations
#define NORMALIZE_GPS_DATA 10000.0f

#define GPS_X_LOCATION_TI_CONDO 33.0000f       // 33.762616, -117.934505
#define GPS_Y_LOCATION_TI_CONDO -117.0000f     // 33.762616, -117.934505

#define CUBE_X_LOCATION_1 33.0000f
#define CUBE_Y_LOCATION_1 -117.0005f
#define CUBE_X_LOCATION_2 33.0000f
#define CUBE_Y_LOCATION_2 -117.0010f
#define CUBE_X_LOCATION_3 33.0000f
#define CUBE_Y_LOCATION_3 -117.0050f
#define CUBE_X_LOCATION_4 33.0000f
#define CUBE_Y_LOCATION_4 -117.0100f

//---------------------------------------------------------------------------
// Equal to circumference of a circle
#define M_TAU (2.0f* M_PI)
#define M_DEGREE (M_TAU / 360.0f)

//---------------------------------------------------------------------------
// Conversion factors for degrees and radians
#define kDegreesToRadians 0.0174532925f
#define kRadiansToDegrees 57.2957795f


#endif
