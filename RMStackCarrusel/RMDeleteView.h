//
//  RMDeleteView.h
//  RMStackCarrusel
//
//  Created by Ruben on 01/07/14.
//  Copyright (c) 2014 minube. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RMDeleteViewDelegate <NSObject>
@optional
- (void)deleteButtonWasPressed;
@end

@interface RMDeleteView : UICollectionReusableView
@property (nonatomic, weak) id<RMDeleteViewDelegate> delegate;
@end
