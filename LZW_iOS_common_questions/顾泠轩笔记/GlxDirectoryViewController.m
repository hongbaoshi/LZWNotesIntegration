//
//  GlxDirectoryViewController.m
//  LZW_iOS_common_questions
//
//  Created by 文艺复兴 on 2017/8/17.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "GlxDirectoryViewController.h"
#import "GlxBaseViewController.h"
#import "CDUIKit.h"

@interface GlxDirectoryViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
PropertyNSArray(dataArr);
@end

@implementation GlxDirectoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- set / get
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCW, SCH - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

-(NSArray *)dataArr
{
    if (!_dataArr)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"List" ofType:@"plist"];
        _dataArr = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataArr;
}


#pragma mark -- 数据加载




#pragma mark -- UI
-(void)createUI
{
    [self setNavTitle:@"目录"];
    
    //左键
    UIButton *leftbtn = [CDUIKit createButtonWithFrame:CGRectMake(0, 0, 80, 30) ImageName:nil Target:self Action:@selector(backHome) Title:nil];
    leftbtn.titleLabel.font= [UIFont systemFontOfSize:14];
    [leftbtn setTitle:@"返回首页" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
}



#pragma mark -- 点击事件
-(void)backHome
{
    [[AllPublicMethod sharedAllPublicMethod] backToFirstView];
}



#pragma mark --逻辑处理



#pragma mark -- TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr?self.dataArr.count:0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSDictionary *dic = self.dataArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld .  %@",indexPath.row+1,dic[@"title"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArr[indexPath.row];
    Class class = NSClassFromString(dic[@"vc"]);
    GlxBaseViewController *bvc = [[class alloc]init];
    [bvc setNavTitle:dic[@"title"]];
    [self.navigationController pushViewController:bvc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}



@end
