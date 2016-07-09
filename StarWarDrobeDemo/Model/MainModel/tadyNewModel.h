//
//  tadyNewModel.h
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/6.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tadyNewModel : NSObject

//国家
@property (copy, nonatomic)NSString *country;
//描述
@property (copy, nonatomic)NSString *descriptionNew;
//国籍
@property (copy, nonatomic)NSString *nationalFlag;
//图片
@property (copy, nonatomic)NSString  *picUrl;
//价格
@property (assign, nonatomic)NSInteger price;
//原先价格
@property (assign , nonatomic)NSInteger origin_price;


- (instancetype)initWithTadyNewDic:(NSDictionary *)dic;

+ (instancetype)TadyNewDic:(NSDictionary *)dic;

@end
