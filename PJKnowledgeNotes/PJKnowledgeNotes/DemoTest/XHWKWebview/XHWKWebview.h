//
//  XHWKWebview.h
//  EverStarIOSCode
//
//  Created by 周鹏钜 on 2020/7/1.
//  Copyright © 2020 李顺喜. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 自定义图片预览, 需要做以下处理
 // 1. 设置预览属性
 _webView.isPreviewPictureDefault = YES;
 
 // 2. 实现预览回调
 _webView.previewPictureCallBack = ^(int currentIndex, NSArray * _Nonnull arrayImgs) {
     
 };
 */

@interface XHWKWebview : WKWebView

@property (nonatomic,assign) BOOL isEstimatedProgress; //!< 是否显示 H5 加载进度, 默认Yes

@property (nonatomic,assign) BOOL isRemoveCookies; //!< 是否移除Cookies, 默认Yes

@property (nonatomic,assign) BOOL isJsInteraction; //!< 是否和 H5 交互, 默认NO

@property (nonatomic,assign) BOOL isPreviewPictureDefault; //!< 预览图片方式选择 默认NO 使用内部默认的图片预览   YES: 自己实现
 
@property (nonatomic, copy) void(^estimatedProgressCallBack)(double estimatedProgress); //!< 加载进度回调

@property (nonatomic, copy) void(^previewPictureCallBack)(int currentIndex, NSArray *arrayImgs); //!< 自定义图片预览

@property (nonatomic, copy) void(^getWKWebViewHeightBlock)(CGFloat webHeight);

- (void)loadUrlString:(NSString *)urlString; //!< 加载 js 代码段

- (WKNavigation *)loadRequestString:(NSString *)urlStr; //!< 加载 完整 url 链接

- (WKNavigation *)localHTMLFileString:(NSString *)urlStr; //!< 加载 H5 文件 index.html 就传 index



@end

NS_ASSUME_NONNULL_END
