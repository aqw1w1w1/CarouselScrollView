//
//  CarouselCollectionViewCell.m
//  CarouselScrollView
//
//  Created by Archer on 16/8/18.
//  Copyright © 2016年 AVIC. All rights reserved.
//

#import "CarouselCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface CarouselCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CarouselCollectionViewCell

- (void)awakeFromNib {
    
}

/**
 *  设置本地图片
 *
 *  @param imageStr 图片路径
 */
- (void)setCellLocalImage:(NSString *)imageStr {
    _imageView.image = [UIImage imageNamed:imageStr];
}

/**
 *  设置网络图片
 *
 *  @param imageUrl 图片url
 */
- (void)setCellNetImage:(NSString *)imageUrl {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
}

@end
