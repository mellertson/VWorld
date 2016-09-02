//
//  OpenGLViewController.m
//  TestOfContainerView
//
//  Created by Michael Ellertson on 1/23/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#import "OpenGLViewController.h"

@interface OpenGLViewController ()

@end

@implementation OpenGLViewController
@synthesize baseEffect;
@synthesize motionManager;
@synthesize refAttitude;
@synthesize currentAttitude;
@synthesize deviceCurrentGPSLocation;

/////////////////////////////////////////////////////////////////
// This data type is used to store information for each vertex
typedef struct {
    GLKVector3  positionCoords;
}
SceneVertex;

/////////////////////////////////////////////////////////////////
// Define vertex data for a triangle to use in example
static const SceneVertex vertices[] =
{
    {{-0.5f, -0.5f, 0.0}}, // lower left corner
    {{ 0.5f, -0.5f, 0.0}}, // lower right corner
    {{-0.5f,  0.5f, 0.0}}  // upper left corner
};

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initLocalVariables {
    // COMPLETED: 5/27/2014: No test case needed at this time
    compassPoint = GLKVector3Make(0, 0, 0);
    currentColor = @"blue";
    dbOfObjects = [[NSMutableDictionary alloc] init];
    [dbOfObjects populateWithDatabaseObjects];
    objectsForRendering = [[NSMutableArray alloc] init];
    deviceCurrentGPSLocation = [[WorldCoordinate alloc] init];
    viewableRadius = DEFAULT_VIEWABLE_RADIUS_I;
    locServicesRunning = FALSE;
    currentRiddle = [[Riddle alloc] init];
    [self setPaused:NO];    // Make sure view controller's update loop runs

    // ---------------- Set Attributes of View -----------------------
    self.view.opaque = NO;
    self.view.backgroundColor = [UIColor clearColor];
    self.view.alpha = 1;
    
    // ---------------- Init Rotation Vectors  -----------------------
    rmX90 = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(-90), 1, 0, 0);
    rmX180 = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(-180), 1, 0, 0);
    
    // ---------------- Init the down reference vector based on device's orientation -----------
    if (1 == 1) { 
        downReferenceVector = GLKVector3Make(0, -1, 0);
    }
}

- (void)initOpenGL {
    // COMPLETED: 5/28/2014: No test case needed at this time.
    GLKView *view = (GLKView *)self.view;
    NSAssert([view isKindOfClass:[GLKView class]], @"OpenGLViewController's view isn't a GLKView");
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];   // Initialize the OpenGL context
    
    [EAGLContext setCurrentContext:view.context];   // Set the current context
    
    // Create a base effect that provides standard OpenGL ES 2.0
    // Shading Language programs and set constants to be used for
    // all subsequent rendering
    self.baseEffect = [[GLKBaseEffect alloc] init];
    //    self.baseEffect.useConstantColor = GL_TRUE;
    //    self.baseEffect.constantColor = GLKVector4Make(
    //                                                   0.0f, // Red
    //                                                   0.0f, // Green
    //                                                   1.0f, // Blue
    //                                                   1.0f);// Alpha
    
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f); // Set OpenGL's background color
    self.preferredFramesPerSecond = 30;     // Set preferred frames per second to 30
}

