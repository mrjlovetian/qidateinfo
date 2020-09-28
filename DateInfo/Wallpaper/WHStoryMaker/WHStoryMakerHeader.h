//
//  WHStoryMakerHeader.h
//  Demo
//
//  Created by whbalzac on 12/08/2017.
//  Copyright © 2017 whbalzac. All rights reserved.
//

#ifndef WHStoryMakerHeader_h
#define WHStoryMakerHeader_h

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "StoryMakeImageEditorViewController.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define SCREENAPPLY(x, y) CGSizeMake(ScreenWidth / 375.0 * (x), ScreenHeight / 667.0 * (y))
#define SCREENAPPLYSPACE(x) ScreenWidth / 375.0 * (x)
#define SCREENAPPLYHEIGHT(x) ScreenHeight / 667.0 * (x)

#define UIColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(r,g,b)               UIColorFromRGBA(r,g,b,1.0)

static inline BOOL IsEmpty(id thing) {
    return thing == nil || [thing isEqual:[NSNull null]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

#endif /* WHStoryMakerHeader_h */
