//
//  CarouselView2.m
//  CarouselScrollView
//
//  Created by Archer on 16/8/18.
//  Copyright © 2016年 AVIC. All rights reserved.
//

#import "CarouselView2.h"
#import "UIImageView+WebCache.h"
#import "CarouselCollectionViewCell.h"

#define CollectionViewCellIdentifier            @"CollectionViewCellIdentifier"

#define PageTurnTime                            3.0       //翻页时间间隔


/**
 *  轮播view（collectionview实现）
 */
@interface CarouselView2 ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;

//图片个数
@property (assign, nonatomic) NSInteger imageCount;
//加载本地图片：1，网络图片：0
@property (assign, nonatomic) NSInteger loadImageStatus;

@end

@implementation CarouselView2

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
        
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(rect.size.width, rect.size.height);
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.minimumLineSpacing = 0.001f;
    flowLayout.minimumInteritemSpacing = 0.001f;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    _collectionView.frame = rect;
    _collectionView.backgroundColor = [UIColor grayColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:_collectionView];
    
    //初始化pageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [_pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
    
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"CarouselCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
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
    _loadImageStatus = 1;
    
    _pageControl.numberOfPages = _imageCount;
    CGSize size = [_pageControl sizeForNumberOfPages:_imageCount];
    size.height = 20;
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake(self.center.x, self.bounds.size.height - 20);
    _pageControl.currentPage = 0;
    
    [_collectionView reloadData];
}

- (void)setImageUrlArray:(NSMutableArray *)imageUrlArray {
    _imageUrlArray = imageUrlArray;
    _imageCount = imageUrlArray.count;
    _loadImageStatus = 0;
    
    _pageControl.numberOfPages = _imageCount;
    CGSize size = [_pageControl sizeForNumberOfPages:imageUrlArray.count];
    size.height = 20;
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake(self.center.x, self.bounds.size.height - 20);
    _pageControl.currentPage = 0;
    
    [_collectionView reloadData];
}

#pragma mark - 翻页处理

/**
 *  翻页监听方法
 *
 *  @param sender
 */
- (void)pageTurn:(UIPageControl *)sender {
    //根据当前pageControl位置调整scrollView的偏移
    CGFloat x = sender.currentPage * _collectionView.bounds.size.width;
    [_collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
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

#pragma mark UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
    //本地图片
    if (_loadImageStatus == 1) {
        [cell setCellLocalImage:_imageArray[indexPath.row]];
    }
    //网络图片
    else {
        [cell setCellNetImage:_imageUrlArray[indexPath.row]];
    }
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    _pageControl.currentPage = page;
}

@end
