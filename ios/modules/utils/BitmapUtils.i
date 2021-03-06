#ifndef _BITMAPUTILS_I
#define _BITMAPUTILS_I

%module BitmapUtils

!proxy_imports(carto::BitmapUtils, graphics.Bitmap)
!objc_imports(carto::BitmapUtils, <UIKit/UIKit.h>)
!cs_imports(carto::BitmapUtils, UIKit)

%{
#include "utils/BitmapUtils.h"
#include "components/Exceptions.h"
%}

%include <std_shared_ptr.i>
%include <std_string.i>
%include <cartoswig.i>

%import "graphics/Bitmap.i"

%typemap(objctype) UIImage* "UIImage*"
%typemap(objcin) UIImage* "(__bridge void*) $objcinput"
%typemap(objcout) UIImage* %{
    return (__bridge_transfer UIImage*)$imcall;
%}
%typemap(cstype) UIImage* "UIImage"
%typemap(csin) UIImage* "new HandleRef($csinput, $csinput.Handle)"
%typemap(csout, excode=SWIGEXCODE) UIImage* {
    var uiImage = $imcall; $excode;
    return ObjCRuntime.Runtime.GetNSObject<UIImage>(uiImage);
}
%typemap(in, canthrow=1) UIImage* %{
    $1 = (__bridge UIImage*)$input;
%}
%typemap(out) UIImage* %{
    $result = (__bridge_retained void*)$1;
%}

%std_exceptions(carto::BitmapUtils::CreateBitmapFromUIImage)
%std_exceptions(carto::BitmapUtils::CreateUIImageFromBitmap)

%include "utils/BitmapUtils.h"

#endif
