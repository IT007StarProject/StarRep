//
//  MainViewController.m
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "MainViewController.h"
#import "MainManagerTools.h"

#import "MainTopScrollerModel.h"
#import "SDCycleScrollView.h"

#import "MainTableViewModel.h"
#import "tadyNewModel.h"
#import "JHHeaderFlowLayout.h"

@interface MainViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
    //    创建TopScroller
    SDCycleScrollView *SDcrollView;
    UIImageView *lineimage;
    UICollectionView *collView;
}
@property (strong, nonatomic)UIScrollView *bgScrollView;

@property (strong, nonatomic)NSMutableArray *ToScrollerdataArr;

@property (strong, nonatomic)NSMutableArray *guanDataArr;

@property (strong,nonatomic)NSMutableArray *tadyNewArr;

@end

@implementation MainViewController


- (NSMutableArray *)tadyNewArr{
    if (!_tadyNewArr) {
        _tadyNewArr= [NSMutableArray array];
    }
    return _tadyNewArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.guanDataArr = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets= NO;
    [self search];
    [self navGationbutton];
    [self createBgScrollView];
    [self createTablView];
 

}



#pragma mark ---搜索栏的------------
- (void)search{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW-180, 30)];
    view.backgroundColor= [UIColor whiteColor];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 30, view.frame.size.height)];
    label.text = @"🔍";
    [view addSubview:label];
    UITextField *textFile = [[UITextField alloc]initWithFrame:CGRectMake(label.frame.size.width, 0, view.frame.size.width - label.frame.size.width, view.frame.size.height)];
    textFile.backgroundColor= [UIColor whiteColor];
    textFile.placeholder= @"单品/品牌/红人";
    textFile.font = [UIFont systemFontOfSize:15];
    [textFile addTarget:self action:@selector(textRgist00) forControlEvents:UIControlEventEditingDidEndOnExit];
    //    textFile.borderStyle = UITextBorderStyleRoundedRect;
    [view addSubview:textFile];
    
    self.navigationItem.titleView =view;
    
}

- (void)textRgist00{
    //   键盘失去响应
}

#pragma mark ----导航条button的按钮 ---- - -

