//
//  ColorfulCube.m
//  Cube
//
//  Created by Michael Ellertson on 9/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// TODO: Create a way to init and get the object's unique World ID
// TODO: Synthesize worldObjectID;

#import "ColorfulCube.h"

//#define M_TAU (2*M_PI)

#define kDegreesToRadians 0.0174532925
#define kRadiansToDegrees 57.2957795

#pragma mark - Synthesize Variables
static BOOL initialized = NO;
static GLKVector3 vertices[8];
static GLKVector4 colors[8];
static GLKVector3 triangleVertices[36];
static GLKVector4 triangleColors[36];
//static GLKBaseEffect *effect;

@implementation ColorfulCube

@synthesize position, rotation, scale;
@synthesize rps;
@synthesize compassPoint;
@synthesize worldObjectID;

#pragma mark - Initialization, Deconstruction, and General Functions
+ (void)initialize {
    // Initializes the instance of the cube object
    // Sets the vertices and color of the object
    
    if (!initialized) {
        // *********************************************************************
        // Define the cubes 8 points (vertices)
        vertices[0] = GLKVector3Make(-0.5, -0.5,  0.5); // Left  bottom front
        vertices[1] = GLKVector3Make( 0.5, -0.5,  0.5); // Right bottom front
        vertices[2] = GLKVector3Make( 0.5,  0.5,  0.5); // Right top    front
        vertices[3] = GLKVector3Make(-0.5,  0.5,  0.5); // Left  top    front
        vertices[4] = GLKVector3Make(-0.5, -0.5, -0.5); // Left  bottom back
        vertices[5] = GLKVector3Make( 0.5, -0.5, -0.5); // Right bottom back
        vertices[6] = GLKVector3Make( 0.5,  0.5, -0.5); // Right top    back
        vertices[7] = GLKVector3Make(-0.5,  0.5, -0.5); // Left  top    back
        
        // *********************************************************************
        // Define the cubes colors for each of the eight points
        colors[0] = GLKVector4Make(1.0, 0.0, 0.0, 1.0); // Red
        colors[1] = GLKVector4Make(1.0, 0.0, 0.0, 1.0); // Red
        colors[2] = GLKVector4Make(0.0, 0.0, 1.0, 1.0); // Blue
        colors[3] = GLKVector4Make(0.0, 0.0, 1.0, 1.0); // Blue
        colors[4] = GLKVector4Make(1.0, 0.0, 0.0, 1.0); // Red
        colors[5] = GLKVector4Make(1.0, 0.0, 0.0, 1.0); // Red
        colors[6] = GLKVector4Make(0.0, 0.0, 1.0, 1.0); // Blue
        colors[7] = GLKVector4Make(0.0, 0.0, 1.0, 1.0); // Blue
        
        // *********************************************************************
        // Define the object using triangles, using indices of the objects vertices
        // so OpenGL can render the vertices in the right order.
        int vertexIndices[36] = {
            // Front
            0, 1, 2,
            0, 2, 3,
            // Right
            1, 5, 6,
            1, 6, 2,
            // Back
            5, 4, 7,
            5, 7, 6,
            // Left
            4, 0, 3,
            4, 3, 7,
            // Top
            3, 2, 6,
            3, 6, 7,
            // Bottom
            4, 5, 1,
            4, 1, 0,
        };
        for (int i = 0; i < 36; i++) {
            triangleVertices[i] = vertices[vertexIndices[i]];
            triangleColors[i] = colors[vertexIndices[i]];
        }
        
        // *********************************************************************
        // initialize the GLKBaseEffect object
//        effect = [[GLKBaseEffect alloc] init];
        
        initialized = YES;
    }
}

// Initialize the instance
- (id)init
{
    self = [super init];
    worldObjectID = [[NSString alloc] init];
    if (self) {
        position = GLKVector3Make(0,0,0);
        rotation = GLKVector3Make(0,0,0);
        scale    = GLKVector3Make(1,1,1);
    }
    
    // ****************************************
    // Initialize the view ports default direction
    lookAt.x = 0; lookAt.y = 0; lookAt.z = -1;

    // ****************************************
    // Initialize the 90 degree rotatation for the view port correction
//    ViewPortCorrection = GLKVector3Make(0, 0, -1);
    upNinety = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(-90), 1, 0, 0);
    
    upValue = GLKVector3Make(0, 1, 0);
    
    return self;
}

