//
//  WSMViewController.h
//  WhoShookMe
//
//  Created by P Dev on 3/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WSMDetector.h"
#import "WSMNotifier.h"

@interface WSMViewController : UIViewController {
    WSMDetector *detector;
    WSMNotifier *notifier;
    NSMutableArray *infoSources;
    NSTimer *pollTimer;
    NSTimer *authTimer;
    bool requiresAuthentication;
}
@property (weak, nonatomic) IBOutlet UIButton *runButton;

- (IBAction)runButtonClicked:(id)sender;
- (IBAction)viewLogButtonClicked:(id)sender;


@end
