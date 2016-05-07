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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *STD_TEXTIO;
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;
char *UNISIM_P_0947159679;
char *UNISIM_P_3222816464;
char *IEEE_P_2717149903;
char *IEEE_P_1367372525;
char *WORK_P_4054474977;
char *IEEE_P_0774719531;
char *IEEE_P_3564397177;
char *WORK_P_3962537331;
char *WORK_P_2022827561;
char *IEEE_P_1242562249;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_3499444699_init();
    ieee_p_0774719531_init();
    work_p_2022827561_init();
    std_textio_init();
    ieee_p_3564397177_init();
    work_p_3962537331_init();
    work_p_4054474977_init();
    work_a_3643194780_1302593206_init();
    ieee_p_3620187407_init();
    xilinxcorelib_a_2829566387_2959432447_init();
    xilinxcorelib_a_1241677169_1709443946_init();
    xilinxcorelib_a_4102145353_0543512595_init();
    xilinxcorelib_a_1297668570_3212880686_init();
    work_a_1599222407_1588258000_init();
    xilinxcorelib_a_1698962618_2959432447_init();
    xilinxcorelib_a_2027134146_1709443946_init();
    xilinxcorelib_a_1848371049_0543512595_init();
    xilinxcorelib_a_2880282685_3212880686_init();
    work_a_1251448530_3024609260_init();
    xilinxcorelib_a_1761051636_2959432447_init();
    xilinxcorelib_a_0311910964_1709443946_init();
    xilinxcorelib_a_1998376409_0543512595_init();
    xilinxcorelib_a_3868206843_3212880686_init();
    work_a_0918706604_0911010895_init();
    work_a_2123551742_2843490319_init();
    work_a_3416596500_3212880686_init();
    work_a_2359047201_0410720174_init();
    work_a_2089732261_3212880686_init();
    work_a_2466477690_3212880686_init();
    unisim_p_0947159679_init();
    ieee_p_2717149903_init();
    ieee_p_1367372525_init();
    unisim_p_3222816464_init();
    work_a_1376064129_3212880686_init();
    ieee_p_1242562249_init();
    unisim_a_2562466605_1496654361_init();
    unisim_a_1717296735_4086321779_init();
    unisim_a_1769350033_2693788048_init();
    unisim_a_3519694068_2693788048_init();
    unisim_a_2650278463_3403034321_init();
    unisim_a_1916428545_3403034321_init();
    unisim_a_2680519808_1064626918_init();
    unisim_a_3055263662_1392679692_init();
    unisim_a_2261302797_3723259517_init();
    unisim_a_2121384304_3723259517_init();
    unisim_a_0587692967_3731405331_init();
    unisim_a_0774281858_3731405331_init();
    unisim_a_3600803327_3731405331_init();
    unisim_a_1446710196_3752513572_init();
    unisim_a_4104775526_3752513572_init();
    unisim_a_1646226234_1266530935_init();
    unisim_a_3484885994_2523279426_init();
    unisim_a_3702704980_1602505438_init();
    work_a_2061948963_0632001823_init();
    work_a_3985918781_3212880686_init();
    work_a_1137292053_3212880686_init();
    work_a_3025319636_3212880686_init();
    work_a_2380943386_3212880686_init();
    work_a_2709916656_3212880686_init();
    work_a_0368068746_3212880686_init();
    work_a_3432914883_2843490319_init();
    work_a_2827759163_2372691052_init();


    xsi_register_tops("work_a_2827759163_2372691052");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    UNISIM_P_0947159679 = xsi_get_engine_memory("unisim_p_0947159679");
    UNISIM_P_3222816464 = xsi_get_engine_memory("unisim_p_3222816464");
    IEEE_P_2717149903 = xsi_get_engine_memory("ieee_p_2717149903");
    IEEE_P_1367372525 = xsi_get_engine_memory("ieee_p_1367372525");
    WORK_P_4054474977 = xsi_get_engine_memory("work_p_4054474977");
    IEEE_P_0774719531 = xsi_get_engine_memory("ieee_p_0774719531");
    IEEE_P_3564397177 = xsi_get_engine_memory("ieee_p_3564397177");
    WORK_P_3962537331 = xsi_get_engine_memory("work_p_3962537331");
    WORK_P_2022827561 = xsi_get_engine_memory("work_p_2022827561");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");

    return xsi_run_simulation(argc, argv);

}
