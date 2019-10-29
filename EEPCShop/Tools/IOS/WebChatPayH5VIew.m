//
//  WebChatPayH5VIew.m
//  One
//
//  Created by MJL on 2018/1/12.
//  Copyright © 2018年 MJL. All rights reserved.
//

#import "WebChatPayH5VIew.h"

@interface WebChatPayH5VIew ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *myWebView;

@property (assign, nonatomic) BOOL isLoading;

@end

@implementation WebChatPayH5VIew

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.myWebView = [[UIWebView alloc] initWithFrame:self.frame];
        [self addSubview:self.myWebView];
        self.myWebView.delegate = self;
    }
    return self;
}

#pragma mark 加载地址
- (void)loadingURL:(NSString *)url withIsWebChatURL:(BOOL)isLoading {
    //首先要设置为NO
    self.isLoading = isLoading;
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *wxValue = [@"shop.shijihema.cn" stringByAppendingString:@"://"];     //拼接给外部使用的URLScheme
    wxValue = [self db_URLEncode:wxValue];
    if ([request.URL.absoluteString hasPrefix:@"https://wx.tenpay.com/cgi-bin/mmpayweb-bin/checkmweb"] && [request.URL.absoluteString rangeOfString:wxValue].length==0) {
        //微信支付,且没做过处理
        NSString *newURLStr = [self db_makeAURL:request.URL.absoluteString appendKey:@"redirect_url" value:wxValue replace:YES];
        NSMutableURLRequest *newRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:newURLStr]];
        newRequest.allHTTPHeaderFields = request.allHTTPHeaderFields;
        if (![newRequest.allHTTPHeaderFields objectForKey:@"Referer"]) {
            //头部没有Referer字段
            NSMutableDictionary *newHeader = [[NSMutableDictionary alloc] initWithDictionary:newRequest.allHTTPHeaderFields];
            NSString *referer = [NSString stringWithFormat:@"http://%@",@"ds.shijihema.cn"];
            newHeader[@"Referer"] = referer;
            newRequest.allHTTPHeaderFields = newHeader;
        }
        [webView loadRequest:newRequest];
        return NO;
    }
    else if ([request.URL.absoluteString hasPrefix:@"alipay://alipayclient"]) {
        //支付宝
        NSString *newURL = [request.URL.absoluteString stringByReplacingOccurrencesOfString:@"alipays" withString:@"shop.shijihema.cn"];   //替换支付宝原scheme为自己的
        BOOL bSucc = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:newURL]];                      //调起支付宝
        
        // NOTE: 如果跳转失败，则跳转itune下载支付宝App
        if (!bSucc) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"未检测到支付宝客户端，请安装后重试。"
                                                          delegate:self
                                                 cancelButtonTitle:@"立即安装"
                                                 otherButtonTitles:nil];
            [alert show];
        }
        else {
            //支付完成通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dbPayFinishedNotification" object:self userInfo:@{@"type":@(2)}];
        }
    }
    else if ([request.URL.scheme rangeOfString:@"shop.shijihema.cn"].length!=0) {
        //微信支付结束后会进入这里,重定向到订单页面
        
        //支付完成通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dbPayFinishedNotification" object:self userInfo:@{@"type":@(1)}];
        return NO;
    }
    return YES;
    
    
//    NSURL *url = [request URL];
//    NSString *newUrl = url.absoluteString;
//    if (!self.isLoading) {
//        if ([newUrl rangeOfString:@"weixin://wap/pay"].location != NSNotFound) {
//            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//            [self.myWebView loadRequest:request];
//            self.isLoading = YES;
//            return NO;
//        }
//    } else {
//        if ([newUrl rangeOfString:@"weixin://wap/pay"].location != NSNotFound) {
//            self.myWebView = nil;
//            UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
//            [self addSubview:web];
//            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//            [web loadRequest:request];
////            [[self getCurrentVC] showhide];
//            return YES;
//        }
//    }
//
//    NSDictionary *headers = [request allHTTPHeaderFields];
//    BOOL hasReferer = [headers objectForKey:@"Referer"] != nil;
//    if (hasReferer) {
//        return YES;
//    } else {
//        // relaunch with a modified request
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSURL *url = [request URL];
//                NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//                //设置授权域名
//                [request setValue:@"app.52xxdh.com://" forHTTPHeaderField: @"Referer"];
//                [self.myWebView loadRequest:request];
//            });
//        });
//        return NO;
//    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [[self getCurrentVC] showhide];
//    [[self getCurrentVC] showAlertWithTitle:@"调取微信失败" message:nil complete:nil];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

