//
//  PJKnowledgeNotesController.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2019/12/2.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import "ViewControllerHelper.h"
#import "PJKnowledgeNotesController.h"

static NSString *ID = @"UITableViewCell";

@interface PJKnowledgeNotesController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *arrayData;

@end

@implementation PJKnowledgeNotesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayData = [ViewControllerHelper dataSource];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
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
