//
//  tadyNewModel.m
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/6.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "tadyNewModel.h"

@implementation tadyNewModel


- (instancetype)initWithTadyNewDic:(NSDictionary *)dic{
    self= [super init];
    if (self) {
        NSDictionary *componentDic = [dic objectForKey:@"component"];
      
        self.price = [[componentDic objectForKey:@"price"]integerValue];
        self.nationalFlag = [componentDic objectForKey:@"nationalFlag"];
        self.origin_price = [[componentDic objectForKey:@"origin_price"]integerValue];
        self.country = [componentDic objectForKey:@"country"];
        self.descriptionNew = [componentDic objectForKey:@"description"];
        self.picUrl = [componentDic objectForKey:@"picUrl"];
    }
    return self;
}

+ (instancetype)TadyNewDic:(NSDictionary *)dic{
    return [[self alloc]initWithTadyNewDic:dic];
 }

@end
