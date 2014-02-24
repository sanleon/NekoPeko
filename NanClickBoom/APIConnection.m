//
//  APIConnection.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/07.
//
//

#import "APIConnection.h"
#import "NSString+SBJSON.h"
#import "AccountManager.h"

@implementation APIConnection

@synthesize delegate = _delegate;
@synthesize actionType = actionType;
@synthesize isLogined;
@synthesize isConnected;


static NSString* WEBSOCKET_SERVER_ADDRESS = @"neko.tutatuta.tk";

static NSString* WEBSOCKET_SERVER_PORT = @"15904";

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
    [self setIsConnected:YES];
//    [socket send:@"{\"id\":\"1\"}"];
//    NSLog(@"Opened");
}

- (void) sendMessage:(NSString*) message {
    if ([socket readyState] == 1 ) {
        [socket send:[NSString stringWithFormat:@"%@", message]];
        
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    if (message != nil) {
        NSDictionary *messageDic = (NSDictionary*)[message JSONValue];
        // TODO
//        NSLog(@"didReceiveMessage: %@", [message JSONValue]);
        if (self) {
            [self receiveMessage:messageDic];
        }
    }

}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    if (error) {
        if (webSocket != nil && [self isConnected]) {
            [[self delegate] receivedErrorFromAction:[error description]];
        }
    }

}



- (void) connecToServer {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"ws://%@:%@",WEBSOCKET_SERVER_ADDRESS, WEBSOCKET_SERVER_PORT]];
    socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:url]];
    if (socket) {
        socket.delegate = self;
        [socket open];
    }
}

- (void) closeToServer {
    //[socket closeWithCode:1000 reason:@"Close From Application"];
    [self setIsConnected:NO];
    [self sendMessage:@"{\"close\":\"\"}"];
    [socket release];
    socket = nil;
}

- (void) receiveMessage:(NSDictionary*) messageDic
{
    // TODO 修正
    if (messageDic != nil && [self isConnected]) {
        

//        if ([messageDic objectForKey:RESULT_ERROR] != nil) {
//            NSString *message = [messageDic objectForKey:RESULT_ERROR];
//            if ([message isEqualToString:UNEXPECTED_ERROR]) {
//                [self closeToServer];
//                [self connecToServer];
//                
//            }
//            
//        }
//
//        BOOL opend = [messageDic valueForKey:@"open"];
//        if (opend) {
//            [self sendReLogin];
//        }
        
        
        

        if ([actionType isEqualToString:LOGIN_TO_SERVER]) {
            if ([messageDic objectForKey:RESULT_ERROR] != nil) {
                
                [[self delegate] receivedErrorFromAction:[messageDic objectForKey:RESULT_ERROR]];
                return;
            }
            
            
            [[self delegate] receivedMessageFromLoginToServer:messageDic];
            
            
        } else if([actionType isEqualToString:CONNECT_TO_SERVER]) {
            if ([messageDic objectForKey:RESULT_ERROR] != nil) {
                
                [[self delegate] receivedErrorFromAction:[messageDic objectForKey:RESULT_ERROR]];
                return;
            }
            
            [[self delegate] receivedMessageFromConnectToServer:messageDic];
        } else if([actionType isEqualToString:APPLY_GAME]) {
            if ([messageDic objectForKey:RESULT_ERROR] != nil) {
                
                [[self delegate] receivedErrorFromAction:[messageDic objectForKey:RESULT_ERROR]];
                return;
            }
            
            [[self delegate] receivedMessageFromApplyGame:messageDic];
        } else if([actionType isEqualToString:ADD_UP_SCORE]) {
            if ([messageDic objectForKey:RESULT_ERROR] != nil) {
                
                [[self delegate] receivedErrorFromAction:[messageDic objectForKey:RESULT_ERROR]];
                return;
            }
            
            [[self delegate] receivedMessageFromAddUpScore:messageDic];
        } else if([actionType isEqualToString:REGISTER_TO_SERVER]) {
            if ([messageDic objectForKey:RESULT_ERROR] != nil) {
                
                [[self delegate] receivedErrorFromAction:[messageDic objectForKey:RESULT_ERROR]];
                return;
            }
            
            
            
            [[self delegate] receivedMessageFromRegisterToServer:messageDic];
        } else if([actionType isEqualToString:END_GAME]) {
            if ([messageDic objectForKey:RESULT_ERROR] != nil) {
                
                [[self delegate] receivedErrorFromAction:[messageDic objectForKey:RESULT_ERROR]];
                return;
            }
            
            [[self delegate] receivedMessageFromGameEnd:messageDic];
        } else if([actionType isEqualToString:RELOGIN_TO_SERVER]) {
            if ([messageDic objectForKey:RESULT_ERROR] != nil) {
                
                [self receivedError:[messageDic objectForKey:RESULT_ERROR]];
                return;
            }
            
            [self receivedMessageFromLogin:messageDic]; 
        } else if([actionType isEqualToString:RECONNECT_TO_SERVER]) {
            if ([messageDic objectForKey:RESULT_ERROR] != nil) {
                
                [self receivedError:[messageDic objectForKey:RESULT_ERROR]];
                return;
            }
            
            [self receivedMessageFromReConnectToServer:messageDic];
        } else if([actionType isEqualToString:GET_RECORD]) {
            if ([messageDic objectForKey:RESULT_ERROR] != nil) {
                
                [[self delegate] receivedErrorFromAction:[messageDic objectForKey:RESULT_ERROR]];
                return;
            }
            
            [[self delegate] receivedMessageFromRecord:messageDic];
        }
        return;
    }
   
}

