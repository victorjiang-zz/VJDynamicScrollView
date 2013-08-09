//
//  PageView.m
//  FreeTradeZone
//
//  Created by Victor Jiang on 8/7/13.
//  Copyright (c) 2013 Victor Jiang. All rights reserved.
//

#import "PageView.h"
#import "UIView+Animation.h"

@implementation PageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        contentView = nil;
        backgroundView = nil;
        _isContentReleased = YES;
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)image
{
    backgroundView = [[UIImageView alloc] initWithFrame:self.frame];
    backgroundView.image = image;
    [self addSubview:backgroundView];
}

-(void)setContentView:(UIView *)view
{
    if (contentView) {
        [contentView removeFromSuperview];
        [contentView release];
        contentView = nil;
    }
    
    contentView = view;
    [contentView retain];
    contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:contentView];
    
    _isContentReleased = NO;
}

-(UIView *)contentView
{
    return contentView;
}

-(void)releasePageView
{
    if (contentView) {
        [contentView stopAnimation];
        [contentView removeFromSuperview];
        [contentView release];
        contentView = nil;
//        NSLog(@"releaseView:%.0f",self.frame.origin.x/self.frame.size.width);
    }
    _isContentReleased = YES;
}

@end
