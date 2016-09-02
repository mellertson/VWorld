//
//  OpenGLViewController.h
//  TestOfContainerView
//
//  Created by Michael Ellertson on 1/23/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import "WorldCoordinate.h"
#import "ColorfulCube.h"
#import "Test Object Locations.h"
#import "AccelerometerFilter.h"         // Implements a low and high pass filters
#import "MyMathLibrary.h"
#import "ViewController.h"              // Allows OpenGLViewController to send messages to ViewController
#import "DatabaseOfWorldObjects.h"
#import "RiddleGenerator.h"

@interface OpenGLViewController : GLKViewController <CLLocationManagerDelegate, UIAlertViewDelegate> {
    GLuint vertexBufferID;
    NSString *currentColor;
    NSMutableDictionary *dbOfObjects; // The database of all object's GPS coordinates.  Stored as WorldCoordinate objects.
    NSMutableArray *objectsForRendering;    // The array of object's world coorindates, that will be rendered.  Stored as WorldObject objects.
    CLLocationManager *locMan;
    GLKVector3 downReferenceVector; // A vector pointing down, relative to the device's orientation.  i.e Portrait = (0, -1, 0)
    GLKMatrix4 rmX90, rmX180;   // rotation vectors
    short int viewableRadius;
    BOOL locServicesRunning;       // The state of the GPS and compass notifications from iOS
    Riddle *currentRiddle;
    
    GLKVector3 compassPoint;    // COMPASS heading
    GLKVector3 lookAtVector;    // Always points where the front camera is looking
    GLKVector3 upVector;        // Vector pointing straight up
}

@property (strong, nonatomic) GLKBaseEffect *baseEffect;
@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) CMAttitude *refAttitude;
@property (strong, nonatomic) CMAttitude *currentAttitude;
@property (readonly, nonatomic) WorldCoordinate *deviceCurrentGPSLocation;

#pragma mark GLKViewController Delegate Protocol Functions
//- (void)glkViewControllerUpdate:(GLKViewController *)controller;
- (void)update;
//- (void)glkViewController:(GLKViewController *)controller willPause:(BOOL)pause;

#pragma mark Child View Controller Callbacks
- (void)willMoveToParentViewController:(UIViewController *)parent;

#pragma mark Class Methods
- (NSMutableArray *)addObjectsToRenderingList:(NSMutableArray *)objectsToBeRendered witinRadius:(short int)radius fromGPSCoordinate:(WorldCoordinate *)gpsCoordinate usingDBOfObjects:(NSMutableDictionary *)localDBOfObjects;
- (NSMutableArray *)removeObjectsFromRenderingList:(NSMutableArray *)arrayObjectsToBeRendered fartherThanRadius:(short int)radius fromGPSCoordinate:(WorldCoordinate *)gpsCoordinate usingDBOfObjects:(NSMutableDictionary *)dictionaryAllObjects;
- (NSMutableArray *)removeAllObjectsFromRenderingList:(NSMutableArray *)arrayObjectsToBeRendered;
- (NSMutableArray *)reInitObjectsForRendering:(NSMutableArray *)objectsToBeRendered withinRadius:(short int)radius fromGPSCoordinate:(WorldCoordinate *)gpsCoordinate usingDBOfObjects:(NSMutableDictionary *)localDBOfObjects;
- (void)actionCalibrate;

@end








