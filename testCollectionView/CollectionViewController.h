//
//  CollectionViewController.h
//  testCollectionView
//
//  Created by Sirui Wang, EC-17 on 12/7/15.
//  Copyright © 2015 Sirui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"

@interface CollectionViewController : UICollectionViewController<UIGestureRecognizerDelegate, CardViewDelegate>
@property (weak, nonatomic) CollectionViewCell *swipeCard;

@end
