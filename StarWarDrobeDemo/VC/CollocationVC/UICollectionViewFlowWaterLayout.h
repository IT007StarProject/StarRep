//
//  UICollectionViewFlowWaterLayout.h
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlowWaterDelegate <NSObject>

- (CGFloat)getHeight:(NSIndexPath *)indexPath;


@end


@interface UICollectionViewFlowWaterLayout : UICollectionViewLayout

//声明列数
@property(nonatomic, assign)NSInteger columnCount;
//声明每一个item的高度
@property(nonatomic, assign)CGFloat itemWith;
//设置section的大小
@property(nonatomic, assign)UIEdgeInsets sectionInset;

@property (nonatomic, assign) id<FlowWaterDelegate>delegate;



@end
