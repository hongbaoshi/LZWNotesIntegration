//
//  ElevenViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/11.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "ElevenViewController.h"

#import "TheoryViewController.h"
#import "ChangePropertyViewController.h"
#import "RotateAnimationViewController.h"
#import "SpringAnimationViewController.h"

@interface ElevenViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *elevenTableView;

@property(nonatomic,strong)NSMutableArray *elevenDataArray;

@end

@implementation ElevenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"11---iOS简单动画";
    self.elevenDataArray = [NSMutableArray arrayWithArray:@[
                                                            @"1、动画原理",
                                                            @"2、改变视图属性",
                                                            @"3、旋转动画",
                                                            @"4、弹簧动画"]];
    
    [self createUI];
    
}

-(void)createUI
{
    self.elevenTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.elevenTableView.delegate = self;
    self.elevenTableView.dataSource = self;
    [self.view addSubview:self.elevenTableView];
}

#pragma mark --- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.elevenDataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"elevenViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.elevenDataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            TheoryViewController *vcr = [[TheoryViewController alloc] init];
            [self.navigationController pushViewController:vcr animated:YES];
        }
            break;
            
        case 1:
        {
            ChangePropertyViewController *vcr = [[ChangePropertyViewController alloc] init];
            [self.navigationController pushViewController:vcr animated:YES];
        }
            break;
        case 2:
        {
            RotateAnimationViewController *vcr = [[RotateAnimationViewController alloc] init];
            [self.navigationController pushViewController:vcr animated:YES];
        }
            break;
        case 3:
        {
            SpringAnimationViewController *vcr = [[SpringAnimationViewController alloc] init];
            [self.navigationController pushViewController:vcr animated:YES];
        }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
