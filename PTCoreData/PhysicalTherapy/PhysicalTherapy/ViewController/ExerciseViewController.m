//
//  ExerciseViewController.m
//  PhysicalTherapy
//
//  Created by Yousuf on 11/7/13.
//  Copyright (c) 2013 AtriusHealth. All rights reserved.
//

#import "ExerciseViewController.h"
#import "AddExerciseRecordViewController.h"
#import "VideoViewController.h"
#import "PTRecordHeaderCell.h"

@interface ExerciseViewController ()
{
    PTExerciseRecordModel * currentExerciseRecord;
    UIBarButtonItem *editButton;
    UIBarButtonItem *addButton;
}

@end

@implementation ExerciseViewController


- (IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        
        AddExerciseRecordViewController    *addController = [segue sourceViewController];
        if (addController.exerciseRecord) {
            [self.exercise addExerciseRecord:addController.exerciseRecord];
            [[self tableView] reloadData];
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"CancelInput"]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}


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
  //  [self.exercise addObserver:self forKeyPath:@"updateView" options:(NSKeyValueObservingOptionNew |
   //                                                                            NSKeyValueObservingOptionOld) context:NULL];
    [_exercise addObserver:self forKeyPath:@"updateView" options:0 context:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section == 0)
        return 9;
    else if(section == 1)
        return self.exercise.exerciseRecordCount+1;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Configure the cell...
    UITableViewCell *cell;
    
    if(indexPath.section == 0)
    {
        NSString *CellIdentifier = @"exerciseInfoCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textLabel.text =  [NSString stringWithFormat:@"%d", indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
        switch (indexPath.row) {
            
            case 0:
                cell.textLabel.text = @"Equipment";
                cell.detailTextLabel.text=self.exercise.equipment;
                cell.accessoryType = UITableViewCellAccessoryNone;
                break;
            case 1:
                cell.textLabel.text = @"Level";
                cell.detailTextLabel.text=self.exercise.level;
                break;
            case 2:
                cell.textLabel.text = @"Resistance";
                cell.detailTextLabel.text=self.exercise.resistance;
                break;
            case 3:
                cell.textLabel.text = @"Time";
                cell.detailTextLabel.text=self.exercise.time;
                break;
            case 4:
                cell.textLabel.text = @"Repitition";
                cell.detailTextLabel.text=self.exercise.reps;
                break;
            case 5:
                cell.textLabel.text = @"Sets";
                cell.detailTextLabel.text=self.exercise.sets;
                break;
            case 6:
                cell.textLabel.text = @"Weight";
                cell.detailTextLabel.text=self.exercise.weight;
                break;
            case 7:
                cell.textLabel.text = @"Home";
                cell.detailTextLabel.text=self.exercise.frequency;
                break;
            case 8:
                cell.textLabel.text = @"Video";
                cell.detailTextLabel.text=self.exercise.link;
                cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
                break;
            default:
                break;
        }
    }
    else if(indexPath.section == 1)
    {
        if (indexPath.row==0)
        {
            PTRecordHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordSectionHeader"];
            editButton = cell.editButton;
            editButton.target = self;
            editButton.action =@selector(editRecords);
            editButton.enabled =  (self.exercise.exerciseRecordCount >0);
            addButton = cell.addButton;
            addButton.target = self;
            addButton.action =@selector(addNewExerciseRecord);
            return cell;
        }
        else
        {
            NSString *CellIdentifier = @"recordCell";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            currentExerciseRecord=[self.exercise exerciseRecordAtIndex:indexPath.row-1];
            cell.textLabel.text = currentExerciseRecord.name;
            cell.detailTextLabel.text =currentExerciseRecord.detail;
        }
    }
    return  cell;
    
}



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
        if (indexPath.row == 8)
        {
            [self performSegueWithIdentifier:@"segueToVideo" sender:nil];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if(section == 0)
        return self.exercise.name;
    else if(section == 1)
        return @"Record";
    return @"";
}

-(float) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1 && indexPath.row>0)
    {
        return true;
    }
    else
    {
        return false;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==1 && indexPath.row > 0)
    {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.exercise deleteExerciseRecordAtIndex:[self exerciseRecordIndex:indexPath]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueToVideo"])
    {
        VideoViewController * destination = segue.destinationViewController;
        //NSString * x = self.exercise.link;
        destination.videoLink =self.exercise.name;
    }
    if ([segue.identifier isEqualToString:@"segueToAddRecord"])
    {
       //
    }

}


-(void) addNewExerciseRecord
{
    [self performSegueWithIdentifier:@"segueToAddRecord" sender:nil];

}

-(void) editRecords
{
    if (self.tableView.editing)
    {
        [self.tableView setEditing:NO animated:YES];
        [editButton setTitle:@"Edit"];
        [editButton setEnabled:(self.exercise.exerciseRecordCount >0)];
        [editButton setStyle:UIBarButtonItemStylePlain];
        [addButton setEnabled:true];
        
    }
    else
    {
        [self.tableView setEditing:YES animated:YES];
        [editButton setTitle:@"Done"];
        [editButton setStyle:UIBarButtonItemStyleDone];
        [addButton setEnabled:false];
    }
}

-(int) exerciseRecordIndex:(NSIndexPath *)indexPath
{
    return indexPath.row-1;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if ([keyPath isEqual:@"updateView"]) {
        NSRange range = NSMakeRange(1, 1);
        NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    }
   
}










@end