- (void) receivedError:(NSString*)message
{
//   NSLog(@"receivedError : %@", message); 
}

- (void) receivedMessageFromLogin:(NSDictionary *)messageDic
{
    
    BOOL result = NO;
    if (messageDic != nil) {
        NSNumber *loginResult = [messageDic valueForKey:@"login"];
        if ([loginResult intValue] == 1) {
            result = YES;
        } else {
            result = NO;
        }
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:nil forKey:@"CurrentGameCount"];
//        NSLog(@"Login result : %d", result);
    }
    
    if (result) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *recordDic = [messageDic valueForKey:@"record"];
        NSNumber *winCount = [recordDic valueForKey:@"win"];
        NSNumber *loseCount = [recordDic valueForKey:@"lose"];
        NSNumber *drawCount = [recordDic valueForKey:@"draw"];
        [userDefaults setObject:winCount forKey:@"WinCount"];
        [userDefaults setObject:loseCount forKey:@"LoseCount"];
        [userDefaults setObject:drawCount forKey:@"DrawCount"];
        [userDefaults synchronize];
        self.isLogined = YES;
       
    } else {
        self.isLogined = NO;
    }
    
    
}

- (void) receivedMessageFromReConnectToServer:(NSDictionary*) messageDic
{
    if (messageDic != nil) {
        //NSLog(@"IntroLayer ReceivedMessageFromConnectToServer %@", messageDic);
        // TODO
        
    }
    
    
}

- (void)sendReLogin
{
    NSMutableArray *accountArray = [AccountManager allAccount];
    NSString *loginId = nil;
    NSString *uuid = nil;
    for (NSDictionary *accountDic in accountArray) {
        loginId = [accountDic objectForKey:@"acct"];
        uuid = [AccountManager getUUIDByAccountId:[accountDic objectForKey:@"acct"]];
    }
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    
//    NSString *loginedUserId = [userDefaults objectForKey:@"NumClickUserID"];
//    NSString *loginedUUID =     [userDefaults objectForKey:@"NumClickUUID"];
    
    
    
    if (loginId && uuid) {
        
        [self setActionType:LOGIN_TO_SERVER];
        // TODO 保存！
        [self sendMessage:[NSString stringWithFormat:@"{\"login\":{\"id\":\"%@\", \"uid\":\"%@\"}}", loginId,uuid]];
        
        
        [self sendMessage:@"{\"record\":\"\"}"];
    }

    
}

- (BOOL) isClosed
{
    if([socket readyState] == 3 ) {
        return YES;
    }
    return NO;
}

- (BOOL) isConnecting
{
    if([socket readyState] == 0) {
        return YES;
    }
    return NO;
}



@end
