//
//  MainTopScrollerModel.m
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "MainTopScrollerModel.h"

@implementation MainTopScrollerModel

- (instancetype)initWithTopScrollerDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        NSDictionary *picDic = [dic objectForKey:@"component"];  
        self.picUrl = [picDic objectForKey:@"picUrl"];
        self.width = [[dic objectForKey:@"width"]integerValue];
        self.Height = [[dic objectForKey:@"hegith"]integerValue];   
    }
    return self;
}

+ (instancetype)topScrollerDic:(NSDictionary *)dic{
    return [[self alloc]initWithTopScrollerDic:dic];
}

@end



/**
 限时购物model
 
 - returns: 单独的model
 */
@implementation img_indexModel


- (instancetype)initWithimg_indexDic:(NSDictionary *)dic{
    if (self =[super init]) {
        
         NSDictionary *picDic = [dic objectForKey:@"component"];
          self.img_index = [picDic objectForKey:@"img_index"];
        self.end_time =[[picDic objectForKey:@"end_time"]integerValue];
    }
    return self;
}

+ (instancetype)img_indexDic:(NSDictionary *)dic{
    return [[self alloc]initWithimg_indexDic:dic];
}

@end

