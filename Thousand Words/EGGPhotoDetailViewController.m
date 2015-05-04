//
//  EGGPhotoDetailViewController.m
//  Thousand Words
//
//  Created by Edu González on 3/3/15.
//  Copyright (c) 2015 Edu González. All rights reserved.
//

#import "EGGPhotoDetailViewController.h"
#import "Photo.h"
#import "EGGFiltersCollectionViewController.h"

@interface EGGPhotoDetailViewController ()

@end

@implementation EGGPhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    self.ImageView.image = self.photo.image;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"filterSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[EGGFiltersCollectionViewController class]]) {
            EGGFiltersCollectionViewController *nextVC = segue.destinationViewController;
            nextVC.photo = self.photo;
        }
    }
}


- (IBAction)deleteButtonPressed:(UIButton *)sender {
    
    [[self.photo managedObjectContext] deleteObject:self.photo];
    
    //Estas dos lineas solo necesarias para ejecutar en el simulador
    NSError *error = nil;
    [[self.photo managedObjectContext] save:&error];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addFilterButtonPressed:(UIButton *)sender {
}
@end
