//
//  WSMNotificationInfo.h
//  WhoShookMeSkeleton
//
//  Created by Stuart Johnston on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A source which gathers information about a detection.
 */
@protocol WSMInformationSource <NSObject> 

/**
 * Prepares the information source for gathering information.
 * For sources such as video and audio, this indicates that they should begin recording.
 *
 * This would indicate that a detection has occurred, so single reading sources may want 
 * to take their reading when this is called.
 */
- (void)prepareInfo;

/**
 * Gets the information the source has acquired. 
 *
 * For sources such as video and audio, this indicates they should stop recording. 
 *
 * Do note that in some situations we may be forced to prepare and then get the 
 * information immediately after. For example when the application is being closed.
 *
 * This means that information should probably be dumped if it is not substantial,
 * e.g. when the audio recording is less than a second long.
 */
- (NSString*)getInfo;

/**
 * This is called when a source is required to dump any information it has acquired.
 *
 * Normally this will happen when the user authenticates themselves, and so no detection
 * should be recorded.
 */
- (void)dumpInfo;

/**
 * Returns the name of the information this source gathers. It is used as a dictionary
 * key, so these must be unique between implementing classes.
 */
- (NSString*)informationTypeIdentifier;


@end
