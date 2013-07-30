//
//  WSMViewController.h
//  WhoShookMe
//
//  Created by P Dev on 3/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface WSMViewController : UIViewController {
    NSTimer *logoutTimer;
    CAGradientLayer *gradient;
    BOOL requiresAuthentication;
}

@end
