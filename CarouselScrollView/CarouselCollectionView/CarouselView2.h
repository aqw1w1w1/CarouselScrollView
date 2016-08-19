//
//  CarouselView2.h
//  CarouselScrollView
//
//  Created by Archer on 16/8/18.
//  Copyright © 2016年 AVIC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  轮播view（collectionview实现）
 */
@interface CarouselView2 : UIView

/**
 *  本地图片数组
 */
@property (strong, nonatomic) NSMutableArray *imageArray;
/**
 *  网络图片数组(图片链接)
 */
@property(strong, nonatomic) NSMutableArray *imageUrlArray;

@end
