//
//  AccountManager.m
//  NekoPeko
//
//  Created by Jo Sungbum on 13/06/11.
//
//

#import "AccountManager.h"
#define IDENTIFIER @"nekopeoko_account"
static NSString *RECEIPT_SERVICE_NAME = @"NekoPekoService";


@implementation AccountManager


/*
 　レシートの追加
 デカグラフに登録できなかったレシートを追加する
 */
+ (void) addAccount:(NSString *) uuid accountId : (NSString*) accountId
{
    NSString *existUUID = [self getUUIDByAccountId:accountId];
    if (existUUID == nil) {
        if (uuid != nil && accountId != nil) {
            //NSMutableDictionary *attributes = nil;
            NSMutableDictionary* query = [NSMutableDictionary dictionary];
            //NSString *receiptStr = [transactionReceipt base64EncodedString];
            
            //        NSString *keyString = [NSString stringWithFormat:@"%@:%@",asUserId,productId];
            //        NSData *keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
            NSData *uuidData = [uuid dataUsingEncoding:NSUTF8StringEncoding];
            
            [query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
            [query setObject:accountId forKey:(id)kSecAttrAccount];
            [query setObject:uuidData forKey:(id)kSecValueData];
            [query setObject:RECEIPT_SERVICE_NAME forKey:(id)kSecAttrService];
            [query setObject:[IDENTIFIER dataUsingEncoding:NSUTF8StringEncoding] forKey:(id)kSecAttrGeneric];
            
            
            OSStatus err = SecItemAdd((CFDictionaryRef) query, NULL);
            if (err == noErr) {
                NSLog(@"SecItemAdd: noErr");
            } else {
                NSLog(@"SecItemAdd: error(%ld)", err);
            }
        }
    }
    
    
}



+ (NSString*) getUUIDByAccountId:(NSString*) accountId
{
    
    NSMutableDictionary*query = [NSMutableDictionary dictionary];
    [query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    [query setObject:accountId forKey:(id)kSecAttrAccount];
    [query setObject:RECEIPT_SERVICE_NAME forKey:(id)kSecAttrService];
    [query setObject:[IDENTIFIER dataUsingEncoding:NSUTF8StringEncoding]forKey:(id)kSecAttrGeneric];
    [query setObject:(id)kCFBooleanTrue forKey:kSecReturnData];
    
    NSData* IdData =nil;
    
    OSStatus err =SecItemCopyMatching((CFDictionaryRef)query, (CFTypeRef*)&IdData);
    NSString*uuidString =nil;
    if(err ==noErr) {
        NSLog(@"SecItemCopyMatching: noErr");
        uuidString = [[[NSString alloc]initWithData:IdData encoding:NSUTF8StringEncoding]autorelease];
        
               
        NSLog(@"uuidString Data : %@", uuidString);
    }else if(err ==errSecItemNotFound) {
        NSLog(@"SecItemCopyMatching: errSecItemNotFound");
    }else{
        NSLog(@"SecItemCopyMatching : error(%ld)", err);
    }
    return uuidString;
}

+ (void) deleteUUID:(NSString*) accountId
{

    //NSString *receiptStr = [transactionReceipt base64EncodedString];
    NSMutableDictionary* query = [NSMutableDictionary dictionary];
    [query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    [query setObject:accountId forKey:(id)kSecAttrAccount];
    OSStatus err =SecItemDelete((CFDictionaryRef)query);
    
    if(err ==noErr) {
        NSLog(@"SecItemDelete: noErr");
    }else{
        NSLog(@"SecItemDelete: error(%ld)", err);
    }
}

/*
 全てのレシートを取得する
 */
+ (NSMutableArray*) allAccount
{
    
    NSMutableDictionary* query = [NSMutableDictionary dictionary];
    
    [query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    [query setObject:RECEIPT_SERVICE_NAME forKey:(id)kSecAttrService];
    [query setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
    [query setObject:(id)kSecMatchLimitAll forKey:(id)kSecMatchLimit];
    
    NSMutableArray*arrayData =nil;
    OSStatus err =SecItemCopyMatching((CFDictionaryRef)query,(CFTypeRef*)&arrayData);
    if(err ==noErr) {
        NSLog(@"SecItemCopyMatching: noErr");
        NSLog(@"result : %@", arrayData);
        for(NSMutableDictionary*dic in arrayData) {
            //            NSString *encodingRecipt = [dic objectForKey:@"acct"];
            NSString*accountId = [dic objectForKey:@"acct"];
            if(accountId !=nil) {
                NSLog(@"UUID : %@", accountId);
                
            }
        }
    }else if(err ==errSecItemNotFound) {
        NSLog(@"SecItemCopyMatching: errSecItemNotFound");
    }else{
        NSLog(@"SecItemCopyMatching: error(%ld)", err);
    }
    return arrayData;
}

+ (void) deleteAllAccount {
    
    NSMutableArray*arrayData = [self allAccount];
    
    if(arrayData !=nil) {

        for(NSMutableDictionary*dic in arrayData) {
            //NSString *encodingReceipt = [dic objectForKey:@"acct"];
            //            NSData* receiptData = [NSData dataFromBase64String:encodingReceipt];
            NSString*accountId = [dic objectForKey:@"acct"];
            
            NSString*uuid = [self getUUIDByAccountId:accountId];
            
            if(uuid !=nil) {
                [self deleteUUID:accountId];
            }
        }
    }
}

@end
