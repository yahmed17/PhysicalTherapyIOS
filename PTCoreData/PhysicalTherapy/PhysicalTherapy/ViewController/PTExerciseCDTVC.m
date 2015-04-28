//
//  PTExerciseCDTVC.m
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/6/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import "PTExerciseCDTVC.h"
#import "TherapyDBAvailability.h"
#import "Exercise.h"
#import "Patient.h"
#import "PTPatientStore.h"
#import "PTExerciseDetailCDTVC.h"
#import "Exercise+CRUD.h"

@interface PTExerciseCDTVC ()
{
    Patient * modelPatient;
    Exercise * currentExercise;
}

@end

@implementation PTExerciseCDTVC

//- (void)awakeFromNib
//{
//    [[NSNotificationCenter defaultCenter] addObserverForName:TherapyDBAvailabilityNotification
//                                                      object:nil
//                                                       queue:nil
//                                                  usingBlock:^(NSNotification *note) {
//                                                      self.managedObjectContext = note.userInfo[TherapyDBAvailabilityContext];
//                                                  }];
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.debug=true;
    [self loadTherapy];
    //self.patientID = @"2083";
   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)loadTherapy
{
    
    PTPatientStore* ptStore = [[PTPatientStore alloc] initWithPatientID:self.patientID forManagedContext:self.managedObjectContext];
    modelPatient = ptStore.modelPatient;
    
    NSLog(@"loadTherapy %@",[NSDate date]);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exercise"];
    request.predicate = [NSPredicate predicateWithFormat:@"patient.patientID == %@", self.patientID];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                              ascending:YES
                                                               selector:@selector(localizedStandardCompare:)]];
    
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:@"root"];
    //NSError *error;
   // [self.fetchedResultsController performFetch:&error];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"exerciseCell";
    UITableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    currentExercise =[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    cell.textLabel.text = currentExercise.name;
    cell.detailTextLabel.text    = @"";  //currentExercise.equipment;
    NSLog(@"tableView: %@",currentExercise.name);
    
    return cell;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"exerciseDetail"])
    {
        PTExerciseDetailCDTVC * destination = segue.destinationViewController;
        
        currentExercise = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        [currentExercise loadRecords];
        destination.exercise =currentExercise;
        
    }
}

@end
