//
//  Tools.m
//  StarWarDrobeDemo
//
//  Created by Mr.Sun on 16/7/4.
//  Copyright © 2016年 SGYAndZl. All rights reserved.
//

#import "Tools.h"

@implementation Tools


#pragma mark ---------- 创建TabBar改变根视图--------
+ (void)creatTabBar:(UIViewController *)VC{
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    MainViewController *mainVc = [[MainViewController alloc]init];
    UINavigationController *mainNav =[self tabBarItemWithController:mainVc withTitle:@"首页" imageName:@"bottom_home_icon@2x.png" selectedImageName:@"bottom_home_icon_on"];
    
    CollocationViewController *collocationVC = [[CollocationViewController alloc]init];
    
    UINavigationController *collocationNav =[self tabBarItemWithController:collocationVC withTitle:@"搭配" imageName:@"bottom_dapei_icon.png" selectedImageName:@"bottom_dapei_icon_on@2x.png"];
    
    CommunityViewController *communityVc = [[CommunityViewController alloc]init];
    UINavigationController *communityNav =[self tabBarItemWithController:communityVc withTitle:@"社区" imageName:@"bottom_bbs_icon" selectedImageName:@"bottom_bbs_icon_on"];
    
    ShopingCartViewController *shoppingCartVc = [[ShopingCartViewController alloc]init];
    UINavigationController *shoppingNav =[self tabBarItemWithController:shoppingCartVc withTitle:@"购物车" imageName:@"bottom_shopping_icon" selectedImageName:@"bottom_shopping_icon_on"];


    tabBar.viewControllers = @[mainNav,collocationNav,communityNav,shoppingNav];
    
    VC.view.window.rootViewController = tabBar;
}

+ (UINavigationController *)tabBarItemWithController:(UIViewController *)controller withTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
   
    UINavigationController *Nav = [[UINavigationController alloc]initWithRootViewController:controller];
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:imageName] selectedImage:selectedImage];
    
    //     设置tabbarItem的普通文字
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //    textAttrs[NSForegroundColorAttributeName] = [[UIColor alloc]initWithRed:113/255.0 green:109/255.0 blue:104/255.0 alpha:1];
    //    改变文字的大小
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [Nav.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [[UIColor alloc]initWithRed:255/255.0 green:0.0 blue:100/255.0 alpha:1];
    [Nav.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    return Nav;
}

@end
