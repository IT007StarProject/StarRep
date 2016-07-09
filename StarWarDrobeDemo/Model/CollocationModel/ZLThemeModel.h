//
//  ZLThemeModel.h
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZLThemeModel : NSObject

@property(nonatomic,assign)NSInteger height;
@property(nonatomic,assign)NSInteger width;
//@property(nonatomic, strong)ZLThemeComModel *comModel;

@property(nonatomic, copy)NSString *category;
@property(nonatomic, copy)NSString *picUrl;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *v;
@property(nonatomic, copy)NSString *collectionCount;
@property(nonatomic, copy)NSString *commentCount;
@property(nonatomic, copy)NSString *year;
@property(nonatomic, copy)NSString *month;


@property(nonatomic, assign)float cellHeight;

- (id)initWithDictionary:(NSDictionary *)dic;


@end