- (NSMutableArray *)removeObjectsFromRenderingList:(NSMutableArray *)arrayObjectsToBeRendered
                                 fartherThanRadius:(short int)radius
                                 fromGPSCoordinate:(WorldCoordinate *)gpsCoordinate
                                  usingDBOfObjects:(NSMutableDictionary *)dictionaryAllObjects
{
    // local variables
    WorldCoordinate *currentObjectsWorldCoordinate;
    ColorfulCube *colorfulCubeObject;
    WCDistance feetFromGPSCoordinate;
    
    // TODO: Unit test this function
    
    // Remove objects from rendering that are outside the viewable radius
    if ([arrayObjectsToBeRendered count] > 0) {
        for (id objectID in [arrayObjectsToBeRendered copy]) {
            colorfulCubeObject = objectID;
            currentObjectsWorldCoordinate = [dictionaryAllObjects objectForKey:colorfulCubeObject.worldObjectID];
            
            // See if the worldCoordinate is outside of the viewableRadius.  If it is then
            // remove the ColorfulCube object from objectsForRendering.
            feetFromGPSCoordinate = [currentObjectsWorldCoordinate feetFromLocation:gpsCoordinate];
            // TODO: NEXT STEP: Bug found at previous line.  Method feetFromLocation is returning incorrect values.  
            if (feetFromGPSCoordinate > radius) {
                [arrayObjectsToBeRendered removeObject:colorfulCubeObject];
            }
        }
    }
    
    return arrayObjectsToBeRendered;
}

- (NSMutableArray *)removeAllObjectsFromRenderingList:(NSMutableArray *)arrayObjectsToBeRendered
{
    // local variables
    ColorfulCube *colorfulCubeObject = nil;
    
    if (arrayObjectsToBeRendered == nil) {
        return nil;
    }
    
    if([arrayObjectsToBeRendered count] > 0)
    {
        for (id objectID in [arrayObjectsToBeRendered copy]) {
            colorfulCubeObject = objectID;
            
            [arrayObjectsToBeRendered removeObject:colorfulCubeObject];
        }
    }

    return arrayObjectsToBeRendered;
}

