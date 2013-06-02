//
//  APIConnection.h
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/07.
//
//

#define RESULT_ERROR         @"error"
// サーバー接続結果
#define CONNECT_TO_SERVER @"ConnectToServer"

#define RECONNECT_TO_SERVER @"ReConnectToServer"

#define LOGIN_TO_SERVER   @"LoginToServer"

#define RELOGIN_TO_SERVER @"ReLoginToServer"
// ゲーム申請
#define APPLY_GAME        @"ApplyGame"
// スコア集計
#define ADD_UP_SCORE      @"AddUpScore"

#define REGISTER_TO_SERVER      @"RegisterToServer"

#define END_GAME          @"EndGame"

#define GET_RECORD         @"GetRecord"


#define REGISTER_FALSE  @"false"

#define ERROR_ALREADY_LOGIN @"already login"

#define ERROR_USED_ID @"already used id"

#define ERROR_SEND_UID @"please send uid"

// 既に使用中のID
#define ERROR_SEND_ANOTHER_ID @"please send another id"

#define ERROR_SEND_ANOTHER_NAME @"please send another name"

// 新規入会
#define ERROR_SEND_YOUR_INFO @"please send your info"

#define ERROR_ALREADY_FIGHTING  @"already fighting"
#define ERROR_NO_LOGIN          @"no login"
#define ERROR_ENEMY_DISCONNECTED @"enemy disconnected"
#define ERROR_ALREADY_SEND_POINT @"already send point"
//ゲーム未申請
#define ERROR_NOT_READY           @"not ready"

#define UNEXPECTED_ERROR        @"unexpected error"




#import <Foundation/Foundation.h>
#import "SRWebSocket.h"


@protocol APIConnectionDelegate;

@protocol APIConnectionDelegate <NSObject>

- (void) receivedErrorFromAction:(NSString*)message;

@optional

// message will either be an NSString if the server is using text
// or NSData if the server is using binary.
- (void) receivedMessageWithDic:(NSDictionary*) messageDic;

- (void) receivedMessageFromLoginToServer:(NSDictionary*) messageDic;

- (void) receivedMessageFromConnectToServer:(NSDictionary*) messageDic;

- (void) receivedMessageFromApplyGame:(NSDictionary*) messageDic;

- (void) receivedMessageFromAddUpScore:(NSDictionary*) messageDic;

- (void) receivedMessageFromRegisterToServer:(NSDictionary *)messageDic;

- (void) receivedMessageFromGameEnd:(NSDictionary*) messageDic;

- (void) receivedMessageFromRecord:(NSDictionary*) messageDic;



@end

@interface APIConnection : NSObject <SRWebSocketDelegate>
{
    SRWebSocket *socket;
    NSString *actionType;
    BOOL isLogined;
}

@property (nonatomic, assign) id <APIConnectionDelegate> delegate;
@property (nonatomic, retain) NSString *actionType;
@property (nonatomic, readwrite) BOOL isLogined;

+ (APIConnection*) sharedAPIConnection;

- (void) sendMessage:(NSString*) message;

- (void) connecToServer;

- (void) closeToServer;

- (BOOL) isClosed;

- (BOOL) isConnecting;

- (void) sendReLogin;



@end
