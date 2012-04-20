//
//  ViewController.m
//  NavBarTitleSwipe
//
//  Created by Josh Holtz on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#import "SwipeLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    [label1 setFont:[UIFont boldSystemFontOfSize:16.0]];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:[UIColor whiteColor]];
    [label1 setText:@"SwipeTitle"];
    [label1 setTextAlignment:UITextAlignmentCenter];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    [label2 setFont:[UIFont boldSystemFontOfSize:16.0]];
    [label2 setBackgroundColor:[UIColor clearColor]];
    [label2 setTextColor:[UIColor whiteColor]];
    [label2 setText:@"Questions"];
    [label2 setTextAlignment:UITextAlignmentCenter];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    [label3 setFont:[UIFont boldSystemFontOfSize:16.0]];
    [label3 setBackgroundColor:[UIColor clearColor]];
    [label3 setTextColor:[UIColor whiteColor]];
    [label3 setText:@"Images"];
    [label3 setTextAlignment:UITextAlignmentCenter];
    
    SwipeLabel *label = [[SwipeLabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30) withOptions:[[NSArray alloc] initWithObjects:label1,label2,label3, nil]];
    label.delegate = self;
    
    [self.navigationController.navigationBar.topItem setTitleView:label];
    
}

- (void)swipeLabelChanged:(NSInteger)index withText:(NSString *)text {
    NSLog(@"%d - %@", index, text);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
