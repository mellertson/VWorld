//
//  ColorfulCube.h
//  Cube
//
//  Created by Michael Ellertson on 9/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "Conversion Factors.h"
#import "WorldObject.h"
#import "MyMathLibrary.h"

// Equal to circumference of a circle
#define M_TAU (2 * M_PI)
#define M_DEGREE (M_TAU / 360)




@interface ColorfulCube : NSObject {
    GLKVector3 position, rotation, scale;
    GLKVector3 rps; // revolutions per second
    GLKVector3 downVector;  // Vector pointing toward gravity
    GLKMatrix4 upNinety;
    WCObjectID *worldObjectID;
    
    GLKVector3 cameraPosition;
    GLKVector3 lookAt; // TODO: repurpose vp.  currently vp.y is used in lookAt vector
    GLKVector3 compassPoint;  // TODO: Repurpose compassPoint.  See next line for full explanation.
    // currently used as X and Z values of lookAt vecor.  But the calculations on compassPoint should be done
    // in the application logic, not in the rendering engine.  The application should pass over the lookAt vecor
    // and combine the compass and accelerometer data before it passes it into the rendering engine as the lookAt vector.
    GLKVector3 upValue;  // Vector pointing up
    

}

@property GLKVector3 position, rotation, scale;
@property GLKVector3 rps;
@property GLKVector3 compassPoint;
@property (strong, nonatomic) WCObjectID *worldObjectID;

- (void)updateTimeSinceUpdate:(NSTimeInterval)dt;
- (void)updateLookAtVector:(GLKVector3)newLookAtVector;
- (void)updateUpValue:(GLKVector3)newUpValue;
- (void)updateCompassPoint:(GLKVector3)newCompassPoint;
- (void)draw:(GLKBaseEffect *)effect;
-(ColorfulCube *)updateOpenGLPositionUsingDeviceGPSCoordinate:(WorldCoordinate *)deviceGPSCoordinate usingViewableRadius:(short int)radius usingDBOfObjects:(NSMutableDictionary *)dbOfObjects;


@end



