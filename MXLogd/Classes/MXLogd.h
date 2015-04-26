//
//  MXLogd.h
//  Pods
//
//  Created by 吴星煜 on 15/4/26.
//
//

#import <Foundation/Foundation.h>

#define LOG_LEVEL_CRASH         @"6"

@interface MXLogd : NSObject

+ (MXLogd *)getInstance;

- (BOOL)enableCrashReporter;

@end
