//
//  Unit Conversions.h
//  VWorld
//
//  Created by Mike Ellertson on 7/4/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#ifndef VWorld_Unit_Conversions_h
#define VWorld_Unit_Conversions_h

#define INIT_LONG   0.0;
#define INIT_SHORT  0.0f;

#include <stdio.h>
#include "Conversion Factors.h"

#pragma mark Typedefs

typedef double  radianLong;
typedef float   radianShort;
typedef double  degreesLong;
typedef float   degreesShort;

radianLong convertDegreesToRadians(degreesLong degrees);



#endif
