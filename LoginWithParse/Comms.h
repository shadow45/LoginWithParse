//
//  Comms.h
//  LoginWithParse
//
//  Created by yasser jennani on 03/04/14.
//  Copyright (c) 2014 ensa. All rights reserved.
//

@protocol CommsDelegate <NSObject>
@optional
- (void) commsDidLogin:(BOOL)loggedIn;
@end

@interface Comms : NSObject
+ (void) login:(id<CommsDelegate>)delegate;
@end
