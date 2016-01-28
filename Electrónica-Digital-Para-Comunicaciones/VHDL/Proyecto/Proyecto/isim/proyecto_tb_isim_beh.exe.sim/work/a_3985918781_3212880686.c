/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x8ef4fb42 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Proyecto/src/conjugador.vhd";
extern char *IEEE_P_0774719531;
extern char *IEEE_P_2592010699;

char *ieee_p_0774719531_sub_436279890_2162500114(char *, char *, char *, char *, int );
unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );
char *ieee_p_2592010699_sub_1837678034_503743352(char *, char *, char *, char *);


static void work_a_3985918781_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(47, ng0);

LAB3:    t1 = (t0 + 1144U);
    t2 = *((char **)t1);
    t1 = (t0 + 2348);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t5 = (t4 + 40U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 32U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 2288);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_3985918781_3212880686_p_1(char *t0)
{
    char t14[16];
    char t15[16];
    char t16[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    int t17;
    unsigned int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t22;

LAB0:    xsi_set_current_line(51, ng0);
    t1 = (t0 + 776U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(55, ng0);
    t1 = (t0 + 1144U);
    t2 = *((char **)t1);
    t1 = (t0 + 2384);
    t5 = (t1 + 32U);
    t9 = *((char **)t5);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    memcpy(t11, t2, 32U);
    xsi_driver_first_trans_fast(t1);

LAB3:    t1 = (t0 + 2296);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(52, ng0);
    t1 = (t0 + 868U);
    t5 = *((char **)t1);
    t6 = (31 - 31);
    t7 = (t6 * 1U);
    t8 = (0 + t7);
    t1 = (t5 + t8);
    t9 = (t0 + 2384);
    t10 = (t9 + 32U);
    t11 = *((char **)t10);
    t12 = (t11 + 40U);
    t13 = *((char **)t12);
    memcpy(t13, t1, 16U);
    xsi_driver_first_trans_delta(t9, 0U, 16U, 0LL);
    xsi_set_current_line(53, ng0);
    t1 = (t0 + 868U);
    t2 = *((char **)t1);
    t6 = (31 - 15);
    t7 = (t6 * 1U);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t5 = (t16 + 0U);
    t9 = (t5 + 0U);
    *((int *)t9) = 15;
    t9 = (t5 + 4U);
    *((int *)t9) = 0;
    t9 = (t5 + 8U);
    *((int *)t9) = -1;
    t17 = (0 - 15);
    t18 = (t17 * -1);
    t18 = (t18 + 1);
    t9 = (t5 + 12U);
    *((unsigned int *)t9) = t18;
    t9 = ieee_p_2592010699_sub_1837678034_503743352(IEEE_P_2592010699, t15, t1, t16);
    t10 = ieee_p_0774719531_sub_436279890_2162500114(IEEE_P_0774719531, t14, t9, t15, 1);
    t11 = (t14 + 12U);
    t18 = *((unsigned int *)t11);
    t19 = (1U * t18);
    t3 = (16U != t19);
    if (t3 == 1)
        goto LAB5;

LAB6:    t12 = (t0 + 2384);
    t13 = (t12 + 32U);
    t20 = *((char **)t13);
    t21 = (t20 + 40U);
    t22 = *((char **)t21);
    memcpy(t22, t10, 16U);
    xsi_driver_first_trans_delta(t12, 16U, 16U, 0LL);
    goto LAB3;

LAB5:    xsi_size_not_matching(16U, t19, 0);
    goto LAB6;

}

static void work_a_3985918781_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;

LAB0:    xsi_set_current_line(61, ng0);
    t1 = (t0 + 684U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 568U);
    t3 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 2304);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(62, ng0);
    t1 = xsi_get_transient_memory(32U);
    memset(t1, 0, 32U);
    t5 = t1;
    memset(t5, (unsigned char)2, 32U);
    t6 = (t0 + 2420);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 40U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 32U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(64, ng0);
    t2 = (t0 + 1052U);
    t5 = *((char **)t2);
    t2 = (t0 + 2420);
    t6 = (t2 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 40U);
    t9 = *((char **)t8);
    memcpy(t9, t5, 32U);
    xsi_driver_first_trans_fast(t2);
    goto LAB3;

}


extern void work_a_3985918781_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3985918781_3212880686_p_0,(void *)work_a_3985918781_3212880686_p_1,(void *)work_a_3985918781_3212880686_p_2};
	xsi_register_didat("work_a_3985918781_3212880686", "isim/proyecto_tb_isim_beh.exe.sim/work/a_3985918781_3212880686.didat");
	xsi_register_executes(pe);
}
