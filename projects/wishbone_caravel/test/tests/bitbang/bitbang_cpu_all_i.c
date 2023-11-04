#include <defs.h>
#include <stub.c>
#include "bitbang_functions.c"

void main(){
    unsigned int i, j, k;
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    reg_mprj_io_37 = 0x1803;
    reg_mprj_io_36 = 0x1803;
    reg_mprj_io_35 = 0x1803;
    reg_mprj_io_34 = 0x1803;
    reg_mprj_io_33 = 0x1803;
    reg_mprj_io_32 = 0x1803;
    reg_mprj_io_31 = 0x1803;
    reg_mprj_io_30 = 0x1803;
    reg_mprj_io_29 = 0x1803;
    reg_mprj_io_28 = 0x1803;
    reg_mprj_io_27 = 0x1803;
    reg_mprj_io_26 = 0x1803;
    reg_mprj_io_25 = 0x1803;
    reg_mprj_io_24 = 0x1803;
    reg_mprj_io_23 = 0x1803;
    reg_mprj_io_22 = 0x1803;
    reg_mprj_io_21 = 0x1803;
    reg_mprj_io_20 = 0x1803;
    reg_mprj_io_19 = 0x1803;
    reg_mprj_io_18 = 0x1803;
    reg_mprj_io_17 = 0x1803;
    reg_mprj_io_16 = 0x1803;
    reg_mprj_io_15 = 0x1803;
    reg_mprj_io_14 = 0x1803;
    reg_mprj_io_13 = 0x1803;
    reg_mprj_io_12 = 0x1803;
    reg_mprj_io_11 = 0x1803;
    reg_mprj_io_10 = 0x1803;
    reg_mprj_io_9  = 0x1803;
    reg_mprj_io_8  = 0x1803;
    reg_mprj_io_7  = 0x1803;
    reg_mprj_io_6  = 0x1803;
    reg_mprj_io_5  = 0x1803;
    reg_mprj_io_4  = 0x1803;
    reg_mprj_io_3  = 0x1803;
    reg_mprj_io_2  = 0x1803;
    reg_mprj_io_1  = 0x1803;
    reg_mprj_io_0  = 0x1803;
    reg_mprj_io_0  = 0x1803;

    // bitbang
   //Configure all as input except reg_mprj_io_3
    clock_in_right_i_left_i_standard(0); // 18	and 19	
    clock_in_right_i_left_i_standard(0); // 17	and 20	
    clock_in_right_i_left_i_standard(0); // 16	and 21	
    clock_in_right_i_left_i_standard(0); // 15	and 22	
    clock_in_right_i_left_i_standard(0); // 14	and 23	
    clock_in_right_i_left_i_standard(0); // 13	and 24	
    clock_in_right_i_left_i_standard(0); // 12	and 25	
    clock_in_right_i_left_i_standard(0); // 11	and 26	
    clock_in_right_i_left_i_standard(0); // 10	and 27	
    clock_in_right_i_left_i_standard(0); // 9	and 28	
    clock_in_right_i_left_i_standard(0); // 8	and 29	
    clock_in_right_i_left_i_standard(0); // 7	and 30	
    clock_in_right_i_left_i_standard(0); // 6	and 31	
    clock_in_right_i_left_i_standard(0); // 5	and 32	
    clock_in_right_i_left_i_standard(0); // 4	and 33	
    clock_in_right_i_left_i_standard(0); // 3	and 34	
    clock_in_right_i_left_i_standard(0); // 2	and 35	
    clock_in_right_i_left_i_standard(0); // 1	and 36	
    clock_in_right_i_left_i_standard(0); // 0	and 37	
    load();		                        // load
    reg_debug_1 = 0XAA; // configuration done wait environment to send 0x8F66FD7B to reg_mprj_datal
    while (reg_mprj_datal != 0x8F66FD7B);
    reg_debug_1 = 0XBB; // configuration done wait environment to send 0xFFA88C5A to reg_mprj_datal
    while (reg_mprj_datal != 0xFFA88C5A);
    reg_debug_1 = 0XCC; // configuration done wait environment to send 0xC9536346 to reg_mprj_datal
    while (reg_mprj_datal != 0xC9536346);
    reg_debug_1 = 0XD1;
    while (reg_mprj_datah != 0x3F);
    reg_debug_1 = 0XD2;
    while (reg_mprj_datah != 0x0);
    reg_debug_1 = 0XD3;
    while (reg_mprj_datah != 0x15);
    reg_debug_1 = 0XD4;
    while (reg_mprj_datah != 0x2A);

    reg_debug_2 = 0xFF;

}

