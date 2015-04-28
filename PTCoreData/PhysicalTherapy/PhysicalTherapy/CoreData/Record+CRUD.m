//
//  Record+CRUD.m
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/6/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import "Record+CRUD.h"

@implementation Record (CRUD)
-(NSString *) detail
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd HHmm"];
    NSString * det= [formatter stringFromDate:self.timestamp];
    det = [det stringByAppendingString:[NSString stringWithFormat:@"  Duration: %@  Intensity: %@",self.duration,self.intensity] ];
    
    return det;
}
@end
