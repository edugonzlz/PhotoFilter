//
//  EGGPictureDataTransformer.m
//  Thousand Words
//
//  Created by Edu González on 24/2/15.
//  Copyright (c) 2015 Edu González. All rights reserved.
//

#import "EGGPictureDataTransformer.h"

@implementation EGGPictureDataTransformer

+(Class)transformedValueClass{
    
    return [NSData class];
}

+(BOOL)allowsReverseTransformation{
    
    return YES;
}

-(id)transformedValue:(id)value{
    
    return UIImagePNGRepresentation(value);
    
}

-(id)reverseTransformedValue:(id)value{
    
    UIImage *image = [UIImage imageWithData:value];
    
    return image;
}

@end
