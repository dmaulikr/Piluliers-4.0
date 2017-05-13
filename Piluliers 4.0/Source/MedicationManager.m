//
//  MedicationManager.m
//  Piluliers 4.0
//
//  Created by Meumann Ulrich, IT133 on 12.05.17.
//  Copyright © 2017 Post CH AG. All rights reserved.
//

#import "MedicationManager.h"
#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>

@implementation MedicationManager

- (NSMutableDictionary *)medicationForDate:(NSDate *)date {
    
    NSDate *then = [NSDate dateWithTimeIntervalSince1970:0];
    
    return nil;
}

- (void)saveMedication:(NSMutableDictionary *)data toDate:(NSDate *)date {
    
}

- (long)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2 {
    NSUInteger unitFlags = NSCalendarUnitDay;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
    return [components day]+1;
}

- (NSDictionary *)loadMockMedication:(int)index {

    NSError *error ;
    NSString *resourceName = [NSString stringWithFormat:@"Medication%d", index];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:resourceName ofType:@"json"] ;
    NSData *content = [[NSData alloc] initWithContentsOfFile:filePath] ;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:content options:kNilOptions error:&error] ;
    if (error) {
        NSLog(@"Json error: %@", error) ;
    }
    return json;
}
@end
