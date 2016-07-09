//
//  TopBarView.m
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "TopBarView.h"

@interface TopBarView(){
    
    UIView *_barIndicator;
    BOOL selectedState;
}

@property (nonatomic, copy)TitleBtnBlock block;

@end

@implementation TopBarView


- (id)initWithFrame:(CGRect)frame completion:(TitleBtnBlock)newBlock {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.block = newBlock;
        [self initView];
    }
    return self;
}

- (void)initView {
    
//    UIView *titleView = [[UIView alloc]initWithFrame:self.bounds];
//    titleView.backgroundColor = [UIColor greenColor];
//    [self addSubview:titleView];
    
    NSArray *titleArr = @[@"搭配",@"专题"];
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i + TitleTypeCollocation;
        btn.frame = CGRectMake(i * kMainBoundsW/4 , 0, kMainBoundsW/4, 40);
    
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
       //        设置字体
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        //        颜色设置
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:BXColor(255, 0, 100) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(changeTitle:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
        
        if (i == 0) {
            [self changeTitle:btn];
        }
    }
    
    _barIndicator = [[UIView alloc]initWithFrame:CGRectMake((kMainBoundsW/4-70)/2, 44-5, 70, 5)];
    _barIndicator.backgroundColor = BXColor(255, 0, 100);
    [self addSubview:_barIndicator];
    
    
}



//点击标题button，选择view
- (void)changeTitle:(UIButton *)sender {
    
    [self setSelectedIndex:(sender.tag - TitleTypeCollocation)];
    
    switch (sender.tag) {
        case 100:
            self.block(TitleTypeCollocation);
            break;
        case 101:
            self.block(TitleTypeTheme);
            break;
        default:
            break;
    }
    
    
    
    
    
//    单选
      selectedState = !selectedState;
    if (sender.tag == TitleTypeCollocation) {

        if (!sender.selected) {
            sender.selected = selectedState;
            UIButton *btn = [self viewWithTag:TitleTypeCollocation + 1];
            btn.selected = !selectedState;
        }
    }
    
    if(sender.tag == TitleTypeTheme){
        
        if (!sender.selected) {
            sender.selected = !selectedState;
            UIButton *btn = [self viewWithTag:TitleTypeTheme - 1];
            btn.selected = selectedState;
        }
   }
    
    
    

 
    
    

}


- (void)setSelectedIndex:(NSInteger)index {
    
    [self sliderWithIndex:index];
    
}






- (void)sliderWithIndex:(NSInteger)newIndex {
    
    [UIView animateWithDuration:0.3 animations:^{

        _barIndicator.frame = CGRectMake(newIndex * kMainBoundsW/4+(kMainBoundsW/4-70)/2, 44-5, 70, 5);
        
    }];
    
}


@end
