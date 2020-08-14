//
//  XHWKWebview.m
//  EverStarIOSCode
//
//  Created by 周鹏钜 on 2020/7/1.
//  Copyright © 2020 李顺喜. All rights reserved.
//

#import "XHWKWebview.h"
//#import "XHWebImageScrollView.h"
#import "NSObject+KVOGoalkeeper.h"

@interface XHWKWebview () <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>
{
    NSString *_imgSrc;//  预览图片的URL路径
}

@property (nonatomic, strong) WKUserScript *userScript; //!<

@property (nonatomic, strong, readonly) NSMutableArray *imgSrcArray; //!< web页面中的图片链接数组

@end

@implementation XHWKWebview

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
        [self addObserverEvent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame configuration:(nonnull WKWebViewConfiguration *)configuration {
    
    WKWebViewConfiguration *configer = [[WKWebViewConfiguration alloc] init];
    configer.userContentController = [[WKUserContentController alloc] init];

    configer.selectionGranularity = NO;
    configer.preferences = [[WKPreferences alloc] init];
    configer.preferences.javaScriptEnabled = YES;
    [configer.userContentController addUserScript:self.userScript];
    
//    WKUserContentController *userCC = configer.userContentController;
//    [userCC addScriptMessageHandler:self name:@"getWebHeight"];
    
    self = [super initWithFrame:frame configuration:configer];
    
    return self;
}

- (void)initialization {
    
    self.backgroundColor = [UIColor clearColor];
    
    self.isJsInteraction = NO;
    self.isRemoveCookies = YES;
    self.isEstimatedProgress = YES;
    self.isPreviewPictureDefault = NO;
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.navigationDelegate = self;
    self.UIDelegate = self;
    self.opaque = NO;
    self.allowsBackForwardNavigationGestures = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
}


- (void)setIsRemoveCookies:(BOOL)isRemoveCookies {
    _isRemoveCookies = isRemoveCookies;
}

- (void)setIsEstimatedProgress:(BOOL)isEstimatedProgress {
    _isEstimatedProgress = isEstimatedProgress;
    
    if (!isEstimatedProgress) {
        if ([NSObject isObj:self hasObserverKey:@"estimatedProgress"]) {
            [self removeObserver:self forKeyPath:@"estimatedProgress"];
        }
    }
}

- (void)setIsJsInteraction:(BOOL)isJsInteraction {
    _isJsInteraction = isJsInteraction;
    
    if (isJsInteraction) {
        
    }
}

- (WKNavigation *)localHTMLFileString:(NSString *)urlStr {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:urlStr ofType:@"html"];
    return [self loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
}

- (void)loadUrlString:(NSString *)urlString {
    
    NSString *htmlcontent = [NSString stringWithFormat:@"<%@ %@",@"img",@"style='display: block; max-width: 100%;'"];
    
    urlString = [urlString stringByReplacingOccurrencesOfString:@"<img" withString:htmlcontent];
    
    NSString *htmlStr = [NSString stringWithFormat:@"<html><head><meta http-equiv=\'Content-Type\' content=\'text/html; charset=utf-8\'/><meta content=\'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;\' name=\'viewport\' /><meta name=\'apple-mobile-web-app-capable\' content=\'yes\'><meta name=\'apple-mobile-web-app-status-bar-style\' content=\'black\'><link rel=\'stylesheet\' type=\'text/css\' /></head><body><div id=\'content\'>%@</div>", urlString];
    
    [self loadHTMLString:htmlStr baseURL:nil];
}

- (WKNavigation *)loadRequestString:(NSString *)urlStr {
    return [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)addObserverEvent {
    
    NSKeyValueObservingOptions observingOptions = NSKeyValueObservingOptionNew;
    [self addObserver:self forKeyPath:@"estimatedProgress" options:observingOptions context:nil];
}

#pragma mark - KVO监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        if (self.estimatedProgressCallBack) {
            self.estimatedProgressCallBack(self.estimatedProgress);
        }
    }
}

