#import <Foundation/Foundation.h>
#import "BDBOAuth1SessionManager.h"

#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 1090)

@interface BDBOAuth1SessionManager (KBExtension)

/**
 *  Sends a generic OAuth signed request (using "Authentication" header) for JSON object.
 *  You should have successfully fetched access token first before using this method.
 *
 *  @param accessPath   An endpoint that requires an OAuth signed request.
 *  @param method       HTTP method for the request.
 *  @param parameters   The parameters to be either set as a query string for `GET` requests, or the request HTTP body.
 *  @param success      Completion block performed upon successful request.
 *  @param failure      Completion block performed if the request failed.
 */
- (void)jsonObjectWithPath:(NSString *)accessPath
                    method:(NSString *)method
                parameters:(NSDictionary *)parameters
                   success:(void (^)(NSURLResponse *response, id jsonObject))success
                   failure:(void (^)(NSURLResponse *response, NSError *error))failure;

@end

#endif
