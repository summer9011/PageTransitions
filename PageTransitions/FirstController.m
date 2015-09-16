//
//  FirstController.m
//  PageTransitions
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 zleb. All rights reserved.
//

#import "FirstController.h"

#import "FirstCell.h"
#import "FirstFlowLayout.h"

@interface FirstController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

static NSString *cellIdentifier = @"FirstCell";

@implementation FirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    
    CGSize boundSize = [UIScreen mainScreen].bounds.size;
    FirstFlowLayout *flowLayout = (FirstFlowLayout *)self.collectionView.collectionViewLayout;
    
    flowLayout.itemSize = CGSizeMake(boundSize.width, boundSize.width);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 30);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (FirstCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FirstCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.listImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", indexPath.item + 1]];
    
    return cell;
}

@end