#pragma mark - WKUIDelegate, WKNavigationDelegate
#pragma mark - WKNavigationDelegate
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    self.navigationItem.title = webView.title;
    
    //获取图片数组
    [webView evaluateJavaScript:@"getImages()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        self->_imgSrcArray = [NSMutableArray arrayWithArray:[result componentsSeparatedByString:@"+"]];
    }];
    
    [webView evaluateJavaScript:@"registerImageClickAction();" completionHandler:^(id _Nullable result, NSError * _Nullable error) {}];
    
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
        if (self.getWKWebViewHeightBlock) {
            self.getWKWebViewHeightBlock([result floatValue]);
        }
    }];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {

}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    if ([navigationAction.request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [navigationAction.request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        _imgSrc = path;
        
        NSString *hasSuffix = path.pathExtension;
        if ((hasSuffix.length) && ([hasSuffix isEqualToString:@"png"] || [hasSuffix isEqualToString:@"jpg"] || [hasSuffix isEqualToString:@"jpeg"])) {
            [self previewPicture];
        }
    }
    
    // 获取完整url并进行UTF-8转码
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    
    NSString *hasSuffixRequest = strRequest.pathExtension;
    if ([navigationAction.request.URL.scheme isEqualToString:@"image-preview"] || !strRequest.length || [hasSuffixRequest isEqualToString:@"png"] || [hasSuffixRequest isEqualToString:@"jpg"] || [hasSuffixRequest isEqualToString:@"jpeg"]) {   // 拦截点击链接
        decisionHandler(WKNavigationActionPolicyCancel);    // 不允许跳转
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);     // 允许跳转
    }
}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [webView reload];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {

//    if ([message.name isEqualToString:@"getWebHeight"]) {
//        NSString *body = [NSString stringWithFormat:@"%@",message.body];
//        CGFloat webH = body.floatValue;
//
//        if (self.getWKWebViewHeightBlock) {
//            self.getWKWebViewHeightBlock(webH);
//        }
//    }
}

- (void)dealloc {
    
    if (self.isEstimatedProgress) {
        if ([NSObject isObj:self hasObserverKey:@"estimatedProgress"]) {
            [self removeObserver:self forKeyPath:@"estimatedProgress"];
        }
    }
    
    [self removeAllCachedCookies];
}

// TODO: 清除cookie
- (void)removeAllCachedCookies {
    
    if (!self.isRemoveCookies) return;
    
    if (@available(iOS 9.0, *)) {
        
        WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
        [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes] completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
            for (WKWebsiteDataRecord *record  in records) {
                [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes forDataRecords:@[record] completionHandler:^{
                    NSLog(@"Cookies for %@ deleted successfully", record.displayName);
                }];
            }
        }];
    }
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses]; //清除UIWebView的缓存
}

#pragma mark - 懒加载
- (WKUserScript *)userScript {
    if (!_userScript) {
        static  NSString * const jsGetImages =
        @"function getImages(){\
        var objs = document.getElementsByTagName(\"img\");\
        var imgScr = '';\
        for(var i=0;i<objs.length;i++){\
        imgScr = imgScr + objs[i].src + '+';\
        };\
        return imgScr;\
        };function registerImageClickAction(){\
        var imgs=document.getElementsByTagName('img');\
        var length=imgs.length;\
        for(var i=0;i<length;i++){\
        img=imgs[i];\
        img.onclick=function(){\
        window.location.href='image-preview:'+this.src}\
        }\
        }";
        _userScript = [[WKUserScript alloc] initWithSource:jsGetImages injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    }
    return _userScript;
}

#pragma mark - 图片预览
- (void)previewPicture {
    
    int currentIndex = 0;
    NSMutableArray *arrImageShow = [NSMutableArray array];
    
    for (int i = 0; i < self.imgSrcArray.count; i++) {

        NSString *imgUrlPath = self.imgSrcArray[i];
        if ([imgUrlPath isEqualToString:_imgSrc]) {
            currentIndex = i;
        }
        
        NSString *hasSuffix = imgUrlPath.pathExtension;
        if ([hasSuffix isEqualToString:@"png"] || [hasSuffix isEqualToString:@"jpg"] || [hasSuffix isEqualToString:@"jpeg"]) {
            [arrImageShow addObject:imgUrlPath];
        }
    }
    
    [self previewPictureIndex:currentIndex ShowArray:arrImageShow];
}

- (void)previewPictureIndex:(int)currentIndex ShowArray:(NSArray *)arrImageShow{
    
    if (!arrImageShow.count) {
        return;
    }
    
    if (self.isPreviewPictureDefault) {
        if (self.previewPictureCallBack) {
            self.previewPictureCallBack(currentIndex, arrImageShow);
        }
    } else {
//        [XHWebImageScrollView showImageWithImageArr:arrImageShow andImageIndex:currentIndex];
    }
}

@end
