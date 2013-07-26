//
//  WSMViewController.m
//  WhoShookMe
//
//  Created by P Dev on 3/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMViewController.h"

#import "WSMReflection.h"
#import "WSMDetector.h"

#import "WSMGradientBackgrounds.h"

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

- (IBAction)viewLogButtonClicked:(id)sender {

}

- (IBAction)runButtonClicked:(id)sender {
    
}

- (void) viewDidAppear:(BOOL)animated {
    
}

- (void) viewDidDisappear:(BOOL)animated {
}

- (void)viewWillAppear:(BOOL)animated {
//    [WSMGradientBackgrounds useBackground:[WSMGradientBackgrounds greyGradient] forController:self];
    [WSMGradientBackgrounds useBackground:[WSMGradientBackgrounds reverseBlackGradient] forController:self];
}



@end
