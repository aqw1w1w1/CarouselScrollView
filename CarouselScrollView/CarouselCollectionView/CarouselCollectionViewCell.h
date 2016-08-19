//
//  CarouselCollectionViewCell.h
//  CarouselScrollView
//
//  Created by Archer on 16/8/18.
//  Copyright © 2016年 AVIC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  轮播用的collectionViewCell
 */
@interface CarouselCollectionViewCell : UICollectionViewCell

/**
 *  设置本地图片
 *
 *  @param imageStr 图片路径
 */
- (void)setCellLocalImage:(NSString *)imageStr;
/**
 *  设置网络图片
 *
 *  @param imageUrl 图片url
 */
- (void)setCellNetImage:(NSString *)imageUrl;

@end

