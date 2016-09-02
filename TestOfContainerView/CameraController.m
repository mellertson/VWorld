//
//  CameraController.m
//  TestOfContainerView
//
//  Created by Michael Ellertson on 1/16/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#import "CameraController.h"
#import "OpenGLViewController.h"

#define CAMERA_TRANSFORM  1.24299  // Define from AGCameraExample (ACE)


@interface CameraController ()

@end

@implementation CameraController

@synthesize imagePicker;
@synthesize captureManager, subView1, subView2;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"CameraController::viewDidLoad was called.");

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
// --------------- Launch the OpenGL Segue ----------------------
//    [self performSegueWithIdentifier:@"toOpenGLViewController" sender:self];
    OpenGLViewController *glViewController = [[OpenGLViewController alloc] init];
    [self addChildViewController:glViewController];
    [self.view addSubview:glViewController.view];
    [glViewController didMoveToParentViewController:self]; 
    
//    // --------------- Set Sub View Properties ----------------------------------
            self.subView1.backgroundColor = [UIColor whiteColor];
    self.subView1.alpha = 1.0;
    self.subView2.opaque = NO;
    self.subView1.backgroundColor = [UIColor clearColor];
    self.subView1.alpha = 1.0;
    [[self fuckYahLabel] setBackgroundColor:[UIColor clearColor]];
    [[self fuckYahLabel] setAlpha:1.0];
    [[self fuckYahLabel] setOpaque:YES];

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

-(void)initCameraOverlay {
    @try {
        // MARK: Initialize the Camera
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.showsCameraControls = NO;
        imagePicker.toolbarHidden = YES;
        imagePicker.navigationBarHidden = YES;
        imagePicker.wantsFullScreenLayout = YES;
        imagePicker.cameraViewTransform = CGAffineTransformScale(imagePicker.cameraViewTransform, CAMERA_TRANSFORM, CAMERA_TRANSFORM);
        NSLog(@"Camera was initialized");
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



@end
