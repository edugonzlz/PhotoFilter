//
//  EGGPhotoDetailViewController.h
//  Thousand Words
//
//  Created by Edu González on 3/3/15.
//  Copyright (c) 2015 Edu González. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface EGGPhotoDetailViewController : UIViewController

@property (strong, nonatomic)Photo *photo;
@property (strong, nonatomic) IBOutlet UIImageView *ImageView;

- (IBAction)deleteButtonPressed:(UIButton *)sender;
- (IBAction)addFilterButtonPressed:(UIButton *)sender;

@end