#pragma mark - Application Logic Functions
- (void)updateTimeSinceUpdate:(NSTimeInterval)dt {
    rotation = GLKVector3Add(rotation, GLKVector3MultiplyScalar(rps, dt));
}

- (void)updateLookAtVector:(GLKVector3)newLookAtVector {
    lookAt = newLookAtVector;
}

- (void)updateCameraPosition:(GLKVector3)newCameraPosition {
    cameraPosition = newCameraPosition;
}


-(ColorfulCube *)updateOpenGLPositionUsingDeviceGPSCoordinate:(WorldCoordinate *)deviceGPSCoordinate
                  usingViewableRadius:(short int)radius
                     usingDBOfObjects:(NSMutableDictionary *)dbOfObjects
{
    // local variables
    WorldCoordinate *worldCoordinate;
    CLLocationDegrees minLat, maxLat, minLong, maxLong;

    minLat = deviceGPSCoordinate.latitude - GPS_QUANTITY_LATITUDE_1_FOOT * radius;
    maxLat = deviceGPSCoordinate.latitude + GPS_QUANTITY_LATITUDE_1_FOOT * radius;
    minLong = deviceGPSCoordinate.longitude - GPS_QUANTITY_LATITUDE_1_FOOT * radius;
    maxLong = deviceGPSCoordinate.longitude + GPS_QUANTITY_LATITUDE_1_FOOT * radius;
    
    // 1.1 lookup this object's gpsCoordinates using the dbOfObjects
    worldCoordinate = [dbOfObjects objectForKey:self.worldObjectID];
    
    // 1.2 update this object's new OpenGL coordinates using deviceGPSCoodinate
    position.z = normalizeDouble(minLat, maxLat,  -(radius), radius, worldCoordinate.latitude);
    position.x = normalizeDouble(minLong, maxLong, -(radius), radius, worldCoordinate.longitude);
    
    return self;
}

// *******************************************************************************
// TO DO: Optimize this function by making upValue a class variable
// and call updateUpValue only once from the application class (CubeAppDelegate)
// DESCRIPTION: Update the vector used to determine:
//                  1) Gravity's vector (oposite of upValue)
//                  2) Vertical angle of the device (i.e. device is tilted upward or downward)
- (void)updateUpValue:(GLKVector3)newUpValue {
    downVector = upValue = newUpValue;
    downVector.y = -(downVector.y);
}

- (void)updateCompassPoint:(GLKVector3)newCompassPoint {
    compassPoint = newCompassPoint;
}

