//
//  MXUtils.h
//  Pods
//
//  Created by 吴星煜 on 15/4/26.
//
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import "OpenUDID.h"

static inline NSString* randomString() {
    int NUMBER_OF_CHARS = 10;
    char data[NUMBER_OF_CHARS];
    for (int x=0;x<NUMBER_OF_CHARS;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
}

static inline NSString* md5String(NSString *strOrigin){
    const char *original_str = [strOrigin UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}

static inline NSString* appName() {
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    return appName;
}

static inline NSString* appPkgName() {
    NSString *appPkgName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    return appPkgName;
}

static inline NSString* appVersion() {
    NSString *appVerShort = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *appVer = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *ret = [NSString stringWithFormat:@"%@(%@)", appVerShort, appVer];
    return ret;
}

static inline NSString* deviceName() {
    return [[UIDevice currentDevice] name];
}

static inline NSString* deviceOSName() {
    return [[UIDevice currentDevice] systemName];
}

static inline NSString* deviceOSVersion() {
    return [[UIDevice currentDevice] systemVersion];
}

static inline NSString* deviceID() {
    return [OpenUDID value];
}

static inline NSString* deviceRes() {
    NSString *ret = [NSString stringWithFormat:@"%dx%d", (int)[UIScreen mainScreen].bounds.size.width, (int)[UIScreen mainScreen].bounds.size.height];
    return ret;
}

@interface MXUtils : NSObject

@end
