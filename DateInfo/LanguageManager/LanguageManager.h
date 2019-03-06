
#import <UIKit/UIKit.h>

#define HXLocalizableString(key, tbl, comment)\
[[LanguageManager shareManager] getKeyStr:(key) pathStr:(tbl)]

@interface LanguageManager : NSObject

+ (instancetype)shareManager;

- (NSBundle *)bundle;

- (NSString *)currentLanguage;

- (void)setUserLanguage:(NSString *)language;

- (NSString *)getKeyStr:(NSString *)keyStr pathStr:(NSString *)pathStr;

@end