#pragma mark - OpenGL Functions
// Method which draws the cube in OpenGL
- (void)draw:(id)effectID {
    GLKBaseEffect *effect = (GLKBaseEffect *)effectID;
    NSAssert([effect isKindOfClass:[GLKBaseEffect class]], @"Something went wrong hommie!!  effect isn't of class GLKBaseEffect.");

    // ********************************************************************************************
    // ******************** Rotate, Scale, and Move the 3D Object *********************************
    // ********************************************************************************************
    GLKMatrix4 xRotationMatrix = GLKMatrix4MakeXRotation(rotation.x);       // Object's initial x rotation
    GLKMatrix4 yRotationMatrix = GLKMatrix4MakeYRotation(rotation.y);       // Object's initial y rotation
    GLKMatrix4 zRotationMatrix = GLKMatrix4MakeZRotation(rotation.z);       // Object's initial y rotation
    GLKMatrix4 scaleMatrix     = GLKMatrix4MakeScale(scale.x, scale.y, scale.z);    // Object's initial scale
    GLKMatrix4 translateMatrix = GLKMatrix4MakeTranslation(position.x, position.y, position.z);     // Object's initial position
    GLKMatrix4 modelMatrix = GLKMatrix4Multiply(translateMatrix,
                             GLKMatrix4Multiply(scaleMatrix,
                             GLKMatrix4Multiply(zRotationMatrix, 
                             GLKMatrix4Multiply(yRotationMatrix, 
                                                xRotationMatrix))));

    // ********************************************************************************************
    // ********************* Change the model view and projection matrices ************************
    // *********************    to include the effects of gravity and      ************************
    // *********************          camera view changes                  ************************
    // ********************************************************************************************
    // View Matrix (Look At Matrix)
//    NSLog(@"ColofulCube --------------------------------");
//    NSLog(@"Draw function");
//    NSLog(@"lookAt.x = %f     lookAt.y = %f     lookAt.z = %f", lookAt.x, lookAt.y, lookAt.z);
//    lookAt = GLKMatrix4MultiplyVector3(upNinety, downVector);     // NOTE: commented out on 2/8/2013 when implementing rotation of LookAt around Y Axis in recieveAccelerometerUpdates method
//    NSLog(@"90 Degree Rotation Applied to lookAt:  lookAt.x = %f     lookAt.y = %f     lookAt.z = %f", lookAt.x, lookAt.y, lookAt.z);
//    NSLog(@"compassPoint.x = %f     compassPoint.y = %f     compassPoint.z = %f", compassPoint.x, compassPoint.y, compassPoint.z);
//    lookAt.y = -(lookAt.y);   // NOTE: commented out on 2/8/2013 when implementing rotation of LookAt around Y Axis in recieveAccelerometerUpdates method
//    lookAt = GLKVector3Multiply(lookAt, compassPoint);
//    NSLog(@"Compass Vector Applied to lookAt:      lookAt.x = %f     lookAt.y = %f     lookAt.z = %f", lookAt.x, lookAt.y, lookAt.z);
    // -------- Version 1 ----------
//    GLKMatrix4 viewMatrix = GLKMatrix4MakeLookAt(0, 0, 0,       // Camera's position
//                                                 0, 0, -2,      // Look At position
//                                                 0, 1, 0);      // "Up" orientation of the camera
    
    
//    // --------- Version 2 ---------
//    GLKMatrix4 viewMatrix = GLKMatrix4MakeLookAt(0, 0, 0,               // Camera's position
//                                                 vp.x,vp.y, vp.z,       // Look At position
//                                                 upValue.x, upValue.y, upValue.z);              // "Up" orientation of the camera
    // --------- Version 3 ------------------------------------------------------------------------------------------------
    // Version 3 includes integration with the compass and accelerometer.  When the device is rotated left and right, the compass
    // cube moves left and right.  When the device is tilted up and down, the accelerometer data moves the cube up and down.
    // --------------------------------------------------------------------------------------------------------------------
//    NSLog(@"lookAt.X = %f     Y = %f     Z = %f", compassPoint.x, 0.0f, compassPoint.z);
    GLKMatrix4 viewMatrix = GLKMatrix4MakeLookAt(0.0f, 0.0f, 0.0f,               // Camera's position, center of OpenGL coordinate system
                                                 compassPoint.x, 0.0f, compassPoint.z,       // Look At position
                                                 upValue.x, upValue.y, upValue.z);              // "Up" orientation of the camera


    // ********************************************************************************************
    // *****                                Model View Matrix                               *******
    // ********************************************************************************************
    effect.transform.modelviewMatrix = GLKMatrix4Multiply(viewMatrix, modelMatrix);
    
    // ********************************************************************************************
    // *****                                Projection Matrix                               *******
    // ********************************************************************************************
    effect.transform.projectionMatrix = GLKMatrix4MakePerspective(0.125*M_TAU,  // The camera's viewing angle
                                                                  2.0/3.0,      // Screen width-to-height ratio
                                                                  1, DEFAULT_VIEWABLE_RADIUS_D);   // Draw objects 1-10 units from the eye position
    
    // ********************************************************************************************
    // ************************ Draw the object using OpenGL functions ****************************
    // ********************************************************************************************
    [effect prepareToDraw];    // MARK: Investigate whether this call is necessary.  It's already been called in glkView:drawInRect.
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, triangleVertices);
    
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, triangleColors);
    
    glDrawArrays(GL_TRIANGLES, 0, 36);  // Draw 36 triangles.
    
    glDisableVertexAttribArray(GLKVertexAttribPosition);
    glDisableVertexAttribArray(GLKVertexAttribColor);
}

@end








