//
//  CollectionViewController.m
//  testCollectionView
//
//  Created by Sirui Wang, EC-17 on 12/7/15.
//  Copyright © 2015 Sirui Wang. All rights reserved.
//

#import "CollectionViewController.h"

static NSString * const reuseIdentifier = @"redCard";

@interface CollectionViewController ()
@end

@implementation CollectionViewController

- (void)viewDidLoad {    
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor grayColor];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer * _Nonnull)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer * _Nonnull)otherGestureRecognizer
{
    // avoid scrolling the card list view while the user is swiping a card
    return self.swipeCard ? NO : YES;
}

- (void)awakeFromNib
{
    // add a pan gesture recognizer to the view to recognize a swiping card gesture
    UIPanGestureRecognizer *swipeRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeRecognizer.delegate = self;
    NSMutableArray *gestureRecognizers = [NSMutableArray arrayWithArray:self.collectionView.gestureRecognizers];
    [gestureRecognizers addObject:swipeRecognizer];
    self.collectionView.gestureRecognizers = gestureRecognizers;
}

- (void)handleSwipeGesture:(UIPanGestureRecognizer *)recognizer {
    if (self.collectionView.dragging) { return; }
    
    CGPoint location = [recognizer locationInView:self.collectionView];
    
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            self.swipeCard = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[self.collectionView indexPathForItemAtPoint:location]];
            [self.swipeCard beginSwipeAtLocation:location];
            break;
            
        case UIGestureRecognizerStateChanged:
            NSLog(@"Changed");
            [self.swipeCard swipeToLocation:location];
            break;
            
        case UIGestureRecognizerStateEnded:
            [self.swipeCard endSwipe:location velocity:[recognizer velocityInView:self.collectionView]];
            self.swipeCard = nil;
            break;
            
        default: break;
    }

}

- (IBAction)handleLongPressGesture:(UILongPressGestureRecognizer *)gesture {
    NSIndexPath *path = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:path];
            break;
        case UIGestureRecognizerStateChanged:
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
            break;
        case UIGestureRecognizerStateEnded:
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

#pragma mark - CollectionViewCellDelegate

//- (void)cardDidSwipeOut:(CollectionViewCell *)card
//{
//    NSIndexPath *indexPath = [self.collectionView indexPathForCell:card];
//    [self.collectionView removeObjectAtIndex:indexPath.row];
//    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
//}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    cell.delegate = self;
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath
          toIndexPath :(NSIndexPath *)destinationIndexPath {
    NSLog(@"%ld,%ld",(long)sourceIndexPath.row,(long)destinationIndexPath.row);
}
@end
