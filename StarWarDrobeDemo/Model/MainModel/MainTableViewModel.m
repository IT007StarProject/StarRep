//
//  MainTableViewModel.m
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/5.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "MainTableViewModel.h"

@implementation MainTableViewModel
- (instancetype)initWithRegion_nameDic:(NSDictionary *)Dic{

    self = [super init];
    if (self) {
      
        NSDictionary *ComponentDic = [Dic objectForKey:@"component"];
        self.PicUrl = [ComponentDic objectForKey:@"picUrl"];
        self.price = [ComponentDic objectForKey:@"price"];
        self.origin_price = [ComponentDic objectForKey:@"origin_price"];
        self.title = [ComponentDic objectForKey:@"title"];
        self.Height = [[ComponentDic objectForKey:@"height"]integerValue];
        self.Width = [[ComponentDic objectForKey:@"width"]integerValue];
    }
    return self;
}

+ (instancetype)region_nameDic:(NSDictionary *)dic{
    return [[self alloc]initWithRegion_nameDic:dic];
}
@end
