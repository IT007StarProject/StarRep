//
//  communityModel.m
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/8.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "communityModel.h"

@implementation communityModel

- (instancetype)initWithCommunityDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        
        NSDictionary *componet = [dic objectForKey:@"component"];
        
        self.picUrl = [componet objectForKey:@"picUrl"];
        self.height = [[componet objectForKey:@"height"]integerValue];
        self.width = [[componet objectForKey:@"width"]integerValue];
   
    }
    return self;
}

+ (instancetype)communityDic:(NSDictionary *)dic{
    return [[self alloc]initWithCommunityDic:dic];
}

@end
