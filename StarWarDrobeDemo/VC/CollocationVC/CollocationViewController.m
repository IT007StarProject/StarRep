//
//  CollocationViewController.m
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "CollocationViewController.h"

#import "UICollectionViewFlowWaterLayout.h"
#import "ZLCollocationModel.h"
#import "HTTPManager.h"
#import "ThemeCell.h"
#import "TopBarView.h"


#define CollocationCellWidth kMainBoundsW/2-5

typedef enum : NSUInteger {
    CollocationViewA = 300,
    CollocationViewB,
} CollocationView;



typedef enum : NSUInteger {
    CollocationLeftButtonClick = 1000,
    CollocationRightButtonClick,
} MyButtonClick;

@interface CollocationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,FlowWaterDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView * _bgCollocationView;
    UIView * _bgThemeView;
    UIScrollView * _midScrollView;
    UIButton * _midBtn;
    UIView * _bgChannelView;
    UIView * _bgSortView;
    UIView * _bgAddView;
    BOOL  editBtnSelected;
    UIButton * _editBtn;
    UIView * _sortTitleView;
    NSInteger selectedIndex;
    UITableView * _tableView;
    NSInteger selectedBtn;
    NSMutableArray *_themeArr;
    UIScrollView     * _scrollView;
}

@property(nonatomic, strong)NSMutableArray *dataArr;
//@property(nonatomic, strong)NSMutableArray *dataArr1;
@property(nonatomic, strong)NSMutableArray *mySortArr;
@property(nonatomic, strong)NSMutableArray *addSortArr;
@property(nonatomic, strong)NSMutableArray * themeData;

@end

@implementation CollocationViewController

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}

- (NSMutableArray *)themeData {
    if (!_themeData) {
        _themeData = [NSMutableArray array];
    }
    return _themeData;
}



//- (NSMutableArray *)dataArr1 {
//    if (!_dataArr1) {
//        _dataArr1 = [NSMutableArray array];
//    }
//    
//    return _dataArr;
//}

- (NSMutableArray *)mySortArr {
    if (!_mySortArr) {
        _mySortArr = @[].mutableCopy;
    }
    
    return _mySortArr;
}

- (NSMutableArray *)addSortArr {
    if (!_addSortArr) {
        _addSortArr=[NSMutableArray array];
    }
    return _addSortArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.mySortArr = @[@"清新",@"娇小"].mutableCopy;
    self.addSortArr = @[@"欧美",@"本土",@"复古",@"轻熟",@"OL",@"混搭",@"街头",@"休闲",@"摩登",@"逛街",@"约会",@"派对",@"运动",@"出游",@"典礼",@"高挑",@"型男",@"甜美",@"日韩",@"热门",@"闺蜜",@"优选",@"丰满"].mutableCopy;
    
     selectedBtn = 11000;
    
//    加载视图
    [self initView];
//    加载数据
    [self getData];
    
    [self getDataWithIndex:0];
    
}

#pragma mark - 初始化视图
- (void)initView {
     self.view.backgroundColor = [UIColor whiteColor];
    
    __block CollocationViewController *collocationVC = self;
//    导航栏上的按钮选择主题
    TopBarView * topBar = [[TopBarView alloc]initWithFrame:CGRectMake(kMainBoundsW/4, 0,kMainBoundsW/2,44) completion:^(TitleTypeSelected typeItem) {
        
        [collocationVC changeView:typeItem];
    }];

    self.navigationItem.titleView = topBar;
    
    UIImage *rightBarButtonImage = [UIImage imageNamed:@"button_head_massage@2x"];
    rightBarButtonImage = [rightBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:rightBarButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(enterlogin)];
    
}

