//
//  ConnectivityHandler.m
//  Piluliers 4.0
//
//  Created by Kolly Sandro, IT133 on 12.05.17.
//  Copyright © 2017 Post CH AG. All rights reserved.
//

#import "ConnectivityHandler.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface ConnectivityHandler () <WCSessionDelegate>
@property (nonatomic) WCSession *session;
@end

@implementation ConnectivityHandler

- (instancetype)init {
    self = [super init];
    if (self) {
        self.session = [WCSession defaultSession];
        self.session.delegate = self;
        [self.session activateSession];
    }
    return self;
}

-(void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler {
    NSString *requestKey = message[@"request"];
    NSDictionary *response = @{};
    if ([requestKey isEqualToString:@"dummy"]) {
        response = @{@"todaysPills" : @[@{@"time" : [NSDate dateWithTimeIntervalSince1970:1494680400],
                                          @"pills" : @[@{
                                                           @"name" : @"Quetiapine",
                                                           @"pictureName": @"capsule",
                                                           @"info" : @"5mg",
                                                           @"amount": @"1 capsule"
                                                           },
                                                       @{
                                                           @"name" : @"Dafalgan",
                                                           @"pictureName": @"pill",
                                                           @"info" : @"2mg",
                                                           @"amount": @"1 pill"
                                                           }]
                                          },
                                        @{@"time" : [NSDate dateWithTimeIntervalSince1970:1494702000],
                                          @"pills" : @[@{
                                                           @"name" : @"Aspirine",
                                                           @"pictureName": @"pill",
                                                           @"info" : @"5mg",
                                                           @"amount": @"1 pill"
                                                           },
                                                       @{
                                                           @"name" : @"Roaccutan",
                                                           @"pictureName": @"pill",
                                                           @"info" : @"5mg",
                                                           @"amount": @"1 pill"
                                                           }]
                                          }]};
    }
    if ([requestKey isEqualToString:@"ifeelbad"]) {
        //TODO: "I feel bad" handling...
    }
    replyHandler(response);
}

- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(NSError *)error {
    if (!error) {
        if (activationState == WCSessionActivationStateActivated) {
            NSLog(@"activated watch connectivity");
        } else {
            NSLog(@"some other status than connected: %ld", (long)activationState);
        }
    } else {
        NSLog(@"Error: %@", error.localizedDescription);
    }
}

- (void)sessionDidBecomeInactive:(WCSession *)session {
    
}

- (void)sessionDidDeactivate:(WCSession *)session {
    NSLog(@"session did deactivate, reactivating...");
    [self.session activateSession];
}


@end
