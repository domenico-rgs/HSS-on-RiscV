#include "functions.h"
#include "segmenter.h"
#include <airisc.h>
#include <ee_printf.h>
#include <inttypes.h>

//Data for tests
//#include "test_data.h"
#include "weights.h"

#define CLOCK_HZ   (32000000)
#define UART0_BAUD (9600)

int main(int argc, char *argv[]){
    uart_init(uart0, UART_DATA_BITS_8, UART_PARITY_EVEN, UART_STOP_BITS_1, UART_FLOW_CTRL_NONE, (uint32_t)(CLOCK_HZ/UART0_BAUD));
    gpio0->EN   = -1; // all configured as outputs
    gpio0->DATA =  0; // all LEDs off

    datatype y[N][N_STATES];
    datatype test_data[N_FEATURES*N];
    int i = 0;
    
    timer_set_time(timer0, 0);

    while(fread(test_data, sizeof(datatype), N_FEATURES*N, stdin) == N_FEATURES*N){ //stdin mapped to uart0
        Segmenter(test_data,
            enc_0_conv_relu_0_w,enc_0_conv_relu_1_w,enc_1_conv_relu_0_w,
            enc_1_conv_relu_1_w,enc_2_conv_relu_0_w,enc_2_conv_relu_1_w,
            enc_3_conv_relu_0_w,enc_3_conv_relu_1_w,central_conv_relu_0_w,
            central_conv_relu_1_w, dec_0_up_conv_relu_w,dec_0_conv_relu_0_w,
            dec_0_conv_relu_1_w,dec_1_up_conv_relu_w,dec_1_conv_relu_0_w,
            dec_1_conv_relu_1_w,dec_2_up_conv_relu_w,dec_2_conv_relu_0_w,
            dec_2_conv_relu_1_w,dec_3_up_conv_relu_w,dec_3_conv_relu_0_w,
            dec_3_conv_relu_1_w,final_conv_w,y
        );

        if(i%7500==0){ //print elapsed time at each 100 patients and also at patient 1, 25 and 50
            ee_printf("Processed %d samples - time: %" PRIu64 "seconds\r\n", i+1, timer_get_time(timer0)); //to be converted manually in decimal value by dividing it by CLOCK_HZ
        }
        
        i++;
    }
    
	ee_printf("\nTotal elapsed computation time (%d samples): %" PRIu64 "seconds\r\n", i, timer_get_time(timer0));
    gpio0->DATA =  0b11111111; // all LEDs on

    return 0;
}