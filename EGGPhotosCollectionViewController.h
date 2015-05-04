//
//  EGGPhotosCollectionViewController.h
//  Thousand Words
//
//  Created by Edu González on 23/2/15.
//  Copyright (c) 2015 Edu González. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface EGGPhotosCollectionViewController : UICollectionViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong,nonatomic) Album *album;

- (IBAction)cameraBarButtonPressed:(UIBarButtonItem *)sender;


@end
