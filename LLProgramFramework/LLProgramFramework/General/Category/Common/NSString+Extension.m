//
//  NSString+Extension.m
//  MVC
//
//  Created by liushaohua on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

// 判断是不是可用的手机号码或固话
- (BOOL)isUserPhone
{
    NSString * MOBILE = @"^[1][3578]\\d{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:self];
}

// 判断用户名
- (BOOL)isUserName
{
    NSString *regex = @"^([\u4e00-\u9fa5]|[A-Za-z]){2,}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

// 判断密码
- (BOOL)isPassword
{
    NSString *regex = @"^[?!\\x00-\\xff]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

// 判断公司名
- (BOOL)isCompany
{
    NSString *regex = @"^([\u4e00-\u9fa5]|[A-Za-z])+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

// 判断职务
- (BOOL)isPosition
{
    NSString *regex = @"^([\u4e00-\u9fa5]|[A-Za-z])+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

// 判断固话
- (BOOL)isFixTel
{
    NSString *regexThree = @"^(010|021|022|023|024|025|026|027|028|029|852)-\\d{8}$";
    NSString *regexFour = @"^(0[3-9][1-9]{2})-\\d{7,8}$";
    NSPredicate *predThree = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexThree];
    NSPredicate *predFour = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexFour];
    
    return [predThree evaluateWithObject:self] || [predFour evaluateWithObject:self];
}

// 判断是否是座机电话
- (BOOL)isFixTelWithOutConnection {
    NSString *regexThree = @"^(010|021|022|023|024|025|026|027|028|029|852)\\d{8}$";
    NSString *regexFour = @"^(0[3-9][0-9]{2})\\d{7,8}$";
    NSPredicate *predThree = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexThree];
    NSPredicate *predFour = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexFour];
    
    return [predThree evaluateWithObject:self] || [predFour evaluateWithObject:self];
}

// 判断邮箱
- (BOOL)isEmail
{
    NSString *email = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *regextestEmail = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", email];
    
    return [regextestEmail evaluateWithObject:self];
}

- (BOOL)checkInputMsg {
    
    NSString *predicateStr = @"^[\\s]{0,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicateStr];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidURL {
    
    NSString *predicateStr = @"[a-zA-z]+://[^\\s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicateStr];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidateIdentityCard {
    
    NSString *predicateStr = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicateStr];
    return [predicate evaluateWithObject:self];
}

- (NSString *)trimString {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)parseIDNumber {
    if (self.length<15)  return self;
    NSString *head = [self substringToIndex:6];
    NSString *foot = [self substringFromIndex:14];
    return [NSString stringWithFormat:@"%@************%@",head,foot];
}

- (NSString *)addIDCardSpace {
    if (self.length < 6) return self;
    NSString *trimStr = [self trimString];
    NSMutableString *strM = [NSMutableString stringWithString:self];
    NSInteger length = trimStr.length;
    if (length == 7 || length == 11 || length == 15) { // 添加空格
        [strM insertString:@" " atIndex:self.length - 1];
        return strM.copy;
    }
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)parsePhoneNum {
    if (self.length < 11)  return self;
    NSString *head = [self substringToIndex:3];
    NSString *foot = [self substringFromIndex:7];
    return [NSString stringWithFormat:@"%@****%@",head,foot];
}

- (NSString *)addPhoneSpace {
    if (self.length < 4) return self;
    NSString *trimStr = [self trimString];
    NSMutableString *strM = [NSMutableString stringWithString:self];
    NSInteger length = trimStr.length;
    if (length == 4 || length == 8) { // 添加空格
        [strM insertString:@" " atIndex:self.length - 1];
        return strM.copy;
    }
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


- (NSString *)addComm {
    NSString * str = [self stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSInteger numl = [str length];
    if (numl > 3 && numl < 7) {
        str = [NSString stringWithFormat:@"%@,%@",
               [str substringWithRange:NSMakeRange(0,numl-3)],
               [str substringWithRange:NSMakeRange(numl-3,3)]];
        return str;
    }else if (numl>6 && numl < 10){
        str =  [NSString stringWithFormat:@"%@,%@,%@",
                [str substringWithRange:NSMakeRange(0,numl-6)],
                [str substringWithRange:NSMakeRange(numl-6,3)],
                [str substringWithRange:NSMakeRange(numl-3,3)]];
        return str;
    }else if (numl>9 && numl < 13){
        str =  [NSString stringWithFormat:@"%@,%@,%@,%@",
                [str substringWithRange:NSMakeRange(0,numl-9)],
                [str substringWithRange:NSMakeRange(numl-9,3)],
                [str substringWithRange:NSMakeRange(numl-6,3)],
                [str substringWithRange:NSMakeRange(numl-3,3)]];
        return str;
    }else {
        return str;
    }
}

- (NSString *)removeComm {
    return [self stringByReplacingOccurrencesOfString:@"," withString:@""];
}

- (int)textLength {    
    float number = 0.0;
    for (int index = 0; index < [self length]; index++) {
        //一个汉字两个字节，应是+2.项目中数据库使用的mysql-utf8 一个汉字是3个字节，改成+3
        NSString *character = [self substringWithRange:NSMakeRange(index, 1)];
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3){
            number += 3;
        }else{
            number ++;
        }
    }
    return ceil(number);
}

- (CGSize)ll_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize resultSize;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSDictionary *attributes = @{ NSFontAttributeName:font };
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        NSStringDrawingContext *context;
        [invocation setArgument:&size atIndex:2];
        [invocation setArgument:&options atIndex:3];
        [invocation setArgument:&attributes atIndex:4];
        [invocation setArgument:&context atIndex:5];
        [invocation invoke];
        CGRect rect;
        [invocation getReturnValue:&rect];
        resultSize = rect.size;
    } else {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithFont:constrainedToSize:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithFont:constrainedToSize:)];
        [invocation setArgument:&font atIndex:2];
        [invocation setArgument:&size atIndex:3];
        [invocation invoke];
        [invocation getReturnValue:&resultSize];
    }
    
    return resultSize;
}

@end
