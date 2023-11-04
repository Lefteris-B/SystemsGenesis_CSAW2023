/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

#include <defs.h>
#include <stub.c>
#include <uart.h>
// --------------------------------------------------------

void wait_for_char(char *c){
    while (uart_rxempty_read() == 1);
    if (reg_uart_data == *c){
        reg_debug_1 = 0x1B; // recieved the correct character
    }else{
        reg_debug_1 = 0x1E; // timeout didn't recieve the character
    }
    reg_debug_1 =0;
    uart_ev_pending_write(UART_EV_RX);
}

void main(){
    int j;
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    reg_mprj_io_6 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_5 = GPIO_MODE_MGMT_STD_INPUT_NOPULL;

    // Now, apply the configuration
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    reg_uart_enable = 1;

    print("M");
    wait_for_char("M");
    
    print("B");
    wait_for_char("B");

    print("A");
    wait_for_char("A");

    print("5");
    wait_for_char("5");

    print("o");
    wait_for_char("o");

}