/**
 *  Adds ColorfulCube objects to the array of objects to be rendered.  Only objects
 *
 *  Returns an array of ColorfulCube objects within the radius from the gps coordinate.  ColorfulCube.position will be normalized to OpenGL space.
 *
 *  @param objectsRenderingList Working list of objects to be rendered
 *  @param radius               Objects within this viewable radius (in feet) will be rendered.
 *  @param gpsCoordinate        Objects within radius feet of this gps coordinate will be rendered.
 *  @param localDBOfObjects     The database of objects's gps coordinates, from which the rendering list will be created.
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)addObjectsToRenderingList:(NSMutableArray *)objectsToBeRendered
                                  witinRadius:(short int)radius
                            fromGPSCoordinate:(WorldCoordinate *)gpsCoordinate
                             usingDBOfObjects:(NSMutableDictionary *)localDBOfObjects
{
    // TODO: COMPLETED: 5/29/2014 Unit test this method and the removeObjectsFromRenderingList method
    
    // local variables
    WorldCoordinate *currentObjectsWorldCoordinate;
    ColorfulCube *current3DObject;
    NSString *currentWCoordinatesID;
//    float openGLZ, openGLX;
    BOOL bAddCurrentObjectToList;
    
    // add objects that are now in range
    for (id key in localDBOfObjects)
    {
        currentWCoordinatesID = key;
        bAddCurrentObjectToList = TRUE;
        
        // If the current key is already in objectsForRendering, don't add it again.
        for (id objectID in objectsToBeRendered)
        {
            current3DObject = (ColorfulCube *)objectID;
            if ([currentWCoordinatesID isEqualToString:current3DObject.worldObjectID])
            {
                bAddCurrentObjectToList = FALSE; // The current world coordinate is already in the rendering objects, don't add it again
                break;
            }
        }
        if(!bAddCurrentObjectToList)
            continue;
        
        id value = [localDBOfObjects objectForKey:key];
        currentObjectsWorldCoordinate = (WorldCoordinate *)value;
        
        // See if the worldCoordinate is inside of the viewableRadius.  If it is then add it to objectsForRendering.
        if ([currentObjectsWorldCoordinate feetFromLocation:gpsCoordinate] <= radius)
        {
            // The object is inside the vieableRadius, convert to OpenGL coordinates and add it to objectsForRendering.
            ColorfulCube *threeDObject = [[ColorfulCube alloc] init];
            
            // TODO: Alter the following 2 lines so the first two arguments use the current camera's position to
            //       calculate the min_latitude and max_latitude
            // TODO: BUG FOUND: Add another method, which accepts the device's current gps coordinates and ColorfulCube object as an input, and uses it to calculate the min_latitude and max_latitude
            //       and updates the ColorfulCube's position property using the normalizeDouble() function to compute the ColorfulCube's Z and X values.
            // Normalize OpenGLX and OpenGLZ to be in the range of +/-100
//            openGLZ = normalizeDouble(TC3_MIN_LATITUDE,  TC3_MAX_LATITUDE,  -(DEFAULT_VIEWABLE_RADIUS_D), DEFAULT_VIEWABLE_RADIUS_D, currentObjectsWorldCoordinate.latitude);
//            openGLX = normalizeDouble(TC3_MIN_LONGITUDE, TC3_MAX_LONGITUDE, -(DEFAULT_VIEWABLE_RADIUS_D), DEFAULT_VIEWABLE_RADIUS_D, currentObjectsWorldCoordinate.longitude);
            
            // Init threeDObject object and add to objectsForRendering
            threeDObject.worldObjectID = (WCObjectID *)key;
            [threeDObject updateOpenGLPositionUsingDeviceGPSCoordinate:gpsCoordinate usingViewableRadius:radius usingDBOfObjects:localDBOfObjects];
            threeDObject.scale      = GLKVector3Make(1.0f, 1.0f, 1.0f);
            threeDObject.rotation   = GLKVector3Make(0.0f, 0.0f, 0.0f);
            threeDObject.rps        = GLKVector3Make(0.25f, 0.5f, 0.10f);
            threeDObject.worldObjectID = currentWCoordinatesID;
            [objectsToBeRendered addObject:threeDObject];
            
            threeDObject = nil;
        }
    }
    
    return objectsToBeRendered;
}

/**
 *   Initialize objectsForRendering.  Using localDBOfObjects, determine how far away gpsCoordinate is from each 3D object, and add it to objectsForRendering if it's within the viewable radius.
 *
 *  @param localObjectsRenderingList Working list of objects to be rendered
 *  @param radius                    Objects within this viewable radius (in feet) will be rendered.
 *  @param gpsCoordinate             Objects within radius feet of this gps coordinate will be rendered.
 *  @param localDBOfObjects          The database of objects's gps coordinates, from which the rendering list will be created.
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)reInitObjectsForRendering:(NSMutableArray *)objectsToBeRendered
                               withinRadius:(short int)radius
                          fromGPSCoordinate:(WorldCoordinate *)gpsCoordinate
                           usingDBOfObjects:(NSMutableDictionary *)localDBOfObjects
{
    // 1.1: Remove all 3D objects from objectForRenderingList
    objectsToBeRendered = [self removeAllObjectsFromRenderingList:objectsToBeRendered];

    // add objects to the rendering list, which are within the viewable radius
    objectsToBeRendered = [self addObjectsToRenderingList:objectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsCoordinate usingDBOfObjects:localDBOfObjects];
    
    return objectsToBeRendered;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self initLocalVariables];
    
    [self turnOnCompassNotifications];
    
    [self initMotionManager];
    
    [self initOpenGL];  // Initialize the OpenGL context and set the clear color
}

- (void)generateBuffersForSingleTriangle {
    // Generate, bind, and initialize contents of a buffer to be
    // stored in GPU memory
    glGenBuffers(1, &vertexBufferID);
    glBindBuffer(GL_ARRAY_BUFFER,  // STEP 2
                 vertexBufferID);
    glBufferData(                  // STEP 3
                 GL_ARRAY_BUFFER,  // Initialize buffer contents
                 sizeof(vertices), // Number of bytes to copy
                 vertices,         // Address of bytes to copy
                 GL_STATIC_DRAW);  // Hint: cache in GPU memory
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Make the view's context current
    GLKView *view = (GLKView *)self.view;
    [EAGLContext setCurrentContext:view.context];
    
    // Delete buffers that aren't needed when view is unloaded
    if (0 != vertexBufferID)
    {
        glDeleteBuffers (1,          // STEP 7
                         &vertexBufferID);
        vertexBufferID = 0;
    }
    
    // Stop using the context created in -viewDidLoad
    ((GLKView *)self.view).context = nil;
    [EAGLContext setCurrentContext:nil];
    
    objectsForRendering = nil;
    dbOfObjects = nil;
    [self setMotionManager:nil];
    deviceCurrentGPSLocation = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    RiddleGenerator *riddleGenerator = [[RiddleGenerator alloc] init];
    currentRiddle = [riddleGenerator getNewRiddle];
    
    UIAlertView *alertDialog;
	alertDialog = [[UIAlertView alloc]
                   initWithTitle: @"Riddle Me This!"
                   message:currentRiddle.question
                   delegate: self
                   cancelButtonTitle: @"Ok"
                   otherButtonTitles: nil];
    alertDialog.alertViewStyle=UIAlertViewStylePlainTextInput;
	[alertDialog show];
//    int iRed, iGreen, iBlue;
    
//    if ([currentColor isEqualToString:@"blue"]) {
//        currentColor = @"green";
//        iRed = 0; iGreen = 1; iBlue = 0;
//    } else if ([currentColor isEqualToString:@"green"]) {
//        currentColor = @"red";
//        iRed = 1; iGreen = 0; iBlue = 0;
//    } else if ([currentColor isEqualToString:@"red"]) {
//        currentColor = @"blue";
//        iRed = 0; iGreen = 0; iBlue = 1;
//    }
    
//    if (locServicesRunning) {
//        [self pauseLocationServices];
//    }else {
//        [self startLocationServices];
//    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *answer;
    
    if ([alertView.title
         isEqualToString: @"Riddle Me This!"]) {
        answer = [[alertView textFieldAtIndex:0] text];
    }
    
    if ([answer caseInsensitiveCompare:currentRiddle.answer] == NSOrderedSame) {
        // User answered the riddle correctly
        UIAlertView *alertDialog;
        alertDialog = [[UIAlertView alloc]
                       initWithTitle: @"Correct Answer"
                       message:@"You have answered my questions three!  No you get a kewpie doll!"
                       delegate: nil
                       cancelButtonTitle: @"Ok"
                       otherButtonTitles: nil];
        [alertDialog show];
    } else {
        UIAlertView *alertDialog;
        alertDialog = [[UIAlertView alloc]
                       initWithTitle: @"Wrong Answer"
                       message:@"You've answered incorrectly.  Now off the cliff with you!"
                       delegate: nil
                       cancelButtonTitle: @"Ok"
                       otherButtonTitles: nil];
        [alertDialog show];
    }
}

- (void)recalibrateAttitude {
    self.refAttitude = self.motionManager.deviceMotion.attitude;
}

#pragma mark - GLKViewController Delegate Protocol Functions

- (void)update {
    GLKVector3 newLookAtVector;
    GLKVector3 cameraReferenceVector = GLKVector3Make(0.0f, 0.0f, 0.0f);
    GLKVector3 cameraVector;
    GLKMatrix4 yRotationMatrix;
    double pitchInRadians;
    
    // 1.1 Store local variable with timeSinceLastDraw
    NSTimeInterval dt = [self timeSinceLastDraw];
    NSTimeInterval yTimeRotated = 0;
    
    if(yTimeRotated < M_TAU) {
        yTimeRotated += dt;
    }
    
    // 2.1 - Initialize refAttitude if it's null
    if (self.refAttitude == nil) {
        [self recalibrateAttitude];
    }
    
    // 2.2 - Calculate the number of radians the device has rotated around it's roll axis.
    self.currentAttitude = self.motionManager.deviceMotion.attitude;
    [self.currentAttitude multiplyByInverseOfAttitude:self.refAttitude];
    pitchInRadians = self.currentAttitude.roll; // CONVERT_DEGREES_TO_RADIANS;
    
    // TODO: NEXT STEP: !!!! Convert roll to compassPoint vector  !!!!!!
    
    // 2.2 Convert roll to compassPoint vector
    yRotationMatrix = GLKMatrix4MakeYRotation(pitchInRadians);
    cameraVector = GLKMatrix4MultiplyVector3(yRotationMatrix, cameraReferenceVector);
    
    if([objectsForRendering count] > 0)
    {
        for (id cube in objectsForRendering)
            [((ColorfulCube *)cube) updateCompassPoint:compassPoint];
    }
    
    // 2.3 Pass the lookAt vector to 3D objects
    if([objectsForRendering count] > 0)
    {
        for (id cube in objectsForRendering)
            [((ColorfulCube *)cube) updateLookAtVector:newLookAtVector];
    }
    
    // 3.1 Redraw each 3D object
    if([objectsForRendering count] > 0)
    {
        for (id cube in objectsForRendering)
            [((ColorfulCube *)cube) updateTimeSinceUpdate:dt];
    }
}

/**
 *  Pauses execution of application loop.
 *
 *  @param controller The GLKViewController's continaing the application loop which will be paused.
 *  @param pause      If TRUE application loop will be paused.
 */
