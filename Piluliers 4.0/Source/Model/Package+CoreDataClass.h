//
//  Package+CoreDataClass.h
//  Piluliers 4.0
//
//  Created by Meumann Ulrich, IT133 on 12.05.17.
//  Copyright © 2017 Post CH AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Batch, CodeableConcept, Content;

NS_ASSUME_NONNULL_BEGIN

@interface Package : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Package+CoreDataProperties.h"
