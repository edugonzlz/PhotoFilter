//
//  EGGAlbumTableViewController.m
//  Thousand Words
//
//  Created by Edu González on 12/2/15.
//  Copyright (c) 2015 Edu González. All rights reserved.
//

#import "EGGAlbumTableViewController.h"
#import "Album.h"
#import "EGGCoreDataHelper.h"
#import "EGGPhotosCollectionViewController.h"

@interface EGGAlbumTableViewController () <UIAlertViewDelegate>

@end

@implementation EGGAlbumTableViewController

- (NSMutableArray *)albums{
    
    if(!_albums) _albums = [[NSMutableArray alloc]init];
    return _albums;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //creamos una peticion
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    //Organizamos por la fecha
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    
    //REFACTORIZADO EN EGGCOREDATAHELPER
    //    //llamamos al delegate
    //    id delegate = [[UIApplication sharedApplication] delegate];
    //    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSError *error = nil;
    //Ejecutamos la peticion
    NSArray *fetchedAlbums = [[EGGCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    self.albums = [fetchedAlbums mutableCopy];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBActions

- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    UIAlertView *newAlbumAlertView = [[UIAlertView alloc] initWithTitle:@"Enter New Album Name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    
    [newAlbumAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    [newAlbumAlertView show];
    
    
    
    //    UIAlertController *newAlbumAlertView = [UIAlertController alertControllerWithTitle:@"Enter new album name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    //    UIAlertAction *addAlbum = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    //        NSString *alertText = newAlbumAlertView.textFields[0];
    //        NSLog(@"el nombre es %@", alertText);
    //    }];
    
    //    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    //
    //    [newAlbumAlertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    //      textField.placeholder = @"Album name"
    //    }];
    //
    //    [newAlbumAlertView addAction:cancel];
    //    [newAlbumAlertView addAction:addAlbum];
    //
    //    [self presentViewController:newAlbumAlertView animated:YES completion:nil];
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        //Recuperamos el texto del alertview
        NSString *alertText = [alertView textFieldAtIndex:0].text;
        //Guardamos en el array de albums lo que nos devuelve el metodo que guarda en CoreData
        [self.albums addObject:[self albumWithName:alertText]];
        //Insertamos en la tabla
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.albums count]-1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //Lo mismo con otro codigo
        //        Album *newAlbum = [self albumWithName:alertText];
        //        [self.albums addObject:newAlbum];
        //        [self.tableView reloadData];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Album *selectedAlbum = self.albums[indexPath.row];
    cell.textLabel.text = selectedAlbum.name;
    
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"Album choosen"]){
        if ([segue.destinationViewController isKindOfClass:[EGGPhotosCollectionViewController class]]){
            
            NSIndexPath *path = [self.tableView indexPathForSelectedRow];
            
            EGGPhotosCollectionViewController *nextVC = segue.destinationViewController;
            nextVC.album = self.albums[path.row];
        }
    }
}


#pragma mark Helper Methods

-(Album *)albumWithName:(NSString *)name{
    
    NSManagedObjectContext *context = [EGGCoreDataHelper managedObjectContext];
    
    Album *album = [NSEntityDescription  insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    album.name = name;
    album.date = [NSDate date];
    
    NSError *error = nil;
    if (![context save:&error]) {
        //we have an error
        NSLog(@"Error: %@", error);
    }
    return album;
}

@end
