//
//  WSMAudioInformation.m
//  WhoShookMe
//
//  Created by Maddy Mills on 26/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMAudioInformation.h"


@implementation WSMAudioInformation

- (NSString*)getNewFilePath {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss-SSS"];
    
    NSString *filename = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *appendedPath = [NSString stringWithFormat:@"Documents/%@.m4a", filename];
    return [NSHomeDirectory() stringByAppendingPathComponent:appendedPath];
}


- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)prepareInfo {
    recorder = nil;
    filePath = nil;
    
    NSError *error = nil;
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryRecord error:&error];
    if (error != nil) return;
    
    [session setActive:YES error:nil];
    if (error != nil) return;
    
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    
    [recordSettings setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSettings setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSettings setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    filePath = [self getNewFilePath];
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:&error];
    if (error != nil) return;
    
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
    [recorder record];
}

- (NSString*)getInfo {
    if (recorder == nil) {
        return nil;
    } else {
        [recorder stop];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
        
        return filePath;
    }
}

- (void)dumpInfo {
    [recorder stop];
    [recorder deleteRecording];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

- (NSString*)informationTypeIdentifier {
    return [WSMAudioInformation informationTypeIdentifier];
}

+ (NSString*)informationTypeIdentifier {
    return @"AudioRecording";
}

@end
