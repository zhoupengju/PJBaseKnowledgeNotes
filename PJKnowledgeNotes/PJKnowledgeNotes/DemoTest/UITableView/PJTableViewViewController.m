//
//  PJTableViewViewController.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2019/12/14.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import "TestTableViewCell.h"
#import "PJTableViewViewController.h"

#define IDCell @"TestTableViewCell"

@interface PJTableViewViewController ()

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation PJTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    UIGestureRecognizer *ges = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(hahahh)];
//    ges.delegate = self;
//    [self.view addGestureRecognizer:ges];


    [self createContainerView];
    
    
    
    

}
#pragma mark - 创建布局控件
- (void)createContainerView {
    // 1. 创建tableview
    [self setTableView];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
//    NSLog(@"numberOfSectionsInTableView");
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"numberOfRowsInSection");
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"cellForRowAtIndexPath= %ld", indexPath.row);

    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDCell];
    }
    cell.textLabel.text = @"11111123456543212345";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"heightForRowAtIndexPath= %ld", indexPath.row);
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"-----------");
}

- (void)hahahh {
    NSLog(@"========");
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
      
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

#pragma mark - 创建tableview
- (void)setTableView {
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 750) style:UITableViewStylePlain];
    [self.view addSubview:self.tableview];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.estimatedRowHeight = 0;
//    self.tableview.estimatedSectionHeaderHeight = 0;
//    self.tableview.estimatedSectionFooterHeight = 0;

    [self.tableview registerClass:[TestTableViewCell class] forCellReuseIdentifier:IDCell];
}

- (void)testTextAttachment {
    
    //1.设置标签
     UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
     titleLabel.backgroundColor = [UIColor yellowColor];
    titleLabel.numberOfLines = 0;
     titleLabel.text = @"周鹏钜祝所有人步步高升,成为技术大神";
     titleLabel.textColor = [UIColor redColor];
     [self.view addSubview:titleLabel];


     //2.初始化富文本对象
      NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];

     //2.1修改富文本中的不同文字的样式
     [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 5)];//字体颜色
     [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(7, 6)];//字体颜色
     [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0, 6)];//字体大小


     //3.初始化NSTextAttachment对象
     NSTextAttachment *attchment = [[NSTextAttachment alloc]init];
     attchment.bounds = CGRectMake(0, 0, 40, 40);//设置frame
     attchment.image = [UIImage imageNamed:@"release_homework.jpg"];//设置图片


     //4.创建带有图片的富文本
     NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)(attchment)];
     [attributedString insertAttributedString:string atIndex:0];//插入到第几个下标
     [attributedString appendAttributedString:string];   //添加到尾部


     //5.用label的attributedText属性来使用富文本
     titleLabel.attributedText = attributedString;
}

@end
