//
//  MidBarView.h
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TypeSelectedLatest = 200,
    TypeSelectedHot,
    TypeSelectedWestern,
    TypeSelectedJapanKorrea,
    TypeSelectedChina,
    TypeSelectedBoy,
} TypeSelected;

typedef void(^TypeBlock)(TypeSelected);

@interface MidBarView : UIView{
    

}



- (id)initWithFrame:(CGRect)frame completion:(TypeBlock)newBlock;


@end
