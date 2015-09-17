//
//  Temp1Controller.m
//  PageTransitions
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 zleb. All rights reserved.
//

#import "Temp1Controller.h"

@interface Temp1Controller ()

@end

@implementation Temp1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSLog(@"Temp1 viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    NSLog(@"Temp1 viewWillAppear:");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    NSLog(@"Temp1 viewDidDisappear:");
}

- (void)dealloc {
//    NSLog(@"Temp1 dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
