//
//  ContinuingScrollHelper.m
//  Demo
//
//  Created by Bruno.ma on 10/11/17.
//  Copyright © 2017 Bruno.ma. All rights reserved.
//

#import "ContinuingScrollHelper.h"
#import "UIScrollView+Status.h"

OBJC_EXTERN NSString * const ApplicationReceivedStatusBarTap;

@interface ContinuingScrollHelper()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, weak)UIScrollView *mainScrollView;
@property (nonatomic, weak)UIScrollView *subScrollView;
@property (nonatomic, assign)BOOL scrollViewDragging;
@property (nonatomic, assign)CGFloat defaultOffsetY;

@end
@implementation ContinuingScrollHelper
- (instancetype)initWithScrollView:(UIScrollView *)scrollView superView:(UIView *)superView
{
    self = [super init];
    if (self) {
        _scrollView = [UIScrollView new];
        [superView addSubview:_scrollView];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView addSubview:scrollView];
        _mainScrollView = scrollView;
        _mainScrollView.scrollEnabled = NO;
        _mainScrollView.bounces = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToTop) name:ApplicationReceivedStatusBarTap object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ApplicationReceivedStatusBarTap object:nil];
    _scrollView = nil;
}

- (void)scrollToTop
{
    [_scrollView setContentOffset:CGPointMake(0, _defaultOffsetY) animated:YES];
    [_mainScrollView setContentOffsetTop];
    [_subScrollView setContentOffsetTop];
}

- (void)setFrame:(CGRect)frame
{
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    _frame = frame;
    _defaultOffsetY = height / 2;
    _scrollView.frame = frame;
    _scrollView.contentSize = CGSizeMake(width, height * 2);
    _scrollView.contentOffset = CGPointMake(0, _defaultOffsetY);
    _mainScrollView.frame = CGRectMake(0, _defaultOffsetY, width, height);
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _scrollViewDragging = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _scrollViewDragging = NO;
    if ([_mainScrollView isScrollViewOnTop] && [_subScrollView isScrollViewOnTop] && !_scrollViewDragging) {
        [_scrollView setContentOffset:CGPointMake(0, _defaultOffsetY) animated:YES];
        [_mainScrollView setContentOffsetTop];
        [_subScrollView setContentOffsetTop];
        return;
    } else if ([_mainScrollView isScrollViewOnBottom] && [_subScrollView isScrollViewOnBottom] && !_scrollViewDragging){
        [_scrollView setContentOffset:CGPointMake(0, _defaultOffsetY) animated:YES];
        [_mainScrollView setContentOffsetBottom];
        [_subScrollView setContentOffsetBottom];
        return;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = _scrollView.contentOffset.y - _defaultOffsetY;
    //offset < 0 pull down
    //offset > 0 push up
    _scrollView.contentOffset = CGPointMake(0, _defaultOffsetY);
    if (scrollView == _scrollView) {
        if ([_mainScrollView isScrollViewOnTop] && [_subScrollView isScrollViewOnTop] && !_scrollViewDragging) {
            [_scrollView setContentOffset:CGPointMake(0, _defaultOffsetY) animated:YES];
            [_mainScrollView setContentOffsetTop];
            [_subScrollView setContentOffsetTop];
            return;
        } else if ([_mainScrollView isScrollViewOnBottom] && [_subScrollView isScrollViewOnBottom] && !_scrollViewDragging){
            [_scrollView setContentOffset:CGPointMake(0, _defaultOffsetY) animated:YES];
            [_mainScrollView setContentOffsetBottom];
            [_subScrollView setContentOffsetBottom];
            return;
        }
        UIScrollView * sc = [self swithActiveScrollView:offset];
        CGPoint sc_offset =  sc.contentOffset;
        if (sc == _mainScrollView) {
            if ([sc isScrollViewOnTop]) {
                if (_scrollViewDragging) {
                    sc_offset.y += offset * 0.3;
                } else {
                    sc_offset.y = 0;
                }
            } else {
                sc_offset.y += offset;
            }
            if ((sc_offset.y >= sc.contentSize.height - sc.frame.size.height) && sc.contentSize.height > 0) {
                sc_offset.y = sc.contentSize.height - sc.frame.size.height;
            }
            sc.contentOffset = sc_offset;
        } else {
            sc_offset.y += offset;
            if (sc_offset.y < -sc.contentInset.top) {
                sc_offset.y = -sc.contentInset.top;
            }
            if (sc_offset.y >= sc.contentSize.height - sc.frame.size.height) {
                sc_offset.y = sc.contentSize.height - sc.frame.size.height;
            }
            sc.contentOffset = sc_offset;
        }
        
    }
}

- (UIScrollView *)swithActiveScrollView:(CGFloat)offset
{
    BOOL mainScrollViewTop = [_mainScrollView isScrollViewOnTop];
    BOOL mainScrollViewMiddle = [_mainScrollView isScrollViewOnMiddle];
    BOOL mainScrollViewBottom = [_mainScrollView isScrollViewOnBottom];
    BOOL subScrollViewTop = _subScrollView== nil ? YES : [_subScrollView isScrollViewOnTop];
    BOOL subScrollViewMiddle = [_subScrollView isScrollViewOnMiddle];
    BOOL subScrollViewBottom = [_subScrollView isScrollViewOnBottom];
    if (offset > 0) {
        if (mainScrollViewTop && subScrollViewTop) {
            return _mainScrollView;
        }
        if (mainScrollViewMiddle && subScrollViewTop) {
            return _mainScrollView;
        }
        if (mainScrollViewBottom && subScrollViewTop) {
            return _subScrollView;
        }
        if (mainScrollViewBottom && subScrollViewMiddle) {
            return _subScrollView;
        }
        if (mainScrollViewBottom && subScrollViewBottom) {
            return _mainScrollView;
        }
    } else {
        if (mainScrollViewTop && subScrollViewTop) {
            return _mainScrollView;
        }
        if (mainScrollViewMiddle && subScrollViewTop) {
            return _mainScrollView;
        }
        if (mainScrollViewBottom && subScrollViewTop) {
            return _mainScrollView;
        }
        if (mainScrollViewBottom && subScrollViewMiddle) {
            return _subScrollView;
        }
        if (mainScrollViewBottom && subScrollViewBottom) {
            return _subScrollView;
        }
    }
    //incorrect status and fix
    _subScrollView.contentOffset = CGPointMake(0, -_subScrollView.contentInset.top);
    return _mainScrollView;
    
}

- (void)setSecondScrollView:(UIScrollView *)scrollView
{
    _subScrollView = scrollView;
    _subScrollView.scrollEnabled = NO;
}

- (UIView *)view
{
    return _scrollView;
}
@end
