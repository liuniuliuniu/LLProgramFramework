//
//  LLHomeViewController.m
//  LLProgramFramework
//
//  Created by 奥卡姆 on 2017/10/11.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLHomeViewController.h"
#import "XAFHttpClient.h"
#import "RequestManage.h"
#import "LLHomeCell.h"
#import "LLHomeModel.h"


static NSString *HomeCellID = @"LLHomeCell";

@interface LLHomeViewController () <XAFAPIManagerParamSourceDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) RequestManage *manager;
@property (nonatomic,strong) NSDictionary *sellParam;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * modelArrM;
@property (nonatomic,assign) NSInteger indexPage;

@end

@implementation LLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = ({
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TAB_BAR_HEIGHT);
        UITableView * tableV = [[UITableView  alloc]initWithFrame: frame style:UITableViewStylePlain];
        [tableV registerNib:[UINib nibWithNibName:@"LLHomeCell" bundle:nil] forCellReuseIdentifier:HomeCellID];
        tableV.delegate = self;
        tableV.rowHeight = 100;
        tableV.dataSource = self;
        tableV.separatorStyle = NO;
        tableV.tableFooterView = [UIView new];
        [self.view addSubview:tableV];
        tableV;
    });
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.indexPage = 0;
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.indexPage += 1;
        [weakSelf loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArrM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellID forIndexPath:indexPath];
    cell.selectionStyle = NO;
    cell.homeModel = self.modelArrM[indexPath.row];
    return cell;
}


- (void)loadData{
    
    [self.manager startWithCompletionBlockWithSuccess:^(XAFAPIBaseManager *request) {
        id response = [request fetchDataWithReformer:(id <XAFAPIManagerCallbackDataReformer>)self.manager];
        NSArray *arr = [NSArray yy_modelArrayWithClass:[LLHomeModel class] json:response[@"top_stories"]];
        
        // 模拟多页请求数据
        if (self.indexPage == 0) {
            [self.modelArrM removeAllObjects];
            [self.modelArrM addObjectsFromArray:arr];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer resetNoMoreData];
        }else{
            // 实际开发中应该判断有没有翻页数据
            if (self.indexPage >= 3) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.modelArrM addObjectsFromArray:arr];
                [self.tableView.mj_footer endRefreshing];
            }
        }                                
        [self.tableView reloadData];
    } failure:^(XAFAPIBaseManager *request) {
        NSLog(@"fail%@",request.errorMessage);
    }];
}


- (NSDictionary *)paramsForApi:(XAFAPIBaseManager *)manager {
    //    NSDictionary *sellParam = @{@"call":@"1"};
    return @{};
}

- (RequestManage *)manager {
    if (!_manager) {
        _manager = [RequestManage new];
        _manager.paramSource = self;
    }
    return _manager;
}

- (NSMutableArray *)modelArrM{
    if (!_modelArrM) {
        _modelArrM = [NSMutableArray array];
    }
    return _modelArrM;
}

@end

