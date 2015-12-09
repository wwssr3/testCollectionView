//
//  CollectionViewCell.m
//  testCollectionView
//
//  Created by Sirui Wang, EC-17 on 12/8/15.
//  Copyright © 2015 Sirui Wang. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib{
    self.layer.masksToBounds = NO;
    self.contentView.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    self.contentView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.contentView.userInteractionEnabled = YES;
}

-(void)prepareForReuse
{
    // reset the animated properties of the card view
    self.contentView.hidden = NO;
    self.contentView.transform = CGAffineTransformIdentity;
}

- (void)beginSwipeAtLocation:(CGPoint)location
{
    self.swipeBeginLocation = location;
    self.backgroundView.alpha = 1.0f;
}

- (void)swipeToLocation:(CGPoint)location
{
    CGFloat dx = location.x - self.swipeBeginLocation.x;
    if (dx <= 0)
    {
        // translate the content view according to the pan distance
        self.contentView.transform = CGAffineTransformMakeTranslation(dx, 0);
    }
}

- (void)endSwipe:(CGPoint)location velocity:(CGPoint)velocity
{
    NSLog(@"end");
    CGFloat dx = self.swipeBeginLocation.x - location.x;
    
    CGFloat distanceToMove = self.frame.size.width - dx;
    NSTimeInterval duration = distanceToMove / -velocity.x;
    CGFloat swipeThreshold = self.frame.size.width * (3.0f / 4.0f + velocity.x / 4000);
    
    if (dx > swipeThreshold)
    {
        // translate the content view out of sight
        [UIView animateWithDuration:(duration < 0.2) ? duration : 0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.contentView.transform = CGAffineTransformMakeTranslation(-self.frame.size.width, 0);
                         }
                         completion:^(BOOL finished) {
                             self.contentView.hidden = YES;
//                             [self.delegate cardDidSwipeOut:self];
                         }];
    }
    else
    {
        // reset the content view transform
        [UIView animateWithDuration:0.2
                              delay:0.0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0.2
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.backgroundView.alpha = 0.0f;
                             self.contentView.transform = CGAffineTransformIdentity; }
                         completion:nil];
    }
}

@end
