//
//  ZLCollocationModel.m
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "ZLCollocationModel.h"

@implementation ZLCollocationModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"component"]) {
        
        self.comModel = [[ZLCollocationComModel alloc]initWithDic:value];
    }else {
        
        [super setValue:value forKey:key];
    }
   
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}


- (float)cellHeight {
    
    float height = [self.height floatValue];
    float width = [self.width floatValue];
    
    
    if (height == 0 && width == 0 ) {
        
        return 0;
        
    }
    
    float W = kMainBoundsW/2-5;
    
    float H = height/width *W;
    
    return H;
}




@end