- (void)changeView:(TitleTypeSelected)typeItem {

    NSInteger index = 0;
    switch (typeItem) {
        case TitleTypeCollocation:
            index = 0;
            break;
        case TitleTypeTheme:
            index = 1;
            break;
        default:
            break;
    }
    
    if (index == 0) {
    
        if (_bgThemeView) {
            [_bgThemeView removeFromSuperview];
        }
        if (_bgCollocationView) {
            [_bgCollocationView removeFromSuperview];
        }
 //        搭配的背景
        UIView *bgCollocationView = [[UIView alloc]initWithFrame:kMainBounds];
        [self.view addSubview:bgCollocationView];
        _bgCollocationView = bgCollocationView;
        
        UIButton *midBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        midBtn.frame =CGRectMake(kMainBoundsW-40, 64+10, 20, 40-20);
        [midBtn setBackgroundImage:[UIImage imageNamed:@"icon_class_open@2x"]forState:UIControlStateNormal];
//         NSLog(@"========%d",midBtn.selected);
        [midBtn addTarget:self action:@selector(enterChannelView:) forControlEvents:UIControlEventTouchUpInside];
        [bgCollocationView addSubview:midBtn];
        _midBtn = midBtn;

        [self createMidView];
        
    }else{
        
//        专题的背景
        if (_bgCollocationView) {
            [_bgCollocationView removeFromSuperview];
        }
        if (_bgThemeView) {
            [_bgThemeView removeFromSuperview];
        }
     
        UIView *bgThemeView = [[UIView alloc]initWithFrame:kMainBounds];
//        bgThemeView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:bgThemeView];
        _bgThemeView = bgThemeView;
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kMainBoundsW, kMainBoundsH-64) style:UITableViewStylePlain];
        tableView.delegate =self;
        tableView.dataSource =self;
        [bgThemeView addSubview:tableView];
        
        [tableView registerClass:[ThemeCell class] forCellReuseIdentifier:@"Theme"];
//        [self reloadThemeView];
    }

}

#pragma mark - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.themeData.count>0) {
        return self.themeData.count;
       
    }
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.themeData.count>0) {
       ZLThemeModel *model = self.themeData[indexPath.row];
        
        if (model.cellHeight>0) {
            
            return model.cellHeight+130;
        }
    }
    
    return 0.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Theme" forIndexPath:indexPath];
    cell.model = self.themeData[indexPath.row];
    return cell;
}

#pragma mark- 搭配和专题转换
- (void)enterChannelView:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [UIView animateWithDuration:0.5 animations:^{
                    sender.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        
        [_midScrollView removeFromSuperview];
        [_scrollView removeFromSuperview];
        [self channelView];
        
    }else{
        
      [UIView animateWithDuration:0.5 animations:^{
                    sender.transform = CGAffineTransformRotate( sender.transform, M_PI);
                }];
    
        [_bgChannelView removeFromSuperview];
        
        if (_midScrollView) {
            [_midScrollView removeFromSuperview];
        }
        if (_scrollView) {
          [_scrollView removeFromSuperview];
        }
        [self createMidView];
    }
  
}


//频道定制
- (void)channelView {

    //  我的分类底层
    UIView *bgChannelView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kMainBoundsW, kMainBoundsH-64)];
//    bgChannelView.backgroundColor=[UIColor greenColor];
    [_bgCollocationView addSubview:bgChannelView];
    _bgChannelView = bgChannelView;
    
    [_bgCollocationView bringSubviewToFront:_midBtn];
   
    UIView *midTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 40)];
//    midTitleView.backgroundColor = [UIColor blueColor];
    [_bgChannelView addSubview:midTitleView];
//    _midTitleView = midTitleView;

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, midTitleView.bounds.size.width , 40)];
    titleLabel.text = @"频道定制";
    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.backgroundColor = [UIColor yellowColor];
    [midTitleView addSubview:titleLabel];
    
    [self mySortView];
    
    //   虚拟点击
    [self editTyle:_editBtn];
    
}

#pragma mark- 我的分类
- (void)mySortView {
    //   我的分类
    UIView *sortTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kMainBoundsW, 30)];
    sortTitleView.backgroundColor = [UIColor lightGrayColor];
    [_bgChannelView addSubview:sortTitleView];
    _sortTitleView = sortTitleView;
    UILabel *mySortLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 60, 30)];
    mySortLabel.text = @"我的分类";
    mySortLabel.font = [UIFont systemFontOfSize:15];
    mySortLabel.textAlignment = NSTextAlignmentLeft;
//    mySortLabel.backgroundColor = [UIColor yellowColor];
    [sortTitleView addSubview:mySortLabel];
    
    UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    editBtn.frame = CGRectMake((kMainBoundsW-12)- 50, 0, 50, 30);
    editBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    editBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    [editBtn setTitle:@"完成" forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑" forState:UIControlStateSelected];
    
    [editBtn setTitleColor:BXColor(255, 0, 100) forState:UIControlStateNormal];
    [editBtn setTitleColor:BXColor(255, 0, 100) forState:UIControlStateSelected];
    [editBtn addTarget:self action:@selector(editTyle:) forControlEvents:UIControlEventTouchUpInside];
//    editBtn.backgroundColor = [UIColor blackColor];
    [sortTitleView addSubview:editBtn];
    _editBtn = editBtn;
    
    if (self.mySortArr.count>0) {
        
        UIView *bgSortView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sortTitleView.frame), kMainBoundsW, 15+(15+30)*(self.mySortArr.count/4 +1))];
