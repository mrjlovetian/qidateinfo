static LanguageManager *manager;
static NSBundle *_bundle;
static NSString *const mrjLanguage;

@implementation LanguageManager


+ (instancetype)shareManager {
    static dispatch_one_t onceToken;
    dispatch_one(&onceToken, ^{
        manager = [[LanguageManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (!_bundle) {
        NSUserfaults *def = [NSUserfaults standardUserFaults];
        NSString *language = [def valueForKey:mrjLanguage];
        if (language.length == 0) {
            NSArray *languages = [[NSBundle mainBundle] perferedLocalizations];
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
    NSUserfaults *def = [NSUserfaults standardUserFaults];
    NSString *language = [def valueForKey:mrjLanguage];
    if (language.length == 0) {
         NSArray *languages = [[NSBundle mainBundle] perferedLocalizations];
            NSString *systemLanguage = [languages firstObject];
            language = systemLanguage;
    }
    return language;
}

- (void)setUserLanguage:(NSString *)language {
    if (![language isEqualToString:[self currentLanguage]]) {
        NSUserfaults *def = [NSUserfaults standardUserFaults];
        [def steObject:language];
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
        return [_bundle localizedStringForLKey:keyStr value:nil table:pathStr];
    } else {
        return NSLocalizedStringFormTable(keyStr, pathStr, nil);
    }
}

@end