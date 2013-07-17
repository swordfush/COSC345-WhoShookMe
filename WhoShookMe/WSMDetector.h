//
//  WSMDetectionManager.h
//  WhoShookMeSkeleton
//
//  Created by Stuart Johnston on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSMDetectionMethod.h"
#import "WSMNotificationInfo.h"
#import "WSMNotificationMethod.h"


@interface WSMDetector : NSObject {
    NSMutableArray *methodsOfDetection;
}

- (id)initWithDetectionMethods:(NSMutableArray*)detectionMethods;
- (bool)poll;
- (void)reset;


@end
