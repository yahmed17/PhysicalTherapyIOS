//
//  AddExerciseRecordViewController.m
//  PhysicalTherapy
//
//  Created by Yousuf on 11/11/13.
//  Copyright (c) 2013 AtriusHealth. All rights reserved.
//

#import "AddExerciseRecordViewController.h"
#import "PTExerciseRecordModel.h"

@interface AddExerciseRecordViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *dateTime;
@property (weak, nonatomic) IBOutlet UISlider *duration;
@property (weak, nonatomic) IBOutlet UISlider *score;
@property (weak, nonatomic) IBOutlet UILabel *durationValue;
@property (weak, nonatomic) IBOutlet UILabel *scoreValue;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewer;
@property (weak,nonatomic) IBOutlet UIBarButtonItem *doneButton;


@end

@implementation AddExerciseRecordViewController
- (IBAction)scoreValueChanged:(UISlider *)sender {
    self.scoreValue.text = [NSString  stringWithFormat:@"%d", (int)sender.value];

}
- (IBAction)durationValueChanged:(UISlider *)sender
{
     self.durationValue.text = [NSString  stringWithFormat:@"%d", (int)sender.value];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.dateTime setMinimumDate:[NSDate dateWithTimeIntervalSinceNow:-864000]];
    [self.dateTime setMaximumDate:[NSDate dateWithTimeIntervalSinceNow:3600]];
    
    
    NSLog(@"Frame Width-%f Frame Height-%f",self.scrollViewer.frame.size.width,self.scrollViewer.frame.size.height);
        NSLog(@"Content Width-%f Content Height-%f",self.scrollViewer.contentSize.width,self.scrollViewer.contentSize.height);


    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%@",[segue identifier]);
    if ([[segue identifier] isEqualToString:@"ReturnInput"] ||  sender == self.doneButton)   {
        PTExerciseRecordModel *exerciseRecord = [[PTExerciseRecordModel alloc] init];
        exerciseRecord.duration = [NSString  stringWithFormat:@"%d", (int)self.duration.value];
        exerciseRecord.intensity = [NSString  stringWithFormat:@"%d", (int) self.score.value];
        exerciseRecord.datetime = self.dateTime.date;
        self.exerciseRecord = exerciseRecord;
    }
}



@end
