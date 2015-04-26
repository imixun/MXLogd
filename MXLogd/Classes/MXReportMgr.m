//
//  MXReportMgr.m
//  Pods
//
//  Created by 吴星煜 on 15/4/25.
//
//

#import "MXReportMgr.h"
#import "AFNetworking.h"
#import "MXUtils.h"

#define Token                   @"sRsJoZtv1RaGCORQaHPztQy4Kh6EdQFb"

#define BASE_URL                @"http://outsourcing.imixun.com/"
#define POST_LOG_URL            @"/logSystem/Public/index.php/Home/Api/postLogs"

@interface MXReportMgr()
{
    AFHTTPRequestOperationManager *_httpMgr;
}

@end

@implementation MXReportMgr

+ (MXReportMgr *)getInstance {
    __strong static MXReportMgr *mgr = nil;
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
        _httpMgr = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        _httpMgr.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    }
    return self;
}

- (void)postLogInfo:(NSString*)strLog
         andLogFile:(NSString*)strLogFile
        andLogLevel:(NSString*)strLevel
       andTimestamp:(NSString*)strTime
   withSuccessBlock:(NoRetSuccBlock)succBlk
     withErrorBlock:(ErrorBlock)errBlk
{
    NSMutableDictionary *aParametersDic = [[NSMutableDictionary alloc] init];
    
    NSString *aNonce = randomString();
    NSString *aSignature = md5String([NSString stringWithFormat:@"%@%@", Token, aNonce]);
    [aParametersDic setObject:aNonce forKey:@"nonce"];
    [aParametersDic setObject:aSignature forKey:@"signature"];

    NSString *strAppName = appName();
    [aParametersDic setObject:strAppName forKey:@"app_name"];
    
    NSString *strPkgName = appPkgName();
    [aParametersDic setObject:strPkgName forKey:@"app_package_name"];
    
    NSString *strVersion = appVersion();
    [aParametersDic setObject:strVersion forKey:@"app_version"];
    
    [aParametersDic setObject:strLevel forKey:@"log_level"];
    
    NSString *strDevName = deviceName();
    [aParametersDic setObject:strDevName forKey:@"device_name"];
   
    NSString *strDevOS = deviceOSName();
    [aParametersDic setObject:strDevOS forKey:@"device_os_name"];
    
    NSString *strDevOSVer = deviceOSVersion();
    [aParametersDic setObject:strDevOSVer forKey:@"device_os_version"];
    
    NSString *strDevID = deviceID();
    [aParametersDic setObject:strDevID forKey:@"device_udid"];
    
    NSString *strRes = deviceRes();
    [aParametersDic setObject:strRes forKey:@"device_resolution"];
    
    [aParametersDic setObject:strLog forKey:@"log_info"];
    
    [aParametersDic setObject:strTime forKey:@"log_time"];
    
    [_httpMgr POST:POST_LOG_URL parameters:aParametersDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        NSInteger code = [resDic[@"Return"] integerValue];
        if (code == 0) {
            succBlk();
        }else {
            NSString *aDetail = resDic[@"Detail"];
            errBlk(aDetail);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errBlk([error localizedDescription]);
    }];
}

@end
