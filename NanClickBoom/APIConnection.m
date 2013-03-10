//
//  APIConnection.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/07.
//
//

#import "APIConnection.h"
#import "NSString+SBJSON.h"

@implementation APIConnection

@synthesize delegate = _delegate;
@synthesize actionType = actionType;


static NSString* WEBSOCKET_SERVER_ADDRESS = @"211.239.124.234";

static NSString* WEBSOCKET_SERVER_PORT = @"13404";

- (id) init
{
    self = [super init];
    if (self) {
        self.delegate = _delegate;
    }
    return self;
}

+ (APIConnection*) sharedAPIConnection
{
    static APIConnection *sharedAPIConnection = nil;
    if (!sharedAPIConnection) {
        sharedAPIConnection = [[super allocWithZone:nil] init];
    }
    return sharedAPIConnection;
}


- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
//    [socket send:@"{\"id\":\"1\"}"];
    NSLog(@"Opened");
}

- (void) sendMessage:(NSString*) message {
    [socket send:[NSString stringWithFormat:@"%@", message]];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    if (message != nil) {
        NSDictionary *messageDic = (NSDictionary*)[message JSONValue];
        NSLog(@"didReceiveMessage: %@", [message JSONValue]);
        [self receiveMessage:messageDic];
    }

}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    [[self delegate] receivedErrorFromAction:[error description]];
}



- (void) connecToServer {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"ws://%@:%@",WEBSOCKET_SERVER_ADDRESS, WEBSOCKET_SERVER_PORT]];
    socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:url]];
    socket.delegate = self;
    [socket open];
}

- (void) closeToServer {
    [socket close];
}

- (void) receiveMessage:(NSDictionary*) messageDic
{
    if (messageDic != nil) {
        if ([messageDic objectForKey:RESULT_ERROR] != nil) {
            
            [[self delegate] receivedErrorFromAction:[messageDic objectForKey:RESULT_ERROR]];
            return;
        }
        
        if ([actionType isEqualToString:LOGIN_TO_SERVER]) {
            if ([[messageDic valueForKey:@"msg"] isEqualToString:ERROR_ALREADY_LOGIN]) {
                [[self delegate] receivedErrorFromAction:ERROR_ALREADY_LOGIN];
                return;
            } else if([[messageDic valueForKey:@"msg"] isEqualToString:ERROR_USED_ID]) {
                [[self delegate] receivedErrorFromAction:ERROR_USED_ID];
                return;
                
            }
            
            [[self delegate] receivedMessageFromLoginToServer:messageDic];
            
            
        } else if([actionType isEqualToString:CONNECT_TO_SERVER]) {
            [[self delegate] receivedMessageFromConnectToServer:messageDic];
        } else if([actionType isEqualToString:APPLY_GAME]) {
            [[self delegate] receivedMessageFromApplyGame:messageDic];
        } else if([actionType isEqualToString:ADD_UP_SCORE]) {
            [[self delegate] receivedMessageFromAddUpScore:messageDic];
        }
        return;
    }
   
}


@end
