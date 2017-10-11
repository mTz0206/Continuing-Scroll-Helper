//
//  ScrollViewTableViewCell.m
//  scrollView_test
//
//  Created by Bruno.ma on 9/27/17.
//  Copyright © 2017 Bruno.ma. All rights reserved.
//

#import "ScrollViewTableViewCell.h"
#define GET_FULL_WIDTH                      ([UIScreen mainScreen].bounds.size.width)
#define GET_FULL_HEIGHT                     ([UIScreen mainScreen].bounds.size.height)


@implementation ScrollViewTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        WKWebView * webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, GET_FULL_WIDTH, GET_FULL_HEIGHT)];
        [self addSubview:webview];
        _scrollView = webview.scrollView;
        webview.scrollView.showsVerticalScrollIndicator = YES;
        webview.scrollView.scrollEnabled = NO;
        webview.UIDelegate = self;
        webview.navigationDelegate = self;
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/mTz0206/Continuing-Scroll-Helper"]]];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    _scrollView.contentSize = CGSizeMake(GET_FULL_WIDTH, 2 * GET_FULL_HEIGHT);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}


@end