- (void)glkViewController:(GLKViewController *)controller willPause:(BOOL)pause {
    
}

#pragma mark - GLKView Delegate Protocol Functions

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {    
    [self.baseEffect prepareToDraw];
    
    // Clear Frame Buffer (erase previous drawing)
    glClear(GL_COLOR_BUFFER_BIT);
    
    // Call the draw method for each 3D object in the objectsForRendering array
    if(objectsForRendering.count > 0)
        [objectsForRendering makeObjectsPerformSelector:@selector(draw:) withObject:self.baseEffect];   // Send draw message to all 3D objects
    
    
    
    // --------------------------------------------------------------------------------------
    // -----    Used to draw single triangle for demo                                   -----
    // --------------------------------------------------------------------------------------
    // Enable use of positions from bound vertex buffer
//    glEnableVertexAttribArray(GLKVertexAttribPosition);
//    
//    glVertexAttribPointer(          // STEP 5
//                          GLKVertexAttribPosition,
//                          3,                   // three components per vertex
//                          GL_FLOAT,            // data is floating point
//                          GL_FALSE,            // no fixed point scaling
//                          sizeof(SceneVertex), // no gaps in data
//                          NULL);               // NULL tells GPU to start at
//    // beginning of bound buffer
//    
//    // Draw triangles using the first three vertices in the
//    // currently bound vertex buffer
//    glDrawArrays(GL_TRIANGLES,      // STEP 6
//                 0,  // Start with first vertex in currently bound buffer
//                 3); // Use three vertices from currently bound buffer
}

