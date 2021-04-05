//
//  LLBaseTableViewController.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/8.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLBaseTableViewController.h"


static NSString * const BBAUIMenuCellID = @"BBAUIMenuCellID";

@interface LLBaseTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *baseTableView;

@end

@implementation LLBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menuItemModels = [[NSMutableArray alloc] init];
    [self.view addSubview:self.baseTableView];
}

#pragma mark - lazy loading
- (UITableView *)baseTableView {
    _baseTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _baseTableView.backgroundColor = [UIColor whiteColor];
    _baseTableView.delegate = self;
    _baseTableView.dataSource = self;
    _baseTableView.rowHeight = 60;
    // tableView自适应横竖屏-横屏时铺满
    _baseTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // 去掉多余的cell分割线
    _baseTableView.tableFooterView = [[UIView alloc] init];
    _baseTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return _baseTableView;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LLBaseModel *model = self.menuItemModels[indexPath.row];
    if (model.clickCallBack) {
        // 获取当前选中的cell
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        model.clickCallBack(cell);
    }
    
    if (model.className) {
        LLBaseTableViewController *vc = [NSClassFromString(model.className) new];
        vc.title = model.titleName;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItemModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BBAUIMenuCellID];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BBAUIMenuCellID];
        // cell样式带箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    LLBaseModel *model = self.menuItemModels[indexPath.row];
    cell.textLabel.text = model.titleName;    
    return cell;
}

@end
