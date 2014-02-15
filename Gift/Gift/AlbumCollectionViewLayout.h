//
//  AlbumCollectionViewLayout.h
//  Gift
//
//  Created by Ruchi Varshney on 2/14/14.
//
//

#import <UIKit/UIKit.h>

@interface AlbumCollectionViewLayout : UICollectionViewLayout

@property (nonatomic) UIEdgeInsets cellInsets;
@property (nonatomic) CGSize cellSize;
@property (nonatomic) CGFloat interCellSpacing;
@property (nonatomic) NSInteger numColumns;

@end
