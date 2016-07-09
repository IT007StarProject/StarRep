//
//  MainManagerTools.m
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "MainManagerTools.h"
#import "MainTopScrollerModel.h"
#import "MainTableViewModel.h"
#import "tadyNewModel.h"
#import "communityModel.h"

static AFHTTPSessionManager *manager;

@implementation MainManagerTools

+ (AFHTTPSessionManager *)AFHTTP{
    if (!manager) {
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html", nil];
        return manager;
    }
    return manager;
}


#pragma mark -----请求首页顶部的数据-----------
+ (void)GetmainDataTopScroller:(void(^)(NSArray *MainArr))complain{
    
    [self AFHTTP];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;
//    NSLog(@"请求时间超时了");
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager GET:@"http://api-v2.mall.hichao.com/mall/banner?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=32E61C2B-F5FE-422D-84DB-38B0E6AC5FBB&gs=640x1136&gos=8.4&access_token=" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            
            NSMutableArray *datAarr=[NSMutableArray array];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDIc = dic[@"data"];
            NSArray *items = dataDIc[@"items"];

            for (NSDictionary *itemsDic in items) {
                MainTopScrollerModel *model = [MainTopScrollerModel topScrollerDic:itemsDic];
                
                [datAarr addObject:model];
            }
            if (complain) {
                complain(datAarr);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        if (complain) {
            complain(nil);
        }
    }];
}
#pragma mark -------特价限时购-------
+ (void)GetTimeInfoDic:(void(^)(NSArray *timeArr))timeComplain{
    [self AFHTTP];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;
//    NSLog(@"请求时间超时了");
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager POST:@"http://api-v2.mall.hichao.com/active/flash/list?method=%2Factive%2Fflash%2Flist&data=eyJnYSI6Imh0dHA6Ly9hcGktdjIubWFsbC5oaWNoYW8uY29tIn0%3D&sign=6102fc4961e311e3e2e16e234ed895be&ga=http%3A%2F%2Fapi-v2.mall.hichao.com&source=mxyc_adr&version=6.6.3.32" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            NSMutableArray *dataArr = [NSMutableArray array];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDic = dic[@"response"];
           NSDictionary  *itemsDic = dataDic[@"data"];
            NSArray *array =itemsDic[@"items"];

            for (NSDictionary *indexDic in array) {
                img_indexModel *model =[img_indexModel img_indexDic:indexDic];
                [dataArr addObject:model];
            }
            if (timeComplain) {
                timeComplain(dataArr);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (timeComplain) {
            timeComplain(nil);
        }
    }];
    
}

#pragma mark  - ---------韩国馆----------
+ (void)getIndex:(NSInteger)index GuanInfoDic:(void (^)(NSArray *))KoreaComplain{

    [self AFHTTP];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;
//    NSLog(@"请求时间超时了");
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager GET:[NSString stringWithFormat:@"http://api-v2.mall.hichao.com/mall/region/new?region_id=%ld&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=CBD795AD-1BFC-40FE-A351-407FEAC7219D&gs=640x1136&gos=8.4.1&access_token=",index] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

            NSDictionary *dataDic= dic[@"data"];
            NSMutableArray  *region_skusArr= [NSMutableArray array];
            NSMutableArray  *region_nameArr= [NSMutableArray array];
            NSMutableArray *region_brandsArr = [NSMutableArray array];
            NSMutableArray *region_picturesArr =[NSMutableArray array];

   
            for (NSDictionary  *region_skusDic in dataDic[@"region_skus"]) {
                MainTableViewModel *model = [MainTableViewModel region_nameDic:region_skusDic];
                [region_skusArr addObject:model];
            }
            for (NSDictionary *region_nameDic in dataDic[@"region_name"]) {
                MainTableViewModel *model = [MainTableViewModel region_nameDic:region_nameDic];
                [region_nameArr addObject:model];
//                NSLog(@"%@",model.PicUrl);
     
            }
//
            for (NSDictionary *region_brandsDic in dataDic[@"region_brands"]) {
                MainTableViewModel *model = [MainTableViewModel region_nameDic:region_brandsDic];
                [region_brandsArr addObject:model];
            }
            for (NSDictionary *region_picturesDic in dataDic[@"region_pictures"]) {
                
              MainTableViewModel *model = [MainTableViewModel region_nameDic:region_picturesDic];
                [region_picturesArr addObject:model];
            }
            
            NSMutableArray *dataArr = [[NSMutableArray alloc]initWithObjects:region_nameArr,region_brandsArr,region_picturesArr,region_skusArr, nil];
            
            
            if (KoreaComplain) {
                KoreaComplain(dataArr);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (KoreaComplain) {
            KoreaComplain(nil);
        }
    }];
}
+ (void)getTadyNewClothesBlock:(void(^)(NSArray *TadArr))complain{

    [self AFHTTP];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;
//    NSLog(@"请求时间超时了");
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager GET:@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=32E61C2B-F5FE-422D-84DB-38B0E6AC5FBB&gs=640x1136&gos=8.4&access_token=" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            
            NSMutableArray *dataArr =[NSMutableArray array];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDic = dic[@"data"];
            NSArray *arr = dataDic[@"items"];
            for (NSDictionary *componter in arr) {
                tadyNewModel *model = [tadyNewModel TadyNewDic:componter];
                [dataArr addObject:model];
            }
            if (complain) {
                complain(dataArr);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (complain) {
            complain(nil);
        }
        
    }];
}

