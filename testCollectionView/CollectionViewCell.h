//
//  CollectionViewCell.h
//  testCollectionView
//
//  Created by Sirui Wang, EC-17 on 12/8/15.
//  Copyright © 2015 Sirui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionViewCell;

@protocol CardViewDelegate
- (void)cardDidSwipeOut:(CollectionViewCell *)card;
@end

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) CGPoint swipeBeginLocation;

- (void)beginSwipeAtLocation:(CGPoint)location;
- (void)swipeToLocation:(CGPoint)location;
- (void)endSwipe:(CGPoint)location velocity:(CGPoint)velocity;

@property (weak, nonatomic) id<CardViewDelegate> delegate;
@end
