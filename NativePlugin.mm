#import "SSKeychain.h"
char szDst[256];

extern "C" {
    const char* hoge_();
    void hogehoge_(const char* info);
}

char* MakeStringCopy (const char* string)
{
    if (string == NULL)
        return NULL;
    
    char* res = (char*)malloc(strlen(string) + 1);
    strcpy(res, string);
    return res;
}

const char* hoge_()
{
    NSLog(@"#hoge");
    
    NSString *info = [SSKeychain passwordForService:@"UserInfo"
                           account:@"com.mushikago.KeyChainTest1"
                           error:nil];
    
    NSLog(info);
    
    return MakeStringCopy([info UTF8String]);
}

void hogehoge_ (const char* info)
{
    NSString *nsstr = [NSString stringWithUTF8String: info];
    NSLog(@"#saveToKeyChain");
    
    [SSKeychain setPassword:nsstr forService:@"UserInfo" account:@"com.mushikago.KeyChainTest1" error:nil];
    
}



