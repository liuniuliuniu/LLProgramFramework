//
//  MainViewController.m
//  BaseMVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavigationController.h"

#define TABBARITEM_TAG_OFFSET      500

NSString * const kMenuItemController = @"page";
NSString * const kMenuItemTitle = @"title";                            //标题
NSString * const kMenuItemNormalIcon = @"normal_icon";                 //正常图标
NSString * const kMenuItemNormalIconSelect = @"normal_icon_select";    //正常点击图标

@interface MainViewController ()
@property (nonatomic, strong) NSArray *tabbars;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载menu json配置文件
- (NSArray *)loadMenuData{
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"menu" ofType:@"json"];
    NSString *menuJson = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *sortDict = [menuJson objectFromJSONString];
    return sortDict[@"tabbar_items"];
}
- (void)initTab
{
    self.tabbars = [self loadMenuData];
    
    //2.设置导航的文字
    UIColor *normalFontColor = [UIColor colorWithRed:51.0f / 255.0f
                                               green:51.0f / 255.0f
                                                blue:51.0f / 255.0f
                                               alpha:1.0f];
    //字体的系统颜色 NSForegroundColorAttributeName替换UITextAttributeTextColor
    NSDictionary *titleTextAttributesSelectedDict = @{NSForegroundColorAttributeName : UIColorFromRGB(0xf04447)};
    NSDictionary *titleTextAttributesDict = @{NSForegroundColorAttributeName : normalFontColor};
    
    NSMutableArray *navArray = [NSMutableArray array];
    for(NSInteger index = 0;index<[self.tabbars count]; index++){
        NSDictionary *item = [self.tabbars objectAtIndex:index];
        NSString *strPage = [item objectForKey:kMenuItemController];
        id Controller = NSClassFromString(strPage);
        UINavigationController *navController = [[BaseNavigationController alloc] initWithRootViewController:[Controller new]];
        NSString *title = [item objectForKey:kMenuItemTitle];
        NSString *icon = [item objectForKey:kMenuItemNormalIcon];
        NSString *selectedIcon = [item objectForKey:kMenuItemNormalIconSelect];
        UIImage *iconImage = nil;
        UIImage *selectedIconImage = nil;
        //判断选中图标样式
        if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)]) {
            iconImage = [[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            selectedIconImage = [[UIImage imageNamed:selectedIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } else {
            iconImage = [UIImage imageNamed:icon];
            selectedIconImage = [UIImage imageNamed:selectedIcon];
        }
        //设置文字与icon
        UITabBarItem *baritem = [[UITabBarItem alloc] initWithTitle:title
                                                              image:iconImage
                                                                tag:index + TABBARITEM_TAG_OFFSET];
        //设置字的颜色
        [baritem setTitleTextAttributes:titleTextAttributesDict
                               forState:UIControlStateNormal];//普通字体颜色
        [baritem setTitleTextAttributes:titleTextAttributesSelectedDict
                               forState:UIControlStateSelected];//设置选中时的字体颜色
        baritem.titlePositionAdjustment = UIOffsetMake(0, -3.0f);
        baritem.selectedImage = selectedIconImage;//选中的图标
        
        //添加项
        navController.tabBarItem = baritem;
        navController.navigationBar.translucent = YES;
        [navArray addObject:navController];
    }
    
    self.viewControllers = navArray;
    
    //-------------------------TabBar分割线阴影-----------------------------
//            UIImageView *bottomShadowLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, - 2.0f, CGRectGetWidth(self.view.frame), 2.0f)];
//            bottomShadowLineImageView.image = [UIImage imageNamed:@"bottomShadowLine"];
//            bottomShadowLineImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//            self.tabBar.clipsToBounds = NO;
//            [self.tabBar addSubview:bottomShadowLineImageView];
}


@end
