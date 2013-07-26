//
//  WSMAuthenticationPin.m
//  WhoShookMe
//
//  Created by Maddy Mills on 26/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMAuthenticationPin.h"

@implementation WSMAuthenticationPin

static WSMAuthenticationPin* singleton;

+ (NSString*)filePath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/pin"];
}


+ (void)initialize {
    static BOOL initialized = NO;
    if (!initialized) {
        singleton = [[WSMAuthenticationPin alloc] init];
        initialized = YES;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[WSMAuthenticationPin filePath]]) {
            pin = [NSString stringWithContentsOfFile:[WSMAuthenticationPin filePath] encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"Loaded pin: %@", pin);
        }
    }
    return self;
}

+ (WSMAuthenticationPin*)instance {
    return singleton;
}

- (BOOL)pinExists {
    return pin != nil;
}

- (void)setPin:(NSString*)newPin {
    NSAssert([newPin length] == 4, @"Pins must have a length of 4 digits");
    
    pin = newPin;
    [pin writeToFile:[WSMAuthenticationPin filePath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (BOOL)authenticate:(NSString*)attempt {
    NSLog(@"Comparing pin attempt %@ against the current pin %@", attempt, pin);
    NSAssert([self pinExists], @"No pin exists");
    return [pin isEqualToString:attempt];
}

@end
