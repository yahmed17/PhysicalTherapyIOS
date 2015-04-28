//
//  TherapyViewController.m
//  PhysicalTherapy
//
//  Created by Yousuf on 11/6/13.
//  Copyright (c) 2013 AtriusHealth. All rights reserved.
//

#import "TherapyViewController.h"
#import "EpicCommand.h"
#import "HTTRequest.h"
#import "TherapyResponse.h"
#import "PTTherapyModel.h"
#import "PTExerciseModel.h"
#import "ExerciseViewController.h"

@interface TherapyViewController ()
{
    PTTherapyModel * therapyModel;
    HTTRequest * httpRequest;
    PTExerciseModel * currentExercise;
}

@end



@implementation TherapyViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    httpRequest = [[HTTRequest alloc] initWithEnvelope:@""];
    [self initializeTherapy];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) initializeTherapy
{
    NSString *envelopeText  =[[[EpicCommand alloc] initPhysicalTherapyWithPatientID:self.patientID byUser:@"27821"] xml];
    httpRequest.envelope = envelopeText;
    [httpRequest sendRequestOnCompletion:^(NSString *result, NSError *error) {
        if(error)
        {
            //Handle Error
        }
        else
        {
            TherapyResponse *response = [[TherapyResponse alloc] initWithXML:result forPatient:self.patientID];
            therapyModel = response.therapyModel;
            therapyModel.patientID = self.patientID;
            [self.tableView reloadData];
        }
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"tableView: %d",therapyModel.count);

    return therapyModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"exerciseCell";
    UITableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Configure the cell...
    currentExercise =[therapyModel exerciseAtIndex:indexPath.row];
    
    
    cell.textLabel.text = currentExercise.name;
    cell.detailTextLabel.text    = currentExercise.equipment;
    NSLog(@"tableView: %@",currentExercise.name);

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"exerciseDetail"])
    {
        ExerciseViewController * destination = segue.destinationViewController;
        int exerciseIndex = [self.tableView indexPathForSelectedRow].row;
        currentExercise =[therapyModel exerciseAtIndex:exerciseIndex];
        [currentExercise loadExerciseRecord];
        destination.exercise =currentExercise;
    }
}



@end