#pragma mark - CHILD VIEW CONTROLLER METHODS

- (void)willMoveToParentViewController:(UIViewController *)parent {
//    NSLog(@"OpenGLViewController::willMoveToParentViewControler called.  This view controller was added as a child.");
}

#pragma mark - COMPASS AND GPS FUNCTIONS
// --------------------------------------------------------------------------
// -----    locationManager                                             -----
// -----    New heading received from compass                           -----
// -----    This function passed unit testing on 11/18/2012 by Mike Ellertson
// -----    Test results                                                -----
// -----    Compass Heading  X   Y   Z                                  -----
// -----    0 - North       0   0   -1                                  -----
// -----    90 - West       +1  0   0                                   -----
// -----    180 - South     0   0   +1                                  -----
// -----    270 - East      -1  0   0                                   -----
// --------------------------------------------------------------------------
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if(newHeading.headingAccuracy < 0) {
        // The heading is invalid, need to recalibrate it
        NSLog(@"The compass needs to be re-calibrated.");
    } else {
        // The heading is valid
        double radHeading;
        radHeading = CONVERT_DEGREES_TO_RADIANS * newHeading.magneticHeading;
        
        self->compassPoint.x = sin(radHeading);
        self->compassPoint.z = -(cos(radHeading));
        self->compassPoint.y = 0;
        
        // Update objects with compass data
//        if([objectsForRendering count] > 0)
//        {
//            for (id cube in objectsForRendering)
//                [((ColorfulCube *)cube) updateCompassPoint:compassPoint];
//        }
    }
    
    // Update ivar in ViewController for output of gps data to screen
    [(( ViewController *) self.parentViewController) updateCompassOutput:[NSString stringWithFormat:@"Heading = %f \nLook At Vector.x = %f \nLook At Vector.z = %f", newHeading.magneticHeading, compassPoint.x, compassPoint.z]];
    
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {

    // 1.1: Update local variable with new GPS coordinates
//    [deviceCurrentGPSLocation updateWithLatitude:newLocation.coordinate.latitude Longitude:newLocation.coordinate.longitude Altitude:0.0f];
    [deviceCurrentGPSLocation updateWithLatitude:LOC7LAT Longitude:LOC7LONG Altitude:0.0f];
    
    // 1.2: Re-Initialize objectsForRenderingList using the newly updated
    // GPS coordinates.  Each 3D object's position property will be updated.
    objectsForRendering = [self reInitObjectsForRendering:objectsForRendering withinRadius:viewableRadius fromGPSCoordinate:deviceCurrentGPSLocation usingDBOfObjects:dbOfObjects];
    
    if([objectsForRendering count] > 0)
    {
        NSString *text = [[NSString alloc] init];
        for (id objectID in objectsForRendering)
        {
            ColorfulCube *cube = (ColorfulCube *)objectID;
            text = [text stringByAppendingFormat:@"%@ x = %0.0f z = %0.0f\n", cube.worldObjectID, cube.position.x, cube.position.z];
        }
        [(( ViewController *) self.parentViewController) update3DObjectOutput:text];
    }
    
    // 1.3: Send the newly updated GPS coordinate to the parent view controller so it can be displayed to the user.
    [(( ViewController *) self.parentViewController) updateGPSCoordinatesLabel:[NSString stringWithFormat:@"GPS.Lat: %f \nGPS.Lon: %f \nGPS.alt: %f", deviceCurrentGPSLocation.latitude, deviceCurrentGPSLocation.longitude, deviceCurrentGPSLocation.altitudeAGL]];
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
}

