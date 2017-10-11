//
//  ContinuingScrollHelper.h
//  Demo
//
//  Created by Bruno.ma on 10/11/17.
//  Copyright © 2017 Bruno.ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ContinuingScrollHelper : NSObject
@property (nonatomic, assign)CGRect frame;
@property (nonatomic, weak, readonly)UIView *view;
- (void)setSecondScrollView:(UIScrollView *)scrollView;
- (instancetype)initWithScrollView:(UIScrollView *)scrollView superView:(UIView *)superView;
@end
