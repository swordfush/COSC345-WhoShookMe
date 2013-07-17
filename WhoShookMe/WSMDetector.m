//
//  WSMDetectionManager.m
//  WhoShookMeSkeleton
//
//  Created by Stuart Johnston on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import "WSMDetector.h"

#import "WSMDetectionMethod.h"
#import "WSMInformationSource.h"
#import "WSMNotificationMethod.h"

@implementation WSMDetector

- (id)initWithDetectionMethods:(NSMutableArray *)detectionMethods {
    methodsOfDetection = detectionMethods;
    
    return self;
}


- (bool)poll {
    // Check all our detection sources
    for (id<WSMDetectionMethod> detectionMethod in methodsOfDetection) {
        if ([detectionMethod hasDetectedUser]) {
            return true;
        }
    }
    
    return false;
}

- (void)reset {
    NSLog(@"Resetting detection methods");
    for (id<WSMDetectionMethod> detectionMethod in methodsOfDetection) {
        [detectionMethod reset];
    }
}

@end
