//
//  MyMathLibrary.c
//  VWorld
//
//  Created by Michael Ellertson on 4/14/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#include "MyMathLibrary.h"

/**
 Normalizes an inputted number (numberToNormalize) to fall within the specified range (normalizeRangeMin - normalizeRangeMax)
 
 <Longer description>
 <May span multiple lines or paragraphs as needed>
 
 @param  int dataSetMin
 @param  int dataSetMax
 @param  int normalizeRangeMin
 @param  int normalizeRangeMax
 @param  int numberToNormalize
 @return normalized integer
 */
int normalizeInt(int dataSetMin, int dataSetMax, int normalizedRangeMin, int normalizeRangeMax, int numberToNormalize) {
    
    return normalizedRangeMin + (numberToNormalize - dataSetMin) * (normalizeRangeMax - normalizedRangeMin) / (dataSetMax - dataSetMin);
}

/**
 Normalizes an inputted number (numberToNormalize) to fall within the specified range (normalizeRangeMin - normalizeRangeMax)
 
 <Longer description>
 <May span multiple lines or paragraphs as needed>
 
 @param  float dataSetMin
 @param  float dataSetMax
 @param  float normalizeRangeMin
 @param  float normalizeRangeMax
 @param  float numberToNormalize
 @return normalized float
 */
float normalizeFloat(float dataSetMin, float dataSetMax, float normalizedRangeMin, float normalizeRangeMax, float numberToNormalize) {
    return normalizedRangeMin + (numberToNormalize - dataSetMin) * (normalizeRangeMax - normalizedRangeMin) / (dataSetMax - dataSetMin);
}

/**
 Normalizes an inputted number (numberToNormalize) to fall within the specified range (normalizeRangeMin - normalizeRangeMax)
 
 <Longer description>
 <May span multiple lines or paragraphs as needed>
 
 @param  double dataSetMin
 @param  double dataSetMax
 @param  double normalizeRangeMin
 @param  double normalizeRangeMax
 @param  double numberToNormalize
 @return normalized double
 */
double normalizeDouble(double dataSetMin, double dataSetMax, double normalizedRangeMin, double normalizeRangeMax, double numberToNormalize) {
    return normalizedRangeMin + (numberToNormalize - dataSetMin) * (normalizeRangeMax - normalizedRangeMin) / (dataSetMax - dataSetMin);
}


