//
//  CodeableConcept+CoreDataProperties.m
//  Piluliers 4.0
//
//  Created by Meumann Ulrich, IT133 on 12.05.17.
//  Copyright © 2017 Post CH AG. All rights reserved.
//

#import "CodeableConcept+CoreDataProperties.h"

@implementation CodeableConcept (CoreDataProperties)

+ (NSFetchRequest<CodeableConcept *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CodeableConcept"];
}

@dynamic text;
@dynamic coding;

@end
