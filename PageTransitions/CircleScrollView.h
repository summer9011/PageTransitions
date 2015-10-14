//
//  CircleScrollView.h
//  PageTransitions
//
//  Created by 赵立波 on 15/10/14.
//  Copyright © 2015年 zleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleScrollView : UIView

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

@property(nonatomic, copy) NSString *(^fetchImageStrAtIndex)(NSInteger pageIndex);
@property(nonatomic, copy) NSInteger (^totalPagesCount)(void);
@property(nonatomic, copy) void (^TapActionBlock)(NSInteger pageIndex);

@end
