//
//  LYRUILayerContentFactory.m
//  LayerSample
//
//  Created by Kevin Coleman on 9/3/14.
//  Copyright (c) 2014 Layer, Inc. All rights reserved.
//

#import "LYRUILayerContentFactory.h"
#import "LSUser.h"

@interface LYRUILayerContentFactory ()

@property (nonatomic, strong) LYRClient *layerClient;

@end

@implementation LYRUILayerContentFactory

+ (instancetype)layerContentFactoryWithLayerClient:(LYRClient *)layerClient;
{
    return [[self alloc] initWithLayerClient:layerClient];
}

- (id)initWithLayerClient:(LYRClient *)layerClient
{
    self = [super init];
    if (self) {
        _layerClient = layerClient;
    }
    return self;
}

- (void)conversationsWithParticipants:(NSSet *)participants number:(NSUInteger)number
{
    for (int i = 0; i < number; i++) {
        LYRConversation *conversation = [LYRConversation conversationWithParticipants:participants];
        [self sendMessagesToConversation:conversation number:10];
    }
}

- (void)sendMessagesToConversation:(LYRConversation *)conversation number:(NSUInteger)number
{
    for (int i = 0; i < number; i++) {
        LYRMessagePart *part = [LYRMessagePart messagePartWithText:@"Let's go DOUG!"];
        
        NSError *error;
        LYRMessage *message = [LYRMessage messageWithConversation:conversation parts:@[part]];
        [self.layerClient setMetadata:@{LYRMessagePushNotificationAlertMessageKey: @"Test Push"} onObject:message];
        [self.layerClient sendMessage:message error:&error];
    }
}

@end