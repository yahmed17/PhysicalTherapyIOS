//
//  Record.h
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/15/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;

@interface Record : NSManagedObject

@property (nonatomic, retain) NSString * duration;
@property (nonatomic, retain) NSString * intensity;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * deleteFromEpic;
@property (nonatomic, retain) NSNumber * saveToEpic;
@property (nonatomic, retain) Exercise *exercise;

@end
