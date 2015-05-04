//
//  Album.h
//  Thousand Words
//
//  Created by Edu González on 13/2/15.
//  Copyright (c) 2015 Edu González. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;

@property (nonatomic, retain) NSSet *photos;

@end

//Copiado del proyecto de CodeCoalition, deberia haberlo generado XCDataModeled
@interface Album (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(NSManagedObject *)value;
- (void)removePhotosObject:(NSManagedObject *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end