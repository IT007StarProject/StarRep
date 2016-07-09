//
//  MainTableViewModel.h
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/5.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  ************每一个馆要调用的button**********
 */
@interface MainTableViewModel : NSObject

@property (copy, nonatomic) NSString *PicUrl;
@property (assign, nonatomic) NSInteger Height;
@property (assign, nonatomic) NSInteger Width;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *origin_price;
@property (copy, nonatomic) NSString *title;

- (instancetype)initWithRegion_nameDic:(NSDictionary *)Dic;
+ (instancetype)region_nameDic:(NSDictionary *)dic;
@end



