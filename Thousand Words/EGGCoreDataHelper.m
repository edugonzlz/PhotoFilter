//
//  EGGCoreDataHelper.m
//  Thousand Words
//
//  Created by Edu González on 16/2/15.
//  Copyright (c) 2015 Edu González. All rights reserved.
//

#import "EGGCoreDataHelper.h"

@implementation EGGCoreDataHelper

+ (NSManagedObjectContext *)managedObjectContext{
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    
    return context;
}

@end
