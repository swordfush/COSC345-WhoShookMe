//
//  WSMViewController.h
//  WhoShookMe
//
//  Created by P Dev on 3/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface WSMViewController : UIViewController <UIAlertViewDelegate> {
    NSTimer *logoutTimer;
    CAGradientLayer *gradient;
    BOOL hasRunInitialAuthentication;
}

- (IBAction)helpButtonPressed:(id)sender;

@end
