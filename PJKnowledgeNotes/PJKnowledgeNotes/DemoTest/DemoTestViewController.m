//
//  DemoTestViewController.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2019/12/14.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import "ViewControllerHelper.h"
#import "DemoTestViewController.h"

static NSString *ID = @"UITableViewCell";

@interface DemoTestViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *arrayData;

@end

@implementation DemoTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayData = [ViewControllerHelper dataSourceDemoTest];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 350, 300)];
//    btn.backgroundColor = [UIColor redColor];
//    [self.view addSubview:btn];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 350, 300)];
//    imageView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:imageView];
//    
//    imageView.userInteractionEnabled = YES;
//    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 300, 80)];
//    btn.backgroundColor = [UIColor greenColor];
//    [imageView addSubview:btn];
//
//    [btn addTarget:self action:@selector(hahhahahhaa:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

- (void)hahhahahhaa:(UIButton *)sender {
    NSLog(@"hahhahahhaa");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (!cell) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    ViewControllerModel *model = self.arrayData[indexPath.row];
    
    cell.textLabel.text = model.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ViewControllerModel *model = self.arrayData[indexPath.row];
    
    UIViewController *vc = [[model.destVc alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
