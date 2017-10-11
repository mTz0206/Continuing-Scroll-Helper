//
//  ViewController.m
//  Demo
//
//  Created by Bruno.ma on 10/11/17.
//  Copyright © 2017 Bruno.ma. All rights reserved.
//

#import "ViewController.h"
#import "ScrollViewTableViewCell.h"
#import "ContinuingScrollHelper.h"
#define GET_FULL_WIDTH                      ([UIScreen mainScreen].bounds.size.width)
#define GET_FULL_HEIGHT                     ([UIScreen mainScreen].bounds.size.height)
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, weak)UITableView * tableView;
@property (nonatomic, strong)ScrollViewTableViewCell *scrollCell;
@property (nonatomic, strong)ContinuingScrollHelper *helper ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    UITableView *tbv = [[UITableView alloc] initWithFrame:CGRectMake(0, GET_FULL_HEIGHT/2, GET_FULL_WIDTH, GET_FULL_HEIGHT) style:UITableViewStylePlain];
    _tableView = tbv;
    _tableView.backgroundColor = [UIColor redColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    [_tableView registerClass:[ScrollViewTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.bounces = NO;
    
    ContinuingScrollHelper *helper = [[ContinuingScrollHelper alloc] initWithScrollView:_tableView superView:self.view];
    [helper setFrame:CGRectMake(0, 0, GET_FULL_WIDTH, GET_FULL_HEIGHT)];
    _helper = helper;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [UITableViewCell new];
        cell.textLabel.text = @"native view\nnative view\nnative view\nnative view\nnative view\nnative view\nnative view\nnative view\nnative view\n";
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        return cell;    } else {
            _scrollCell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
            [_helper setSecondScrollView:_scrollCell.scrollView];
            return _scrollCell;
        }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 390;
    }
    return GET_FULL_HEIGHT;
}
@end
