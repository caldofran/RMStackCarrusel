//
//  RMMainViewController.m
//  RMStackCarrusel
//
//  Created by Ruben on 26/06/14.
//  Copyright (c) 2014 minube. All rights reserved.
//

#import "RMMainViewController.h"
#import "RMCarruselCell.h"

@interface RMMainViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
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
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(-90, 0, 90, self.collectionView.frame.size.height)];
    [deleteButton addTarget:self action:@selector(deleteTrip) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setTitle:@"BORRAR" forState:UIControlStateNormal];
    deleteButton.backgroundColor = [UIColor clearColor];
    [self.collectionView addSubview:deleteButton];
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

#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat xOffset = scrollView.contentOffset.x;
    if (xOffset <= -90) {
        [UIView animateWithDuration:0.3
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|
         UIViewAnimationOptionAllowUserInteraction|
         UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.collectionView.contentInset = UIEdgeInsetsMake(0, 90, 0, 0);
                         } completion:NULL];
        
    } else {
        [UIView animateWithDuration:0.3
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|
         UIViewAnimationOptionAllowUserInteraction|
         UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                         } completion:NULL];
    }
    
    if (xOffset > 0 && !decelerate) {
        [UIView animateWithDuration:0.3
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|
         UIViewAnimationOptionAllowUserInteraction|
         UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
                         } completion:NULL];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    CGFloat xOffset = scrollView.contentOffset.x;
    if (xOffset >= 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        [UIView animateWithDuration:0.3
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|
         UIViewAnimationOptionAllowUserInteraction|
         UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
                         } completion:NULL];
    }
}

#pragma mark - Actions
- (void)deleteTrip
{
    [UIView animateWithDuration:0.2
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState|
     UIViewAnimationOptionAllowUserInteraction|
     UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                     } completion:NULL];
}

@end
