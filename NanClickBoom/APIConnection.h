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

#define LOGIN_TO_SERVER   @"LoginToServer"
// ゲーム申請
#define APPLY_GAME        @"ApplyGame"
// スコア集計
#define ADD_UP_SCORE      @"AddUpScore"

#define ERROR_ALREADY_LOGIN @"already login"

#define ERROR_USED_ID @"already used id"

#define ERROR_ALREADY_FIGHTING  @"already fighting"
#define ERROR_NO_LOGIN          @"no login"
#define ERROR_ENEMY_DISCONNECTED @"enemy disconnected"
#define ERROR_ALREADY_SEND_POINT @"already send point"
//ゲーム未申請
#define ERROR_NOT_READY           @"not ready"




#import <Foundation/Foundation.h>
#import <SRWebSocket.h>

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




@end

@interface APIConnection : NSObject <SRWebSocketDelegate>
{
    SRWebSocket *socket;
    NSString *actionType;
}

@property (nonatomic, assign) id <APIConnectionDelegate> delegate;
@property (nonatomic, retain) NSString *actionType;

+ (APIConnection*) sharedAPIConnection;

- (void) sendMessage:(NSString*) message;

- (void) connecToServer;

- (void) closeToServer;





@end
