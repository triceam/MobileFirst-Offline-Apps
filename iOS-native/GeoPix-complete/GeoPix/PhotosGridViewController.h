//
//  PhotosGridViewController.h
//  GeoPix
//
//  Created by Andrew Trice on 3/16/15.
//  Copyright (c) 2015 Andrew Trice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface PhotosGridViewController : UIViewController <UICollectionViewDataSource> {
    
    NSArray *photos;
    IBOutlet UICollectionView *gridCollectionView;
}


@end