//        bgSortView.backgroundColor = [UIColor brownColor];
        [_bgChannelView addSubview:bgSortView];
        _bgSortView = bgSortView;
        
//        我的分类上按钮
        for (int i = 0; i < self.mySortArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = 20000+i;
            btn.frame = CGRectMake(12 + (80 +12)*(i%4), 15+(15+30)*(i/4), 80, 30);
            [btn setBackgroundImage:[UIImage imageNamed:@"invitation_window_item@2x"] forState:UIControlStateNormal];
            [btn setTitle:self.mySortArr[i] forState:UIControlStateNormal];
             btn.titleLabel.font = [UIFont systemFontOfSize:16];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            btn.backgroundColor=[UIColor blueColor];
            [btn addTarget:self action:@selector(mySort:) forControlEvents:UIControlEventTouchUpInside];
            [_bgSortView addSubview:btn];
        }
    }else{
        
        UIView *bgSortView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(sortTitleView.frame), kMainBoundsW, 15)];
//        bgSortView.backgroundColor = [UIColor redColor];
        [_bgChannelView addSubview:bgSortView];
        _bgSortView = bgSortView;
    }
    
}


#pragma mark- 点击添加分类
- (void)editTyle:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    editBtnSelected = sender.selected;
    if (sender.selected) {
        if (self.addSortArr.count>0) {
            //    点击添加分类底层
            UIView *bgAddView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bgSortView.frame), kMainBoundsW, 400)];
//             bgAddView.backgroundColor = [UIColor yellowColor];
            [_bgChannelView addSubview:bgAddView];
            _bgAddView = bgAddView;
            
            UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, kMainBoundsW , 30)];
            addLabel.text = @"   点击添加分类";
            addLabel.font = [UIFont systemFontOfSize:15];
            addLabel.backgroundColor = [UIColor lightGrayColor];
            [bgAddView addSubview:addLabel];
            
            UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kMainBoundsW,15+(15+30)*(self.addSortArr.count/4+1) )];
            [bgAddView addSubview:btnView];
            
            for (int i = 0; i < self.addSortArr.count; i++) {
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.tag =10000 +i;
                btn.frame = CGRectMake(12 + (80 +10)*(i%4), 15+(15+30)*(i/4), 80, 30);
                [btn setBackgroundImage:[UIImage imageNamed:@"invitation_window_item@2x"] forState:UIControlStateNormal];
                [btn setTitle:self.addSortArr[i] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:16];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
                [btn addTarget:self action:@selector(addSort:) forControlEvents:UIControlEventTouchUpInside];
                [btnView addSubview:btn];
            }
            
        }else{
            UIView *bgAddView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bgSortView.frame), kMainBoundsW, 30)];
            bgAddView.backgroundColor = [UIColor lightGrayColor];
            [_bgChannelView addSubview:bgAddView];
            _bgAddView = bgAddView;
            
            UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, kMainBoundsW - 12, 30)];
            addLabel.text = @"   没有更多分类";
            addLabel.font = [UIFont systemFontOfSize:15];
            [bgAddView addSubview:addLabel];
        }
    }else {
        
        if (_bgAddView) {
            [_bgAddView removeFromSuperview];
        }
    }
   
}

#pragma mark- 进入搭配界面
- (void)mySort:(UIButton *)sender {
    
    if (editBtnSelected) {
        [_bgChannelView removeFromSuperview];
        
//        变换按钮的状态
        [self enterChannelView:_midBtn];
        
        [self changeTitleTypeWithIndex:sender.tag - 20000+1];
        
    }else{
        [self.addSortArr addObject:self.mySortArr[sender.tag-20000]];
        [self.mySortArr removeObjectAtIndex:sender.tag-20000];

        [_sortTitleView removeFromSuperview];
        [_bgSortView removeFromSuperview];

        [self mySortView];
    }
    
}


- (void)addSort:(UIButton *)sender {
    
    if (editBtnSelected) {

        [self.mySortArr addObject:self.addSortArr[sender.tag-10000]];
        
        [self.addSortArr removeObjectAtIndex:sender.tag-10000];
        
        if (_bgChannelView) {
            [_bgChannelView removeFromSuperview];
        }
        [self channelView];
        
    }
    
}

