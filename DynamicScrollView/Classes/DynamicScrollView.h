//
//  DynamicScrollView.h
//  FreeTradeZone
//
//  Created by Victor Jiang on 8/7/13.
//  Copyright (c) 2013 Victor Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageView.h"
#import "UIView+Animation.h"

@class DynamicScrollView;
@protocol DynamicScrollViewDelegate <NSObject>

- (UIView *)dynamicScrollView:(DynamicScrollView *)dynamicScrollView subViewForIndex:(int)index;

@optional
- (void)dynamicScrollView:(DynamicScrollView *)dynamicScrollView currentPageChanged:(int)currentPage;

@end

@interface DynamicScrollView : UIScrollView<UIScrollViewDelegate>
{
    NSMutableArray *viewArray;
    NSArray *imageArray;  //用于设置PageView的backgroundImage,当你快速滑动的时候有的页面没有加载,就显示空白,可以通过设置该对象,给每个view一个默认的图片(最好是低清的),就解决上面显示空白的问题,可以为空
    int viewCount;  //有多少个页面
    int currentPage;    //当前是第几个页面
}

@property (nonatomic, assign) id<DynamicScrollViewDelegate> dynamicScrollViewDelegate;

- (id)initWithFrame:(CGRect)frame viewCount:(int)count delegate:(id<DynamicScrollViewDelegate>)delegate imagesArray:(NSArray *)imagesArray;
- (int)viewCount;
- (int)currentPage;

@end
