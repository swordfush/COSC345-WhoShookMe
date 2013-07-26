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
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss.SSS"];
    
    NSString *filename = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *appendedPath = [NSString stringWithFormat:@"Documents/%@.jpg", filename];
    return [NSHomeDirectory() stringByAppendingPathComponent:appendedPath];
}

- (void)prepareInfo {
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (input) {    
        [session addInput:input];
        
        AVCaptureStillImageOutput *stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
        [stillImageOutput setOutputSettings:outputSettings];
        
        [session addOutput:stillImageOutput];
        
        AVCaptureConnection *videoConnection = nil;
        for (AVCaptureConnection *connection in [stillImageOutput connections]) {
            for (AVCaptureInputPort *port in [connection inputPorts]) {
                if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                    videoConnection = connection;
                    break;
                }
            }
            if (videoConnection) {
                break;
            }
        }
        
        [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^
            (CMSampleBufferRef imageSampleBuffer, NSError *error) {
                imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
                filePath = [self getNewFilePath];
            }];
    } else {
        NSLog(@"Failed to open the camera");
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
