//
//  ZLCollocationModel.h
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLCollocationComModel.h"

@interface ZLCollocationModel : NSObject

@property(nonatomic, strong)NSNumber *width;
@property(nonatomic, strong)NSNumber *height;
@property(nonatomic, strong)ZLCollocationComModel *comModel;


@property(nonatomic, assign)float cellHeight;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
