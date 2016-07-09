//
//  ZLCollocationComModel.h
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLCollocationComModel : NSObject

@property(nonatomic, copy)NSString  * picUrl;
@property(nonatomic,strong)NSString * itemsCount;
@property(nonatomic,strong)NSString * collectionCount;
@property(nonatomic, copy)NSString  * Description;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
