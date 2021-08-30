//
//  HMCommonHeader.h
//  OCToolsClass
//
//  Created by zhuhc on 2021/8/30.
//

#ifndef HMCommonHeader_h
#define HMCommonHeader_h

/// RGB颜色
#define HMColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

/// 弱引用
#define weakObject(type) __weak typeof(type) weak##type = type

#endif /* HMCommonHeader_h */
