//
//  TKMacro.h
//  TapKit
//
//  Created by Wu Kevin on 4/26/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#ifdef __cplusplus
extern "C" {
#endif


///-------------------------------
/// Degree and radian
///-------------------------------

#define TKDegreesToRadians(_dgr_) ( M_PI * (_dgr_) / 180.0 )
#define TKRadiansToDegrees(_rdn_) ( (_rdn_) * 180.0 / M_PI )


///-------------------------------
/// Time interval
///-------------------------------

#define TKTimeIntervalMinute()  (60.0)
#define TKTimeIntervalHour()    (60.0*60)
#define TKTimeIntervalDay()     (60.0*60*24)
#define TKTimeIntervalWeek()    (60.0*60*24*7)


///-------------------------------
/// Variable argument lists
///-------------------------------

#define TKValistToArray(_ary_, _stt_, _cnt_) \
if ( (_cnt_)!=0 ) { \
  va_list _lst_; \
  va_start(_lst_, (_stt_)); \
  if ( (_cnt_)>0 ) { \
    for ( int i=0; i<(_cnt_); ++i ) { \
      id _obj_ = va_arg(_lst_, id); \
      [(_ary_) addObject:( (_obj_) ? _obj_ : [NSNull null] )]; \
    } \
  } else if ( (_cnt_)<0 ) { \
    id _obj_ = nil; \
    while ( (_obj_=va_arg(_lst_, id)) ) { \
      [(_ary_) addObject:_obj_]; \
    } \
  } \
  va_end(_lst_); \
}


///-------------------------------
/// Color shortcut
///-------------------------------

#define TKRGBA(_r_, _g_, _b_, _a_)  ([UIColor colorWithRed:(_r_)/255.0 green:(_g_)/255.0 blue:(_b_)/255.0 alpha:(_a_)/255.0])
#define TKRGB(_r_, _g_, _b_)        ([UIColor colorWithRed:(_r_)/255.0 green:(_g_)/255.0 blue:(_b_)/255.0 alpha:1.0])


#ifdef __cplusplus
}
#endif