-(void)turnOnCompassNotifications {
    // COMPLETED: 5/28/2014: No test case needed at this time.
    // Initialize the location manager, used to sense compass heading
    locMan = [[CLLocationManager alloc] init];
    locMan.delegate = self;
    locMan.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    locMan.distanceFilter = 1609; // a mile
    [locMan startUpdatingLocation];             // This line tells iOS to send GPS updates
    if ([CLLocationManager headingAvailable]) {
        locMan.headingFilter = 1; // 1 degree
        [locMan startUpdatingHeading];          // This line tells iOS to send compass updates
    }
    locServicesRunning = TRUE;
}

-(void)pauseLocationServices {
    if (locServicesRunning) {
        [locMan stopUpdatingHeading];
        [locMan stopUpdatingLocation];
        locServicesRunning = !locServicesRunning;
    }
}

-(void)startLocationServices {
    if (!locServicesRunning) {
        [locMan startUpdatingHeading];
        [locMan startUpdatingLocation];
        locServicesRunning = !locServicesRunning;
    }
}

#pragma mark - Accelerometer & Gyro Functions
// --------------------------------------------------------------------------
// -----    initMotionManager                                           -----
// -----    Custom function, not included in iOS                        -----
// --------------------------------------------------------------------------
- (void)initMotionManager {
    // COMPLETED: 5/28/2014: No test case needed at this time.
    // Initialize default values for refreshing accelerometer and gryo data
//    DebugMaxX = DebugMaxY = DebugMaxZ = 0;
//    DebugMinX = DebugMinY = DebugMinZ = 0;
//    oldAccel.x = oldAccel.y = oldAccel.z = 0;
    
    // Initialize low-pass filter
//    float updateFrequency = 60.0f;
//    accelFilter = [[LowpassFilter alloc] initWithSampleRate:updateFrequency cutoffFrequency:5.0];
//    [accelFilter setAdaptive:YES];
    
    // Init motion manager
    self.motionManager = [[CMMotionManager alloc] init];
    
    // init accelerometer and gyroscope update intervals
//    self.motionManager.accelerometerUpdateInterval = .01;
//    self.motionManager.gyroUpdateInterval = .01;
    
    // Init and start device motion updates
    self.motionManager.deviceMotionUpdateInterval = 1 / 30; // 30 times per second to match OpenGL ES update interval
    [self.motionManager startDeviceMotionUpdates];

    // Start receiving gyroscopic updates from device, if deivce has a gryo
//    if (self.motionManager.gyroAvailable) {
//        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
//                                        withHandler:^(CMGyroData *gyroData, NSError *error) {
//                                            [self receiveGyroUpdate:gyroData.rotationRate];
//                                        }];
//    }
    
    // Start receiving accelerometer updates from device
//    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
//                                             withHandler:^(CMAccelerometerData *accelData, NSError *error) {
//                                                 [self receiveAccelerometerUpdates:accelData];
//                                             }];

}

