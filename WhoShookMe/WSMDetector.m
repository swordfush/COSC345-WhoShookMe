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


const double kPollInterval = 0.5;
const double kPendingInterval = 10.0;

static WSMDetector *singletonInstance;

- (id)init {
    self = [super init];
    
    methodsOfDetection = [WSMReflection createAnInstanceOfEveryImplementingClass:@protocol(WSMDetectionMethod)];
    informationSources = [WSMReflection createAnInstanceOfEveryImplementingClass:@protocol(WSMInformationSource)];
    methodsOfNotification = [WSMReflection createAnInstanceOfEveryImplementingClass:@protocol(WSMNotificationMethod)];
    
    isPrepared = NO;
    
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

- (void)prepareToRun {
    isPrepared = YES;
}

- (void)run {
    NSAssert(isPrepared, @"The detector was not prepared to run");
    NSAssert(![self isDetectorRunning], @"The detector was already running");
    NSAssert(![self hasPendingDetection], @"There is currently a detection pending");
    
    isPrepared = NO;
    
    for (id<WSMDetectionMethod> detectionMethod in methodsOfDetection) {
        [detectionMethod reset];
    }
    
    NSLog(@"Detector running");
    
    // Use the timer to poll the devices so that isRunning reports
    // correctly
    detectionPollTimer = [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(checkDetectionMethods) userInfo:nil repeats:NO];
}

- (BOOL)isDetectorRunning {
    return detectionPollTimer != nil;
}

- (BOOL)isDetectorWaitingToBeRun {
    return isPrepared;
}

- (BOOL)hasPendingDetection {
    return detectionPendingTimer != nil;
}

- (BOOL)isActive {
    return [self isDetectorRunning] || [self hasPendingDetection];
}

- (void)checkDetectionMethods {
    NSAssert(detectionPollTimer != nil, @"isRunning assumption is false");
    
    for (id<WSMDetectionMethod> detectionMethod in methodsOfDetection) {
        if ([detectionMethod hasDetectedUser]) {
            [self prepareDetection];
            
            return;
        }
    }
    
    detectionPollTimer = [NSTimer scheduledTimerWithTimeInterval:kPollInterval target:self selector:@selector(checkDetectionMethods) userInfo:nil repeats:NO];
}

- (void)prepareDetection {
    NSAssert([self isDetectorRunning], @"The detector was not running.");
    
    NSLog(@"Detection prepared and pending");
    
    [detectionPollTimer invalidate];
    detectionPollTimer = nil;
    
    for (id<WSMInformationSource> informationSource in informationSources) {
        [informationSource prepareInfo];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[WSMDetector detectionOccurredEventName] object:nil];
    
    detectionPendingTimer = [NSTimer scheduledTimerWithTimeInterval:kPendingInterval target:self selector:@selector(detectionRequiresNotification) userInfo:nil repeats:NO];
}

- (void)cancelPendingDetection {
    NSAssert([self hasPendingDetection], @"No detection was pending.");
    
    NSLog(@"Pending detection cancelled");
    
    [detectionPendingTimer invalidate];
    detectionPendingTimer = nil;
    
    for (id<WSMInformationSource> infoSource in informationSources) {
        [infoSource dumpInfo];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[WSMDetector detectionCancelledEventName] object:nil];
}

- (void)triggerDetection {
    NSAssert([self isDetectorRunning], @"The detector must be running for a detection to be triggered.");
    [self prepareDetection];
}

- (void)forceNotification {
    NSAssert([self hasPendingDetection], @"No detection was pending");
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[WSMDetector detectionNotifiedEventName] object:nil];
    
    NSLog(@"Detection notified");
}

+ (NSString*)detectionOccurredEventName {
    return @"DetectionOccurred";
}

+ (NSString*)detectionNotifiedEventName {
    return @"NotificationOccurred";
}
+ (NSString*)detectionCancelledEventName {
    return @"DetectionCancelled";
}



@end
