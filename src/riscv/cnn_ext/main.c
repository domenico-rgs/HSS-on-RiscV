#include "functions.h"
#include "segmenter.h"
#include <ee_printf.h>
#include <inttypes.h>

//Data for tests
#include "weights.h"

#define CLOCK_HZ   (32000000)
#define UART0_BAUD (9600)

int main(int argc, char *argv[]){
    uart_init(uart0, UART_DATA_BITS_8, UART_PARITY_EVEN, UART_STOP_BITS_1, UART_FLOW_CTRL_NONE, (uint32_t)(CLOCK_HZ/UART0_BAUD));

    gpio0->EN   = -1; // all configured as outputs
    gpio0->DATA =  0b11111111; // all LEDs on

    int16_t y[N][N_STATES];
    int16_t test_data[N_FEATURES*N]; //={-733,-520,-315,-323,-758,-386,-353,-288,-811,-581,-433,-462,-807,-405,-266,-148,-816,-839,-608,-814,-475,-173,232,682,897,2214,1746,2194,1149,1044,311,-76,96,-554,-616,-534,-314,-301,-253,-247,-514,-495,-441,-458,-670,-411,-305,-234,-674,-479,-361,-393,-559,-444,-378,-329,-389,-217,-282,-317,-477,-399,-385,-330,-610,-449,-345,-362,-680,-420,-369,-300,-817,-834,-478,-620,2,186,281,395,1695,1769,862,1678,1991,1210,230,534,806,-17,-367,-364,-134,-445,-336,-305,-414,-421,-347,-395,-448,-438,-411,-350,-409,-134,-203,-178,-541,-474,-490,-507,-681,-446,-267,-173,-676,-584,-590,-654,-315,-592,-162,-96,994,2042,1968,2542,1381,1443,677,759,424,-432,-596,-797,-313,-146,-289,-148,-745,-641,-478,-529,-781,-429,-236,-212,-774,-489,-450,-384,-802,-522,-266,-352,-828,-448,-500,-324,-769,-536,-238,-375,-746,-325,-351,-263,-783,-641,-549,-440,-630,-638,-807,-438,581,-30,-69,-123,3583,3061,7187,2670,4043,3919,6576,2910,1249,168,-866,-424,-179,-697,-569,-509,-408,-305,-381,-295,-546,-600,-502,-520,-530,-210,-24,-76,-698,-615,-689,-617,-712,-386,-138,-110,-708,-666,-719,-747,-423,-615,-134,-125,870,1983,1789,2804,1444,1514,655,862,643,-362,-581,-801,73,-98,-299,-119,-389,-411,-375,-527,-701,-512,-368,-228,-608,-388,-310,-347,-542,-445,-403,-414};
    int i = 0;
    
    ee_printf("Starting...\r\n");
    
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

        //if(i%7500==0){ //print elapsed time at each 100 patients and also at patient 1, 25 and 50
        ee_printf("Processed %d samples - %d clock cycles\r\n", i+1, timer_get_time(timer0)); //to be converted manually in decimal value dividing it by CLOCK_HZ
        //}
        
        for (int wait=0; wait<(3200000/32); wait++) { //wait 0.1s before sending signal for the next sample
            asm volatile("nop");
        }
        
        uart_writeByte(uart0,0x01); //once finished ask to the producer (peripheral - uart) to send the next sample        
        i++;
    }

    /*for(int j=0; j<N; j++){
        for(int k=0; k<N_STATES; k++){
                printf("%d ", y[j][k]); //remember that the abs error depends on the amount of decimals in the txt files
            }
        printf("\r\n");
    }

    gpio0->DATA =  0; // all LEDs off

    return 0;*/
}