#pragma mark- 创建搭配视图
- (void)createMidView {
    
    NSMutableArray *themeArr = @[@"最新"].mutableCopy;
    [themeArr addObjectsFromArray:self.mySortArr];
    _themeArr = themeArr;
    
    //中间滚动视图
    UIScrollView *midScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kMainBoundsW-60, 40)];
    midScrollView.delegate = self;
    [_bgCollocationView addSubview:midScrollView];
//    midScrollView.pagingEnabled = YES;
    midScrollView.showsHorizontalScrollIndicator = NO;
    midScrollView.contentSize = CGSizeMake(themeArr.count*60, 0);
    midScrollView.showsHorizontalScrollIndicator = YES;
    _midScrollView = midScrollView;
    
//    中间tabBar
    for (int i = 0; i < themeArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * 60, 0, 80,40);
        btn.tag = i +11000;
        [btn setTitle:themeArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font =[UIFont systemFontOfSize:15];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(changeThemeStyle:) forControlEvents:UIControlEventTouchUpInside];
        [midScrollView addSubview:btn];

        
        if (selectedBtn-11000==i) {
            btn.selected = YES;
        }

    }

    [self createCollocationView];
    
}

#pragma mark-点击中间栏按钮选择风格
- (void)changeThemeStyle:(UIButton *)sender {
 
    if (sender.selected == NO) {
    
        UIButton *btn = [_midScrollView viewWithTag:selectedBtn];
        btn.selected = NO;

        sender.selected = YES;
        selectedBtn = sender.tag;
        
        NSInteger index = sender.tag - 11000;
        [self changeTitleTypeWithIndex:index];
    }
    
}

#pragma mark-创建瀑布流
- (void)createCollocationView {
    
//    瀑布流的背景
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 104, kMainBoundsW, kMainBoundsH-104)];
        scrollView.contentSize = CGSizeMake((self.mySortArr.count+1) * kMainBoundsW, 0);
    scrollView.backgroundColor = [UIColor whiteColor];
    [_bgCollocationView addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView = scrollView;

//    创建两个瀑布流
    UICollectionViewFlowWaterLayout *layout = [UICollectionViewFlowWaterLayout new];
    layout.delegate = self;
    layout.itemWith = CollocationCellWidth;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
    for (int i = 0; i < 2; i++) {
        UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(kMainBoundsW * i, 0, kMainBoundsW, kMainBoundsH-104) collectionViewLayout:layout];
        collection.tag = CollocationViewA + i;
        collection.delegate = self;
        collection.dataSource = self;
        collection.backgroundColor = [UIColor whiteColor];
        [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
        [_scrollView addSubview:collection];

    }
   
}


- (void)changeTitleTypeWithIndex:(NSInteger)index {
    //    瀑布流水平滑动时的偏移量
    NSInteger offsetIndex = index;
    if (_scrollView) {
        _scrollView.contentOffset = CGPointMake(offsetIndex * kMainBoundsW, 0);
    }
    
    [self MoveCollectionViewWith:offsetIndex];
    
    UIButton *btn = [_midScrollView viewWithTag:11000+index];
    
    [self changeThemeStyle:btn];
}

#pragma mark - scrollView代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger offset = 0;
    if (_scrollView == scrollView) {
        
    offset = scrollView.contentOffset.x/kMainBoundsW;

    [self changeTitleTypeWithIndex:offset];
    }
   
}


//    水平滑动时，两个瀑布流交替使用
- (void)MoveCollectionViewWith:(NSInteger)index {
//    点击中间tabBar按钮位移设置
    
    [UIView animateWithDuration:0.1 animations:^{
        if (index>selectedIndex&&index<_themeArr.count-2&&index>2) {
            _midScrollView.contentOffset =CGPointMake((index-2)*60, 0);
        }
        
        if (index<selectedIndex&&index<_themeArr.count-2&&index>2){
            _midScrollView.contentOffset =CGPointMake((index-2)*60, 0);
        }
    }];
    
   
//    上一次点击的序号
    selectedIndex = index;
    
    UICollectionView *collection0 = [_scrollView viewWithTag:CollocationViewA];
    UICollectionView *collection1 = [_scrollView viewWithTag:CollocationViewA + 1];
    if (index % 2 == 0) {
        collection0.frame = CGRectMake(kMainBoundsW *index, 0, kMainBoundsW, kMainBoundsH-104);
    }
    
    if (index % 2 == 1) {
        collection1.frame = CGRectMake(kMainBoundsW *index, 0, kMainBoundsW, kMainBoundsH-104);
    }
    
    [self getDataWithIndex:index];
    
}


