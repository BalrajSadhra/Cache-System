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

/* This file is designed for use with ISim build 0x8ddf5b5d */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/student1/bsadhra/COE 758/Non-Bricked Project/cachecontroller/sram.vhd";



static void work_a_2444083905_1878664202_p_0(char *t0)
{
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    int t9;
    unsigned char t10;
    char *t11;
    int t12;
    int t13;
    char *t14;
    char *t15;
    int t16;
    int t17;
    char *t18;
    char *t19;
    unsigned char t20;
    char *t21;
    int t22;
    int t23;
    unsigned int t24;
    unsigned int t25;
    char *t26;
    int t27;
    int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;

LAB0:    xsi_set_current_line(28, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 3784);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(29, ng0);
    t4 = (t0 + 2312U);
    t8 = *((char **)t4);
    t9 = *((int *)t8);
    t10 = (t9 == 0);
    if (t10 != 0)
        goto LAB8;

LAB10:
LAB9:    xsi_set_current_line(38, ng0);
    t2 = (t0 + 1192U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB23;

LAB25:
LAB24:    xsi_set_current_line(41, ng0);
    t2 = (t0 + 1832U);
    t4 = *((char **)t2);
    t2 = (t0 + 1992U);
    t5 = *((char **)t2);
    t9 = *((int *)t5);
    t12 = (t9 - 7);
    t24 = (t12 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t9);
    t25 = (t24 * 32U);
    t2 = (t0 + 2152U);
    t8 = *((char **)t2);
    t13 = *((int *)t8);
    t16 = (t13 - 31);
    t29 = (t16 * -1);
    xsi_vhdl_check_range_of_index(31, 0, -1, t13);
    t30 = (t25 + t29);
    t31 = (8U * t30);
    t32 = (0 + t31);
    t2 = (t4 + t32);
    t11 = (t0 + 3992);
    t14 = (t11 + 56U);
    t15 = *((char **)t14);
    t18 = (t15 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t2, 8U);
    xsi_driver_first_trans_fast_port(t11);
    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(30, ng0);
    t4 = (t0 + 8752);
    *((int *)t4) = 0;
    t11 = (t0 + 8756);
    *((int *)t11) = 7;
    t12 = 0;
    t13 = 7;

LAB11:    if (t12 <= t13)
        goto LAB12;

LAB14:    xsi_set_current_line(35, ng0);
    t2 = (t0 + 3928);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((int *)t11) = 1;
    xsi_driver_first_trans_fast(t2);
    goto LAB9;

LAB12:    xsi_set_current_line(31, ng0);
    t14 = (t0 + 8760);
    *((int *)t14) = 0;
    t15 = (t0 + 8764);
    *((int *)t15) = 31;
    t16 = 0;
    t17 = 31;

LAB15:    if (t16 <= t17)
        goto LAB16;

LAB18:
LAB13:    t2 = (t0 + 8752);
    t12 = *((int *)t2);
    t4 = (t0 + 8756);
    t13 = *((int *)t4);
    if (t12 == t13)
        goto LAB14;

LAB22:    t9 = (t12 + 1);
    t12 = t9;
    t5 = (t0 + 8752);
    *((int *)t5) = t12;
    goto LAB11;

LAB16:    xsi_set_current_line(32, ng0);
    t18 = (t0 + 8768);
    t20 = (8U != 8U);
    if (t20 == 1)
        goto LAB19;

LAB20:    t21 = (t0 + 8752);
    t22 = *((int *)t21);
    t23 = (t22 - 7);
    t24 = (t23 * -1);
    t25 = (t24 * 32U);
    t26 = (t0 + 8760);
    t27 = *((int *)t26);
    t28 = (t27 - 31);
    t29 = (t28 * -1);
    t30 = (t25 + t29);
    t31 = (8U * t30);
    t32 = (0U + t31);
    t33 = (t0 + 3864);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    memcpy(t37, t18, 8U);
    xsi_driver_first_trans_delta(t33, t32, 8U, 0LL);

LAB17:    t2 = (t0 + 8760);
    t16 = *((int *)t2);
    t4 = (t0 + 8764);
    t17 = *((int *)t4);
    if (t16 == t17)
        goto LAB18;

LAB21:    t9 = (t16 + 1);
    t16 = t9;
    t5 = (t0 + 8760);
    *((int *)t5) = t16;
    goto LAB15;

LAB19:    xsi_size_not_matching(8U, 8U, 0);
    goto LAB20;

LAB23:    xsi_set_current_line(39, ng0);
    t2 = (t0 + 1512U);
    t5 = *((char **)t2);
    t2 = (t0 + 1992U);
    t8 = *((char **)t2);
    t9 = *((int *)t8);
    t12 = (t9 - 7);
    t24 = (t12 * -1);
    t25 = (t24 * 32U);
    t2 = (t0 + 2152U);
    t11 = *((char **)t2);
    t13 = *((int *)t11);
    t16 = (t13 - 31);
    t29 = (t16 * -1);
    t30 = (t25 + t29);
    t31 = (8U * t30);
    t32 = (0U + t31);
    t2 = (t0 + 3864);
    t14 = (t2 + 56U);
    t15 = *((char **)t14);
    t18 = (t15 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t5, 8U);
    xsi_driver_first_trans_delta(t2, t32, 8U, 0LL);
    goto LAB24;

}


extern void work_a_2444083905_1878664202_init()
{
	static char *pe[] = {(void *)work_a_2444083905_1878664202_p_0};
	xsi_register_didat("work_a_2444083905_1878664202", "isim/cachetest_isim_beh.exe.sim/work/a_2444083905_1878664202.didat");
	xsi_register_executes(pe);
}
