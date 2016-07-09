//
//  ThemeCell.m
//  StarWarDrobeDemo
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "ThemeCell.h"

@interface ThemeCell (){
    UIView *_bgView ;
    UILabel * _titlelabel;
    UILabel *_categoryLabel;
    UILabel *_timeLabel;
    UIImageView *_imageView;
    UILabel *_commentLabel;
    UILabel *_vLabel;
    UIButton *_collectionBtn;
    UILabel *_collectionLabel;
    
    UIView * _bgcomment;
    UIView * _bgV;
    
    UIView * _bgcollection;
}



@end


@implementation ThemeCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectZero];
//    bgView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:bgView];
    _bgView = bgView;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [bgView addSubview:titleLabel];
    _titlelabel = titleLabel;
    
    UILabel *categoryLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [bgView addSubview:categoryLabel];
    _categoryLabel = categoryLabel;
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [bgView addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [bgView addSubview:imageView];
    _imageView = imageView;
    
    
    UIView *bgcomment = [[UIView alloc]init];
    [_bgView addSubview:bgcomment];
    _bgcomment = bgcomment;
    
    UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [bgView addSubview:commentLabel];
    _commentLabel = commentLabel;
    
    UIView *bgV = [[UIView alloc]init];
    [_bgView addSubview:bgV];
    _bgV = bgV;
    
    UILabel *vLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [bgView addSubview:vLabel];
    _vLabel = vLabel;
    
    UIView *bgcollection = [[UIView alloc]init];
    [_bgView addSubview:bgcollection];
    _bgcollection = bgcollection;

    UIButton *collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionBtn setBackgroundImage:[UIImage imageNamed:@"icon_like@2x"] forState:UIControlStateNormal];
    [collectionBtn addTarget:self action:@selector(collectionHeart:) forControlEvents:UIControlEventTouchUpInside];
    [_bgcollection addSubview:collectionBtn];
    _collectionBtn = collectionBtn;
    
    UILabel *collectionLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    [bgView addSubview:collectionLabel];
    _collectionLabel = collectionLabel;
    
    
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    
}

- (void)collectionHeart:(UIButton *)sender {
    
    
    NSLog(@"用户登录界面");
    
    
}

- (void)setModel:(ZLThemeModel *)model {
    
    if (_model != model) {
        _model = model;

        [self layoutIfNeeded];
    }
 
}

- (void)layoutSubviews {
    [super layoutSubviews];

    ZLThemeModel *model = self.model;

    if (model.picUrl) {
//        左边标题
        _titlelabel.frame = CGRectMake(10, 10, kMainBoundsW-60, 40);
        _titlelabel.text = model.title;
//        右边标题
        _categoryLabel.frame = CGRectMake(kMainBoundsW - 60, 10 , 60, 40);
        _categoryLabel.text =[NSString stringWithFormat:@"#%@#",model.category];
        _categoryLabel.font = [UIFont systemFontOfSize:13];
//        时间
        _timeLabel.frame = CGRectMake(10, CGRectGetMaxY(_titlelabel.frame), kMainBoundsW-10, 30);
        _timeLabel.text = [NSString stringWithFormat:@"%@%@",model.year,model.month];
        
//        图片
        _imageView.frame =CGRectMake(0, CGRectGetMaxY(_timeLabel.frame), kMainBoundsW,model.cellHeight );
        NSString *urlStr = model.picUrl ;
        if ([urlStr containsString:@"?"]) {
            urlStr = [[urlStr componentsSeparatedByString:@"?"]firstObject];
        }
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        
//       评论背景
        _bgcomment.frame = CGRectMake(20, CGRectGetMaxY(_imageView.frame), (kMainBoundsW-40)/3/2, 40);
//        评论图片
        UIImageView *commentImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_bgcomment.frame)-30, 5, 30, 30)];
        commentImage.image = [UIImage imageNamed:@"icon_bbs_detail_comment_title_1218@2x.png"];
        [_bgcomment addSubview:commentImage];
//        评论文本
        _commentLabel.frame = CGRectMake(CGRectGetMaxX(_bgcomment.frame), CGRectGetMaxY(_imageView.frame), (kMainBoundsW-40)/3/2, 40);
        _commentLabel.text = model.commentCount;
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        
//        v背景
        _bgV.frame = CGRectMake(CGRectGetMaxX(_commentLabel.frame), CGRectGetMaxY(_imageView.frame), (kMainBoundsW-40)/3/2, 40);
//        v图片
        UIImageView *vImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_bgV.frame)-30, 5, 30, 30)];
        vImage.image = [UIImage imageNamed:@"icon_bbs_liuliang_list@3x"];
        [_bgV addSubview:vImage];
//        v文本
        _vLabel.frame =CGRectMake(CGRectGetMaxX(_bgV.frame),CGRectGetMaxY(_imageView.frame) , (kMainBoundsW-40)/3/2, 40);
        _vLabel.text = model.collectionCount;
        _vLabel.textAlignment = NSTextAlignmentLeft;
        
//        收藏背景
        _bgcollection.frame = CGRectMake(CGRectGetMaxX(_vLabel.frame), CGRectGetMaxY(_imageView.frame), (kMainBoundsW-40)/3/2, 40);
//        收藏button
        _collectionBtn.frame =CGRectMake(CGRectGetWidth(_bgcollection.frame)-30, 5, 30, 30);
//        收藏文本
        _collectionLabel.frame =CGRectMake(CGRectGetMaxX(_bgcollection.frame), CGRectGetMaxY(_imageView.frame), (kMainBoundsW-40)/3/2, 40);
        _collectionLabel.text = model.collectionCount;
        
//        所有view的背景
        _bgView.frame = CGRectMake(0, 10, kMainBoundsW, self.contentView.bounds.size.height-10);
        _bgView.backgroundColor = [UIColor whiteColor];
        

    }
}



@end