- (void)navGationbutton{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    view.userInteractionEnabled = YES;
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = view.frame;
    [button setImage:[UIImage imageNamed:@"button_info"] forState:UIControlStateNormal];
    [button setTitle:@"首页" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:9];
    [button addTarget:self action:@selector(gotoPersonInfo) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat buttonHeight = CGRectGetHeight(button.bounds);
    CGFloat buttonWidth  = CGRectGetWidth(button.bounds);
    CGFloat buttonImageWidth = CGRectGetWidth(button.imageView.bounds);
    CGFloat buttoLableWidth = CGRectGetWidth(button.titleLabel.bounds);
    UIEdgeInsets edgs=UIEdgeInsetsMake(0, (buttonWidth - buttonImageWidth)/2, 10, (buttonWidth -buttonImageWidth)/2);
    button.imageEdgeInsets =edgs;
    button.titleEdgeInsets = UIEdgeInsetsMake(buttonHeight - edgs.bottom, - (buttonWidth - buttoLableWidth) / 2-10, 5, 0);
    [view addSubview:button];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    
    UIView *rightview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    rightview.userInteractionEnabled = YES;
    
    UIButton *rightbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    rightbutton.frame = view.frame;
    [rightbutton setImage:[UIImage imageNamed:@"botton_shoppingcart_icon"] forState:UIControlStateNormal];
    [rightbutton setTitle:@"购物车" forState:UIControlStateNormal];
    [rightbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightbutton.titleLabel.font = [UIFont systemFontOfSize:9];
    [rightbutton addTarget:self action:@selector(gotoShoping) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat rightbuttonHeight = CGRectGetHeight(rightview.bounds);
    CGFloat rightbuttonWidth  = CGRectGetWidth(rightview.bounds);
    CGFloat rightbuttonImageWidth = CGRectGetWidth(rightbutton.imageView.bounds);
    CGFloat rightbuttoLableWidth = CGRectGetWidth(rightbutton.titleLabel.bounds);
    UIEdgeInsets rightedgs=UIEdgeInsetsMake(0, (rightbuttonWidth - rightbuttonImageWidth)/2-25,15, (rightbuttonWidth -rightbuttonImageWidth)/2);
    rightbutton.imageEdgeInsets =rightedgs;
    rightbutton.titleEdgeInsets = UIEdgeInsetsMake(rightbuttonHeight -rightedgs.bottom, - (rightbuttonWidth - rightbuttoLableWidth) / 2-35, 5, 0);
    
    [rightview addSubview:rightbutton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightview];
}

- (void)gotoPersonInfo{
    NSLog(@"个人信息");
}

- (void)gotoShoping{
    NSLog(@"我要购物去");
}
#pragma mark ----------创建背景Scrollview---
- (void)createBgScrollView{
    
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kMainBoundsW, kMainBoundsH-64)];
    _bgScrollView.backgroundColor = [UIColor whiteColor];
      _bgScrollView.contentSize = CGSizeMake(kMainBoundsW, kMainBoundsH *7);
        _bgScrollView.pagingEnabled = NO;
    _bgScrollView.delegate = self;
   
    [self.view addSubview:_bgScrollView];
    
//    最上边的button上的点击事件
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kMainBoundsW - 50, kMainBoundsH -80, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"home_back_top"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(bgScrollViewTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //    获取数据
    [self refreshInfo];
   
}

- (void)bgScrollViewTop{
    _bgScrollView.contentOffset = CGPointMake(0, 0);
}
//刷新区头，下拉刷新
- (void)refreshInfo {
  
    _bgScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getDatatopScroller];
        [self createUICollectionView];
        [self getDataTady];
         [_bgScrollView.mj_header endRefreshing];
    }];
    [_bgScrollView.mj_header beginRefreshing];

}


#pragma mark ----topScroller获取数据源-------
- (void)getDatatopScroller{
    //    topScroller数据源
    self.ToScrollerdataArr =[NSMutableArray array];
    //    获取数据源
    [MainManagerTools GetmainDataTopScroller:^(NSArray *MainArr) {
        [_ToScrollerdataArr removeAllObjects];
        [_ToScrollerdataArr addObjectsFromArray:MainArr];
        [self createToScroller];
    }];
}

#pragma mark  ----- 创建topScroller ----
- (void)createToScroller{
    
    NSMutableArray *ImageArr=[NSMutableArray array];
    
    for (NSInteger i = 0; i<self.ToScrollerdataArr.count; i++) {
        MainTopScrollerModel *model = self.ToScrollerdataArr[i];
        [ImageArr addObject:model.picUrl];
    }
    SDcrollView.backgroundColor= [UIColor whiteColor];
    SDcrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMainBoundsW, kMainBoundsW *520/750-50) delegate:self placeholderImage:nil];
    //    创建pageControll
    SDcrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [_bgScrollView addSubview:SDcrollView];
    SDcrollView.imageURLStringsGroup = ImageArr;
    [self createTimeShoping];
}
//选中的某个图片（类似于button的点击事件）
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    //    NSLog(@"%ld",index);
}

#pragma mark -----限时特价-------
-(void)createTimeShoping{
    
    [MainManagerTools GetTimeInfoDic:^(NSArray *timeArr) {
        for (NSInteger i = 0; i<timeArr.count; i++) {
            img_indexModel *model = timeArr[i];
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake((10+((kMainBoundsW-30)/2+10)*(i%2)),SDcrollView.size.height+10, (kMainBoundsW-30)/2,kMainBoundsH - kMainBoundsW*350/450-50);
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.img_index] forState:UIControlStateNormal];
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds=YES;
            [_bgScrollView addSubview:button];
        }
        
    }];
}

