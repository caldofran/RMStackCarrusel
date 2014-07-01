//
//  RMDeleteView.m
//  RMStackCarrusel
//
//  Created by Ruben on 01/07/14.
//  Copyright (c) 2014 minube. All rights reserved.
//

#import "RMDeleteView.h"
#import "RMCollectionViewLayoutAttributes.h"

@interface RMDeleteView ()
@property (weak, nonatomic) IBOutlet UIButton *delteButton;
- (IBAction)deleteButtonWasPressed:(UIButton *)sender;
@end

@implementation RMDeleteView

- (void)applyLayoutAttributes:(RMCollectionViewLayoutAttributes *)layoutAttributes
{
    CGFloat progressivenes = layoutAttributes.progressiveness;
    self.delteButton.imageView.alpha = progressivenes;
    if (progressivenes == 0) {
        NSLog(@"");
    }
}

- (void)setAlpha:(CGFloat)alpha
{
    [super setAlpha:1];
}

- (IBAction)deleteButtonWasPressed:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(deleteButtonWasPressed)]) {
        [self.delegate deleteButtonWasPressed];
    }
}

@end
