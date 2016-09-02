//
//  CaptureSessionManager.h
//  TestOfContainerView
//
//  Created by Michael Ellertson on 1/16/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>

@interface CaptureSessionManager : NSObject

@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;

- (void)addVideoPreviewLayer;
- (void)addVideoInput;

@end
