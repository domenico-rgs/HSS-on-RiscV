#include "segmenter.h"
#include <ee_printf.h>

//Data for tests
#include "weights.h"

#define CLOCK_HZ   (32000000)
#define UART0_BAUD (9600)

int main(int argc, char *argv[]){
    uart_init(uart0, UART_DATA_BITS_8, UART_PARITY_EVEN, UART_STOP_BITS_1, UART_FLOW_CTRL_NONE, (uint32_t)(CLOCK_HZ/UART0_BAUD));
    gpio0->EN   = -1; // all gpio ports configured as outputs
    gpio0->DATA =  0xff; // all LEDs initially on

    int16_t y[N][N_STATES];
    int16_t test_data[N_FEATURES*N];
    int i = 0; //total samples processed since turned on
        
    while(1){
        uart_readData(uart0,(uint8_t*)test_data,sizeof(int16_t)*N_FEATURES*N); //it waits if no data are available
        timer_set_time(timer0, 0);

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

        ee_printf("Processed %d samples - %d clock cycles\r\n", ++i, timer_get_time(timer0));
        
        //uart_writeData(uart0,(uint8_t*)y,sizeof(int16_t)*N_FEATURES*N); //to be used to obtain the results

        for (int wait=0; wait<(3200000/32); wait++) { //wait 0.1s before sending signal for the next sample, increase (e.g. to 0.5s) in case data writing by producer
            asm volatile("nop");
        }

        gpio0->DATA = i & 0xff; //turn on the LEDs to show that the sample has been processed
        uart_writeByte(uart0,0x01); //once finished ask to the producer (peripheral - uart) to send the next sample        
    }
}