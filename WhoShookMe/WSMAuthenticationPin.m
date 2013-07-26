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
        keychain = [[SSKeychainQuery alloc] init];
        keychain.service = @"WhoShookMe";
        keychain.account = @"WhoShookMeUser";
        NSError *error = nil;
        [keychain fetch:&error];
        
        if (error == nil) {
            pin = [keychain password];
            NSLog(@"Read pin: %@", pin);
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
    
    [keychain setPassword:newPin];
    NSError *error = nil;
    [keychain save:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    } else {
        pin = newPin;
        NSLog(@"Set pin: %@", pin);
    }
}

- (BOOL)authenticate:(NSString*)attempt {
    NSLog(@"Comparing pin attempt %@ against the current pin %@", attempt, pin);
    NSAssert([self pinExists], @"No pin exists");
    return [pin isEqualToString:attempt];
}

@end
