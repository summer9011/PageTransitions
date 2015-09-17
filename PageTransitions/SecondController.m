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

#define BoundSize [UIScreen mainScreen].bounds.size
#define Duration 0.2
#define TriggerPercent 0.2

@interface SecondController ()

@property (nonatomic, strong) NSMutableArray *vcArr;

@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, strong) UIViewController *leftVC;
@property (nonatomic, assign) NSUInteger leftIndex;

@property (nonatomic, strong) UIViewController *rightVC;
@property (nonatomic, assign) NSUInteger rightIndex;

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
        UIViewController *newVC = [self newVCForIndex:button.tag];
        
        [self replaceVCWithNewVC:newVC index:button.tag];
    }
}

- (UIViewController *)newVCForIndex:(NSUInteger)index {
    CGSize boundSize = [UIScreen mainScreen].bounds.size;
    
    UIViewController *newVC;
    
    for (UIViewController *vc in self.vcArr) {
        switch (index) {
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
        switch (index) {
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
    
    return newVC;
}

#pragma mark - 点击顶部筛选栏切换

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

#pragma mark - 手势切换

- (IBAction)changeView:(id)sender {
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
    CGPoint point = [pan translationInView:self.view];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            //clear left and right ViewController
            self.leftVC = nil;
            self.leftIndex = 0;
            self.rightVC = nil;
            self.rightIndex = 0;
            
            [self setVCViewFrame:self.currentVC point:point];
            
            //set left or right ViewController when recognizer began
            if (self.currentIndex == 1) {
                [self setPanToRight:point];
            } else if (self.currentIndex == self.headArr.count) {
                [self setPanToLeft:point];
            } else {
                [self setPanToLeft:point];
                [self setPanToRight:point];
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            //pan for all ViewController's view
            [self setVCViewFrame:self.currentVC point:point];
            
            if (self.currentIndex == 1) {
                [self setVCViewFrame:self.rightVC point:point];
            } else if (self.currentIndex == self.headArr.count) {
                [self setVCViewFrame:self.leftVC point:point];
            } else {
                [self setVCViewFrame:self.leftVC point:point];
                [self setVCViewFrame:self.rightVC point:point];
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {
            [self setVCViewFrame:self.currentVC point:point];
            
            //set the left ViewController's origin.x compare with the screen's left side
            CGFloat leftPercent = 0;
            if (self.leftVC) {
                if (self.leftVC.view.frame.origin.x > -1 * BoundSize.width) {
                    leftPercent = self.leftVC.view.frame.origin.x/BoundSize.width + 1;
                }
            }
            
            //set the left ViewController's origin.x compare with the screen's left side
            CGFloat rightPercent = 0;
            if (self.rightVC) {
                if (self.rightVC.view.frame.origin.x < BoundSize.width) {
                    rightPercent = 1 - self.rightVC.view.frame.origin.x/BoundSize.width;
                }
            }
            
            //check which percent is more than the trigger percent,
            //if left percent and right percent are less than the trigger percent,
            //set to the current ViewController
            if (leftPercent > TriggerPercent) {
                [self addChildViewController:self.leftVC];
                
                [self transitionFromViewController:self.currentVC toViewController:self.leftVC duration:Duration options:UIViewAnimationOptionCurveEaseOut animations:^{
                    self.leftVC.view.frame = CGRectMake(0, self.leftVC.view.frame.origin.y, BoundSize.width, CGRectGetHeight(self.leftVC.view.frame));
                    
                    self.currentVC.view.frame = CGRectMake(BoundSize.width, self.currentVC.view.frame.origin.y, BoundSize.width, CGRectGetHeight(self.currentVC.view.frame));
                } completion:^(BOOL finished) {
                    if (finished) {
                        [self.leftVC didMoveToParentViewController:self];
                        [self.currentVC willMoveToParentViewController:nil];
                        [self.currentVC removeFromParentViewController];
                        
                        self.currentVC = self.leftVC;
                        self.currentIndex = self.leftIndex;
                        
                        [self setCurrentButtonState];
                        
                        for (UIView *view in self.scrollView.subviews) {
                            if ([view isKindOfClass:[UIButton class]]) {
                                UIButton *button = (UIButton *)view;
                                button.enabled = YES;
                            }
                        }
                    }
                    
                }];
            } else if (rightPercent > TriggerPercent) {
                [self addChildViewController:self.rightVC];
                
                [self transitionFromViewController:self.currentVC toViewController:self.rightVC duration:Duration options:UIViewAnimationOptionCurveEaseOut animations:^{
                    self.currentVC.view.frame = CGRectMake(-1 * BoundSize.width, self.currentVC.view.frame.origin.y, BoundSize.width, CGRectGetHeight(self.currentVC.view.frame));
                    
                    self.rightVC.view.frame = CGRectMake(0, self.rightVC.view.frame.origin.y, BoundSize.width, CGRectGetHeight(self.rightVC.view.frame));
                } completion:^(BOOL finished) {
                    if (finished) {
                        [self.rightVC didMoveToParentViewController:self];
                        [self.currentVC willMoveToParentViewController:nil];
                        [self.currentVC removeFromParentViewController];
                        
                        self.currentVC = self.rightVC;
                        self.currentIndex = self.rightIndex;
                        
                        [self setCurrentButtonState];
                        
                        for (UIView *view in self.scrollView.subviews) {
                            if ([view isKindOfClass:[UIButton class]]) {
                                UIButton *button = (UIButton *)view;
                                button.enabled = YES;
                            }
                        }
                    }
                    
                }];
            } else {
                [self allVCAniamtion];
            }
        }
            break;
        default: {
            [self allVCAniamtion];
        }
            break;
    }
    
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)setVCViewFrame:(UIViewController *)vc point:(CGPoint)point {
    vc.view.frame = CGRectMake(vc.view.frame.origin.x + point.x * 0.6, vc.view.frame.origin.y, CGRectGetWidth(vc.view.frame), CGRectGetHeight(vc.view.frame));
}

- (void)setPanToLeft:(CGPoint)point {
    self.leftIndex = self.currentIndex - 1;
    self.leftVC = [self newVCForIndex:self.leftIndex];
    
    self.leftVC.view.frame = CGRectMake(-1 * BoundSize.width, self.leftVC.view.frame.origin.y, CGRectGetWidth(self.leftVC.view.frame), CGRectGetHeight(self.leftVC.view.frame));
    
    [self.leftVC.view removeFromSuperview];
    [self.view addSubview:self.leftVC.view];
    
    [self setVCViewFrame:self.leftVC point:point];
}

- (void)setPanToRight:(CGPoint)point {
    self.rightIndex = self.currentIndex + 1;
    self.rightVC = [self newVCForIndex:self.rightIndex];
    
    self.rightVC.view.frame = CGRectMake(BoundSize.width, self.rightVC.view.frame.origin.y, CGRectGetWidth(self.rightVC.view.frame), CGRectGetHeight(self.rightVC.view.frame));
    
    [self.rightVC.view removeFromSuperview];
    [self.view addSubview:self.rightVC.view];
    
    [self setVCViewFrame:self.rightVC point:point];
}

- (void)allVCAniamtion {
    [UIView animateWithDuration:Duration delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (self.leftVC) {
            self.leftVC.view.frame = CGRectMake(-1 * BoundSize.width, self.leftVC.view.frame.origin.y, BoundSize.width, CGRectGetHeight(self.leftVC.view.frame));
        }
        
        self.currentVC.view.frame = CGRectMake(0, self.currentVC.view.frame.origin.y, CGRectGetWidth(self.currentVC.view.frame), CGRectGetHeight(self.currentVC.view.frame));
        
        if (self.rightVC) {
            self.rightVC.view.frame = CGRectMake(BoundSize.width, self.rightVC.view.frame.origin.y, BoundSize.width, CGRectGetHeight(self.rightVC.view.frame));
        }
    } completion:^(BOOL finished) {
        if (self.leftVC) {
            [self.leftVC.view removeFromSuperview];
            self.leftVC = nil;
            self.leftIndex = 0;
        }
        
        if (self.rightVC) {
            [self.rightVC.view removeFromSuperview];
            self.rightVC = nil;
            self.rightIndex = 0;
        }
    }];
}

@end
