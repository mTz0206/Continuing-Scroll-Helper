//
//  UIScrollView+Status.h
//  Demo
//
//  Created by Bruno.ma on 10/11/17.
//  Copyright © 2017 Bruno.ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Status)
- (void)setContentOffsetTop;
- (void)setContentOffsetBottom;
- (BOOL)isScrollViewOnTop;
- (BOOL)isScrollViewOnBottom;
- (BOOL)isScrollViewOnMiddle;
@end
