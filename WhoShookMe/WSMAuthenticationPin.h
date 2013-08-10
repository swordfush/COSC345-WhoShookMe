//
//  WSMAuthenticationPin.h
//  WhoShookMe
//
//  Created by Maddy Mills on 26/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SSKeychainQuery.h"

/**
 * Provides access to the application pin which is used to identify the 
 * owner of the device.
 */
@interface WSMAuthenticationPin : NSObject {
    NSString *pin;
    SSKeychainQuery *keychain;
}

/**
 * Returns a reference to the singleton instance.
 */
+ (WSMAuthenticationPin*)instance;

/**
 * Determines whether the pin exists.
 */
- (BOOL)pinExists;

/**
 * Sets the application pin to the pin provided.
 *
 * @param newPin A pin which is a 4 digit number.
 */
- (void)setPin:(NSString*)newPin;

/**
 * Deletes the current application pin saved in the keychain.
 *
 * @return True if the pin was successfully deleted, else false.
 */
- (BOOL)deletePin;

/**
 * Determines whether the attempt matches the application pin
 * or not.
 *
 * @param attempt The pin number to attempt to authenticate against 
 *  the application pin.
 */
- (BOOL)authenticate:(NSString*)attempt;

@end