#pragma mark ----各馆信息-------
- (void)createTablView{
    for (NSInteger i = 1; i<7; i++) {
        [MainManagerTools getIndex:i GuanInfoDic:^(NSArray *KoreaArr) {
            
            [_guanDataArr removeAllObjects];
            [_guanDataArr addObjectsFromArray:KoreaArr];

            [self createHeight:kMainBoundsH+(i-1)*(kMainBoundsW*480/330) with:self.guanDataArr];
        }];
    }
}

- (void)createHeight:(CGFloat)Height with:(NSMutableArray *)array{
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, Height-100, kMainBoundsW,kMainBoundsW *530/400)];
  
    [_bgScrollView addSubview:view];
    if (array.count==0) {
        return;
    }
    NSArray *arr = array[0];
    MainTableViewModel *model = arr[0];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, kMainBoundsW, kMainBoundsW * 100/400);
    [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.PicUrl] forState:UIControlStateNormal];
    [view addSubview:button];
    
    NSArray *scrollArr = array[1];
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, button.frame.size.height, kMainBoundsW, kMainBoundsW *100/500)];
    for (NSInteger i = 0; i<scrollArr.count; i++) {
        MainTableViewModel *model = scrollArr[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(i*kMainBoundsW/4, 0, kMainBoundsW/4,scroll.frame.size.height+10);
        
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.PicUrl] forState:UIControlStateNormal];
        [scroll addSubview:button];
    }
    scroll.pagingEnabled = YES;
    scroll.contentSize = CGSizeMake(kMainBoundsW/4 *scrollArr.count, 0);
    [view addSubview:scroll];
    
    
    NSArray *imageArr = array[2];
    SDCycleScrollView *sdScroller = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, scroll.size.height+button.size.height, kMainBoundsW, kMainBoundsW * 350/550) delegate:nil placeholderImage:nil];
    sdScroller.autoScroll = NO;
    [view addSubview:sdScroller];
    NSMutableArray *sdArr =[NSMutableArray array];
    for (NSInteger i =0; i<imageArr.count; i++) {
        MainTableViewModel *model = imageArr[i];
        [sdArr addObject:model.PicUrl];
    }
    sdScroller.imageURLStringsGroup = sdArr;
    
    
    NSArray *TaillArr = array[3];
    UIScrollView *Taillscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,scroll.size.height+button.size.height+sdScroller.frame.size.height, kMainBoundsW, kMainBoundsW * 100/450+50)];
    for (NSInteger i = 0; i<TaillArr.count; i++) {
        MainTableViewModel *model = TaillArr[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(i*kMainBoundsW/4+5, 0,kMainBoundsW/4,Taillscroll.frame.size.height-30);
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.PicUrl] forState:UIControlStateNormal];
        [Taillscroll addSubview:button];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(i*kMainBoundsW/4, button.frame.size.height-5, kMainBoundsW/4, Taillscroll.frame.size.height - button.frame.size.height)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = [NSString stringWithFormat:@"%@",model.title];
        lable.font = [UIFont systemFontOfSize:13];
        [Taillscroll addSubview:lable];
        
    }
    Taillscroll.pagingEnabled = YES;
    Taillscroll.contentSize = CGSizeMake(kMainBoundsW/4 *TaillArr.count, 0);
    [view addSubview:Taillscroll];
}

#pragma mark ---------今日上新、裤装等创建collectinView ---------
- (void)createUICollectionView{
    
    JHHeaderFlowLayout *layout = [JHHeaderFlowLayout new];
//    layout.naviHeight = 0;
 
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    collView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,6000, kMainBoundsW, kMainBoundsH-115) collectionViewLayout:layout];
  
    collView.backgroundColor = [UIColor whiteColor];
    [_bgScrollView addSubview:collView];
    
    collView.delegate = self;
    collView.dataSource =self;
    
    collView.scrollEnabled= NO;

    
