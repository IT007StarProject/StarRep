//
//  MidBarView.m
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "MidBarView.h"

@interface MidBarView ()

@property(nonatomic, copy)TypeBlock block;

@end

@implementation MidBarView

- (id)initWithFrame:(CGRect)frame completion:(TypeBlock)newBlock {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.block = newBlock;
        [self initView];
    }
    return self;
    
}



- (void)initView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:bgView];
    
    NSArray *themeArr = @[@"最新",@"热门",@"欧美",@"日韩",@"本土",@"型男"];
    for (int i = 0; i < themeArr.count; i++) {
       
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * kMainBoundsW/6, 0, kMainBoundsW/6,40);
        btn.tag = i +TypeSelectedLatest;
        [btn setTitle:themeArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font =[UIFont systemFontOfSize:15];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(changeThemeStyle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
//        UIView *interView = [[UIView alloc]initWit]
    }
    
}

- (void)changeThemeStyle:(UIButton *)sender {
    
    switch (sender.tag) {
        case 200:
            _block(TypeSelectedLatest);
            break;
        case 201:
            _block(TypeSelectedHot);
            break;
        case 202:
            _block(TypeSelectedWestern);
            break;
        case 203:
            _block(TypeSelectedJapanKorrea);
            break;
        case 204:
            _block(TypeSelectedChina);
            break;
        case 205:
            _block(TypeSelectedBoy);
            break;
        default:
            break;
    }
    
}








@end
