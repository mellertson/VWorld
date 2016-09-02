//
//  CameraController.h
//  TestOfContainerView
//
//  Created by Michael Ellertson on 1/16/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptureSessionManager.h"
#import "OpenGLViewController.h"

@interface ViewController : UIViewController {
    UIImagePickerController *imagePicker;
    BOOL showingDebugInfo;
}


@property (retain) CaptureSessionManager *captureManager;           // AVFoundation property
@property (nonatomic, strong) UIImagePickerController *imagePicker; // UIImagePicker property
@property (strong, nonatomic) IBOutlet UIView *subView1;        // View for AVFoundation
@property (strong, nonatomic) IBOutlet UIView *subView2;        // View for test objects
@property (strong, nonatomic) IBOutlet UILabel *gpsCoordinatesLabel;    // Test lable
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UILabel *compassOutput;
@property (strong, nonatomic) IBOutlet UILabel *threeDObjectOutput;
@property (strong, nonatomic) IBOutlet UIButton *btnToggleDebugInfo;


- (IBAction)buttonCalibrate:(id)sender;
- (void)updateGPSCoordinatesLabel:(NSString *)newLabel;
- (void)updateCompassOutput:(NSString *)newLabel;
- (void)update3DObjectOutput:(NSString *)newText;
- (IBAction)toggleDebugInfo:(id)sender;


@end




