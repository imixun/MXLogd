//
//  MXReportMgr.h
//  Pods
//
//  Created by 吴星煜 on 15/4/25.
//
//

#import <Foundation/Foundation.h>

typedef void (^NoRetSuccBlock)();
typedef void (^ErrorBlock)(NSString* strError);

@interface MXReportMgr : NSObject

+ (MXReportMgr *)getInstance;

- (void)postLogInfo:(NSString*)strLog
         andLogFile:(NSString*)strLogFile
        andLogLevel:(NSString*)strLevel
       andTimestamp:(NSString*)strTime
   withSuccessBlock:(NoRetSuccBlock)succBlk
     withErrorBlock:(ErrorBlock)errBlk;

@end
