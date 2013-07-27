//
//  WSMDetectionManager.h
//  WhoShookMeSkeleton
//
//  Created by Stuart Johnston on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSMDetectionMethod.h"
#import "WSMInformationSource.h"
#import "WSMNotificationMethod.h"


@interface WSMDetector : NSObject {
    NSMutableArray *methodsOfDetection;
    NSMutableArray *methodsOfNotification;
    NSMutableArray *informationSources;
    NSTimer *detectionPollTimer;
    NSTimer *detectionPendingTimer;
}

/**
 * Returns the singleton instance of the detector.
 */
+ (WSMDetector*)instance;

/**
 * Runs the detector. It will begin polling detection methods to determine 
 * if a user has been detected. 
 *
 * Once a user has been detected the detectionOccurred event will be 
 * triggered and a timer will begin.
 *
 * If the timer elapses without the detection being cancelled then the 
 * notification methods will be used, and the detectionNotified event
 * will be triggered.
 */
- (void)run;

/**
 * Determines whether the detector is running. This will return NO when
 * a detection is pending.
 */
- (BOOL)isDetectorRunning;

/**
 * Determines whether there is a detection pending.
 */
- (BOOL)hasPendingDetection;

/**
 * Determines whether the detector is active; which means that either it 
 * has the detector running, or has a detection which is pending.
 */
- (BOOL)isActive;

/**
 * Cancels the current detection so that no notification occurs.\
 *
 * This can be used to 
 */
- (void)cancelPendingDetection;

/**
 * Manually triggers a detection if the detector is running.
 */
- (void)triggerDetection;

/**
 * Forces notification of the pending detection.
 */
- (void)forceNotification;

/**
 * Obtains the name of the event posted to NSNotificationCenter when
 * a detection method detects a user.
 */
+ (NSString*)detectionOccurredEventName;

/**
 * Obtains the name of the event posted when notification methods are
 * used to notify the user.
 */
+ (NSString*)detectionNotifiedEventName;

/**
 * Obtains the name of the event posted when a pending detection is 
 * cancelled. 
 */
+ (NSString*)detectionCancelledEventName;



@end
