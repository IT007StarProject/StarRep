//
//  MainManagerTools.h
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  ***************首页的工具类，主要用来请求数据**********
 */
@interface MainManagerTools : NSObject

/**
 *  请求首页顶部scroller
 *
 *  @param complain 传一个数组参数
 */
+ (void)GetmainDataTopScroller:(void(^)(NSArray *MainArr))complain;

/**
 *  特价限时购获取数据
 */
+ (void)GetTimeInfoDic:(void(^)(NSArray *timeArr))timeComplain;


/**
 *  韩国馆信息
 *
 *  @param KoreaComplain 获取各馆的信息
 */
+ (void)getIndex:(NSInteger)index GuanInfoDic:(void(^)(NSArray *KoreaArr))KoreaComplain;

/**
 *  获取今日上新的数据
 */
+ (void)getTadyNewClothesBlock:(void(^)(NSArray *TadArr))complain;

/**
 *  获取上装的数据
 */
+ (void)getjacketDataBlock:(void(^)(NSArray *Jackers))complain;

/**
 *  获取裙装的数据
 */

+ (void)getDressDataBlcok:(void(^)(NSArray *DressArr))complain;

/**
 *  获取裤装的数据
 */

+ (void)getTrousersData:(void(^)(NSArray *Trouses))complain;

/**
 *  获取最新的的今日上新的数据
 */

+ (void)getImageDataUrl:(NSString *)url withData:(void(^)(NSArray *array))complain;


/**
 *  社区顶部的TopScrollerView
 */
+ (void)communityViewTopScrollerData:(void(^)(NSArray *dataArr))complain;

/**
 *  社区顶部scrollview 下面的数据
 */

//+ (void)community;

@end
