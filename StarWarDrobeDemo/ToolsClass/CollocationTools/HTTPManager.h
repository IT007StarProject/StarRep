//
//  HTTPManager.h
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block)(NSMutableArray *array);
@interface HTTPManager : NSObject

//+ (void)getCollocationDataWithBlock:(Block)myBlock;

+ (void)getCollocationDataWithUrl:(NSString *)urlStr WithBlock:(Block)myBlock;

+ (void)getThemeDataWithBlock:(Block)block;

@end
