//
//  ScrollViewTableViewCell.h
//  scrollView_test
//
//  Created by Bruno.ma on 9/27/17.
//  Copyright © 2017 Bruno.ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface ScrollViewTableViewCell : UITableViewCell <WKUIDelegate,WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet WKWebView *webview;

@end