+ (void)getjacketDataBlock:(void(^)(NSArray *Jackers))complain{

    [self AFHTTP];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;

    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager GET:@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=&category_ids=38,33,34&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=32E61C2B-F5FE-422D-84DB-38B0E6AC5FBB&gs=640x1136&gos=8.4&access_token=" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            
            NSMutableArray *dataArr = [NSMutableArray array];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDic = dic[@"data"];
            for (NSDictionary *compeont in dataDic[@"items"]) {
                tadyNewModel *model = [tadyNewModel TadyNewDic:compeont];
                [dataArr addObject:model];
            }
            if (complain) {
                complain(dataArr);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (complain) {
            complain(nil);
        }
    }];
}

+ (void)getDressDataBlcok:(void(^)(NSArray *DressArr))complain{
    [self AFHTTP];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;

    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager GET:@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=&category_ids=39,40&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=32E61C2B-F5FE-422D-84DB-38B0E6AC5FBB&gs=640x1136&gos=8.4&access_token=" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSMutableArray *dataArr = [NSMutableArray array];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDic = dic[@"data"];
            for (NSDictionary * componentin in dataDic[@"items"]) {
                tadyNewModel *model = [tadyNewModel TadyNewDic:componentin];
                [dataArr addObject:model];
            }
            if (complain) {
                complain(dataArr);
            }
            
        } 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (complain) {
            complain(nil);
        }
    }];
}


+ (void)getTrousersData:(void(^)(NSArray *Trouses))complain{

    [self AFHTTP];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;

    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager GET:@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=&category_ids=49,45,48,46,44&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=32E61C2B-F5FE-422D-84DB-38B0E6AC5FBB&gs=640x1136&gos=8.4&access_token=" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSMutableArray *dataArr = [NSMutableArray array];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDic= dic[@"data"];
            for (NSDictionary *component in dataDic[@"items"]) {
                tadyNewModel *model = [tadyNewModel TadyNewDic:component];
                [dataArr addObject:model];
            }
            if (complain) {
                complain(dataArr);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (complain) {
            complain(nil);
        }
    }];
}


+ (void)getImageDataUrl:(NSString *)url withData:(void(^)(NSArray *array))complain{
    [self AFHTTP];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
     
        NSMutableArray * array = [NSMutableArray array];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic =dic[@"data"];
        for (NSDictionary *data in dataDic[@"items"]) {
            
            tadyNewModel *model = [tadyNewModel TadyNewDic:data];
            [array addObject:model];
        }
        if (complain) {
            complain(array);
        }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (complain) {
            complain(nil);
        }
    }];
}

+ (void)communityViewTopScrollerData:(void(^)(NSArray *dataArr))complain{
   
    [self AFHTTP];
    
    [manager GET:@"http://api-v2.mall.hichao.com/forum/banner?ga=%2Fforum%2Fbanner" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            
            NSMutableArray *array = [NSMutableArray array];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *items = dic[@"data"];
           
            for ( NSDictionary *component in items[@"items"]) {
                
                communityModel *model = [communityModel communityDic:component];

                [array addObject:model];
            }
            if (complain) {
                complain(array);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (complain) {
            complain(nil);
        }
    }];
}





@end
