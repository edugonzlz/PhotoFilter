//
//  EGGPhotosCollectionViewController.m
//  Thousand Words
//
//  Created by Edu González on 23/2/15.
//  Copyright (c) 2015 Edu González. All rights reserved.
//

#import "EGGPhotosCollectionViewController.h"
#import "EGGPhotoCollectionViewCell.h"
#import "Photo.h"
#import "EGGPictureDataTransformer.h"
#import "EGGCoreDataHelper.h"
#import "EGGPhotoDetailViewController.h"

@interface EGGPhotosCollectionViewController ()

@property (strong, nonatomic)NSMutableArray *photos;

@end

@implementation EGGPhotosCollectionViewController

-(NSMutableArray *)photos{
    
    if (!_photos) {
        _photos = [[NSMutableArray alloc]init];
    }
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//Comentada esta linea por que da ERROR
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];

    //NSSet es una lista desordenada. Recuperamos las fotos del album de CoreData
    NSSet *unorderedPhotos = self.album.photos;
    //Creamos un criterio de orden
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    //Aplicamos el criterio al nuevo array ordenado
    NSArray *sortedPhotos = [unorderedPhotos sortedArrayUsingDescriptors:@[dateDescriptor]];
    //Guardamos las fotos ordenadas en nuestro array
    self.photos = [sortedPhotos mutableCopy];
    
    [self.collectionView reloadData];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"PhotoDetailSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[EGGPhotoDetailViewController class]]) {
            EGGPhotoDetailViewController *nextVC = segue.destinationViewController;

            NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems]lastObject];
            Photo *selectedPhoto = self.photos[indexPath.row];
            nextVC.photo = selectedPhoto;
        }
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const CellIdentifier = @"Photo Cell";
    EGGPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    Photo *photo = self.photos[indexPath.row];
    cell.imageView.image = photo.image;
    
    return cell;
}
- (IBAction)cameraBarButtonPressed:(UIBarButtonItem *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - Helper Methods

- (Photo *)photoFromImage:(UIImage *)image{
    
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[self.album managedObjectContext]];
    
    photo.image = image;
    
    photo.date = [NSDate date];
    
    photo.albumBook = self.album;
    
    NSError *error = nil;
    
    if (![[photo managedObjectContext] save:&error]) {
        
        NSLog(@"Error %@", error);
        
    }
    
    return photo;
    
}

#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) image = info[UIImagePickerControllerOriginalImage];
    
    
    [self.photos addObject:[self photoFromImage:image]];
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


@end
