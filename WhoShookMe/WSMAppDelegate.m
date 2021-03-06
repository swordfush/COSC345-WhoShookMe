//
//  WSMAppDelegate.m
//  WhoShookMe
//
//  Created by P Dev on 3/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMAppDelegate.h"

#import "WSMDetector.h"
#import "WSMLog.h"
#import "WSMAuthenticationPin.h"

#import "WSMSetPinViewController.h"

@implementation WSMAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Keychain items (read app pin) are not deleted when the app is. NSUserDefaults are deleted with the app, so we can use them to determine when we need to delete the keychain key so as to emulate a fresh install
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"FirstRun"] && [[WSMAuthenticationPin instance] pinExists]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"FirstRun" forKey:@"FirstRun"];
        
        [[WSMAuthenticationPin instance] deletePin];
    }

    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateInactive) {
        NSLog(@"Screen was locked");
    } else if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
        NSLog(@"App was minimized");
        [self appClosing];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateInactive) {
        NSLog(@"Came out of screen lock  or call");
        
        // If the detector is running then someone is using the device
        if ([[WSMDetector instance] isDetectorRunning]) {
            [[WSMDetector instance] triggerDetection];
        }
    } else if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
        NSLog(@"App was restored from minimized state");
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"App is being terminated");
    [self appClosing];
}

- (void)appClosing {    
    if ([[WSMDetector instance] isActive]) {
        // Note that if the app is being closed we will not have time to capture decent audio or video
        if ([[WSMDetector instance] isDetectorRunning]) {
            [[WSMDetector instance] triggerDetection];
        }
        [[WSMDetector instance] forceNotification];
    }
    
    // Save after (possibly) forcing the detection so that we get the most recent detection saved immediately
    [[WSMLog instance] saveLog];
}

@end