//    collView.scrollEnabled = NO;
//    注册
    [collView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
//    注册区头
    [collView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    
//    下拉时刷新
    collView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self refreshCollViewDataWithNum:num returnDid:^{
            
            
            if (butoonTog == 100) {
                
                
                _bgScrollView.contentSize = CGSizeMake(0, _bgScrollView.contentSize.height+3250);
            };

            [collView.mj_footer endRefreshing];
            
        }];
        
        num ++;
        
    }];
//    开始刷新
    [collView.mj_footer beginRefreshing];
    

    
    
}
#pragma mark ----下啦刷新数据---------------0
//静态全局变量
static NSInteger num = 0;
static NSInteger butoonTog =100;
- (void)refreshCollViewDataWithNum:(NSInteger)number  returnDid:(void(^)())didBlock{
    
    NSString * URLStr ;
    
    if (butoonTog == 100) {
        
        URLStr  =[NSString stringWithFormat:@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=%ld&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=ECC2B810-D18C-4BCE-84B8-688CE56E5399&gs=1536x2048&gos=9.3.2&access_token=",91138-18*number];
    }
    
    
        [MainManagerTools getImageDataUrl:URLStr withData:^(NSArray *array) {
            [_tadyNewArr addObjectsFromArray:array];
            [collView reloadData];
            
            if (didBlock) {
                didBlock();
            }
        }];
       
 
     num ++;
    
}
#pragma mark ------------------collectionView协议---------------
//有多少行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tadyNewArr.count;
}
//创建collectionview
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    tadyNewModel *model = self.tadyNewArr[indexPath.row];
//图片
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,(kMainBoundsW -10)/2,kMainBoundsW*366/470-115)];
    NSString *imageStr = [[model.picUrl componentsSeparatedByString:@"?"]firstObject];
    [image sd_setImageWithURL:[NSURL URLWithString:imageStr]];
//  城市图片
    UIImageView *countryImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, image.frame.size.height+5, 15, 15)];
    [countryImage sd_setImageWithURL:[NSURL URLWithString:model.nationalFlag]];
//    城市名字
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(countryImage.origin.x+20, image.frame.size.height+5, 40, 15)];
    label.text = [NSString stringWithFormat:@"%@",model.country];
    label.font =[UIFont systemFontOfSize:11];
    label.textColor =[UIColor lightGrayColor];
//   描述
    UILabel *desclabel = [[UILabel alloc]init];
    desclabel.text = [NSString stringWithFormat:@"%@",model.descriptionNew];
    desclabel.font = [UIFont systemFontOfSize:13];
//   价钱
    UILabel *doller = [[UILabel alloc]init];
    doller.text = [NSString stringWithFormat:@"￥%ld",model.price];
    doller.textColor = [UIColor redColor];
    doller.font= [UIFont systemFontOfSize:15];
//    原先的价钱
    UILabel *oldDoller= [[UILabel alloc]init];
    oldDoller.font= [UIFont systemFontOfSize:9];
    oldDoller.text= [NSString stringWithFormat:@"￥%ld",model.origin_price];
    oldDoller.textAlignment = UITextLayoutDirectionLeft;
    
    [cell.contentView addSubview:image];
    [cell.contentView addSubview:countryImage];
    [cell.contentView addSubview:label];
    [cell.contentView addSubview:desclabel];
    [cell.contentView addSubview:doller];
    [cell.contentView addSubview:oldDoller];
//    自动布局
    desclabel.sd_layout.topSpaceToView(label,5).leftSpaceToView(cell.contentView,10).rightSpaceToView(cell.contentView,5).heightIs(15);
    doller.sd_layout.topSpaceToView(desclabel,10).leftSpaceToView(cell.contentView,10).widthIs(50).heightIs(15);
    
    oldDoller.sd_layout.topSpaceToView(desclabel,15).leftSpaceToView(doller,0.5).widthIs(40).heightIs(10);


    return cell;
}
//设置内容的适应
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kMainBoundsW -10)/2,kMainBoundsW*366/530);
}


