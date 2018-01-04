//
//  NSString+Extension.h
//  MVC
//
//  Created by liushaohua on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (BOOL)isUserPhone;  /// 判断是手机号码
- (BOOL)isUserName;   /// 判断用户名
- (BOOL)isPassword;   /// 判断密码
- (BOOL)isCompany;    /// 判断公司名
- (BOOL)isPosition;   /// 判断职务
- (BOOL)isFixTel;     /// 判断固话
- (BOOL)isEmail;      /// 判断邮箱
- (BOOL)checkInputMsg;/// 判断输入信息是否为空
- (BOOL)isFixTelWithOutConnection; /// 判断输入是否是座机 中间没有“－”连接符
- (BOOL)isValidURL;/// 判断是否是有效网址
- (BOOL)isValidateIdentityCard;/// 验证身份证号
- (BOOL)validateCarNo;/// 车牌号验证

/**
 去掉字符串中的空格
 */
- (NSString *)trimString;
/**
将身份证号改成 110110********1510的样式
 */
- (NSString *)parseIDNumber;

/**
 身份证号添加空格 130529199903335333 -> 130529 1999 0333 5333
 */
- (NSString *)addIDCardSpace;
/**
 将手机号码改为 188****1046 的样式
 */
- (NSString *)parsePhoneNum;
/**
 电话号码添加空格 例: 15811311063 => 158 1131 1063
 */
- (NSString *)addPhoneSpace;
/**
  增加千位分隔符
 */
- (NSString *)addComm;

/**
 去掉千位分隔符
 */
- (NSString *)removeComm;

/**
 字符串的长度
 */
- (int)textLength;

/**
 计算字符串的CGSize
 */
- (CGSize)ll_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;


@end
