//
//  DynamicScrollView.m
//  FreeTradeZone
//
//  Created by Victor Jiang on 8/7/13.
//  Copyright (c) 2013 Victor Jiang. All rights reserved.
//

#import "DynamicScrollView.h"

@implementation DynamicScrollView

- (id)initWithFrame:(CGRect)frame viewCount:(int)count delegate:(id<DynamicScrollViewDelegate>)delegate imagesArray:(NSArray *)imagesArray
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        viewCount = count;
        self.dynamicScrollViewDelegate = delegate;
        imageArray = [imagesArray retain];
        
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.contentSize = CGSizeMake(frame.size.width * count, frame.size.height);
        self.delegate = self;
        
        [self initSubView];
    }
    return self;
}

- (void)dealloc
{
    [imageArray release];
    [viewArray release];
    [super dealloc];
}

- (int)viewCount
{
    return viewCount;
}

- (int)currentPage
{
    return currentPage;
}

- (void)initSubView
{
    if (!viewArray) {
        viewArray = [[NSMutableArray alloc] init];
    }
    [viewArray removeAllObjects];
    
    for (int i = 0; i < viewCount; i++) {
        PageView *pageView = [[PageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        [pageView setBackgroundImage:[imageArray objectAtIndex:i]];
        [self addSubview:pageView];
        [viewArray addObject:pageView];
        [pageView release];
    }
    
    currentPage = 0;
    if (self.dynamicScrollViewDelegate && [self.dynamicScrollViewDelegate respondsToSelector:@selector(dynamicScrollView:currentPageChanged:)]) {
        [self.dynamicScrollViewDelegate dynamicScrollView:self currentPageChanged:currentPage];
    }
    [self updateViewAtIndex:0];
}

#pragma mark - view method
- (void)loadViewAtIndex:(int)index
{
    //加载指定页
    if (index < 0 || index >= viewCount) {
        return;
    }
    
    PageView *pageView = [viewArray objectAtIndex:index];
    if (pageView.isContentReleased) {
        UIView *contentView = [self subViewForIndex:index];
        [pageView setContentView:contentView];
//        contentView.tag = index + 100;
//        [contentView release];
    }
}

- (UIView *)subViewForIndex:(int)index
{
    if (self.dynamicScrollViewDelegate && [self.dynamicScrollViewDelegate respondsToSelector:@selector(dynamicScrollView:subViewForIndex:)]) {
        return [self.dynamicScrollViewDelegate dynamicScrollView:self subViewForIndex:index];
    }
    return nil;
}

- (void)updateViewAtIndex:(int)index
{
    //更新指定页
    for (int i = 0; i < viewCount; i++) {
        if (i != index - 1 && i != index && i != index + 1) {
            //删除不是附近的页面
            [self removeViewAtIndex:i];
        }
    }
    
    [self loadViewAtIndex:index];
    [[(PageView *)[viewArray objectAtIndex:index] contentView] startAnimation];
    [self loadViewAtIndex:index - 1];
    [self loadViewAtIndex:index + 1];
}

- (void)removeViewAtIndex:(int)index
{
    //删除指定页
    if (index < 0 || index >= [viewArray count]) {
        return;
    }
    
    PageView *removedView = [viewArray objectAtIndex:index];
    if (!removedView.isContentReleased) {
        [removedView releasePageView];
    }
}

#pragma mark - scrollView delegate method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWith = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWith / 2) / pageWith) + 1;
    
    PageView *currentPageView = [viewArray objectAtIndex:currentPage];
    if (page != currentPage) {
        [[currentPageView contentView] stopAnimation];
        [self updateViewAtIndex:page];
        currentPage = page;
        if (self.dynamicScrollViewDelegate && [self.dynamicScrollViewDelegate respondsToSelector:@selector(dynamicScrollView:currentPageChanged:)]) {
            [self.dynamicScrollViewDelegate dynamicScrollView:self currentPageChanged:currentPage];
        }
    }
}

@end
