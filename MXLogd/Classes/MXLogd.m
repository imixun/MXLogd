//
//  MXLogd.m
//  Pods
//
//  Created by 吴星煜 on 15/4/26.
//
//

#import "MXLogd.h"
#import <CrashReporter.h>
#import "MXReportMgr.h"

@interface MXLogd()
{
    PLCrashReporter *_crashReporter;
    MXReportMgr     *_reportMgr;
}

@end

@implementation MXLogd

+ (MXLogd *)getInstance {
    __strong static MXLogd *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[self alloc] init];
    });
    
    return mgr;
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        _reportMgr = [MXReportMgr getInstance];
        _crashReporter = [PLCrashReporter sharedReporter];
        if (_crashReporter) {
            [self handleCrash];
        }
    }
    return self;
}

- (BOOL)enableCrashReporter {
    BOOL bRet = [_crashReporter enableCrashReporter];
    return bRet;
}

#pragma mark - private functions

- (void)handleCrash {
    if ([_crashReporter hasPendingCrashReport]) {
        NSData *crashData;
        NSError *error;
        
        // Try loading the crash report
        crashData = [_crashReporter loadPendingCrashReportDataAndReturnError: &error];
        if (crashData) {
            PLCrashReport *report = [[PLCrashReport alloc] initWithData: crashData error: &error];
            
            if (report) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
                NSString *strTimestamp = [dateFormatter stringFromDate:report.systemInfo.timestamp];
                NSString *strPeport = [NSString stringWithFormat:@"Crashed on %@\n\
                                       Crashed with signal %@ (code %@, address=0x%" PRIx64 ")\
                                       ",strTimestamp
                                       ,report.signalInfo.name,report.signalInfo.code, report.signalInfo.address
                                       ];
                
                [_reportMgr postLogInfo:strPeport
                             andLogFile:nil
                            andLogLevel:LOG_LEVEL_CRASH
                           andTimestamp:[NSString stringWithFormat:@"%lld", (long long int)[report.systemInfo.timestamp timeIntervalSince1970]*1000]
                       withSuccessBlock:^{
                           // Purge the report
                           [_crashReporter purgePendingCrashReport];
                       }
                         withErrorBlock:^(NSString *strError) {
                         }];
            }
        }
    }
}

@end
