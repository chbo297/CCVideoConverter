//
//  CCFFmepgOperation.h
//  CCVideoConverter
//
//  Created by bo on 25/01/2018.
//  Copyright © 2018 bo. All rights reserved.
//

#ifndef CCFFmepgOperation_h
#define CCFFmepgOperation_h

#include <stdio.h>

//void cc_ffmpeg(int argc, char **argv);

void cc_ffmpegGetInfo(int argc, char **argv, char **out, int *size);

void cc_exitThread(void);

#endif /* CCFFmepgOperation_h */
