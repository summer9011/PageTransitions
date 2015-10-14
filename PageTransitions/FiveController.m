//
//  FiveController.m
//  PageTransitions
//
//  Created by 赵立波 on 15/10/14.
//  Copyright © 2015年 zleb. All rights reserved.
//

#import "FiveController.h"
#import "CircleScrollView.h"

@interface FiveController ()

@property (nonatomic, strong) CircleScrollView *circleScroll;

@property (nonatomic, strong) NSMutableArray *imageStrArr;

@end

@implementation FiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageStrArr = [NSMutableArray array];
    
    NSArray *arr = @[
                     @"http://zx.kaitao.cn/UserFiles/Image/beijingtupian6.jpg",
                     @"http://news.51sheyuan.com/uploads/allimg/111001/133442IB-2.jpg",
                     @"http://www.xxjxsj.cn/article/UploadPic/2009-10/200910321242159016.jpg",
                     @"http://zx.kaitao.cn/UserFiles/Image/beijingtupian6.jpg",
                     @"http://news.51sheyuan.com/uploads/allimg/111001/133442IB-2.jpg",
                     @"http://www.xxjxsj.cn/article/UploadPic/2009-10/200910321242159016.jpg"
                     ];
    [self.imageStrArr addObjectsFromArray:arr];
    
    __block NSMutableArray *blockImageArr = self.imageStrArr;
    
    self.circleScroll = [[CircleScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 300) animationDuration:-1];
    
    self.circleScroll.fetchImageStrAtIndex = ^NSString *(NSInteger pageIndex) {
        return blockImageArr[pageIndex];
    };
    
    self.circleScroll.totalPagesCount = ^NSInteger(void) {
        return blockImageArr.count;
    };
    
    self.circleScroll.TapActionBlock = ^(NSInteger pageIndex) {
        NSLog(@"%@", blockImageArr[pageIndex]);
    };
    
    [self.view addSubview:self.circleScroll];
}

- (IBAction)doResetDataAction:(id)sender {
    [self.imageStrArr removeLastObject];
    
    __block NSMutableArray *blockImageArr = self.imageStrArr;
    
    self.circleScroll.totalPagesCount = ^NSInteger(void) {
        return blockImageArr.count;
    };
}

@end
