//
//  CommunityViewController.m
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "CommunityViewController.h"
#import "MainManagerTools.h"
#import "communityModel.h"

@interface CommunityViewController ()
@property (strong, nonatomic) UIScrollView *bgScrollview;
@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation CommunityViewController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
//
    [self createNavGationContains];
    [self createBgScrollerView];
    
  
    
}

#pragma mark -------创建NavgationBar-----
- (void)createNavGationContains{
    self.title = @"社区";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *cameBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(cameBtn:)];
    UIBarButtonItem *InfoBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"button_head_massage"] style:UIBarButtonItemStylePlain target:self action:@selector(InfonBtn:)];
    
    self.navigationItem.rightBarButtonItems =@[InfoBtn,cameBtn];
}

- (void)cameBtn:(UIButton *)sender {
    NSLog(@"我是相机");
}

- (void)InfonBtn:(UIButton *)sender {
    NSLog(@"我是个人信息");
}

#pragma mark ---------创建一个背景的_bgScrolView-----；

- (void)createBgScrollerView{
   
    __weak NSMutableArray *arr =self.dataArr;
    _bgScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, kMainBoundsH)];
    _bgScrollview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgScrollview];


        _bgScrollview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [MainManagerTools communityViewTopScrollerData:^(NSArray *dataArr) {
                [arr removeAllObjects];
                [arr addObjectsFromArray:dataArr];
                [self createTopScrollerView];
                [_bgScrollview.mj_header endRefreshing];
            }];
            
        }];
        [_bgScrollview.mj_header beginRefreshing];
}

#pragma mark ------------创建一个topScrollView========

- (void)createTopScrollerView{
   
    SDCycleScrollView *SDView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMainBoundsW, kMainBoundsW *350/750) delegate:nil placeholderImage:nil];
    [_bgScrollview addSubview:SDView];
    
    NSMutableArray *imageArr = [NSMutableArray array];
    for (NSInteger i = 0; i<self.dataArr.count; i++) {
        communityModel *model = self.dataArr[i];
        NSString *str = [[model.picUrl componentsSeparatedByString:@"?"]firstObject];
        [imageArr addObject:str];
    }
    SDView.imageURLStringsGroup = imageArr;
    
    [self TopScrollerViewHeight:SDView.size.height];
}

- (void)TopScrollerViewHeight:(CGFloat)height{
//    UITableView *tabeView = [[UITableView alloc]initWithFrame:CGRectMake(0, height, kMainBoundsW, <#CGFloat height#>) style:UITableViewStylePlain];
    




}




@end
