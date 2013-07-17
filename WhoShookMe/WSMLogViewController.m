//
//  WSMLogViewController.m
//  WhoShookMe
//
//  Created by P Dev on 11/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMLogViewController.h"

@interface WSMLogViewController ()

@end

@implementation WSMLogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *tempDir = NSTemporaryDirectory();
    NSString *fileName = @"Activity_Log.txt";
    
    NSString *path = [tempDir stringByAppendingPathComponent:fileName];
    NSString *contentsOfFile = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"\nContents of file\n%@", contentsOfFile);
    
    [self.logText setText:contentsOfFile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
