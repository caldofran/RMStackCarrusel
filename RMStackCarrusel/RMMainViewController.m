//
//  RMMainViewController.m
//  RMStackCarrusel
//
//  Created by Ruben on 26/06/14.
//  Copyright (c) 2014 minube. All rights reserved.
//

#import "RMMainViewController.h"
#import "RMCarruselCell.h"
#import "RMDeleteView.h"

static const CGFloat deleteButtonOffset = 90;

@interface RMMainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, RMDeleteViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation RMMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RMCarruselCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([RMCarruselCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RMDeleteView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([RMDeleteView class])];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RMCarruselCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RMCarruselCell class]) forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"default%d.jpg", indexPath.item]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        RMDeleteView *deleteView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([RMDeleteView class]) forIndexPath:indexPath];
        deleteView.delegate = self;
        return deleteView;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat xOffset = scrollView.contentOffset.x;
    if (xOffset >= -deleteButtonOffset && xOffset <= 0) {
        self.collectionView.contentInset = UIEdgeInsetsMake(0, -xOffset, 0, 0);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat xOffset = scrollView.contentOffset.x;
    if (xOffset <= -deleteButtonOffset) {
        [self showDeleteButton:YES];
        
    } else {
        [self showDeleteButton:NO];
    }
    
    if (xOffset > 0 && !decelerate) {
        [self scrollToInitialPossitionAnimated];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    CGFloat xOffset = scrollView.contentOffset.x;
    if (xOffset >= 0) {
        [self scrollToInitialPossitionAnimated];
    }
}

#pragma mark - RMDeleteViewDelegate
- (void)deleteButtonWasPressed
{
    [self showDeleteButton:NO];
}

#pragma mark - Animations
- (void)scrollToInitialPossitionAnimated
{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut animations:^{
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    } completion:NULL];
}

- (void)showDeleteButton:(BOOL)show
{
    CGFloat threshold = show ? deleteButtonOffset : 0;
    CGFloat duration = 0.2;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut animations:^{
        self.collectionView.contentInset = UIEdgeInsetsMake(0, threshold, 0, 0);
    } completion:NULL];
}

@end
