//
//  CCFFmepgOperation.c
//  CCVideoConverter
//
//  Created by bo on 25/01/2018.
//  Copyright © 2018 bo. All rights reserved.
//

#include "CCFFmepgOperation.h"
#include "ffmpeg.h"



static char *sfs_buf;
static int sfs_cur_idx;

void callbackfunc(void *vv, int tt, const char * cc, va_list ll)
{

    
    if (32 == tt) {
        if (sfs_cur_idx > 2047) {
            printf("\n werrnning\n");
            return;
        }
        
        sfs_cur_idx += vsprintf(sfs_buf+sfs_cur_idx, cc, ll);
//        vprintf(cc, ll);
    } else {
        return;
    }
    
}


void cc_ffmpegGetInfo(int argc, char **argv, char **out, int *size)
{
    if (!sfs_buf) {
        sfs_buf = malloc(2048);
//        free(sfs_buf);
//        sfs_buf = NULL;
    }
//    sfs_buf = malloc(2048);
    sfs_cur_idx = 0;
    av_log_set_callback(callbackfunc);
    ffmpeg_main(argc, argv);
    av_log_set_callback(NULL);
    
    *out = sfs_buf;
    *size = sfs_cur_idx;
    
}

void cc_exitThread(void)
{
    pthread_exit("ss");
}

//__attribute__((constructor))
//static void init() {
//    pthread_mutex_init(&sfs_mut, NULL);
//}

