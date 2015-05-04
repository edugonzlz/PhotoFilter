//
//  Photo.h
//  Thousand Words
//
//  Created by Edu González on 24/2/15.
//  Copyright (c) 2015 Edu González. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) id image;
@property (nonatomic, retain) Album *albumBook;

@end
