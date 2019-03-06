
#import "LanguageManager.h"

static LanguageManager *manager;
static NSBundle *_bundle;
static NSString *const mrjLanguage;

@implementation LanguageManager


+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LanguageManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (!_bundle) {
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *language = [def valueForKey:mrjLanguage];
        if (language.length == 0) {
            NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
            NSString *systemLanguage = [languages firstObject];
            language = systemLanguage;
        }
        if ([language isEqualToString:@"zh-HK"] || [language isEqualToString:@"zh-TW"]) {
            language = @"zh-Hans";
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
        _bundle = [NSBundle bundleWithPath:path];
    }
    return self;
}

- (NSBundle *)bundle {
    return _bundle;
}

- (NSString *)currentLanguage {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *language = [def valueForKey:mrjLanguage];
    if (language.length == 0) {
        NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
        NSString *systemLanguage = [languages firstObject];
        language = systemLanguage;
    }
    return language;
}

- (void)setUserLanguage:(NSString *)language {
    if (![language isEqualToString:[self currentLanguage]]) {
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        [def setObject:language forKey:mrjLanguage];
        [def synchronize];
        if (language.length > 0) {
            NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
            _bundle = [NSBundle bundleWithPath:path];
        } else {
            NSString *path = [[NSBundle mainBundle] pathForResource:[self currentLanguage] ofType:@"lproj"];
            _bundle = [NSBundle bundleWithPath:path];
        }
        // 刷新rootviewcontroller逻辑
    }
}

- (NSString *)getKeyStr:(NSString *)keyStr pathStr:(NSString *)pathStr {
    if (_bundle) {
        return [_bundle localizedStringForKey:keyStr value:nil table:pathStr];
    } else {
        return NSLocalizedStringFromTable(keyStr, pathStr, nil);
    }
}

@end
