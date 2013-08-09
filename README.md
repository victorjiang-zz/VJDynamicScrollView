VJDynamicScrollView
===================

动态加载scrollView

method
/*
	count:有多少个页面
	imagesArray:用于设置PageView的backgroundImage,当你快速滑动的时候有的页面没有加载,就显示空白,可以通过设置该对象,给每个view一个默认的图片(最好是低清的),就解决上面显示空白的问题,可以为空
*/
- (id)initWithFrame:(CGRect)frame viewCount:(int)count delegate:(id<DynamicScrollViewDelegate>)delegate imagesArray:(NSArray *)imagesArray;

/*多少个页面*/
- (int)viewCount;

/*当前是第几个页面*/
- (int)currentPage;

DynamicScrollViewDelegate
- (UIView *)dynamicScrollView:(DynamicScrollView *)dynamicScrollView subViewForIndex:(int)index;

@optional
- (void)dynamicScrollView:(DynamicScrollView *)dynamicScrollView currentPageChanged:(int)currentPage;
