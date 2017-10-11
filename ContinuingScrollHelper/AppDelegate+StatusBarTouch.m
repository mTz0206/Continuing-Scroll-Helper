//
//  AppDelegate+StatusBarTouch.m
//  Demo
//
//  Created by Bruno.ma on 10/11/17.
//  Copyright © 2017 Bruno.ma. All rights reserved.
//

#import "AppDelegate+StatusBarTouch.h"

@implementation AppDelegate (StatusBarTouch)
#pragma mark - Custom touch event

NSString * const ApplicationReceivedStatusBarTap = @"status-bar-tap";

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    const CGPoint position = [[touches anyObject] locationInView:self.window];
    const CGRect statusFrame = [[UIApplication sharedApplication] statusBarFrame];
    if (CGRectContainsPoint(statusFrame, position)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ApplicationReceivedStatusBarTap object:nil];
    }
}

@end
