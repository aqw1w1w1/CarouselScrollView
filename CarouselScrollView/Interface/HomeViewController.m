//
//  HomeViewController.m
//  CarouselScrollView
//
//  Created by Archer on 16/7/22.
//  Copyright © 2016年 AVIC. All rights reserved.
//

#import "HomeViewController.h"
#import "CarouselView.h"
#import "CarouselView2.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CarouselView *carouselView = [[CarouselView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 150.f)];
    carouselView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:carouselView];
    
//    carouselView.imageArray = [@[@"1.png", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg"] mutableCopy];
    carouselView.imageUrlArray = [@[@"http://ompimage.moonbasagroup.com/decorate/10/b6a1e4c29047409d87ec524376f81005/20160711/0674761f87a4488d84df55b8c6398d04_source.jpg", @"http://ompimage.moonbasagroup.com/decorate/10/24f6796b9bb64dd8ae34f710f242dba3/20160715/ff21999962034ef0a605d7914041980e_source.png", @"http://ompimage.moonbasagroup.com/decorate/10/24f6796b9bb64dd8ae34f710f242dba3/20160715/bf4d2037d9be408a8efd2f87e75539f2_source.jpg", @"http://ompimage.moonbasagroup.com/decorate/10/b6a1e4c29047409d87ec524376f81005/20160712/6603c9cbfa9c49e58d6abb907469eac7_source.jpg", @"http://ompimage.moonbasagroup.com/decorate/10/b6a1e4c29047409d87ec524376f81005/20160711/2dd469f6a38b4b16a3eb56f0cee975ea_source.jpg"] mutableCopy];
    
    //添加collectionview实现的轮播
    CarouselView2 *carouselView2 = [[CarouselView2 alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(carouselView.frame) + 20, self.view.bounds.size.width, 150.f)];
    carouselView2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:carouselView2];
    
    carouselView2.imageArray = [@[@"1.png", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg"] mutableCopy];
//    carouselView2.imageUrlArray = [@[@"http://ompimage.moonbasagroup.com/decorate/10/b6a1e4c29047409d87ec524376f81005/20160711/0674761f87a4488d84df55b8c6398d04_source.jpg", @"http://ompimage.moonbasagroup.com/decorate/10/24f6796b9bb64dd8ae34f710f242dba3/20160715/ff21999962034ef0a605d7914041980e_source.png", @"http://ompimage.moonbasagroup.com/decorate/10/24f6796b9bb64dd8ae34f710f242dba3/20160715/bf4d2037d9be408a8efd2f87e75539f2_source.jpg", @"http://ompimage.moonbasagroup.com/decorate/10/b6a1e4c29047409d87ec524376f81005/20160712/6603c9cbfa9c49e58d6abb907469eac7_source.jpg", @"http://ompimage.moonbasagroup.com/decorate/10/b6a1e4c29047409d87ec524376f81005/20160711/2dd469f6a38b4b16a3eb56f0cee975ea_source.jpg"] mutableCopy];
}

@end
