//
//  EGGPhotoCollectionViewCell.m
//  Thousand Words
//
//  Created by Edu González on 23/2/15.
//  Copyright (c) 2015 Edu González. All rights reserved.
//

#import "EGGPhotoCollectionViewCell.h"
#import "EGGPhotosCollectionViewController.h"

#define IMAGEVIEW_BORDER_LENGTH 5

@implementation EGGPhotoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
    
}

- (void)setup{
    
    //Esta es la primera opcion, pero por algun bug, deja la imagen en 50x50
    //self.imageView = [[UIImageView alloc]initWithFrame:CGRectInset(self.bounds, IMAGEVIEW_BORDER_LENGTH, IMAGEVIEW_BORDER_LENGTH)];
    
       //Para solucionar lo anterior ajustamos el tamaño de la celda manualmente
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0+IMAGEVIEW_BORDER_LENGTH,
                                                                   
                                                                   0+IMAGEVIEW_BORDER_LENGTH,
                                                                   
                                                                   155-(2*IMAGEVIEW_BORDER_LENGTH),
                                                                   
                                                                   155-(2*IMAGEVIEW_BORDER_LENGTH))];
    [self.contentView addSubview:self.imageView];
    
}

@end