#pragma mark - collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
        if (self.dataArr.count == 0) {
            return 0;
        }
        
        return self.dataArr.count;

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    ZLCollocationModel *model = self.dataArr[indexPath.row];
//    cell背景
    UIView *bgView = [[UIView alloc]initWithFrame:cell.contentView.frame];
//    bgView.backgroundColor = [UIColor redColor];
    [cell.contentView addSubview:bgView];
//   图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CollocationCellWidth, model.cellHeight)];
    NSString *picUrl = model.comModel.picUrl;
    if ([picUrl containsString:@"?"]) {
        picUrl = [[picUrl componentsSeparatedByString:@"?"]firstObject];
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:picUrl]];
    [bgView addSubview:imageView];
//    描述背景
    UIView *bgDescription = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame),CollocationCellWidth, 40)];
//    bgDescription.backgroundColor = [UIColor blueColor];
    [bgView addSubview:bgDescription];
//    描述
    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5,CollocationCellWidth, 30)];
    descriptionLabel.text = model.comModel.Description;
    descriptionLabel.font = [UIFont systemFontOfSize:15];
//    descriptionLabel.backgroundColor = [UIColor redColor];
    [bgDescription addSubview:descriptionLabel];
    
    UIView *padView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, CollocationCellWidth, 1)];
    padView.backgroundColor = [UIColor lightGrayColor];
    [bgDescription addSubview:padView];
    
    

    
    UIView *bgItemsView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgDescription.frame),(CollocationCellWidth)/2 , 40)];
//    bgItemsView.backgroundColor = [UIColor redColor];
    [bgView addSubview:bgItemsView];

    UIImageView *itemsImage = [[UIImageView alloc]initWithFrame:CGRectMake((CollocationCellWidth)/4-25,10,22, 20)];
//    bgItemsView.backgroundColor = [UIColor whiteColor];
    itemsImage.image = [UIImage imageNamed:@"icon_bbs_detail_comment_link@2x"];
    [bgItemsView addSubview:itemsImage];
    
    
    UILabel *ItemsLabel = [[UILabel alloc]initWithFrame:CGRectMake((CollocationCellWidth)/4, 10,(CollocationCellWidth)/4, 20)];
    ItemsLabel.textAlignment = NSTextAlignmentLeft;
    ItemsLabel.font = [UIFont systemFontOfSize:15];
    ItemsLabel.text = model.comModel.itemsCount;
//    ItemsLabel.backgroundColor = [UIColor yellowColor];
    [bgItemsView addSubview:ItemsLabel];
    
    UIView *bottomPadView = [[UIView alloc]initWithFrame:CGRectMake((CollocationCellWidth)/2 - 1, 15,1, 10)];
    bottomPadView.backgroundColor = [UIColor lightGrayColor];
    [bgItemsView addSubview:bottomPadView];
//
//
    UIView *bgHeartView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bgItemsView.frame), CGRectGetMaxY(bgDescription.frame), (CollocationCellWidth)/2, 40)];
//    bgHeartView.backgroundColor = [UIColor redColor];
    [bgView addSubview:bgHeartView];
//
    UIButton *heartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    heartBtn.frame =CGRectMake((CollocationCellWidth)/4-25, 10,20, 20);
    [heartBtn setBackgroundImage:[UIImage imageNamed:@"icon_like@2x"] forState:UIControlStateNormal];
    [heartBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    heartBtn.backgroundColor = [UIColor purpleColor];
    [bgHeartView addSubview:heartBtn];
//
    UILabel *heartLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(heartBtn.frame), 10, (CollocationCellWidth)/4, 20)];
    heartLabel.text = model.comModel.collectionCount;
    heartLabel.font = [UIFont systemFontOfSize:15];
//    heartLabel.backgroundColor = [UIColor blueColor];
    [bgHeartView addSubview:heartLabel];
    
 
    return cell;
    
}

//获取collectionViewCell的高度
- (CGFloat)getHeight:(NSIndexPath *)indexPath {
    
    ZLCollocationModel *model = self.dataArr[indexPath.row];
    
    if (model.comModel.picUrl == nil) {
        return 0;
    }
    
    CGFloat h = model.cellHeight + 80;
    
    return h;
}


