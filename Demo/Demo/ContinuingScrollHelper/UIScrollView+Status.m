//
//  UIScrollView+Status.m
//  Demo
//
//  Created by Bruno.ma on 10/11/17.
//  Copyright © 2017 Bruno.ma. All rights reserved.
//

#import "UIScrollView+Status.h"

@implementation UIScrollView (Status)
- (BOOL)isScrollViewOnTop
{
    if (self == nil) {
        return YES;
    }
    BOOL scrollViewTop = self.contentOffset.y <= -self.contentInset.top;
    return scrollViewTop;
}

- (BOOL)isScrollViewOnBottom
{
    BOOL scrollViewBottom = ceil(self.contentOffset.y) >= ceil(self.contentSize.height - self.frame.size.height);
    return scrollViewBottom;
}

- (BOOL)isScrollViewOnMiddle
{
    BOOL scrollViewMiddle = (ceil(self.contentOffset.y) > -self.contentInset.top) && ( ceil(self.contentOffset.y) < ceil(self.contentSize.height - self.frame.size.height)) ;
    return scrollViewMiddle;
}

- (void)setContentOffsetTop
{
    [self setContentOffset:CGPointMake(0, -self.contentInset.top) animated:YES];
}

- (void)setContentOffsetBottom
{
    [self setContentOffset:CGPointMake(0, ceil(self.contentSize.height - self.frame.size.height)) animated:YES];
}
@end