//设置区头
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
   
      UICollectionReusableView *reuser = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
//    本次循环只走一次
    static   dispatch_once_t token;
    dispatch_once(&token, ^{
    for (UIView *view in reuser.subviews) {
        [view removeFromSuperview];
    }
//        创建button
        
    NSArray *array = @[@"今日上新",@"上装",@"裙装",@"裤装"];
  
    for (NSInteger i = 0; i<array.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(15 + 80*(i%4), 10,kMainBoundsW*20/100, kMainBoundsW * 5/100);
        button.titleLabel.font= [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"%@",array[i]] forState:UIControlStateNormal];
        button.tag = i+100;
        [button addTarget:self action:@selector(collectionBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (button.tag ==100) {
            button.selected = YES;
              btn=button;
            
        }
        [reuser addSubview:button];
    }
        
        
    lineimage= [[UIImageView alloc]initWithFrame:CGRectMake(30,30 ,60, 3)];
    lineimage.image = [UIImage imageNamed:@"icon_button@3x"];
    [reuser addSubview:lineimage];
     
        });
    reuser.backgroundColor = [UIColor whiteColor];
  
  return  reuser;
 }

#pragma mark  -------区头的Btn点击事件------
static UIButton  *btn;
- (void)collectionBtn:(UIButton *)sender {

//   当前点击的
    sender.selected=!sender.selected;
// 点击后的
    btn.selected = !btn.selected;
    btn = sender;
    
    [UIView animateWithDuration:0.5 animations:^{
        lineimage.center = CGPointMake(sender.center.x, lineimage.center.y);
    }];
    
//当点击button 下啦刷新
    num = 0;
    butoonTog = sender.tag;
    
    _bgScrollView.contentSize = CGSizeMake(0, kMainBoundsH*9);
    collView.contentOffset = CGPointMake(0, 0);
    _bgScrollView.contentOffset = CGPointMake(0, 4000+60);
    
  
    
      collView.scrollsToTop =YES;
    if (sender.tag == 100) {

        [self  getDataTady];
    }else if (sender.tag == 101){
        
    [MainManagerTools getjacketDataBlock:^(NSArray *Jackers) {
        [_tadyNewArr removeAllObjects];
        [_tadyNewArr addObjectsFromArray:Jackers];
        [collView reloadData];
    }];
    }else if (sender.tag ==102){
        
     [MainManagerTools getDressDataBlcok:^(NSArray *DressArr) {
         [_tadyNewArr removeAllObjects];
         [_tadyNewArr addObjectsFromArray:DressArr];
       [collView reloadData];
     }];
    }else if (sender.tag ==103){
   
       [MainManagerTools getTrousersData:^(NSArray *Trouses) {
           [_tadyNewArr removeAllObjects];
           [_tadyNewArr addObjectsFromArray:Trouses];
        [collView reloadData];
       }];
    
    }
}


- (void)getDataTady{
   [MainManagerTools getTadyNewClothesBlock:^(NSArray *TadArr) {
       [_tadyNewArr removeAllObjects];
       [_tadyNewArr addObjectsFromArray:TadArr];
       [collView reloadData];
   }];
}

//设置区头的适应
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kMainBoundsW, kMainBoundsW*5/50);
}
//选中点击的cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%ld",indexPath.row);
}


#pragma mark -----------是collection不滑动，让scrollview 滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    NSLog(@"%f",_bgScrollView.contentOffset.y);
    
    if (scrollView ==_bgScrollView) {
        if (_bgScrollView.contentOffset.y>4000) {
            collView.frame = CGRectMake(0, _bgScrollView.contentOffset.y, collView.size.width, collView.size.height);
            collView.contentOffset = CGPointMake(0, _bgScrollView.contentOffset.y - 4000-60);
        
        }
    }
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
