//
//  WSMDetectionManager.m
//  WhoShookMeSkeleton
//
//  Created by Stuart Johnston on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import "WSMDetector.h"

#import "WSMReflection.h"

#import "WSMDetectionMethod.h"
#import "WSMInformationSource.h"
#import "WSMNotificationMethod.h"

@implementation WSMDetector


const double kBeginDetectingDelay = 5.0;
const double kPollInterval = 0.5;
const double kPendingInterval = 10.0;

static WSMDetector *singletonInstance;

- (id)init {
    self = [super init];
    
    methodsOfDetection = [WSMReflection createAnInstanceOfEveryImplementingClass:@protocol(WSMDetectionMethod)];
    informationSources = [WSMReflection createAnInstanceOfEveryImplementingClass:@protocol(WSMInformationSource)];
    methodsOfNotification = [WSMReflection createAnInstanceOfEveryImplementingClass:@protocol(WSMNotificationMethod)];
    
    return self;
}

// This is called only once for each class, before it is first used. The boolean guard is to prevent people from manually calling the method.
+ (void)initialize {
    static BOOL initialized = NO;
    if (!initialized) {
        singletonInstance = [[WSMDetector alloc] init];
        initialized = YES;
    }
}

+ (WSMDetector*)instance {
    return singletonInstance;
}

- (void)run {
    NSAssert(![self isDetectorRunning], @"The detector was already running");
    NSAssert(![self hasPendingDetection], @"There is currently a detection pending");
    
    for (id<WSMDetectionMethod> detectionMethod in methodsOfDetection) {
        [detectionMethod reset];
    }
    
    detectionPollTimer = [NSTimer scheduledTimerWithTimeInterval:kBeginDetectingDelay target:self selector:@selector(checkDetectionMethods) userInfo:nil repeats:NO];
}

- (BOOL)isDetectorRunning {
    return detectionPollTimer != nil;
}

- (BOOL)hasPendingDetection {
    return detectionPendingTimer != nil;
}

- (void)checkDetectionMethods {
    NSAssert(detectionPollTimer != nil, @"isRunning assumption is false");
    
    for (id<WSMDetectionMethod> detectionMethod in methodsOfDetection) {
        if ([detectionMethod hasDetectedUser]) {
            [self prepareDetection];
                        
            detectionPendingTimer = [NSTimer scheduledTimerWithTimeInterval:kPendingInterval target:self selector:@selector(detectionRequiresNotification) userInfo:nil repeats:NO];
            
            return;
        }
    }
    
    detectionPollTimer = [NSTimer scheduledTimerWithTimeInterval:kPollInterval target:self selector:@selector(checkDetectionMethods) userInfo:nil repeats:NO];
}

- (void)prepareDetection {
    NSAssert([self isDetectorRunning], @"The detector was not running.");
    
    [detectionPollTimer invalidate];
    detectionPollTimer = nil;
    
    for (id<WSMInformationSource> informationSource in informationSources) {
        [informationSource prepareInfo];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[WSMDetector detectionOccurredName] object:nil];
}

- (void)cancelPendingDetection {
    NSAssert([self hasPendingDetection], @"No detection was pending.");
    
    [detectionPendingTimer invalidate];
    detectionPendingTimer = nil;
    
    for (id<WSMInformationSource> infoSource in informationSources) {
        [infoSource dumpInfo];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[WSMDetector detectionCancelledName] object:nil];
}

- (void)forceDetection {
    if ([self isDetectorRunning]) {
        [self prepareDetection];
    }
    
    // In some instances we won't be able to stall (such as user closing app)
    // so we will just have to deal with not being able to do much about
    // capturing long readings like video and audio when this happens
    
    [self detectionRequiresNotification];
}

- (void)detectionRequiresNotification {
    if (detectionPendingTimer != nil) {
        [detectionPendingTimer invalidate];
        detectionPendingTimer = nil;
    }
    
    WSMDetectionInformation *detectionInfo = [[WSMDetectionInformation alloc] initUsingInformationSources:informationSources];
    
    for (id<WSMNotificationMethod> notificationMethod in methodsOfNotification) {
        [notificationMethod notifyWithInformation:detectionInfo];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[WSMDetector detectionNotifiedName] object:nil];
}

+ (NSString*)detectionOccurredName {
    return @"DetectionOccurred";
}

+ (NSString*)detectionNotifiedName {
    return @"NotificationOccurred";
}
+ (NSString*)detectionCancelledName {
    return @"DetectionCancelled";
}



@end
