//
//  ViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/6/29.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "ViewController.h"
#import "TwoPublicInfo.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *lzwTestTableView;

@property(nonatomic,strong)NSMutableArray *titleDataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"iOS复习笔记";
    _titleDataArray = [NSMutableArray arrayWithArray:@[
                                                      @[@"00---红宝时",@"LZWTableViewController"],
                                                      @[@"01---饶皮皮",@""],
                                                      @[@"02---顾泠轩",@""]
                                                      ]];
    
    NSLog(@"伟神流弊  伟神威武 伟神带我飞");
    
    //*** 1、添加lzwTestTableView
    _lzwTestTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _lzwTestTableView.delegate = self;
    _lzwTestTableView.dataSource = self;
    [self.view addSubview:_lzwTestTableView];
    
    
}



#pragma mark --- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _titleDataArray[indexPath.row][0];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#pragma mark --- 1、根据字符串获取类名
    Class A = NSClassFromString(_titleDataArray[indexPath.row][1]);
    UIViewController *vcr = [[A alloc] init];
    [self.navigationController pushViewController:vcr animated:YES];
}



#pragma mark ---  --------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


































