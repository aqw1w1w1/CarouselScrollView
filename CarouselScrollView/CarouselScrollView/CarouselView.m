//
//  CarouselView.m
//  CarouselScrollView
//
//  Created by Archer on 16/7/22.
//  Copyright © 2016年 AVIC. All rights reserved.
//

#import "CarouselView.h"
#import "UIImageView+WebCache.h"

#define PageTurnTime            3.0       //翻页时间间隔

/**
 *  轮播view
 */
@interface CarouselView ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;

/**
 *  图片个数
 */
@property (assign, nonatomic) NSInteger imageCount;

@end

@implementation CarouselView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initView:frame];
        [self startTimer];
    }
    
    return self;
}

- (void)initView:(CGRect)rect {
    rect.origin.x = 0;
    rect.origin.y = 0;
    
    //初始化scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    _scrollView.bounces = NO;//取消弹簧效果
    _scrollView.showsHorizontalScrollIndicator = NO; //关闭水平滚动条
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES; //开启分页
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    //初始化pageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [_pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
}

#pragma mark - 重写setter

/**
 *  重写setter
 *
 *  @param imageArray 图片数组
 */
- (void)setImageArray:(NSMutableArray *)imageArray {
    _imageArray = imageArray;
    _imageCount = imageArray.count;
    
    _scrollView.contentSize = CGSizeMake(_imageCount * _scrollView.bounds.size.width, 0);
    
    _pageControl.numberOfPages = _imageCount;
    CGSize size = [_pageControl sizeForNumberOfPages:_imageCount];
    size.height = 20;
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake(self.center.x, self.bounds.size.height - 20);
    _pageControl.currentPage = 0;
    
    for (int i = 0; i < _imageCount; i++) {
        UIImage *image = [UIImage imageNamed:imageArray[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
        imageView.image = image;
        [_scrollView addSubview:imageView];
    }
    
    [_scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = obj.frame;
        frame.origin.x = idx * frame.size.width;
        obj.frame = frame;
    }];
}

- (void)setImageUrlArray:(NSMutableArray *)imageUrlArray {
    _imageUrlArray = imageUrlArray;
    _imageCount = imageUrlArray.count;
    
    _scrollView.contentSize = CGSizeMake(imageUrlArray.count * _scrollView.bounds.size.width, 0);
    
    _pageControl.numberOfPages = imageUrlArray.count;
    CGSize size = [_pageControl sizeForNumberOfPages:imageUrlArray.count];
    size.height = 20;
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake(self.center.x, self.bounds.size.height - 20);
    _pageControl.currentPage = 0;
    
    for (int i = 0; i < imageUrlArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlArray[i]] placeholderImage:nil];
        [_scrollView addSubview:imageView];
    }
    
    [_scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = obj.frame;
        frame.origin.x = idx * frame.size.width;
        obj.frame = frame;
    }];
}

#pragma mark - 翻页处理

/**
 *  翻页监听方法
 *
 *  @param sender
 */
- (void)pageTurn:(UIPageControl *)sender {
    //根据当前pageControl位置调整scrollView的偏移
    CGFloat x = sender.currentPage * _scrollView.bounds.size.width;
    [_scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

/**
 *  创建Timer，并将其加入RunLoop
 */
- (void)startTimer {
    _timer = [NSTimer timerWithTimeInterval:PageTurnTime target:self selector:@selector(executePageTurn) userInfo:nil repeats:YES];
    // 添加到运行循环
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 *  NSTimer线程执行的方法
 */
- (void)executePageTurn {
    if (_imageCount > 0) {
        int page = (_pageControl.currentPage + 1) % _imageCount;
        _pageControl.currentPage = page;
        
        [self pageTurn:_pageControl];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    _pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [_timer setFireDate:[NSDate distantFuture]];
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    typeof(self) weakSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * PageTurnTime), dispatch_get_main_queue(), ^{
//        [weakSelf.timer setFireDate:[NSDate distantPast]];
//    });
    [self startTimer];
}

@end
