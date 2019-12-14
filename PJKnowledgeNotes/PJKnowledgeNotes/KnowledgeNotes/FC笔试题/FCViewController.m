//
//  FCViewController.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2019/12/14.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import "Person.h"
#import "FCViewController.h"
#import "FCSanboxFileModel.h"

static NSString *cellIdentifier = @"UITableViewCellIdentifier";

/**
 I 如何使[personA scream]正常输出 @“啊嗷~~~”
    而[personB scream]输出@“Help~~~”
 
 II 写一个简易的文件浏览器，要求以列表的形式展示出Documents目录下的文件以及文件
 夹，并且点击文件夹可以进入对应文件夹下查看文件内容，列表形式如下：
 a.jpg 12KB
 b.mp4 1MB
 Caches folder
*/

@interface FCViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <FCSanboxFileModel *> *arrayFileModels;
@property (nonatomic, copy) NSString *rootPath;

@end

@implementation FCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 正常输出
//    [self methodsExchange];
    
    // 文件浏览器
//    [self fileBrowser];
    
    Person *personA = [Person new];
    [personA funcA];
}

/**
    如何使[personA scream]正常输出 @“啊嗷~~~”
    而[personB scream]输出@“Help~~~”
 */
- (void)methodsExchange {
    
    Person *personA = [Person new];
    Person *personB = [Person new];
    
    [personA scream];
    [personB scream];
}

/**
    写一个简易的文件浏览器，要求以列表的形式展示出Documents目录下的文件以及文件
    夹，并且点击文件夹可以进入对应文件夹下查看文件内容，列表形式如下：
    a.jpg 12KB
    b.mp4 1MB
    Caches folder
 */
- (void)fileBrowser {
    
    [self initData];
    [self initContentView];
    [self loadPath:nil];
}

#pragma mark- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayFileModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row > _arrayFileModels.count - 1 || indexPath.row < 0) {
        return [[UITableViewCell alloc] init];
    }
    
    FCSanboxFileModel *fileModel = [_arrayFileModels objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    switch (fileModel.type) {
        case FCSanboxFileTypeUp:
            cell.textLabel.text = fileModel.name;
            break;
        case FCSanboxFileTypeFile:
            cell.textLabel.text = [NSString stringWithFormat:@"%@   %@",fileModel.name,fileModel.showSize];
            break;
        case FCSanboxFileTypeDirectory:
            cell.textLabel.text = fileModel.name;
            break;
    }
    return cell;
}

#pragma mark- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row > _arrayFileModels.count - 1 || indexPath.row < 0) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    
    FCSanboxFileModel *fileModel = [_arrayFileModels objectAtIndex:indexPath.row];
    
    switch (fileModel.type) {
        case FCSanboxFileTypeUp:
            [self loadPath:[fileModel.path stringByDeletingLastPathComponent]];
            break;
        case FCSanboxFileTypeFile:
            break;
        case FCSanboxFileTypeDirectory:
            [self loadPath:fileModel.path];
            break;
    }
}

#pragma mark- Private
- (void)initData {
 
    _arrayFileModels = [NSArray array];
    _rootPath = NSHomeDirectory();
    [self createTestData];
}

- (void)initContentView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)loadPath:(NSString *)filePath {
    
    NSMutableArray *files = @[].mutableCopy;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *targetPath = filePath;
    if (targetPath.length == 0 || [targetPath isEqualToString:_rootPath]) {
        targetPath = _rootPath;
    } else {
        FCSanboxFileModel *file = [[FCSanboxFileModel alloc] init];
        file.name = @"🔙..";
        file.type = FCSanboxFileTypeUp;
        file.path = filePath;
        file.size = [self getFileSizeWithFilePath:targetPath];
        
        [files addObject:file];
    }
    
    NSError *error = nil;
    NSArray *paths = [fileManager contentsOfDirectoryAtPath:targetPath error:&error];
    for (NSString *path in paths) {
        if ([[path lastPathComponent] hasPrefix:@"."]) {
            continue;
        }
        
        BOOL isDir = false;
        NSString *fullPath = [targetPath stringByAppendingPathComponent:path];
        [fileManager fileExistsAtPath:fullPath isDirectory:&isDir];
        
        FCSanboxFileModel *file = [[FCSanboxFileModel alloc] init];
        file.path = fullPath;
        if (isDir) {
            file.type = FCSanboxFileTypeDirectory;
            file.name = [NSString stringWithFormat:@"%@ %@", @"📁", path];
        } else {
            file.type = FCSanboxFileTypeFile;
            file.name = [NSString stringWithFormat:@"%@ %@", @"📄", path];
        }
        file.size = [self getFileSizeWithFilePath:fullPath];
        [files addObject:file];
    }
    _arrayFileModels = files.copy;
    [_tableView reloadData];
}

- (long long)getFileSizeWithFilePath:(NSString *)filePath {
    
    NSFileManager  *fileMananger = [NSFileManager defaultManager];
    if ([fileMananger fileExistsAtPath:filePath]) {
        NSDictionary *dic = [fileMananger attributesOfItemAtPath:filePath error:nil];
        return [dic[@"NSFileSize"] longLongValue];
    }
    return 0;
}

// 写入测试文件
- (void)createTestData {
    
    NSString *textPath = [_rootPath stringByAppendingString:@"/test.text"];
    NSFileManager *fileManager =[NSFileManager defaultManager];
    [fileManager createFileAtPath:textPath contents:[@"测试文本测" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    NSString *avdioPath = [_rootPath stringByAppendingString:@"/avdio.mp4"];
    [fileManager createFileAtPath:avdioPath contents:[@"测试文本" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
    // 将图片写入文件
    UIImage *image = [UIImage imageNamed:@"image"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *imagePath = [_rootPath stringByAppendingString:@"/image.png"];
    [imageData writeToFile:imagePath atomically:YES];
    
    UIImage *image2 = [UIImage imageNamed:@"IMG_3988"];
    NSData *imageData2 = UIImageJPEGRepresentation(image2, 0.5);
    NSString *imagePath2 = [_rootPath stringByAppendingString:@"/IMG_3988.jpg"];
    [imageData2 writeToFile:imagePath2 atomically:YES];
    
    NSString *textTmpPath = [_rootPath stringByAppendingString:@"/tmp/test.text"];
    [fileManager createFileAtPath:textTmpPath contents:[@"测试文本" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];

    NSString *imagePathxxx = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"mp3"];
    NSData *dataVideo = [NSData dataWithContentsOfFile:imagePathxxx];
    NSString *avdioTmpPath = [_rootPath stringByAppendingString:@"/tmp/music.mp3"];
    [dataVideo writeToFile:avdioTmpPath atomically:YES];
}



@end
