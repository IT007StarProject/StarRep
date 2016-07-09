//
//  CollocationData.m
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/6.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "CollocationData.h"
//#import "FMDatabase.h"
@implementation CollocationData


- (NSString *)getDiretory {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/collocationData.sqlite"];
}

- (void)createTable {
    
//    FMDatabase * database = [FMDatabase databaseWithPath:[self getDiretory]];
//    [database executeQuery:@"create Table mySort(id integer primary key,name text)"];
//    [database executeQuery:@""]
    
    
}






@end
