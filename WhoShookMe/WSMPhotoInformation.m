//
//  WSMPhotoInformation.m
//  WhoShookMe
//
//  Created by Maddy Mills on 26/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMPhotoInformation.h"


@implementation WSMPhotoInformation

- (NSString*)getNewFilePath {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss-SSS"];
    
    NSString *filename = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *appendedPath = [NSString stringWithFormat:@"Documents/%@.jpg", filename];
    return [NSHomeDirectory() stringByAppendingPathComponent:appendedPath];
}

- (id)init {
    self = [super init];
    if (self) {
        AVCaptureDevice *frontalCamera;
        NSArray *allCameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        
        // Find the frontal camera.
        for ( int i = 0; i < allCameras.count; i++ ) {
            AVCaptureDevice *camera = [allCameras objectAtIndex:i];
            
            if ( camera.position == AVCaptureDevicePositionFront ) {
                frontalCamera = camera;
            }
        }
        
        if (frontalCamera) {
            session = [[AVCaptureSession alloc] init];
            
            // Setup instance of input with frontal camera and add to session.
            NSError *error;
            AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:frontalCamera error:&error];
            
            if (!error && [session canAddInput:input]) {
                // Add frontal camera to this session.
                [session addInput:input];
                
                // We need to capture still image.
                imageOutput = [[AVCaptureStillImageOutput alloc] init];
                
                // Captured image settings.
                [imageOutput setOutputSettings:
                 [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil]];
                
                if ([session canAddOutput:imageOutput]) {
                    [session addOutput:imageOutput];
                    
                    videoConnection = nil;
                    for (AVCaptureConnection *connection in imageOutput.connections) {
                        for (AVCaptureInputPort *port in [connection inputPorts]) {
                            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                                videoConnection = connection;
                                break;
                            }
                        }
                        if (videoConnection) { break; }
                    }
                    
                    
                }
            }
        }
        
    }
    
    return self;
}

- (void)prepareInfo {
    // Finally take the picture
    if (videoConnection) {
        [session startRunning];
        
        [imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            if (error != nil) {
                NSLog(@"Camera error: %@", [error localizedDescription]);
            }
            if (imageDataSampleBuffer != nil) {
                filePath = [self getNewFilePath];
                imageData = [AVCaptureStillImageOutput
                                     jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            }
        }];
    }
}

- (NSString*)getInfo {
    if (imageData == nil) {
        return nil;
    } else {
        [imageData writeToFile:filePath atomically:YES];
        
        return filePath;
    }
}

- (void)dumpInfo {
    
}

- (NSString*)informationTypeIdentifier {
    return [WSMPhotoInformation informationTypeIdentifier];
}

+ (NSString*)informationTypeIdentifier {
    return @"Photo";
}


@end
