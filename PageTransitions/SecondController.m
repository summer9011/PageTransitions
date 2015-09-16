//
//  SecondController.m
//  PageTransitions
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 zleb. All rights reserved.
//

#import "SecondController.h"

#import "Temp1Controller.h"
#import "Temp2Controller.h"
#import "Temp3Controller.h"
#import "Temp4Controller.h"
#import "Temp5Controller.h"

@interface SecondController ()

@property (nonatomic, strong) NSMutableArray *vcArr;

@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, strong) NSArray *headArr;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    self.vcArr = [NSMutableArray array];
    
    CGSize boundSize = [UIScreen mainScreen].bounds.size;
    
    self.headArr = @[
                     @"Temp1VC",
                     @"Temp2VC",
                     @"Temp3VC",
                     @"Temp4VC",
                     @"Temp5VC"
                     ];
    
    CGFloat buttonWidth = 80;
    CGFloat buttonHeight = 44;
    
    NSUInteger index = 1;
    for (NSString *name in self.headArr) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor = [UIColor lightGrayColor];
        button.tag = index;
        button.frame = CGRectMake((index - 1) * (buttonWidth + 10), 20, buttonWidth, buttonHeight);
        
        [button setTitle:name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:button];
        
        index ++;
    }
    
    self.scrollView.contentSize = CGSizeMake((buttonWidth + 10) * self.headArr.count, 64);
    
    Temp1Controller *temp1VC = [[Temp1Controller alloc] initWithNibName:@"Temp1Controller" bundle:nil];
    temp1VC.view.frame = CGRectMake(0, 64, boundSize.width, boundSize.height - 64);
    [self.vcArr addObject:temp1VC];
    
    [self addChildViewController:temp1VC];
    
    [self.view addSubview:temp1VC.view];
    self.currentVC = temp1VC;
    self.currentIndex = 1;
    
    [self setCurrentButtonState];
}

- (void)setCurrentButtonState {
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
    }
    
    UIButton *button = (UIButton *)[self.scrollView viewWithTag:self.currentIndex];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (void)changeVC:(UIButton *)button {
    if (self.currentIndex != button.tag) {
        
        CGSize boundSize = [UIScreen mainScreen].bounds.size;
        
        UIViewController *newVC;
        
        for (UIViewController *vc in self.vcArr) {
            switch (button.tag) {
                case 1: {
                    if ([vc isKindOfClass:[Temp1Controller class]]) {
                        newVC = vc;
                    }
                }
                    break;
                case 2: {
                    if ([vc isKindOfClass:[Temp2Controller class]]) {
                        newVC = vc;
                    }
                }
                    break;
                case 3: {
                    if ([vc isKindOfClass:[Temp3Controller class]]) {
                        newVC = vc;
                    }
                }
                    break;
                case 4: {
                    if ([vc isKindOfClass:[Temp4Controller class]]) {
                        newVC = vc;
                    }
                }
                    break;
                case 5: {
                    if ([vc isKindOfClass:[Temp5Controller class]]) {
                        newVC = vc;
                    }
                }
                    break;
            }
        }
        
        if (newVC == nil) {
            switch (button.tag) {
                case 1: {
                    newVC = [[Temp1Controller alloc] initWithNibName:@"Temp1Controller" bundle:nil];
                }
                    break;
                case 2: {
                    newVC = [[Temp2Controller alloc] initWithNibName:@"Temp2Controller" bundle:nil];
                }
                    break;
                case 3: {
                    newVC = [[Temp3Controller alloc] initWithNibName:@"Temp3Controller" bundle:nil];
                }
                    break;
                case 4: {
                    newVC = [[Temp4Controller alloc] initWithNibName:@"Temp4Controller" bundle:nil];
                }
                    break;
                case 5: {
                    newVC = [[Temp5Controller alloc] initWithNibName:@"Temp5Controller" bundle:nil];
                }
                    break;
            }
            
            newVC.view.frame = CGRectMake(0, 64, boundSize.width, boundSize.height - 64);
            [self.vcArr addObject:newVC];
        }
        
        [self replaceVCWithNewVC:newVC index:button.tag];
    }
}

- (void)replaceVCWithNewVC:(UIViewController *)newVC index:(NSUInteger)index {
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.enabled = NO;
        }
    }
    
    CGSize bound = [UIScreen mainScreen].bounds.size;
    
    if (self.currentIndex > index) {
        self.currentVC.view.frame = CGRectMake(0, self.currentVC.view.frame.origin.y, bound.width, CGRectGetHeight(self.currentVC.view.frame));
        newVC.view.frame = CGRectMake(-1 * bound.width, newVC.view.frame.origin.y, bound.width, CGRectGetHeight(newVC.view.frame));
    } else {
        self.currentVC.view.frame = CGRectMake(0, self.currentVC.view.frame.origin.y, bound.width, CGRectGetHeight(self.currentVC.view.frame));
        newVC.view.frame = CGRectMake(bound.width, newVC.view.frame.origin.y, bound.width, CGRectGetHeight(newVC.view.frame));
    }
    
    [self addChildViewController:newVC];
    
    [self transitionFromViewController:self.currentVC toViewController:newVC duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        if (self.currentIndex > index) {
            self.currentVC.view.frame = CGRectMake(bound.width, self.currentVC.view.frame.origin.y, bound.width, CGRectGetHeight(self.currentVC.view.frame));
            newVC.view.frame = CGRectMake(0, newVC.view.frame.origin.y, bound.width, CGRectGetHeight(newVC.view.frame));
        } else {
            self.currentVC.view.frame = CGRectMake(-1 * bound.width, self.currentVC.view.frame.origin.y, bound.width, CGRectGetHeight(self.currentVC.view.frame));
            newVC.view.frame = CGRectMake(0, newVC.view.frame.origin.y, bound.width, CGRectGetHeight(newVC.view.frame));
        }
    } completion:^(BOOL finished) {
        if (finished) {
            [newVC didMoveToParentViewController:self];
            [self.currentVC willMoveToParentViewController:nil];
            [self.currentVC removeFromParentViewController];
            
            self.currentVC = newVC;
            self.currentIndex = index;
            
            [self setCurrentButtonState];
            
            for (UIView *view in self.scrollView.subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    UIButton *button = (UIButton *)view;
                    button.enabled = YES;
                }
            }
        }
        
    }];
    
}

@end
