//
//  WSMAccelerometerDetection.m
//  WhoShookMe
//
//  Created by Stuart Johnston on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMAccelerometerDetection.h"

#import <CoreMotion/CoreMotion.h>

@implementation WSMAccelerometerDetection

- (id)init {
    self = [super init];
    // The vector magnitude of the difference in G-force between two successive callbacks for which to trigger a detection 
    const double THRESHOLD = 0.1;
    // The accelerometer update interval in seconds
    const double INTERVAL = 0.5;
    
    if (self) {
        self->hasDetected = false;
        self->hasTakenFirstReading = false;
     
        [self setMotionManager:[[CMMotionManager alloc] init]];
        [[self motionManager] setAccelerometerUpdateInterval:INTERVAL];
        
        if ([[self motionManager] isAccelerometerAvailable]) {
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Ensure that we take an initial reading
                    if (!hasTakenFirstReading) {
                        hasTakenFirstReading = true;
                    } else if (!hasDetected) {
                        // Calculate the change in accelerometer readings since the last callback
                        double dx = fabs(accelerometerData.acceleration.x - x);
                        double dy = fabs(accelerometerData.acceleration.y - y);
                        double dz = fabs(accelerometerData.acceleration.z - z);
                        
                        // If the difference vector exceeds the threshold we have detected a user
                        if (sqrt(dx*dx + dy*dy + dz*dz) > THRESHOLD) {
                            hasDetected = true;
                        }
                    }
                    
                    // We want these updated regardless, just in case we need to restart reading after a detection has been triggered
                    x = accelerometerData.acceleration.x;
                    y = accelerometerData.acceleration.y;
                    z = accelerometerData.acceleration.z;
                });
            }];
        }
    }
    
    return self;
}

- (BOOL)hasDetectedUser {
    return hasDetected;
}

- (void)reset {
    hasDetected = false;
}


@end
