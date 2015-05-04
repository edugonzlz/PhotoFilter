//
//  EGGAlbumTableViewController.h
//  Thousand Words
//
//  Created by Edu González on 12/2/15.
//  Copyright (c) 2015 Edu González. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EGGAlbumTableViewController : UITableViewController 

@property (strong,nonatomic) NSMutableArray *albums;

- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
