//
//  PTViewController.m
//  PhysicalTherapy
//
//  Created by Yousuf on 11/6/13.
//  Copyright (c) 2013 AtriusHealth. All rights reserved.
//

#import "PTViewController.h"
#import "TherapyViewController.h"
#import "TherapyDBAvailability.h"
#import "PTExerciseCDTVC.h"

@interface PTViewController ()
{
    CGPoint viewCenter;
}
@property (weak, nonatomic) IBOutlet UITextField *myChartID;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong,nonatomic) NSString * patientID;
@end

@implementation PTViewController



-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    if (textField == self.myChartID)
        [self.password becomeFirstResponder];
    else if(textField == self.password)
        [self Login:textField];
    return YES;
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{    
    if (textField == self.password)
    {
        if ([self.myChartID.text length] >0)
            return YES;
        else
            return NO;
    }
    else
    {
        return YES;
    }
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
   
    //NSLog([NSString stringWithFormat:@"Landscape  x :%f y:%f",viewCenter.x,viewCenter.y]);
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    switch (orientation) {
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            self.view.center =CGPointMake(viewCenter.x-60, viewCenter.y);
            break;
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
        case UIDeviceOrientationUnknown:
            self.view.center =CGPointMake(viewCenter.x, viewCenter.y-100);
            break;
        default:
            break;
    }
    // self.view.frame
    // textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y - 100.0), textField.frame.size.width,textField.frame.size.height);
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    self.view.center = viewCenter;
}

- (IBAction)Login:(id)sender {
    NSString *myChartID = self.myChartID.text;
    NSString *password = self.password.text;
    [self.password resignFirstResponder];
    if (![myChartID isEqualToString:password])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Login Failed"
                                                       message: @"Invalid MyChart ID and/or Password"
                                                      delegate: self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:Nil, nil];
        [alert show];
    }
    else
    {
        self.patientID = [self getPatientID:myChartID];
        [self performSegueWithIdentifier:@"start" sender:sender];
    }
    
}

-(NSString *) getPatientID:(NSString *) myChartID
{
    //get patient id from mychart
    return myChartID;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        if ([segue.identifier isEqualToString:@"start"]) {
            PTExerciseCDTVC * therapyVC = (PTExerciseCDTVC* ) [[segue destinationViewController] visibleViewController];
            therapyVC.patientID = self.patientID;
            therapyVC.managedObjectContext = self.managedObjectContext;
            
        }
    
}

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:TherapyDBAvailabilityNotification
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *note) {
                                                      self.managedObjectContext = note.userInfo[TherapyDBAvailabilityContext];
                                                  }];
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    viewCenter = self.view.center;
   
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