// --------------------------------------------------------------------------
// -----      receiveAccelerometerUpdates                               -----
// -----      Call back to receive accelerometer updates from device
// -----      Method's Main Purpose: To pass two vectors to the 3D objects
// -----        lookAtVector
// -----        upVector
// --------------------------------------------------------------------------
- (void)receiveAccelerometerUpdates:(CMAccelerometerData *)accelData {
//    GLKVector3 gravityVector;
//    GLKMatrix4 xRotationMatrix;
////    GLKMatrix4 gravityRotationMatrix;
//    
//    // Initialize variables
//    gravityVector.x = accelData.acceleration.x;
//    gravityVector.y = accelData.acceleration.y;
//    gravityVector.z = accelData.acceleration.z;
////    lookAtVector.x = gravityVector.x;
////    lookAtVector.y = gravityVector.y;
////    lookAtVector.z = gravityVector.z; // I didn't initialize Y because I thought another thread might modify it before it's sent to ColorfulCube.
//    
////    NSLog(@"size of GLKVector3 %ld", sizeof(gravityVector));
////    NSLog(@"size of float %ld", sizeof(float));
////    NSLog(@"size of accelData.acceleration = %ld", sizeof(accelData.acceleration));
////    NSLog(@"size of double %ld", sizeof(double));
//    
//    
//    // Add accelerometer data to the filter
////    NSLog(@"x = %f     y = %f     z = %f", accelData.acceleration.x, accelData.acceleration.y, accelData.acceleration.z);
////    [accelFilter addAcceleration:accelData];
////    float x = accelFilter.x;
////    float y = accelFilter.y;
////    float z = accelFilter.z;
////    float x = accelData.acceleration.x;
//    float y = accelData.acceleration.y;
//    float z = accelData.acceleration.z;
//    
////    pitchAngle = atan2(z, -x) * M_180_OVER_PI;
//    
////    NSLog(@"Pitch angle = %f", pitchAngle);
//    
//    float xRotation;
////    float yRotation;
////    float zRotation;      // Radians of rotation around the respective axis'
//    
////    xRotation = atan2(y, z) * M_180_OVER_PI;
////    yRotation = atan2(z, -x) * M_180_OVER_PI;
////    zRotation = atan2(y, x) * M_180_OVER_PI;
//    
////    NSLog(@"xRotation = %f", xRotation);
////    NSLog(@"yRotation = %f", yRotation);
////    NSLog(@"zRotation = %f", zRotation);
//
//    // ******************************************************************
//    // Calculate yRotation in Radians
//    // ******************************************************************
//    // Option 2: Calculate Angle of Deflection Using Y and Z
////    y = -0.87f; z = -0.5f;
////    yRotation = y / z; // 1) Calculate tangent of the angle by doing Y / Z
//    xRotation = atan2f(y, z) - M_PI; // 2) Use arctan to calculate the angle of ascention
////    if (xRotation >= M_1_PI / 2) {
////        xRotation = xRotation + M_1_PI / 2;
////    }
////    xRotation = xRotation * M_180_OVER_PI; // 3) Convert to degrees
////    NSLog(@"Angle of ascention around X axis:    %f", xRotation * M_180_OVER_PI);
////    NSLog(@"-----------------------------");
//    
//    // ******************************************************************
//    // Perform Rotation of LookAt Around Y Axis
//    xRotationMatrix = GLKMatrix4MakeXRotation(xRotation);
//    lookAtVector = GLKMatrix4MultiplyVector3(xRotationMatrix, downReferenceVector);
////    NSLog(@"lookAtVector = x = %f, y = %f, z = %f", lookAtVector.x, lookAtVector.y, lookAtVector.z);
//    
//    // ******************************************************************
//    // Pass lookAtVector to 3D objects for rendering
//    if(objectsForRendering.count > 0)
//    {
//        for (id cube in objectsForRendering)
//            [((ColorfulCube *)cube) updateLookAtVector:lookAtVector];
//    }
//
//    // ******************************************************************
//    // Pass lookAtVector to 3D objects for rendering
//    xRotationMatrix = GLKMatrix4MakeXRotation(M_PI); // Create matrix to rotate 180 degrees
//    upVector = GLKMatrix4MultiplyVector3(xRotationMatrix, gravityVector);
//    
//    // ******************************************************************
//    // Update objects with upValue (opposite direction of gravity vector)
////    upVector.x = accelData.acceleration.x;
////    upVector.y = -(accelData.acceleration.y);
////    upVector.z = -(accelData.acceleration.z);
//   
//    if(objectsForRendering.count > 0)
//    {
//        for (id cube in objectsForRendering)
//            [((ColorfulCube *)cube) updateUpValue:upVector];
//    }
//    
////    gravityRotationMatrix = GLKMatrix4MakeZRotation(M_1_PI / 2);
////    gravityVector = GLKMatrix4MultiplyVector3(gravityRotationMatrix, gravityVector);
}

