//
//  WSMViewController.h
//  WhoShookMe
//
//  Created by P Dev on 3/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreMotion/CoreMotion.h>

@interface WSMViewController : UIViewController {
    double x;
    double y;
    double z;
    bool detected;
    bool firstReadingTaken;
}
@property (weak, nonatomic) IBOutlet UILabel *xCoord;
@property (weak, nonatomic) IBOutlet UILabel *yCoord;
@property (weak, nonatomic) IBOutlet UILabel *zCoord;
- (IBAction)clearButton:(id)sender;

@property (nonatomic, strong) CMMotionManager *motionManager;


@end
