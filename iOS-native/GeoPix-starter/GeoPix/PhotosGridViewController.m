//
//  PhotosGridViewController.m
//  GeoPix
//
//  Created by Andrew Trice on 3/16/15.
//  Copyright (c) 2015 Andrew Trice. All rights reserved.
//

#import "PhotosGridViewController.h"

@implementation PhotosGridViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    photos = @[];
    
    // Initialize recipe image array
    [[DataManager sharedInstance] getLocalData:^(NSArray *results, NSError *error) {
        photos = results;
        
        gridCollectionView.dataSource = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [gridCollectionView reloadData];
        });
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    

    return photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    imageView.image = nil;
    
    CDTDocumentRevision *doc = [photos objectAtIndex:indexPath.row];

    id val = nil;
    NSArray *values = [doc.attachments allValues];
    
    if ([values count] != 0)
        val = [values objectAtIndex:0];
    
    if ( val != nil ) {
        CDTSavedAttachment *attachment = (CDTSavedAttachment*)val;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
            NSData *imageData = [attachment dataFromAttachmentContent];
            
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
                imageView.image = [UIImage imageWithData:imageData];
            });

        });
        
        
    }
    
    return cell;
}


@end
