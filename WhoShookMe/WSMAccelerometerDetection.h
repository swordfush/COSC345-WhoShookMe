//
//  WSMAccelerometerDetection.h
//  WhoShookMe
//
//  Created by Stuart Johnston on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

#import "WSMDetectionMethod.h"

@interface WSMAccelerometerDetection : NSObject <WSMDetectionMethod> {
    
    double x;
    double y;
    double z;
    bool hasDetected;
    bool hasTakenFirstReading;
}

- (BOOL)hasDetectedUser;
- (NSString*)methodName;
- (NSString*)methodDescription;

@property (nonatomic, strong) CMMotionManager *motionManager;

@end
