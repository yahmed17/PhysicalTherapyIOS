//
//  PTExerciseDetailCDTVC.m
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/8/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import "PTExerciseDetailCDTVC.h"
#import "PTRecordHeaderCell.h"
#import "Exercise+CRUD.h"
#import "Record+CRUD.h"
#import "VideoViewController.h"
#import "AddExerciseRecordViewController.h"

@interface PTExerciseDetailCDTVC()
{
    Record * currentExerciseRecord;
    UIBarButtonItem *editButton;
    UIBarButtonItem *addButton;
}

@end

@implementation PTExerciseDetailCDTVC


#define INFO_SECTION 0
#define RECORD_SECTION 1



-(void)viewDidLoad
{
    NSLog(@"%@",self.exercise.name);
    NSLog(@"%@",self.exercise.frequency);
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = self.exercise.name;
    [self.exercise addObserver:self forKeyPath:@"lastUpdate" options:0 context:nil];
    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exercise"];
//    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", self.exercise.name];
//    NSError *error;
//    NSArray *matches = [self.exercise.managedObjectContext executeFetchRequest:request error:&error];
//    
//    if (!matches || error || ([matches count] > 1)) {
//        // handle error
//    } else if ([matches count]) {
//        self.exercise = [matches firstObject];
//    }
//    
//    NSLog(@"%@",self.exercise.name);
//    NSLog(@"%@",self.exercise.frequency);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    // Return a title or nil as appropriate for the section.
    switch (section) {
        case RECORD_SECTION:
            title = @"Records";
            break;
        default:
            break;
    }
    return title;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger rows = 0;
    /*
     The number of rows depends on the section.
     In the case of ingredients, if editing, add a row in editing mode to present an "Add Ingredient" cell.
	 */
    switch (section) {
        case INFO_SECTION:
            rows = 9;
            break;
        case RECORD_SECTION:
            rows = self.exercise.exerciseRecordCount;

           if (self.editing) {
               rows++;
           }
            break;
		default:
            break;
    }
    return rows;
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
    else if(indexPath.section == RECORD_SECTION)
    {
        
        if (self.editing)
        {
            if ( indexPath.row==0)
            {
                NSString *CellIdentifier = @"addRecordCell";
                cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                
            }
            else
            {
                NSString *CellIdentifier = @"recordCell";
                cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                currentExerciseRecord=[self.exercise exerciseRecordAtIndex:indexPath.row-1];
                cell.textLabel.text = @"";
                cell.detailTextLabel.text =currentExerciseRecord.detail;
            }
        }
        else
        {
            
            NSString *CellIdentifier = @"recordCell";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            currentExerciseRecord=[self.exercise exerciseRecordAtIndex:indexPath.row];
            cell.textLabel.text = @"";
            cell.detailTextLabel.text =currentExerciseRecord.detail;
            
        }
        
        
    }
    return cell;
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSIndexPath *rowToSelect = indexPath;
    NSInteger section = indexPath.section;
    BOOL isEditing = self.editing;
    
    if (isEditing && section == INFO_SECTION)  {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        rowToSelect = nil;
    }
	return rowToSelect;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCellEditingStyle style = UITableViewCellEditingStyleNone;
    // Only allow editing in the ingredients section.
    // In the ingredients section, the last row (row number equal to the count of ingredients) is added automatically (see tableView:cellForRowAtIndexPath:) to provide an insertion cell, so configure that cell for insertion; the other cells are configured for deletion.
    if (indexPath.section == RECORD_SECTION) {
        // If this is the last item, it's the insertion row.
      //  NSInteger row = indexPath.row;
       // row = [self.exercise exerciseRecordCount];
        bool newRow =  [self.tableView numberOfRowsInSection:RECORD_SECTION] >self.exercise.exerciseRecordCount;

        if (indexPath.row == 0  && newRow) {
            style = UITableViewCellEditingStyleInsert;
            NSLog(@"editingStyle for row: %d  editingMode :%hhd rows: %d insert:%@",indexPath.row,self.isEditing,newRow,[self.tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text);
        }
        else {
            style = UITableViewCellEditingStyleDelete;
            NSLog(@"editingStyle for row: %d  editingMode :%hhd rows:",indexPath.row,self.isEditing);
        }
    }
    
    return style;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==INFO_SECTION)
    {
        if (indexPath.row == 8)
        {
            [self performSegueWithIdentifier:@"segueToVideo" sender:nil];
        }
    }
    if (indexPath.section == RECORD_SECTION)
    {
        if (self.editing && indexPath.row == 0)
        {
            [self performSegueWithIdentifier:@"segueToAddRecord" sender:nil];
        }
    }
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.exercise deleteExerciseRecordAtIndex:indexPath.row-1];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        [self performSegueWithIdentifier:@"segueToAddRecord" sender:nil];
    }
}



- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    

	[self.navigationItem setHidesBackButton:editing animated:YES];
	NSArray *zeroIndexPath=[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:RECORD_SECTION]];
    if (editing)
    {
        [self.tableView insertRowsAtIndexPaths:zeroIndexPath withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        [self.tableView deleteRowsAtIndexPaths:zeroIndexPath withRowAnimation:UITableViewRowAnimationTop];
    }
	[self.tableView beginUpdates];
//	
//    NSUInteger recordCount = [self.exercise exerciseRecordCount];
//    
//    NSArray *recordsInsertIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:recordCount inSection:RECORD_SECTION]];
//    NSIndexPath *lastIndexPath =[NSIndexPath indexPathForRow:recordCount inSection:RECORD_SECTION];
//    
//    NSIndexPath *zeroInsertIndexPath = [NSIndexPath indexPathForRow:0 inSection:RECORD_SECTION];
//    
//    if (editing) {
//        [self.tableView insertRowsAtIndexPaths:recordsInsertIndexPath withRowAnimation:UITableViewRowAnimationTop];
//        [self.tableView moveRowAtIndexPath:lastIndexPath toIndexPath:zeroInsertIndexPath];
//		//overviewTextField.placeholder = @"Overview";
//	} else {
//        [self.tableView deleteRowsAtIndexPaths:recordsInsertIndexPath withRowAnimation:UITableViewRowAnimationTop];
//	//	overviewTextField.placeholder = @"";
//    }
//    
    [self.tableView endUpdates];
	
	/*
	 If editing is finished, save the managed object context.
	 */
	if (!editing) {
		NSManagedObjectContext *context = self.exercise.managedObjectContext;
		NSError *error = nil;
		if (![context save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if ([keyPath isEqual:@"lastUpdate"]) {
        NSRange range = NSMakeRange(1, 1);
        NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
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

- (IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        
        AddExerciseRecordViewController    *addController = [segue sourceViewController];
        if (addController.exerciseRecord) {
            [self.exercise addExerciseRecord:addController.exerciseRecord];
            NSRange range = NSMakeRange(1, 1);
            NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
            [self.tableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
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

@end
