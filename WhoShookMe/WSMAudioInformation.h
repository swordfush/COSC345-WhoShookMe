//
//  WSMAudioInformation.h
//  WhoShookMe
//
//  Created by Maddy Mills on 26/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "WSMInformationSource.h"

@interface WSMAudioInformation : NSObject <WSMInformationSource, AVAudioRecorderDelegate> {
    AVAudioRecorder *recorder;
    NSString *filePath;
}

- (void)prepareInfo;
- (NSString*)getInfo;
- (void)dumpInfo;
- (NSString*)informationTypeIdentifier;
+ (NSString*)informationTypeIdentifier;

@end