//获取专题数据
- (void)getData {

    [HTTPManager getThemeDataWithBlock:^(NSMutableArray *array) {
        
        [self.themeData addObjectsFromArray:array];
        
    }];
    
}

//获取搭配数据
- (void)getDataWithIndex:(NSInteger)index {
    
    NSMutableArray *nameArr = @[@"最新"].mutableCopy;
    [nameArr addObjectsFromArray:self.mySortArr];
    
    NSString *name = nameArr[index];
    NSDictionary *dic =@{@"最新":@"http://api-v2.mall.hichao.com/star/list?category=%E5%85%A8%E9%83%A8&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"清新":@"http://api-v2.mall.hichao.com/star/list?category=%E6%B8%85%E6%96%B0&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"娇小":@"http://api-v2.mall.hichao.com/star/list?category=%E5%A8%87%E5%B0%8F&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"欧美":@"http://api-v2.mall.hichao.com/star/list?category=%E6%AC%A7%E7%BE%8E&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"本土":@"http://api-v2.mall.hichao.com/star/list?category=%E6%9C%AC%E5%9C%9F&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"复古":@"http://api-v2.mall.hichao.com/star/list?category=%E5%A4%8D%E5%8F%A4&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"轻熟":@"http://api-v2.mall.hichao.com/star/list?category=%E8%BD%BB%E7%86%9F&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"OL":@"ttp://api-v2.mall.hichao.com/star/list?category=OL&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"混搭":@"http://api-v2.mall.hichao.com/star/list?category=%E6%B7%B7%E6%90%AD&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"街头":@"http://api-v2.mall.hichao.com/star/list?category=%E8%A1%97%E5%A4%B4&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"休闲":@"http://api-v2.mall.hichao.com/star/list?category=%E4%BC%91%E9%97%B2&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"摩登":@"http://api-v2.mall.hichao.com/star/list?category=%E6%91%A9%E7%99%BB&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"逛街":@"http://api-v2.mall.hichao.com/star/list?category=%E9%80%9B%E8%A1%97&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"约会":@"http://api-v2.mall.hichao.com/star/list?category=%E7%BA%A6%E4%BC%9A&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"派对":@"http://api-v2.mall.hichao.com/star/list?category=%E6%B4%BE%E5%AF%B9&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"运动":@"http://api-v2.mall.hichao.com/star/list?category=%E8%BF%90%E5%8A%A8&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"出游":@"http://api-v2.mall.hichao.com/star/list?category=%E5%87%BA%E6%B8%B8&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"典礼":@"http://api-v2.mall.hichao.com/star/list?category=%E5%85%B8%E7%A4%BC&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"高挑":@"http://api-v2.mall.hichao.com/star/list?category=%E9%AB%98%E6%8C%91&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"型男":@"http://api-v2.mall.hichao.com/star/list?category=%E5%9E%8B%E7%94%B7&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"甜美":@"http://api-v2.mall.hichao.com/star/list?category=%E7%94%9C%E7%BE%8E&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"日韩":@"http://api-v2.mall.hichao.com/star/list?category=%E6%97%A5%E9%9F%A9&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"热门":@"http://api-v2.mall.hichao.com/star/list?category=%E7%83%AD%E9%97%A8&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"闺蜜":@"http://api-v2.mall.hichao.com/star/list?category=%E9%97%BA%E8%9C%9C&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"优选":@"http://api-v2.mall.hichao.com/star/list?category=%E4%BC%98%E9%80%89&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token=",@"丰满":@"http://api-v2.mall.hichao.com/star/list?category=%E4%B8%B0%E6%BB%A1&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=2EB93627-1BBD-40F0-B217-AC280C427C51&gs=640x1136&gos=9.3.2&access_token="};
    
    NSString *urlStr = [dic objectForKey:name];
    
    [HTTPManager getCollocationDataWithUrl:urlStr WithBlock:^(NSMutableArray *array) {
        
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:array];

        [self reloadView];
    }];
    
}

//刷新主题数据
//- (void)reloadThemeView {
//    
//    if (!self.dataArr1) {
//        return;
//    }
//    
//    [_tableView reloadData];
//}

//刷新搭配数据
- (void)reloadView {
    
    if (!self.dataArr) {
        return;
    }
    
    for (int i = 0; i < 2; i++) {
        UICollectionView *collectionView = [_scrollView viewWithTag:CollocationViewA + i];
        [collectionView reloadData];
    }
    

}


//导航栏右边按钮进入登录界面
- (void)enterlogin {
    //    NSLog(@"123");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
