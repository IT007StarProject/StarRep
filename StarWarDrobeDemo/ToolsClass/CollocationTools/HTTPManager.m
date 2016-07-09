//
//  HTTPManager.m
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "HTTPManager.h"
#import "ZLCollocationModel.h"
#import "ZLThemeModel.h"

@implementation HTTPManager


//+ (void)getCollocationDataWithBlock:(Block)myBlock {
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    [manager GET:@"http://api-v2.mall.hichao.com/star/list?category=%E5%85%A8%E9%83%A8&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        
////        NSLog(@"%@",dic);
//        
//        if (dic) {
//            NSMutableArray *dataArray = [NSMutableArray array];
//            NSArray *itemsArr = dic[@"data"][@"items"];
//            for (int i = 1; i < itemsArr.count; i++) {
//                
//                ZLCollocationModel *model = [[ZLCollocationModel alloc]initWithDic:itemsArr[i]];
//                [dataArray addObject:model];
//            }
//            
//            if (myBlock) {
//                myBlock(dataArray);
//            }
//        
//        }else {
//            if (myBlock) {
//                myBlock(nil);
//            }
//        }
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        if (myBlock) {
//            myBlock(nil);
//        }
//    }];
//   
//}

+ (void)getCollocationDataWithUrl:(NSString *)urlStr WithBlock:(Block)myBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",dic);
        if (dic) {
            NSMutableArray *dataArray = [NSMutableArray array];
            NSArray *itemsArr = dic[@"data"][@"items"];
            
            for (int i = 1; i < itemsArr.count; i++) {
                ZLCollocationModel *model = [[ZLCollocationModel alloc]initWithDic:itemsArr[i]];
                [dataArray addObject:model];
            }
            
            if (myBlock) {
                myBlock(dataArray);
            }
            
        }else {
            if (myBlock) {
                myBlock(nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (myBlock) {
            myBlock(nil);
        }
    }];
    
    
//    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        
//        //        NSLog(@"%@",dic);
//        
//        if (dic) {
//            NSMutableArray *dataArray = [NSMutableArray array];
//            NSArray *itemsArr = dic[@"data"][@"items"];
//            for (int i = 1; i < itemsArr.count; i++) {
//                
//                ZLCollocationModel *model = [[ZLCollocationModel alloc]initWithDic:itemsArr[i]];
//                [dataArray addObject:model];
//            }
//            
//            if (myBlock) {
//                myBlock(dataArray);
//            }
//            
//        }else {
//            if (myBlock) {
//                myBlock(nil);
//            }
//        }
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        if (myBlock) {
//            myBlock(nil);
//        }
//    }];
    
    
}

+ (void)getThemeDataWithBlock:(Block)block {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:@"http://api-v2.mall.hichao.com/mix_topics?flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
//      NSLog(@"%@",dic);
        if (dic) {
            NSArray *itemsArr =dic[@"data"][@"items"];
//            NSLog(@"==%@",itemsArr);
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in itemsArr) {
                
                ZLThemeModel *model = [[ZLThemeModel alloc]initWithDictionary:dic];
                [array addObject:model];
            }
            
            if (block) {
                block(array);
            }
        }else{
            if (block) {
                block(nil);
            }
        }
   
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (block) {
            block(nil);
        }
        
    }];
    
    
}


@end
