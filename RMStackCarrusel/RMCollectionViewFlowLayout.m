//
//  RMCollectionViewFlowLayout.m
//  RMStackCarrusel
//
//  Created by Ruben on 26/06/14.
//  Copyright (c) 2014 minube. All rights reserved.
//

#import "RMCollectionViewFlowLayout.h"

static const CGFloat pagingOffset = 50;

@implementation RMCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allItems = [NSMutableArray array];
    NSArray *indexPathsForVisibleItems = [self indexPathsForVisibleItems];
    NSArray *attributesForVisibleItems = [self layoutAttributesForElementsWithIndexPaths:indexPathsForVisibleItems];
    [attributesForVisibleItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *itemAttributes = (UICollectionViewLayoutAttributes *)obj;
        [self recalculateLayoutAttributes:itemAttributes];
        [allItems addObject:itemAttributes];
    }];
    return allItems;
}

- (NSArray *)indexPathsForVisibleItems
{
    NSMutableArray *indexPathsForVisibleItems = [NSMutableArray array];
    CGFloat xOffset = self.collectionView.contentOffset.x;
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    NSLog(@"Offset: %f", xOffset);
    if (xOffset <= 0) {
        [indexPathsForVisibleItems addObject:[NSIndexPath indexPathForItem:0 inSection:0]];
    } else {
        CGFloat highestVisibleIndex = (xOffset / pagingOffset) + 1;
        NSLog(@"highestVisibleIndex: %f", highestVisibleIndex);
        CGFloat module = fmodf(xOffset, pagingOffset);
        NSLog(@"module: %f", module);
        if (module == 0) {
            highestVisibleIndex--;
        }
        if (highestVisibleIndex >= numberOfItems) {
            highestVisibleIndex = numberOfItems - 1;
        }
        for (NSInteger i = 0; i <= highestVisibleIndex; i++) {
            [indexPathsForVisibleItems addObject:[NSIndexPath indexPathForItem:i inSection:0]];
        }
    }
    
    NSLog(@"VIsible indexPaths: %@", indexPathsForVisibleItems);
    return indexPathsForVisibleItems;
}

- (NSArray *)layoutAttributesForElementsWithIndexPaths:(NSArray *)indexPaths
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    [indexPaths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = (NSIndexPath *)obj;
        [layoutAttributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }];
    NSLog(@"LayoutAttributes: %@", layoutAttributes);
    return layoutAttributes;
}

- (void)recalculateLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    CGFloat xOffset = self.collectionView.contentOffset.x;
    NSInteger index = layoutAttributes.indexPath.item;
    CGFloat maximunOffset = index * pagingOffset;
    CGFloat minimunOffset = maximunOffset - pagingOffset + 1;
    CGFloat numberOfItems = [self.collectionView numberOfItemsInSection:layoutAttributes.indexPath.section];
    layoutAttributes.zIndex = numberOfItems - index;
    CGFloat newXOrigin;
    if (index != 0) {
        if (xOffset >= minimunOffset && xOffset <= maximunOffset) {
            newXOrigin = xOffset;
        } else {
            newXOrigin = maximunOffset;
        }
        
        CGRect itemFrame = layoutAttributes.frame;
        itemFrame.origin.x = newXOrigin;
        layoutAttributes.frame = itemFrame;
    }
}

- (CGSize)collectionViewContentSize
{
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    NSInteger numberOfPaginatedItems = numberOfItems - 1;
    CGFloat contentSizeWidth = self.collectionView.frame.size.width + (pagingOffset * numberOfPaginatedItems);
    return CGSizeMake(contentSizeWidth, self.collectionView.frame.size.height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareForAnimatedBoundsChange:(CGRect)oldBounds
{
    NSLog(@"prepareForAnimatedBoundsChange");
}


@end
