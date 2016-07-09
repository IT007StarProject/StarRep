//
//  communityModel.h
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/8.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface communityModel : NSObject

@property (copy, nonatomic)NSString *picUrl;
@property (copy, nonatomic)NSString *title;
@property (assign, nonatomic) NSInteger height;
@property (assign, nonatomic) NSInteger width;




- (instancetype)initWithCommunityDic:(NSDictionary *)dic;

+ (instancetype)communityDic:(NSDictionary *)dic;
@end
