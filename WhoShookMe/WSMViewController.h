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
    NSTimer *pollTimer;
}

@property (weak, nonatomic) IBOutlet UILabel *xCoord;
@property (weak, nonatomic) IBOutlet UILabel *yCoord;
@property (weak, nonatomic) IBOutlet UILabel *zCoord;
- (IBAction)clearButton:(id)sender;


@end
