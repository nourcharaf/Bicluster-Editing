//
//  Utilities.h
//  Bicluster Editting
//
//  Created by Mohammad Nour Sharaf on 7/2/18.
//  Copyright © 2018 Mohammad Nour Sharaf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define utilities [Utilities sharedInstance]

@interface Utilities : NSObject

+(Utilities *)sharedInstance;

-(CGSize)statusBarSize;
-(CGSize)navigationBarSize;
-(CGFloat)statusNavigationHeight;
-(CGFloat)safeAreaInsetsBottom;
-(id)mainStoryboardInstantiateViewControllerWithIdentifier:(NSString *)identifier;
-(float)randomNumber;

@end
