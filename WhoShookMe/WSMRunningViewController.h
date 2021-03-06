//
//  WSMRunningViewController.h
//  WhoShookMe
//
//  Created by Maddy Mills on 25/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WSMAuthenticationViewController.h"

@interface WSMRunningViewController : UIViewController {
    int secondsElapsed;
    NSTimer *secondTimer;
}

- (IBAction)triggerDetection:(id)sender;

@property (weak, nonatomic) IBOutlet UIProgressView *countdownProgressBar;
@property (weak, nonatomic) IBOutlet UILabel *helpLabel;


@end
