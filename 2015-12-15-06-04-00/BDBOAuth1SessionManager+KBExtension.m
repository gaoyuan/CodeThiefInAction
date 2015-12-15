#import "BDBOAuth1SessionManager+KBExtension.h"

#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 1090)

@implementation BDBOAuth1SessionManager (KBExtension)

- (void)jsonObjectWithPath:(NSString *)accessPath
                    method:(NSString *)method
                parameters:(NSDictionary *)parameters
                   success:(void (^)(NSURLResponse *response, id jsonObject))success
                   failure:(void (^)(NSURLResponse *response, NSError *error))failure {
    
    AFHTTPResponseSerializer *defaultSerializer = self.responseSerializer; // save old serializer for restore after request is completed
    self.responseSerializer = [AFJSONResponseSerializer serializer]; // override serializer
    
    NSString *URLString = [[NSURL URLWithString:accessPath relativeToURL:self.baseURL] absoluteString];
    NSError *error;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:URLString parameters:parameters error:&error];
    
    if (error) {
        failure(nil, error);
        return;
    }
    
    void (^completionBlock)(NSURLResponse * __unused, id, NSError *) = ^(NSURLResponse * __unused response, id responseObject, NSError *completionError) {
        self.responseSerializer = defaultSerializer; // restore the old serializer
        
        if (completionError) {
            failure(response, completionError);
            return;
        }
        success(response, responseObject);
    };
    
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:completionBlock];
    [task resume];
}

@end

#endif