- (void)receiveGyroUpdate:(CMRotationRate)rotation {
//    NSLog(@"gyroscope update received.");
    //    // Use rotation.x, rotation.y, and rotation.z in your application code.
    //    // Store max x, y, and z values for debugging
    //    if(rotation.x > DebugMaxX)
    //        DebugMaxX = rotation.x;
    //    if(rotation.y > DebugMaxY)
    //        DebugMaxY = rotation.y;
    //    if(rotation.z > DebugMaxZ)
    //        DebugMaxZ = rotation.z;
    //
    //    // Store min x, y, and z values for debugging
    //    if(rotation.x < DebugMinX)
    //        DebugMinX = rotation.x;
    //    if(rotation.y < DebugMinY)
    //        DebugMinY = rotation.y;
    //    if(rotation.z < DebugMinZ)
    //        DebugMinZ = rotation.z;
    //
    //    NSLog(@"Rotation event received from device");
    //    NSLog(@"Rotation x = %f  Rotation y = %f  Rotation z = %f", rotation.x, rotation.y, rotation.z);
    //    NSLog(@"Min X = %f  Min Y = %f  Min Z = %f", DebugMinX, DebugMinY, DebugMinZ);
    //    NSLog(@"Max X = %f  Max Y = %f  Max Z = %f", DebugMaxX, DebugMaxY, DebugMaxZ);
    
}

- (void)actionCalibrate {
    NSLog(@"The calibrate button was pressed and the message passed to OpenGLViewcontroller");
    
      self.refAttitude = self.motionManager.deviceMotion.attitude;
}

@end








