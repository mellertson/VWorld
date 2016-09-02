//
//  MyMathLibrary.h
//  VWorld
//
//  Created by Michael Ellertson on 4/14/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#ifndef VWorld_MyMathLibrary_h
#define VWorld_MyMathLibrary_h

#include <stdio.h>
#include <math.h>

#define GPS_MAX_LONGITUDE   180.0
#define GPS_MAX_LATITUDE    90.0
#define GPS_MIN_LONGITUDE   -180.0
#define GPS_MIN_LATITUDE    -90.0

/**
 Normalizes an inputted number (numberToNormalize) to fall within the specified range (normalizeRangeMin - normalizeRangeMax)
 
 <Longer description>
 <May span multiple lines or paragraphs as needed>
 
 @param  int dataSetMin
 @param  int dataSetMax
 @param  int normalizeRangeMin
 @param  int normalizeRangeMax
 @param  int numberToNormalize
 @return int normalizeInt
 */
int normalizeInt(int dataSetMin, int dataSetMax, int normalizedRangeMin, int normalizeRangeMax, int numberToNormalize);
float normalizeFloat(float dataSetMin, float dataSetMax, float normalizedRangeMin, float normalizeRangeMax, float numberToNormalize);
double normalizeDouble(double dataSetMin, double dataSetMax, double normalizedRangeMin, double normalizeRangeMax, double numberToNormalize);


#endif
