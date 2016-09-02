//
//  myWorld Data Types.h
//  VWorld
//
//  Created by Michael Ellertson on 3/17/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#ifndef VWorld_myWorld_Data_Types_h
#define VWorld_myWorld_Data_Types_h


union _myWorldVector3
{
    struct { double x, y, z; };
    struct { double r, g, b; };
    struct { double s, t, p; };
    double v[3];
};
typedef union _myWorldVector3 myWorldVector3;

#endif