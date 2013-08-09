//
//  ViewController.m
//  DynamicScrollView
//
//  Created by Victor Jiang on 8/9/13.
//  Copyright (c) 2013 Victor Jiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGSize winSize = [[[UIApplication sharedApplication] delegate] window].bounds.size;
    
    DynamicScrollView *dynScrollView = [[DynamicScrollView alloc] initWithFrame:CGRectMake(0, 0, winSize.width, winSize.height - [[UIApplication sharedApplication] statusBarFrame].size.height) viewCount:5 delegate:self imagesArray:nil];
    [self.view addSubview:dynScrollView];
    [dynScrollView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DynamicScrollViewDelegate method
- (UIView *)dynamicScrollView:(DynamicScrollView *)dynamicScrollView subViewForIndex:(int)index
{
    UIView *view = [[[UIView alloc] initWithFrame:dynamicScrollView.bounds] autorelease];
    UILabel *label = [[UILabel alloc] init];
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = [[NSString stringWithFormat:@"%i", index] sizeWithFont:font];
    label.font = font;
    label.textColor = [UIColor blackColor];
    label.text = [NSString stringWithFormat:@"%i", index];
    label.frame = CGRectMake(0, 0, size.width, size.height);
    label.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    [view addSubview:label];
    [label release];
    
    return view;
}



@end
