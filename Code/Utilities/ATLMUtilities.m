//
//  ATLMUtilities.m
//  Atlas Messenger
//
//  Created by Kevin Coleman on 7/1/14.
//  Copyright (c) 2014 Layer, Inc. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "ATLMPersistenceManager.h"
#import "ATLMUtilities.h"

static NSString *ATLAppGroupKey = @"LYRClientGroupIdentifierKey";

BOOL ATLMIsRunningTests(void)
{
    return NSClassFromString(@"XCTestCase") != Nil;
}

NSURL *ATLMRailsBaseURL(void)
{
    if (ATLMIsRunningTests()){
        return [NSURL URLWithString:@"http://layer-test-identity-provider.herokuapp.com"];
    } else {
        return [NSURL URLWithString:@"https://layer-identity-provider.herokuapp.com"];
    }
}

NSString *ATLMApplicationDataDirectory(void)
{
    NSString *path;
    NSString *identifier = [[NSUserDefaults standardUserDefaults] objectForKey:ATLAppGroupKey];
    if (identifier) {
        path = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:identifier].path;
    } else {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    }
    return path;
}

UIAlertView *ATLMAlertWithError(NSError *error)
{
#ifndef WATCH_KIT_TARGET
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unexpected Error"
                                                        message:error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    return alertView;
#endif
    return nil;
}
