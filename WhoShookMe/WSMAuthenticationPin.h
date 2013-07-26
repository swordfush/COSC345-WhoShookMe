//
//  WSMAuthenticationPin.h
//  WhoShookMe
//
//  Created by Maddy Mills on 26/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSMAuthenticationPin : NSObject {
    NSString *pin;
}

+ (WSMAuthenticationPin*)instance;

- (BOOL)pinExists;
- (void)setPin:(NSString*)newPin;
- (BOOL)authenticate:(NSString*)attempt;

@end
