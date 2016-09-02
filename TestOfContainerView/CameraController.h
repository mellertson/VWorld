//
//  CameraController.h
//  TestOfContainerView
//
//  Created by Michael Ellertson on 1/16/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptureSessionManager.h"

@interface CameraController : UIViewController {
    UIImagePickerController *imagePicker;
}

@property (retain) CaptureSessionManager *captureManager;           // AVFoundation property
@property (strong, nonatomic) IBOutlet UIView *glkViewOutlet;       // GLKView property
@property (nonatomic, strong) UIImagePickerController *imagePicker; // UIImagePicker property
@property (strong, nonatomic) IBOutlet UIView *subView1;        // View for AVFoundation
@property (strong, nonatomic) IBOutlet UIView *subView2;        // View for test objects
@property (strong, nonatomic) IBOutlet UIView *fuckYahLabel;    // Test lable


@end
