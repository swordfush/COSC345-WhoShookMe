//
//  WSMNotificationInfo.h
//  WhoShookMeSkeleton
//
//  Created by Stuart Johnston on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

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
 * key, so these must be unique.
 */
+ (NSString*)infoTypeName;


@end
