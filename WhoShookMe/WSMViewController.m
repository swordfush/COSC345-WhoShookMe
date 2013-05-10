//
//  WSMViewController.m
//  WhoShookMe
//
//  Created by P Dev on 3/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMViewController.h"

@interface WSMViewController ()

@end

@implementation WSMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize xCoord = _xCoord;
@synthesize yCoord = _yCoord;
@synthesize zCoord = _zCoord;


- (IBAction)clearButton:(id)sender {
    self->detected = false;
}

- (void) updateLabels {
    self.xCoord.text = [NSString stringWithFormat:@"x: %f", self->x];
    self.yCoord.text = [NSString stringWithFormat:@"y: %f", self->y];
    self.zCoord.text = [NSString stringWithFormat:@"z: %f", self->z];
}

- (void) viewDidAppear:(BOOL)animated {
    const double THRESHOLD = 0.1;
    
    @try {
        self->x = 0;
        self->y = 0;
        self->z = 0;
        self->detected = false;
        self->firstReadingTaken = false;
        
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.accelerometerUpdateInterval = 0.2;
        
        if ([self.motionManager isAccelerometerAvailable]) {
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Should probably calculate the distance between the two vectors instead of each component
                    if (!firstReadingTaken) {
                        firstReadingTaken = true;
                    } else if (!detected) {
                        double dx = fabs(accelerometerData.acceleration.x - self->x);
                        double dy = fabs(accelerometerData.acceleration.y - self->y);
                        double dz = fabs(accelerometerData.acceleration.z - self->z);
                    
                        if (dx > THRESHOLD || dy > THRESHOLD || dz > THRESHOLD) {
                            self.xCoord.text = @"Detected";
                            self.yCoord.text = @"";
                            self.zCoord.text = @"";
                            self->detected = true;
                        } else {
                            self.xCoord.text = [NSString stringWithFormat:@"dx: %f", dx];
                            self.yCoord.text = [NSString stringWithFormat:@"dy: %f", dy];
                            self.zCoord.text = [NSString stringWithFormat:@"dz: %f", dz];
                        }
                    }
                    
                    self->x = accelerometerData.acceleration.x;
                    self->y = accelerometerData.acceleration.y;
                    self->z = accelerometerData.acceleration.z;
                });
            }];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Accelerometer failed: %@", exception.reason);
    }
}

- (void) viewDidDisappear:(BOOL)animated {
}



@end
