//
//  AccountManager.h
//  NekoPeko
//
//  Created by Jo Sungbum on 13/06/11.
//
//

#import <Foundation/Foundation.h>

@interface AccountManager : NSObject

+ (void) addAccount:(NSString *) uuid accountId : (NSString*) accountId;

+ (NSString*) getUUIDByAccountId:(NSString*) accountId;

+ (void) deleteUUID:(NSString*) accountId;

+ (NSMutableArray*) allAccount;

+ (void) deleteAllAccount;


@end
