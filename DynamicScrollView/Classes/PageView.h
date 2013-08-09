//
//  PageView.h
//  FreeTradeZone
//
//  Created by Victor Jiang on 8/7/13.
//  Copyright (c) 2013 Victor Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageView : UIView
{
    UIImageView *backgroundView;
    UIView *contentView;
}

@property (nonatomic, readonly) BOOL isContentReleased;

- (void)setBackgroundImage:(UIImage*)image;
- (void)setContentView:(UIView*)view;
- (UIView*)contentView;
- (void)releasePageView;

@end
