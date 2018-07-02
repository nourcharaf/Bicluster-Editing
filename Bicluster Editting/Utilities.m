//
//  Utilities.m
//  Bicluster Editting
//
//  Created by Mohammad Nour Sharaf on 7/2/18.
//  Copyright © 2018 Mohammad Nour Sharaf. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities{
    UIStoryboard *mainStoryboard;
}

static Utilities *sharedInstance = nil;

+(Utilities *)sharedInstance{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}
-(CGSize)statusBarSize{
    return [UIApplication sharedApplication].statusBarFrame.size;
}
-(CGSize)navigationBarSize{
    return [UINavigationController new].navigationBar.frame.size;
}
-(CGFloat)statusNavigationHeight{
    return [self statusBarSize].height + [self navigationBarSize].height;
}
-(CGFloat)safeAreaInsetsBottom{
    CGFloat bottomPadding = 0;
    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        bottomPadding = window.safeAreaInsets.bottom;
    }
    return bottomPadding;
}
-(id)mainStoryboardInstantiateViewControllerWithIdentifier:(NSString *)identifier{
    if (!mainStoryboard){
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    id viewController = [mainStoryboard instantiateViewControllerWithIdentifier:identifier];
    return viewController;
}
-(float)randomNumber{
    // Random number between 0 and 1; 32 bits precision
    return (float)arc4random() / UINT32_MAX;
}

@end
