//
//  MainTopScrollerModel.h
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * *************************** 首页topScrollerView ******************
 */
@interface MainTopScrollerModel : NSObject

@property (copy, nonatomic) NSString *picUrl;
@property (assign, nonatomic) NSInteger width;
@property (assign, nonatomic) NSInteger Height;

- (instancetype)initWithTopScrollerDic:(NSDictionary *)dic;

+ (instancetype)topScrollerDic:(NSDictionary *)dic;

@end


/**
 * ***************************限时购物model******************
 */
@interface img_indexModel : NSObject

@property (assign, nonatomic) NSInteger end_time;
@property (assign, nonatomic) NSInteger start_time;
@property (copy, nonatomic) NSString *img_index;


- (instancetype)initWithimg_indexDic:(NSDictionary *)dic;

+ (instancetype)img_indexDic:(NSDictionary *)dic;

@end