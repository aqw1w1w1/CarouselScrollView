//
//  CarouselView.h
//  CarouselScrollView
//
//  Created by Archer on 16/7/22.
//  Copyright © 2016年 AVIC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  轮播view
 */
@interface CarouselView : UIView

/**
 *  本地图片数组
 */
@property (strong, nonatomic) NSMutableArray *imageArray;
/**
 *  网络图片数组(图片链接)
 */
@property(strong, nonatomic) NSMutableArray *imageUrlArray;

@end
