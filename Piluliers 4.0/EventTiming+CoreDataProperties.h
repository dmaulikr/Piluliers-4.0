//
//  EventTiming+CoreDataProperties.h
//  Piluliers 4.0
//
//  Created by Meumann Ulrich, IT133 on 12.05.17.
//  Copyright © 2017 Post CH AG. All rights reserved.
//

#import "EventTiming+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface EventTiming (CoreDataProperties)

+ (NSFetchRequest<EventTiming *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *value;

@end

NS_ASSUME_NONNULL_END
