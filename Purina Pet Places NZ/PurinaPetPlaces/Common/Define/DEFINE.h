//
//  DEFINE.h
//  PetPlaces
//
//  Created by art_kernel_zyc on 15/4/12.
//  Copyright (c) 2015年 art_kernel_zyc. All rights reserved.
//

#ifndef PetPlaces_DEFINE_h
#define PetPlaces_DEFINE_h


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#define CD(x) ([[UIDevice currentDevice].systemVersion floatValue] >= (x))
#define CD_X(z) ([[UIDevice currentDevice].systemVersion floatValue] == (z))


#if DEBUG 
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(fmt, ...)
#endif


#endif
