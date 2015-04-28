//
//  PTAppDelegate+MOC.h
//  PhysicalTherapy
//
//  Created by Yousuf Ahmed on 1/6/14.
//  Copyright (c) 2014 Atrius Health. All rights reserved.
//

#import "PTAppDelegate.h"

@interface PTAppDelegate (MOC)

- (NSManagedObjectContext *)createMainQueueManagedObjectContext;


@end