//修改微信URL
- (NSString *)db_makeAURL:(NSString *)url appendKey:(NSString *)key value:(NSString *)value replace:(BOOL)replace
{
    if (!url || !key || !value) {
        return url;
    }
    NSString *result = nil;
    NSRange keyRange = [url rangeOfString:key];
    if (keyRange.length==0) {
        //没有,则追加
        result = [NSString stringWithFormat:@"%@&%@=%@",url,key,value];
        return result;
    }
    else {
        //有,则替换
        long valueBegainIndex = keyRange.location+keyRange.length+1;
        long valueLength = url.length-valueBegainIndex;
        result = [url stringByReplacingCharactersInRange:NSMakeRange(valueBegainIndex, valueLength) withString:value];
        return result;
    }
//    NSMutableDictionary *queueDic = [self db_toParamsDicForURLStr:url];
//    if (queueDic[key] && !replace) {
//        return url;
//    }
//    else {
//        queueDic[key] = value;
//        NSString *newQueue = [self db_urlStrChangeParamsDicToQueryString:queueDic];
//        NSString *host = [[url componentsSeparatedByString:@"?"] firstObject];
//        if (host) {
//            NSString *result = [NSString stringWithFormat:@"%@?%@",host,newQueue];
//            return result;
//        }
//    }
    return result;
}

//字典转换成url参数字符串
- (NSString *)db_urlStrChangeParamsDicToQueryString:(NSDictionary *)dic
{
    NSMutableArray* args = [NSMutableArray arrayWithCapacity:dic.count];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString* key, id obj, BOOL *stop) {
        [args addObject:[NSString stringWithFormat:@"%@=%@",
                         (key),
                         (obj)]];
    }];
    return [args componentsJoinedByString:@"&"];
}

//解析url参数字典
- (NSMutableDictionary *)db_toParamsDicForURLStr:(NSString *)urlStr
{
    NSArray* query = [urlStr componentsSeparatedByString:@"?"];
    if (!query || query.count == 0) {
        return nil;
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    NSArray* kvs;
    if (query.count == 1) {
        kvs = [query[0] componentsSeparatedByString:@"&"];
    }
    if (query.count == 2) {
        kvs = [query[1] componentsSeparatedByString:@"&"];
    }
    
    for (NSString* kvString in kvs) {
        if (kvString.length == 0) {
            continue;
        }
        NSRange pos = [kvString rangeOfString:@"="];
        NSString *key;
        NSString *val;
        if (pos.location == NSNotFound) {
            key = [self db_URLDecode:kvString];
            val = @"";
        } else {
            key = [self db_URLDecode:[kvString substringToIndex:pos.location]];
            val = [self db_URLDecode:[kvString substringFromIndex:pos.location + pos.length]];
        }
        
        if (!key) key = @"";
        if (!val) val = @"";
        [params setObject:val forKey:key];
    }
    return params;
}

//URL解码
- (NSString *)db_URLDecode:(NSString *)str
{
    if (!str) {
        return nil;
    }
    NSString *deCodeStr = str.stringByRemovingPercentEncoding;
    return deCodeStr;
}

//URL编码
- (NSString *)db_URLEncode:(NSString *)str
{
    if (!str) {
        return nil;
    }
    //@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| " 网络上的标准,不敢替换,怕受影响
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"!*'\"();:@+$,/%#[]% &"] invertedSet];  //新增了&符,注意观察各个项目是否受影响 2018.9.6
    NSString *newStr = [str stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    return newStr;
}

@end
