//
//  ZLThemeModel.m
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "ZLThemeModel.h"

@implementation ZLThemeModel

- (id)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        
//        [self setValuesForKeysWithDictionary:dic];
        NSDictionary *componentDic = dic[@"component"];
        self.height = [dic[@"height"] floatValue];
        self.width = [dic[@"width"] floatValue];
        self.title = componentDic[@"title"];
        self.picUrl = componentDic[@"picUrl"];
        self.category = componentDic[@"category"];
        self.collectionCount =componentDic[@"collectionCount"];
        self.commentCount = componentDic[@"commentCount"];
        self.cellHeight = kMainBoundsW * self.height/self.width;
        self.v = componentDic[@"v"];
        self.year = componentDic[@"year"];
        self.month = componentDic[@"month"];
        
    }
    return self;
}


- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@==%ld---%ld=%f",self.title,self.picUrl,self.category,self.collectionCount,self.commentCount,self.v,self.year,self.month,self.height,self.width ,self.cellHeight];
}



//- (float)cellHeight {
//    
////    float height = [self.height floatValue];
////    float width = [self.width floatValue];
//
//    if (self.height == 0 && self.width == 0 ) {
//        
//        return 0;
//        
//    }
//    
//    float W = kMainBoundsW/2;
//    
//    float H = W *(self.height/self.width);
//    
//    return H;
//}

@end
