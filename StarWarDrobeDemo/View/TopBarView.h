//
//  TopBarView.h
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TitleTypeCollocation = 100,
    TitleTypeTheme,
    
} TitleTypeSelected;

typedef void(^TitleBtnBlock)(TitleTypeSelected typeItem);


@interface TopBarView : UIView


- (id)initWithFrame:(CGRect)frame completion:(TitleBtnBlock)newBlock ;

@end
