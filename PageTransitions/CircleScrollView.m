//
//  CircleScrollView.m
//  PageTransitions
//
//  Created by 赵立波 on 15/10/14.
//  Copyright © 2015年 zleb. All rights reserved.
//

#import "CircleScrollView.h"
#import "UIImageView+WebCache.h"

@interface CircleScrollView () <UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic , strong) NSMutableArray *contentImageStrArr;

@property (nonatomic , strong) NSTimer *animationTimer;
@property (nonatomic , assign) NSTimeInterval animationDuration;

@end

@implementation CircleScrollView

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration {
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration) target:self selector:@selector(animationTimerDidFired:) userInfo:nil repeats:YES];
        [self.animationTimer setFireDate:[NSDate date]];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.delegate = self;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:self.scrollView];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)/2.f - 100, CGRectGetHeight(self.bounds) - 37, 200, 37)];
        self.pageControl.hidesForSinglePage = YES;
        [self addSubview:self.pageControl];
        
        self.pageControl.currentPage = 0;
    }
    return self;
}

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount {
    self.pageControl.numberOfPages = totalPagesCount();
    
    if (self.pageControl.numberOfPages > 0) {
        [self configContentViews];
        [self.animationTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.animationDuration]];
    }
}

#pragma mark - 私有函数

- (void)configContentViews {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (NSString *imageStr in self.contentImageStrArr) {
        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CircleScrollItem" owner:nil options:nil];
        UIView *contentView = nibViews[0];
        contentView.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        
        UIImageView *imageView = contentView.subviews[0];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tap];
        
        [self.scrollView addSubview:contentView];
    }
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

- (void)setScrollViewContentDataSource {
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.pageControl.currentPage - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.pageControl.currentPage + 1];
    
    if (self.contentImageStrArr == nil) {
        self.contentImageStrArr = [NSMutableArray array];
    }
    [self.contentImageStrArr removeAllObjects];
    
    if (self.fetchImageStrAtIndex) {
        [self.contentImageStrArr addObject:self.fetchImageStrAtIndex(previousPageIndex)];
        [self.contentImageStrArr addObject:self.fetchImageStrAtIndex(self.pageControl.currentPage)];
        [self.contentImageStrArr addObject:self.fetchImageStrAtIndex(rearPageIndex)];
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex; {
    if(currentPageIndex == -1) {
        return self.pageControl.numberOfPages - 1;
    } else if (currentPageIndex == self.pageControl.numberOfPages) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.animationTimer setFireDate:[NSDate date]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.animationTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.animationDuration]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.pageControl.currentPage = [self getValidNextPageIndexWithPageIndex:self.pageControl.currentPage + 1];
        
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.pageControl.currentPage = [self getValidNextPageIndexWithPageIndex:self.pageControl.currentPage - 1];
        
        [self configContentViews];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer {
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap {
    if (self.TapActionBlock) {
        self.TapActionBlock(self.pageControl.currentPage);
    }
}

@end
