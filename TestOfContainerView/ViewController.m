//
//  CameraController.m
//  TestOfContainerView
//
//  Created by Michael Ellertson on 1/16/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#import "ViewController.h"

#define CAMERA_TRANSFORM  1.24299  // Define from AGCameraExample (ACE)


@interface ViewController ()

@end

@implementation ViewController

@synthesize imagePicker;
//@synthesize glkViewOutlet;
@synthesize captureManager, subView1, subView2;

- (void)initAVFoundationCameraOverlay {
    // -------------- init the capture session manager -------------------------
    [self setCaptureManager:[[CaptureSessionManager alloc] init]];
    
	[[self captureManager] addVideoInput];
    
	[[self captureManager] addVideoPreviewLayer];
	CGRect layerRect = [[[self view] layer] bounds];
	[[[self captureManager] previewLayer] setBounds:layerRect];
	[[[self captureManager] previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                  CGRectGetMidY(layerRect))];
	[[subView1 layer] addSublayer:[[self captureManager] previewLayer]]; // Add the camera as a layer
    [[captureManager captureSession] startRunning];  // Start the camera running
    
    //    // --------------- Set Sub View Properties ----------------------------------
    self.containerView.opaque = NO;
    self.containerView.backgroundColor = [UIColor clearColor];
    self.containerView.alpha = 1;
    //    self.subView1.alpha = 1.0;
    //    self.subView2.opaque = NO;
    //    self.subView1.backgroundColor = [UIColor clearColor];
    //    self.subView2.alpha = 1.0;
    //    [[self fuckYahLabel] setBackgroundColor:[UIColor clearColor]];
    //    [[self fuckYahLabel] setAlpha:1.0];
    //    [[self fuckYahLabel] setOpaque:YES];
    
    // --------------- Init the OpenGL View  ----------------------
    //    [self performSegueWithIdentifier:@"toOpenGLViewController" sender:self];
    //    OpenGLViewController *glViewController = [[OpenGLViewController alloc] init];
    //    [self addChildViewController:glViewController];
    //    [self.view addSubview:glViewController.view];
    //    [glViewController didMoveToParentViewController:self];
    //    [self setGlkViewOutlet:[[OpenGLView alloc] init]];      // Instansiate object for GLK View
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    NSLog(@"First View Controller::viewDidLoad method called.");

    [self initAVFoundationCameraOverlay];
    showingDebugInfo = false;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUIImagePickerCameraOverlay {
    @try {
        // MARK: Initialize the Camera
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.showsCameraControls = NO;
        imagePicker.toolbarHidden = YES;
        imagePicker.navigationBarHidden = YES;
        imagePicker.wantsFullScreenLayout = YES;
        imagePicker.cameraViewTransform = CGAffineTransformScale(imagePicker.cameraViewTransform, CAMERA_TRANSFORM, CAMERA_TRANSFORM);
//        NSLog(@"Camera was initialized");
        //        [uip setDelegate:self];
        // MARK: New code to set camera's overlay view
        //        [imagePicker setCameraOverlayView:glView];
        
        //        imagePicker.cameraOverlayView = glView;
        
    }
    @catch (NSException * e) {
        //        [uip release];
        imagePicker = nil;
    }
    @finally {
        if(imagePicker) {
            // Finish initializing the camera
            //            [viewOverlay addSubview:uip.view];
            //            [viewOverlay sendSubviewToBack:uip.view];
            //            [overlay release];
            //            [_window addSubview:imagePicker.view];
        }
    }
    // MARK: Display Camera
    //    [self presentViewController:imagePicker animated:NO completion:NULL];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"oooh, I'm being touched by a horny man!!");
    NSLog(@"Description of View Controller = \n%@", self.view);
}

- (IBAction)buttonCalibrate:(id)sender {
    NSArray *childViewControllers = self.childViewControllers;
    OpenGLViewController *vcChild;
    
    NSString *searchTerm = @"OpenGLViewController";
    NSString *objectsDescription;
    
    // Iterate through the child view controllers
    for(uint i = 0; i < [childViewControllers count]; i++) {
        // store reference to each child view controller
        vcChild = [childViewControllers objectAtIndex:i];
        NSLog(@"child view controller's description = %@", vcChild.description);
        
        objectsDescription = vcChild.description;
        
        if ([objectsDescription rangeOfString:searchTerm].location == NSNotFound) {
        } else {
            // vcChild == a reference to OpenViewController
            [(OpenGLViewController *)vcChild actionCalibrate];
        }
    }
//        [(( ViewController *) self.child) updateGPSCoordinatesLabel:[NSString stringWithFormat:@"GPS.Lat: %f \nGPS.Lon: %f \nGPS.alt: %f", deviceCurrentGPSLocation.latitude, deviceCurrentGPSLocation.longitude, deviceCurrentGPSLocation.altitudeAGL]];
}

- (void)updateGPSCoordinatesLabel:(NSString *)newLabel
{
    NSLog(@"GPS Coordinates Label was updated in ViewControllers");
    self.gpsCoordinatesLabel.text = newLabel;
}

- (void)updateCompassOutput:(NSString *)newLabel
{
    self.compassOutput.text = newLabel;
}

- (void)update3DObjectOutput:(NSString *)newText
{
    self.threeDObjectOutput.text = newText;
}

- (IBAction)toggleDebugInfo:(id)sender {
    if (showingDebugInfo) {
        // Hide the debug info
        showingDebugInfo = false;
        [self.compassOutput setHidden:YES];
        [self.threeDObjectOutput setHidden:YES];
        [self.gpsCoordinatesLabel setHidden:YES];
    } else {
        // Show the debug info
        showingDebugInfo = true;
        [self.compassOutput setHidden:NO];
        [self.threeDObjectOutput setHidden:NO];
        [self.gpsCoordinatesLabel setHidden:NO];
    }
}


@end



