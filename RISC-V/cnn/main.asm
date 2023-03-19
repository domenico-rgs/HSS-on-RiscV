
main.elf:     formato del fichero elf32-littleriscv


Desensamblado de la sección .init:

80000000 <_reset_entry>:
80000000:	000f5197          	auipc	gp,0xf5
80000004:	9e018193          	add	gp,gp,-1568 # 800f49e0 <_impure_ptr>
80000008:	0016d117          	auipc	sp,0x16d
8000000c:	ff810113          	add	sp,sp,-8 # 8016d000 <_EXT_MEM_END>

80000010 <crt0_init_csrs>:
80000010:	30001073          	csrw	mstatus,zero
80000014:	00002517          	auipc	a0,0x2
80000018:	25050513          	add	a0,a0,592 # 80002264 <__trap_entry>
8000001c:	30551073          	csrw	mtvec,a0
80000020:	34151073          	csrw	mepc,a0
80000024:	34201073          	csrw	mcause,zero
80000028:	34301073          	csrw	mtval,zero
8000002c:	34401073          	csrw	mip,zero
80000030:	b0001073          	csrw	mcycle,zero
80000034:	b8001073          	csrw	mcycleh,zero

80000038 <crt0_init_mtime>:
80000038:	40000517          	auipc	a0,0x40000
8000003c:	0c850513          	add	a0,a0,200 # c0000100 <_timer_base>
80000040:	00052023          	sw	zero,0(a0)
80000044:	00052223          	sw	zero,4(a0)
80000048:	00052423          	sw	zero,8(a0)
8000004c:	00052823          	sw	zero,16(a0)

80000050 <crt0_init_rf>:
80000050:	00000093          	li	ra,0
80000054:	00008213          	mv	tp,ra
80000058:	00008293          	mv	t0,ra
8000005c:	00008313          	mv	t1,ra
80000060:	00008393          	mv	t2,ra
80000064:	00008413          	mv	s0,ra
80000068:	00008493          	mv	s1,ra
8000006c:	00008513          	mv	a0,ra
80000070:	00008593          	mv	a1,ra
80000074:	00008613          	mv	a2,ra
80000078:	00008693          	mv	a3,ra
8000007c:	00008713          	mv	a4,ra
80000080:	00008793          	mv	a5,ra
80000084:	00008813          	mv	a6,ra
80000088:	00008893          	mv	a7,ra
8000008c:	00008913          	mv	s2,ra
80000090:	00008993          	mv	s3,ra
80000094:	00008a13          	mv	s4,ra
80000098:	00008a93          	mv	s5,ra
8000009c:	00008b13          	mv	s6,ra
800000a0:	00008b93          	mv	s7,ra
800000a4:	00008c13          	mv	s8,ra
800000a8:	00008c93          	mv	s9,ra
800000ac:	00008d13          	mv	s10,ra
800000b0:	00008d93          	mv	s11,ra
800000b4:	00008e13          	mv	t3,ra
800000b8:	00008e93          	mv	t4,ra
800000bc:	00008f13          	mv	t5,ra
800000c0:	00008f93          	mv	t6,ra

800000c4 <crt0_bss>:
800000c4:	00c18513          	add	a0,gp,12 # 800f49ec <__malloc_current_mallinfo>
800000c8:	04818593          	add	a1,gp,72 # 800f4a28 <_bss_end>
800000cc:	00b55863          	bge	a0,a1,800000dc <crt0_bss_loop_end>

800000d0 <crt0_bss_loop>:
800000d0:	00052023          	sw	zero,0(a0)
800000d4:	00450513          	add	a0,a0,4
800000d8:	fea5dce3          	bge	a1,a0,800000d0 <crt0_bss_loop>

800000dc <crt0_bss_loop_end>:
800000dc:	00000513          	li	a0,0
800000e0:	00000593          	li	a1,0
800000e4:	014000ef          	jal	800000f8 <main>

800000e8 <crt0_end>:
800000e8:	30047073          	csrc	mstatus,8
800000ec:	34051073          	csrw	mscratch,a0
800000f0:	10500073          	wfi

800000f4 <ctr0_end_loop>:
800000f4:	0000006f          	j	800000f4 <ctr0_end_loop>

Desensamblado de la sección .text:

800000f8 <main>:

//Data for tests
#include "test_data.h"
#include "weights.h"

int main(int argc, char *argv[]){
800000f8:	b8010113          	add	sp,sp,-1152
800000fc:	46812c23          	sw	s0,1144(sp)
80000100:	46912a23          	sw	s1,1140(sp)
    datatype y[N][N_STATES];
    
    uint64_t time;
    timer_set_time(timer0, 0);
80000104:	c0000537          	lui	a0,0xc0000
80000108:	800b6437          	lui	s0,0x800b6
8000010c:	0003d4b7          	lui	s1,0x3d
int main(int argc, char *argv[]){
80000110:	47212823          	sw	s2,1136(sp)
80000114:	47312623          	sw	s3,1132(sp)
80000118:	47412423          	sw	s4,1128(sp)
8000011c:	47512223          	sw	s5,1124(sp)
80000120:	47612023          	sw	s6,1120(sp)
80000124:	45712e23          	sw	s7,1116(sp)
80000128:	45812c23          	sw	s8,1112(sp)
8000012c:	45912a23          	sw	s9,1108(sp)
    timer_set_time(timer0, 0);
80000130:	00000593          	li	a1,0
80000134:	00000613          	li	a2,0
80000138:	10050513          	add	a0,a0,256 # c0000100 <_timer_base>
8000013c:	9b040413          	add	s0,s0,-1616 # 800b59b0 <test_data>
80000140:	09048493          	add	s1,s1,144 # 3d090 <_reset_entry-0x7ffc2f70>

    for(int i=0; i<TEST_SAMPLES_BATCH;i++){
         Segmenter((test_data+i*TEST_SAMPLES_BATCH),
80000144:	80006cb7          	lui	s9,0x80006
80000148:	80006c37          	lui	s8,0x80006
8000014c:	80006bb7          	lui	s7,0x80006
80000150:	80007b37          	lui	s6,0x80007
80000154:	80007ab7          	lui	s5,0x80007
80000158:	80008a37          	lui	s4,0x80008
8000015c:	800099b7          	lui	s3,0x80009
80000160:	8000b937          	lui	s2,0x8000b
int main(int argc, char *argv[]){
80000164:	46112e23          	sw	ra,1148(sp)
80000168:	009404b3          	add	s1,s0,s1
    timer_set_time(timer0, 0);
8000016c:	324020ef          	jal	80002490 <timer_set_time>
         Segmenter((test_data+i*TEST_SAMPLES_BATCH),
80000170:	eb0c8c93          	add	s9,s9,-336 # 80005eb0 <final_conv_w>
80000174:	030c0c13          	add	s8,s8,48 # 80006030 <dec_3_conv_relu_1_w>
80000178:	330b8b93          	add	s7,s7,816 # 80006330 <dec_3_conv_relu_0_w>
8000017c:	930b0b13          	add	s6,s6,-1744 # 80006930 <dec_3_up_conv_relu_w>
80000180:	f30a8a93          	add	s5,s5,-208 # 80006f30 <dec_2_conv_relu_1_w>
80000184:	b30a0a13          	add	s4,s4,-1232 # 80007b30 <dec_2_conv_relu_0_w>
80000188:	33098993          	add	s3,s3,816 # 80009330 <dec_2_up_conv_relu_w>
8000018c:	b3090913          	add	s2,s2,-1232 # 8000ab30 <dec_1_conv_relu_1_w>
80000190:	05010793          	add	a5,sp,80
80000194:	04f12023          	sw	a5,64(sp)
80000198:	8000e7b7          	lui	a5,0x8000e
8000019c:	b3078793          	add	a5,a5,-1232 # 8000db30 <dec_1_conv_relu_0_w>
800001a0:	00f12e23          	sw	a5,28(sp)
800001a4:	800147b7          	lui	a5,0x80014
800001a8:	b3078793          	add	a5,a5,-1232 # 80013b30 <dec_1_up_conv_relu_w>
800001ac:	00f12c23          	sw	a5,24(sp)
800001b0:	8001a7b7          	lui	a5,0x8001a
800001b4:	b3078793          	add	a5,a5,-1232 # 80019b30 <dec_0_conv_relu_1_w>
800001b8:	00f12a23          	sw	a5,20(sp)
800001bc:	800267b7          	lui	a5,0x80026
800001c0:	b3078793          	add	a5,a5,-1232 # 80025b30 <dec_0_conv_relu_0_w>
800001c4:	00f12823          	sw	a5,16(sp)
800001c8:	8003e7b7          	lui	a5,0x8003e
800001cc:	b3078793          	add	a5,a5,-1232 # 8003db30 <dec_0_up_conv_relu_w>
800001d0:	00f12623          	sw	a5,12(sp)
800001d4:	800567b7          	lui	a5,0x80056
800001d8:	b3078793          	add	a5,a5,-1232 # 80055b30 <central_conv_relu_1_w>
800001dc:	00f12423          	sw	a5,8(sp)
800001e0:	800867b7          	lui	a5,0x80086
800001e4:	b3078793          	add	a5,a5,-1232 # 80085b30 <central_conv_relu_0_w>
800001e8:	00f12223          	sw	a5,4(sp)
800001ec:	8009e7b7          	lui	a5,0x8009e
800001f0:	b3078793          	add	a5,a5,-1232 # 8009db30 <enc_3_conv_relu_1_w>
800001f4:	00f12023          	sw	a5,0(sp)
800001f8:	800aa8b7          	lui	a7,0x800aa
800001fc:	800b0837          	lui	a6,0x800b0
80000200:	800b37b7          	lui	a5,0x800b3
80000204:	800b4737          	lui	a4,0x800b4
80000208:	800b56b7          	lui	a3,0x800b5
8000020c:	800b5637          	lui	a2,0x800b5
80000210:	800b65b7          	lui	a1,0x800b6
80000214:	00040513          	mv	a0,s0
80000218:	03812c23          	sw	s8,56(sp)
8000021c:	03712a23          	sw	s7,52(sp)
80000220:	03612823          	sw	s6,48(sp)
80000224:	03512623          	sw	s5,44(sp)
80000228:	03412423          	sw	s4,40(sp)
8000022c:	03312223          	sw	s3,36(sp)
80000230:	03212023          	sw	s2,32(sp)
80000234:	b3088893          	add	a7,a7,-1232 # 800a9b30 <enc_3_conv_relu_0_w>
80000238:	b3080813          	add	a6,a6,-1232 # 800afb30 <enc_2_conv_relu_1_w>
8000023c:	b3078793          	add	a5,a5,-1232 # 800b2b30 <enc_2_conv_relu_0_w>
80000240:	33070713          	add	a4,a4,816 # 800b4330 <enc_1_conv_relu_1_w>
80000244:	f3068693          	add	a3,a3,-208 # 800b4f30 <enc_1_conv_relu_0_w>
80000248:	53060613          	add	a2,a2,1328 # 800b5530 <enc_0_conv_relu_1_w>
8000024c:	83058593          	add	a1,a1,-2000 # 800b5830 <enc_0_conv_relu_0_w>
    for(int i=0; i<TEST_SAMPLES_BATCH;i++){
80000250:	3e840413          	add	s0,s0,1000
         Segmenter((test_data+i*TEST_SAMPLES_BATCH),
80000254:	03912e23          	sw	s9,60(sp)
80000258:	134000ef          	jal	8000038c <Segmenter>
    for(int i=0; i<TEST_SAMPLES_BATCH;i++){
8000025c:	f2941ae3          	bne	s0,s1,80000190 <main+0x98>
               dec_1_conv_relu_1_w,dec_2_up_conv_relu_w,dec_2_conv_relu_0_w,
               dec_2_conv_relu_1_w,dec_3_up_conv_relu_w,dec_3_conv_relu_0_w,
               dec_3_conv_relu_1_w,final_conv_w,y);
    }
    
    time = timer_get_time(timer0);
80000260:	c0000537          	lui	a0,0xc0000
80000264:	10050513          	add	a0,a0,256 # c0000100 <_timer_base>
80000268:	238020ef          	jal	800024a0 <timer_get_time>
	ee_printf("Elapsed computation time: %.5f seconds\n", ((float)time) / 32);
8000026c:	78d030ef          	jal	800041f8 <__floatundisf>
80000270:	800067b7          	lui	a5,0x80006
80000274:	e007a583          	lw	a1,-512(a5) # 80005e00 <__clz_tab+0x10c>
80000278:	3eb030ef          	jal	80003e62 <__mulsf3>
8000027c:	09a040ef          	jal	80004316 <__extendsfdf2>
80000280:	00050613          	mv	a2,a0
80000284:	80006537          	lui	a0,0x80006
80000288:	00058693          	mv	a3,a1
8000028c:	ba850513          	add	a0,a0,-1112 # 80005ba8 <_isatty_r+0x3a>
80000290:	5a8020ef          	jal	80002838 <ee_printf>
80000294:	47c12083          	lw	ra,1148(sp)
80000298:	47812403          	lw	s0,1144(sp)
8000029c:	47412483          	lw	s1,1140(sp)
800002a0:	47012903          	lw	s2,1136(sp)
800002a4:	46c12983          	lw	s3,1132(sp)
800002a8:	46812a03          	lw	s4,1128(sp)
800002ac:	46412a83          	lw	s5,1124(sp)
800002b0:	46012b03          	lw	s6,1120(sp)
800002b4:	45c12b83          	lw	s7,1116(sp)
800002b8:	45812c03          	lw	s8,1112(sp)
800002bc:	45412c83          	lw	s9,1108(sp)
800002c0:	00000513          	li	a0,0
800002c4:	48010113          	add	sp,sp,1152
800002c8:	00008067          	ret

800002cc <Softmax>:
Softmax implementation
  Args:
    x - Input array to perform softmax
    y - Array to save the softmax resultant values
*/
void Softmax(datatype x[N_STATES], datatype y[N_STATES]) {
800002cc:	fd010113          	add	sp,sp,-48
800002d0:	02812423          	sw	s0,40(sp)
800002d4:	02912223          	sw	s1,36(sp)
800002d8:	03212023          	sw	s2,32(sp)
800002dc:	01312e23          	sw	s3,28(sp)
800002e0:	01412c23          	sw	s4,24(sp)
800002e4:	02112623          	sw	ra,44(sp)
800002e8:	00050993          	mv	s3,a0
800002ec:	00058913          	mv	s2,a1
800002f0:	00000493          	li	s1,0
  datatype expx[N_STATES];
  datatype expsum = 0;
800002f4:	00000413          	li	s0,0

  for (int i = 0; i < N_STATES; i++) {
800002f8:	01000a13          	li	s4,16
    expx[i] = exp(x[i]);
800002fc:	009987b3          	add	a5,s3,s1
80000300:	0007a503          	lw	a0,0(a5)
80000304:	012040ef          	jal	80004316 <__extendsfdf2>
80000308:	455020ef          	jal	80002f5c <exp>
8000030c:	0c8040ef          	jal	800043d4 <__truncdfsf2>
80000310:	009107b3          	add	a5,sp,s1
80000314:	00050593          	mv	a1,a0
80000318:	00a7a023          	sw	a0,0(a5)
    expsum += expx[i];
8000031c:	00040513          	mv	a0,s0
80000320:	793020ef          	jal	800032b2 <__addsf3>
  for (int i = 0; i < N_STATES; i++) {
80000324:	00448493          	add	s1,s1,4
    expsum += expx[i];
80000328:	00050413          	mv	s0,a0
  for (int i = 0; i < N_STATES; i++) {
8000032c:	fd4498e3          	bne	s1,s4,800002fc <Softmax+0x30>
  }

  // To prevent division by zero errors, add EPSILON if expsum is zero
  if (expsum == 0) {
80000330:	00000593          	li	a1,0
80000334:	179030ef          	jal	80003cac <__eqsf2>
80000338:	00051663          	bnez	a0,80000344 <Softmax+0x78>
    expsum = EPSILON;
8000033c:	800067b7          	lui	a5,0x80006
80000340:	df47a403          	lw	s0,-524(a5) # 80005df4 <__clz_tab+0x100>
80000344:	00000493          	li	s1,0
  }

  for (int i = 0; i < N_STATES; i++) {
80000348:	01000993          	li	s3,16
    y[i] = expx[i] / expsum;
8000034c:	009107b3          	add	a5,sp,s1
80000350:	0007a503          	lw	a0,0(a5)
80000354:	00040593          	mv	a1,s0
80000358:	00990a33          	add	s4,s2,s1
8000035c:	5aa030ef          	jal	80003906 <__divsf3>
80000360:	00aa2023          	sw	a0,0(s4)
  for (int i = 0; i < N_STATES; i++) {
80000364:	00448493          	add	s1,s1,4
80000368:	ff3492e3          	bne	s1,s3,8000034c <Softmax+0x80>
  }
}
8000036c:	02c12083          	lw	ra,44(sp)
80000370:	02812403          	lw	s0,40(sp)
80000374:	02412483          	lw	s1,36(sp)
80000378:	02012903          	lw	s2,32(sp)
8000037c:	01c12983          	lw	s3,28(sp)
80000380:	01812a03          	lw	s4,24(sp)
80000384:	03010113          	add	sp,sp,48
80000388:	00008067          	ret

8000038c <Segmenter>:
               datatype dec_2_conv_relu_1_w[DEC_2_CONV_RELU_1_K*DEC_2_CONV_RELU_1_INPUT_FEATURES*DEC_2_CONV_RELU_1_OUTPUT_FEATURES],
               datatype dec_3_up_conv_relu_w[DEC_3_UP_CONV_RELU_K*DEC_3_UP_CONV_RELU_INPUT_FEATURES*DEC_3_UP_CONV_RELU_OUTPUT_FEATURES],
               datatype dec_3_conv_relu_0_w[DEC_3_CONV_RELU_0_K*DEC_3_CONV_RELU_0_INPUT_FEATURES*DEC_3_CONV_RELU_0_OUTPUT_FEATURES],
               datatype dec_3_conv_relu_1_w[DEC_3_CONV_RELU_1_K*DEC_3_CONV_RELU_1_INPUT_FEATURES*DEC_3_CONV_RELU_1_OUTPUT_FEATURES],
               datatype final_conv_w[FINAL_CONV_K*FINAL_CONV_INPUT_FEATURES*FINAL_CONV_OUTPUT_FEATURES],
               datatype y[N][N_STATES]){
8000038c:	b9010113          	add	sp,sp,-1136
80000390:	fffec2b7          	lui	t0,0xfffec
80000394:	46812423          	sw	s0,1128(sp)
80000398:	45312e23          	sw	s3,1116(sp)
8000039c:	45512a23          	sw	s5,1108(sp)
800003a0:	45612823          	sw	s6,1104(sp)
800003a4:	45712623          	sw	s7,1100(sp)
800003a8:	45812423          	sw	s8,1096(sp)
800003ac:	45a12023          	sw	s10,1088(sp)
800003b0:	43b12e23          	sw	s11,1084(sp)
800003b4:	46112623          	sw	ra,1132(sp)
800003b8:	46912223          	sw	s1,1124(sp)
800003bc:	47212023          	sw	s2,1120(sp)
800003c0:	45412c23          	sw	s4,1112(sp)
800003c4:	45912223          	sw	s9,1092(sp)
800003c8:	00510133          	add	sp,sp,t0
800003cc:	00e12423          	sw	a4,8(sp)
  datatype dec_3_up_conv_relu[DEC_3_UP_CONV_RELU_N][DEC_3_UP_CONV_RELU_OUTPUT_FEATURES];
  datatype dec_3_concatenate[DEC_3_UP_CONV_RELU_N][DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*2];
  datatype dec_3_conv_relu_0[DEC_3_CONV_RELU_0_N][DEC_3_CONV_RELU_0_OUTPUT_FEATURES];
  datatype dec_3_conv_relu_1[DEC_3_CONV_RELU_1_N][DEC_3_CONV_RELU_1_OUTPUT_FEATURES];

  datatype final_conv[FINAL_CONV_N][FINAL_CONV_OUTPUT_FEATURES]={{0}};
800003d0:	00014737          	lui	a4,0x14
               datatype y[N][N_STATES]){
800003d4:	00f12623          	sw	a5,12(sp)
  datatype final_conv[FINAL_CONV_N][FINAL_CONV_OUTPUT_FEATURES]={{0}};
800003d8:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
800003dc:	fffed7b7          	lui	a5,0xfffed
800003e0:	00f70733          	add	a4,a4,a5
800003e4:	03010793          	add	a5,sp,48
800003e8:	00f707b3          	add	a5,a4,a5
               datatype y[N][N_STATES]){
800003ec:	00050b13          	mv	s6,a0
800003f0:	00058b93          	mv	s7,a1
800003f4:	00060a93          	mv	s5,a2
  datatype final_conv[FINAL_CONV_N][FINAL_CONV_OUTPUT_FEATURES]={{0}};
800003f8:	00000593          	li	a1,0
800003fc:	40000613          	li	a2,1024
80000400:	c0078513          	add	a0,a5,-1024 # fffecc00 <_timer_base+0x3ffecb00>
               datatype y[N][N_STATES]){
80000404:	00d12223          	sw	a3,4(sp)
80000408:	01012823          	sw	a6,16(sp)
8000040c:	01112a23          	sw	a7,20(sp)
  datatype final_conv[FINAL_CONV_N][FINAL_CONV_OUTPUT_FEATURES]={{0}};
80000410:	00f12023          	sw	a5,0(sp)
80000414:	0a4050ef          	jal	800054b8 <memset>
80000418:	00012983          	lw	s3,0(sp)
8000041c:	00000413          	li	s0,0
    for(int i=0; i<ENC_0_CONV_RELU_0_N; i++){    // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_0_CONV_RELU_0_K/2);
      l_max = min(ENC_0_CONV_RELU_0_N, i + ENC_0_CONV_RELU_0_K/2 + 1);
80000420:	04000c13          	li	s8,64
      
      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_0_CONV_RELU_0_INPUT_FEATURES; j++){
80000424:	01000d13          	li	s10,16
  for(int k=0; k<ENC_0_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000428:	01800d93          	li	s11,24
               datatype y[N][N_STATES]){
8000042c:	00098913          	mv	s2,s3
    for(int i=0; i<ENC_0_CONV_RELU_0_N; i++){    // Iterate over the input matrix
80000430:	00000493          	li	s1,0
80000434:	00140c93          	add	s9,s0,1
      l_min = max(0, i - ENC_0_CONV_RELU_0_K/2);
80000438:	fff48813          	add	a6,s1,-1
8000043c:	00085463          	bgez	a6,80000444 <Segmenter+0xb8>
80000440:	00000813          	li	a6,0
      l_max = min(ENC_0_CONV_RELU_0_N, i + ENC_0_CONV_RELU_0_K/2 + 1);
80000444:	00248f13          	add	t5,s1,2
80000448:	01ec5463          	bge	s8,t5,80000450 <Segmenter+0xc4>
8000044c:	04000f13          	li	t5,64
      for(int l=l_min; l<l_max; l++){
80000450:	40980733          	sub	a4,a6,s1
80000454:	00ec8733          	add	a4,s9,a4
80000458:	00271713          	sll	a4,a4,0x2
      acc = 0; // Reset the accumulator
8000045c:	00000a13          	li	s4,0
      for(int l=l_min; l<l_max; l++){
80000460:	09e85063          	bge	a6,t5,800004e0 <Segmenter+0x154>
        for(int j=0; j<ENC_0_CONV_RELU_0_INPUT_FEATURES; j++){
80000464:	00481f93          	sll	t6,a6,0x4
80000468:	00271613          	sll	a2,a4,0x2
8000046c:	01fb0fb3          	add	t6,s6,t6
80000470:	00cb8633          	add	a2,s7,a2
      for(int l=l_min; l<l_max; l++){
80000474:	00000693          	li	a3,0
          //acc += x[l*ENC_0_CONV_RELU_0_INPUT_FEATURES+j]*enc_0_conv_relu_0_w[(l-i+ENC_0_CONV_RELU_0_K/2)*ENC_0_CONV_RELU_0_INPUT_FEATURES*ENC_0_CONV_RELU_0_OUTPUT_FEATURES+j*ENC_0_CONV_RELU_0_OUTPUT_FEATURES+k];  // Multiply the input and the weight
          acc += x[l*ENC_0_CONV_RELU_0_INPUT_FEATURES+j]*enc_0_conv_relu_0_w[k*ENC_0_CONV_RELU_0_K*ENC_0_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_0_CONV_RELU_0_K/2)*ENC_0_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80000478:	00df8533          	add	a0,t6,a3
8000047c:	00d605b3          	add	a1,a2,a3
80000480:	0005a583          	lw	a1,0(a1)
80000484:	00052503          	lw	a0,0(a0)
80000488:	02e12623          	sw	a4,44(sp)
8000048c:	03e12423          	sw	t5,40(sp)
80000490:	03012223          	sw	a6,36(sp)
80000494:	03f12023          	sw	t6,32(sp)
80000498:	00d12e23          	sw	a3,28(sp)
8000049c:	00c12c23          	sw	a2,24(sp)
800004a0:	1c3030ef          	jal	80003e62 <__mulsf3>
800004a4:	00050593          	mv	a1,a0
800004a8:	000a0513          	mv	a0,s4
800004ac:	607020ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<ENC_0_CONV_RELU_0_INPUT_FEATURES; j++){
800004b0:	01c12683          	lw	a3,28(sp)
800004b4:	01812603          	lw	a2,24(sp)
800004b8:	02012f83          	lw	t6,32(sp)
800004bc:	00468693          	add	a3,a3,4
800004c0:	02412803          	lw	a6,36(sp)
800004c4:	02812f03          	lw	t5,40(sp)
800004c8:	02c12703          	lw	a4,44(sp)
          acc += x[l*ENC_0_CONV_RELU_0_INPUT_FEATURES+j]*enc_0_conv_relu_0_w[k*ENC_0_CONV_RELU_0_K*ENC_0_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_0_CONV_RELU_0_K/2)*ENC_0_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
800004cc:	00050a13          	mv	s4,a0
        for(int j=0; j<ENC_0_CONV_RELU_0_INPUT_FEATURES; j++){
800004d0:	fba694e3          	bne	a3,s10,80000478 <Segmenter+0xec>
      for(int l=l_min; l<l_max; l++){
800004d4:	00180813          	add	a6,a6,1
800004d8:	00470713          	add	a4,a4,4
800004dc:	f85ff06f          	j	80000460 <Segmenter+0xd4>
          //printf("%f %f\n",enc_0_conv_relu_0_w[k*l_max*ENC_0_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_0_CONV_RELU_0_K/2)*ENC_0_CONV_RELU_0_INPUT_FEATURES+j],enc_0_conv_relu_0_w[(l-i+ENC_0_CONV_RELU_0_K/2)*ENC_0_CONV_RELU_0_INPUT_FEATURES*ENC_0_CONV_RELU_0_OUTPUT_FEATURES+j*ENC_0_CONV_RELU_0_OUTPUT_FEATURES+k]);
        }
      }

      enc_0_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
800004e0:	00000593          	li	a1,0
800004e4:	000a0513          	mv	a0,s4
800004e8:	0e1030ef          	jal	80003dc8 <__lesf2>
800004ec:	00055463          	bgez	a0,800004f4 <Segmenter+0x168>
800004f0:	00000a13          	li	s4,0
800004f4:	01492023          	sw	s4,0(s2)
    for(int i=0; i<ENC_0_CONV_RELU_0_N; i++){    // Iterate over the input matrix
800004f8:	00148493          	add	s1,s1,1
800004fc:	02090913          	add	s2,s2,32
80000500:	f3849ce3          	bne	s1,s8,80000438 <Segmenter+0xac>
  for(int k=0; k<ENC_0_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000504:	00340413          	add	s0,s0,3
80000508:	00498993          	add	s3,s3,4
8000050c:	f3b410e3          	bne	s0,s11,8000042c <Segmenter+0xa0>
80000510:	fffeeb37          	lui	s6,0xfffee
80000514:	000147b7          	lui	a5,0x14
80000518:	800b0b13          	add	s6,s6,-2048 # fffed800 <_timer_base+0x3ffed700>
8000051c:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
80000520:	016787b3          	add	a5,a5,s6
80000524:	03010713          	add	a4,sp,48
80000528:	00e78b33          	add	s6,a5,a4
8000052c:	000b0993          	mv	s3,s6
80000530:	00000413          	li	s0,0
    for(int i=0; i<ENC_0_CONV_RELU_1_N; i++){    // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_0_CONV_RELU_1_K/2);
      l_max = min(ENC_0_CONV_RELU_1_N, i + ENC_0_CONV_RELU_1_K/2 + 1);
80000534:	04000b93          	li	s7,64

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_0_CONV_RELU_1_INPUT_FEATURES; j++){
80000538:	02000c93          	li	s9,32
  for(int k=0; k<ENC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
8000053c:	01800d13          	li	s10,24
  datatype final_conv[FINAL_CONV_N][FINAL_CONV_OUTPUT_FEATURES]={{0}};
80000540:	00098913          	mv	s2,s3
    for(int i=0; i<ENC_0_CONV_RELU_1_N; i++){    // Iterate over the input matrix
80000544:	00000493          	li	s1,0
80000548:	00140c13          	add	s8,s0,1
      l_min = max(0, i - ENC_0_CONV_RELU_1_K/2);
8000054c:	fff48713          	add	a4,s1,-1
80000550:	00075463          	bgez	a4,80000558 <Segmenter+0x1cc>
80000554:	00000713          	li	a4,0
      l_max = min(ENC_0_CONV_RELU_1_N, i + ENC_0_CONV_RELU_1_K/2 + 1);
80000558:	00248e93          	add	t4,s1,2
8000055c:	01dbd463          	bge	s7,t4,80000564 <Segmenter+0x1d8>
80000560:	04000e93          	li	t4,64
      for(int l=l_min; l<l_max; l++){
80000564:	409707b3          	sub	a5,a4,s1
80000568:	00fc07b3          	add	a5,s8,a5
8000056c:	00379793          	sll	a5,a5,0x3
      acc = 0; // Reset the accumulator
80000570:	00000d93          	li	s11,0
      for(int l=l_min; l<l_max; l++){
80000574:	07d75e63          	bge	a4,t4,800005f0 <Segmenter+0x264>
        for(int j=0; j<ENC_0_CONV_RELU_1_INPUT_FEATURES; j++){
80000578:	00012683          	lw	a3,0(sp)
8000057c:	00571f13          	sll	t5,a4,0x5
80000580:	00279e13          	sll	t3,a5,0x2
80000584:	01e68f33          	add	t5,a3,t5
80000588:	01ca8e33          	add	t3,s5,t3
      for(int l=l_min; l<l_max; l++){
8000058c:	00000a13          	li	s4,0
          acc += enc_0_conv_relu_0[l][j]*enc_0_conv_relu_1_w[k*ENC_0_CONV_RELU_1_K*ENC_0_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_0_CONV_RELU_1_K/2)*ENC_0_CONV_RELU_1_INPUT_FEATURES+j]; // Multiply the input and the weight
80000590:	014f0533          	add	a0,t5,s4
80000594:	014e05b3          	add	a1,t3,s4
80000598:	0005a583          	lw	a1,0(a1)
8000059c:	00052503          	lw	a0,0(a0)
800005a0:	02f12423          	sw	a5,40(sp)
800005a4:	03d12223          	sw	t4,36(sp)
800005a8:	02e12023          	sw	a4,32(sp)
800005ac:	01e12e23          	sw	t5,28(sp)
800005b0:	01c12c23          	sw	t3,24(sp)
800005b4:	0af030ef          	jal	80003e62 <__mulsf3>
800005b8:	00050593          	mv	a1,a0
800005bc:	000d8513          	mv	a0,s11
800005c0:	4f3020ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<ENC_0_CONV_RELU_1_INPUT_FEATURES; j++){
800005c4:	004a0a13          	add	s4,s4,4
800005c8:	01812e03          	lw	t3,24(sp)
800005cc:	01c12f03          	lw	t5,28(sp)
800005d0:	02012703          	lw	a4,32(sp)
800005d4:	02412e83          	lw	t4,36(sp)
800005d8:	02812783          	lw	a5,40(sp)
          acc += enc_0_conv_relu_0[l][j]*enc_0_conv_relu_1_w[k*ENC_0_CONV_RELU_1_K*ENC_0_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_0_CONV_RELU_1_K/2)*ENC_0_CONV_RELU_1_INPUT_FEATURES+j]; // Multiply the input and the weight
800005dc:	00050d93          	mv	s11,a0
        for(int j=0; j<ENC_0_CONV_RELU_1_INPUT_FEATURES; j++){
800005e0:	fb9a18e3          	bne	s4,s9,80000590 <Segmenter+0x204>
      for(int l=l_min; l<l_max; l++){
800005e4:	00170713          	add	a4,a4,1
800005e8:	00878793          	add	a5,a5,8
800005ec:	f89ff06f          	j	80000574 <Segmenter+0x1e8>
        }
      }

      enc_0_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
800005f0:	00000593          	li	a1,0
800005f4:	000d8513          	mv	a0,s11
800005f8:	7d0030ef          	jal	80003dc8 <__lesf2>
800005fc:	00055463          	bgez	a0,80000604 <Segmenter+0x278>
80000600:	00000d93          	li	s11,0
80000604:	01b92023          	sw	s11,0(s2)
    for(int i=0; i<ENC_0_CONV_RELU_1_N; i++){    // Iterate over the input matrix
80000608:	00148493          	add	s1,s1,1
8000060c:	02090913          	add	s2,s2,32
80000610:	f3749ee3          	bne	s1,s7,8000054c <Segmenter+0x1c0>
  for(int k=0; k<ENC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000614:	00340413          	add	s0,s0,3
80000618:	00498993          	add	s3,s3,4
8000061c:	f3a412e3          	bne	s0,s10,80000540 <Segmenter+0x1b4>
80000620:	fffecab7          	lui	s5,0xfffec
80000624:	000147b7          	lui	a5,0x14
80000628:	c00a8a93          	add	s5,s5,-1024 # fffebc00 <_timer_base+0x3ffebb00>
8000062c:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
80000630:	015787b3          	add	a5,a5,s5
80000634:	03010713          	add	a4,sp,48
80000638:	00e78ab3          	add	s5,a5,a4
8000063c:	000a8d13          	mv	s10,s5
80000640:	00000b93          	li	s7,0
  }

  //-----------------------------enc_0_maxpool----------------------------------
  for(int i=0; i<ENC_0_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<ENC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      enc_0_maxpool[i][k] = max(enc_0_conv_relu_1[2*i][k], enc_0_conv_relu_1[2*i+1][k]);
80000644:	02000493          	li	s1,32
  for(int i=0; i<ENC_0_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
80000648:	80000913          	li	s2,-2048
    for(int k=0; k<ENC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
8000064c:	417b0cb3          	sub	s9,s6,s7
  for(int k=0; k<ENC_0_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000650:	00000c13          	li	s8,0
      enc_0_maxpool[i][k] = max(enc_0_conv_relu_1[2*i][k], enc_0_conv_relu_1[2*i+1][k]);
80000654:	41748433          	sub	s0,s1,s7
80000658:	017c87b3          	add	a5,s9,s7
8000065c:	008787b3          	add	a5,a5,s0
80000660:	000ca983          	lw	s3,0(s9)
80000664:	0007ad83          	lw	s11,0(a5)
80000668:	00098513          	mv	a0,s3
8000066c:	000d8593          	mv	a1,s11
80000670:	6be030ef          	jal	80003d2e <__gesf2>
80000674:	00a05463          	blez	a0,8000067c <Segmenter+0x2f0>
80000678:	00098d93          	mv	s11,s3
8000067c:	018d07b3          	add	a5,s10,s8
80000680:	01b7a023          	sw	s11,0(a5)
    for(int k=0; k<ENC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000684:	004c0c13          	add	s8,s8,4
80000688:	004c8c93          	add	s9,s9,4
8000068c:	fc9c16e3          	bne	s8,s1,80000658 <Segmenter+0x2cc>
  for(int i=0; i<ENC_0_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
80000690:	fc0b8b93          	add	s7,s7,-64
80000694:	020d0d13          	add	s10,s10,32
80000698:	fb2b9ae3          	bne	s7,s2,8000064c <Segmenter+0x2c0>
8000069c:	00014737          	lui	a4,0x14
800006a0:	fffee7b7          	lui	a5,0xfffee
800006a4:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
800006a8:	00f70733          	add	a4,a4,a5
800006ac:	03010793          	add	a5,sp,48
800006b0:	00f707b3          	add	a5,a4,a5
800006b4:	00f12023          	sw	a5,0(sp)
800006b8:	00078993          	mv	s3,a5
800006bc:	00000413          	li	s0,0
    for(int i=0; i<ENC_1_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_1_CONV_RELU_0_K/2);
      l_max = min(ENC_1_CONV_RELU_0_N, i + ENC_1_CONV_RELU_0_K/2 + 1);
800006c0:	02000a13          	li	s4,32
  for(int k=0; k<ENC_1_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800006c4:	03000c13          	li	s8,48
  for(int k=0; k<ENC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800006c8:	00098913          	mv	s2,s3
    for(int i=0; i<ENC_1_CONV_RELU_0_N; i++){  // Iterate over the input matrix
800006cc:	00000493          	li	s1,0
800006d0:	00140b93          	add	s7,s0,1
      l_min = max(0, i - ENC_1_CONV_RELU_0_K/2);
800006d4:	fff48d93          	add	s11,s1,-1
800006d8:	000dd463          	bgez	s11,800006e0 <Segmenter+0x354>
800006dc:	00000d93          	li	s11,0
      l_max = min(ENC_1_CONV_RELU_0_N, i + ENC_1_CONV_RELU_0_K/2 + 1);
800006e0:	00248e13          	add	t3,s1,2
800006e4:	01ca5463          	bge	s4,t3,800006ec <Segmenter+0x360>
800006e8:	02000e13          	li	t3,32
      
      for(int l=l_min; l<l_max; l++){
800006ec:	409d8d33          	sub	s10,s11,s1
800006f0:	01ab8d33          	add	s10,s7,s10
800006f4:	003d1d13          	sll	s10,s10,0x3
      acc = 0; // Reset the accumulator
800006f8:	00000c93          	li	s9,0
      for(int l=l_min; l<l_max; l++){
800006fc:	07cdda63          	bge	s11,t3,80000770 <Segmenter+0x3e4>
        for(int j=0; j<ENC_1_CONV_RELU_0_INPUT_FEATURES; j++){
80000700:	00412783          	lw	a5,4(sp)
80000704:	005d9e93          	sll	t4,s11,0x5
80000708:	002d1313          	sll	t1,s10,0x2
8000070c:	015e8eb3          	add	t4,t4,s5
80000710:	00678333          	add	t1,a5,t1
      for(int l=l_min; l<l_max; l++){
80000714:	00000713          	li	a4,0
          acc += enc_0_maxpool[l][j]*enc_1_conv_relu_0_w[k*ENC_1_CONV_RELU_0_K*ENC_1_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_1_CONV_RELU_0_K/2)*ENC_1_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80000718:	00ee8533          	add	a0,t4,a4
8000071c:	00e305b3          	add	a1,t1,a4
80000720:	0005a583          	lw	a1,0(a1)
80000724:	00052503          	lw	a0,0(a0)
80000728:	03c12223          	sw	t3,36(sp)
8000072c:	03d12023          	sw	t4,32(sp)
80000730:	00e12e23          	sw	a4,28(sp)
80000734:	00612c23          	sw	t1,24(sp)
80000738:	72a030ef          	jal	80003e62 <__mulsf3>
8000073c:	00050593          	mv	a1,a0
80000740:	000c8513          	mv	a0,s9
80000744:	36f020ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<ENC_1_CONV_RELU_0_INPUT_FEATURES; j++){
80000748:	01c12703          	lw	a4,28(sp)
8000074c:	01812303          	lw	t1,24(sp)
80000750:	02012e83          	lw	t4,32(sp)
80000754:	00470713          	add	a4,a4,4
80000758:	02412e03          	lw	t3,36(sp)
          acc += enc_0_maxpool[l][j]*enc_1_conv_relu_0_w[k*ENC_1_CONV_RELU_0_K*ENC_1_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_1_CONV_RELU_0_K/2)*ENC_1_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
8000075c:	00050c93          	mv	s9,a0
        for(int j=0; j<ENC_1_CONV_RELU_0_INPUT_FEATURES; j++){
80000760:	fb471ce3          	bne	a4,s4,80000718 <Segmenter+0x38c>
      for(int l=l_min; l<l_max; l++){
80000764:	001d8d93          	add	s11,s11,1
80000768:	008d0d13          	add	s10,s10,8
8000076c:	f91ff06f          	j	800006fc <Segmenter+0x370>
        }
      }

      enc_1_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
80000770:	00000593          	li	a1,0
80000774:	000c8513          	mv	a0,s9
80000778:	650030ef          	jal	80003dc8 <__lesf2>
8000077c:	00055463          	bgez	a0,80000784 <Segmenter+0x3f8>
80000780:	00000c93          	li	s9,0
80000784:	01992023          	sw	s9,0(s2)
    for(int i=0; i<ENC_1_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80000788:	00148493          	add	s1,s1,1
8000078c:	04090913          	add	s2,s2,64
80000790:	f54492e3          	bne	s1,s4,800006d4 <Segmenter+0x348>
  for(int k=0; k<ENC_1_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000794:	00340413          	add	s0,s0,3
80000798:	00498993          	add	s3,s3,4
8000079c:	f38416e3          	bne	s0,s8,800006c8 <Segmenter+0x33c>
800007a0:	fffefa37          	lui	s4,0xfffef
800007a4:	000147b7          	lui	a5,0x14
800007a8:	800a0a13          	add	s4,s4,-2048 # fffee800 <_timer_base+0x3ffee700>
800007ac:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
800007b0:	014787b3          	add	a5,a5,s4
800007b4:	03010713          	add	a4,sp,48
800007b8:	00e78a33          	add	s4,a5,a4
800007bc:	000a0993          	mv	s3,s4
800007c0:	00000413          	li	s0,0
    for(int i=0; i<ENC_1_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_1_CONV_RELU_1_K/2);
      l_max = min(ENC_1_CONV_RELU_1_N, i + ENC_1_CONV_RELU_1_K/2 + 1);
800007c4:	02000a93          	li	s5,32

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_1_CONV_RELU_1_INPUT_FEATURES; j++){
800007c8:	04000c13          	li	s8,64
  for(int k=0; k<ENC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800007cc:	03000c93          	li	s9,48
  for(int i=0; i<ENC_0_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
800007d0:	00098913          	mv	s2,s3
    for(int i=0; i<ENC_1_CONV_RELU_1_N; i++){  // Iterate over the input matrix
800007d4:	00000493          	li	s1,0
800007d8:	00140b93          	add	s7,s0,1
      l_min = max(0, i - ENC_1_CONV_RELU_1_K/2);
800007dc:	fff48793          	add	a5,s1,-1
800007e0:	0007d463          	bgez	a5,800007e8 <Segmenter+0x45c>
800007e4:	00000793          	li	a5,0
      l_max = min(ENC_1_CONV_RELU_1_N, i + ENC_1_CONV_RELU_1_K/2 + 1);
800007e8:	00248e13          	add	t3,s1,2
800007ec:	01cad463          	bge	s5,t3,800007f4 <Segmenter+0x468>
800007f0:	02000e13          	li	t3,32
      for(int l=l_min; l<l_max; l++){
800007f4:	40978db3          	sub	s11,a5,s1
800007f8:	01bb8db3          	add	s11,s7,s11
800007fc:	004d9d93          	sll	s11,s11,0x4
      acc = 0; // Reset the accumulator
80000800:	00000d13          	li	s10,0
      for(int l=l_min; l<l_max; l++){
80000804:	09c7d063          	bge	a5,t3,80000884 <Segmenter+0x4f8>
        for(int j=0; j<ENC_1_CONV_RELU_1_INPUT_FEATURES; j++){
80000808:	00012703          	lw	a4,0(sp)
8000080c:	00679e93          	sll	t4,a5,0x6
80000810:	002d9313          	sll	t1,s11,0x2
80000814:	00ee8eb3          	add	t4,t4,a4
80000818:	00812703          	lw	a4,8(sp)
      for(int l=l_min; l<l_max; l++){
8000081c:	00000693          	li	a3,0
80000820:	00670333          	add	t1,a4,t1
          acc += enc_1_conv_relu_0[l][j]*enc_1_conv_relu_1_w[k*ENC_1_CONV_RELU_1_K*ENC_1_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_1_CONV_RELU_1_K/2)*ENC_1_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
80000824:	00de8533          	add	a0,t4,a3
80000828:	00d305b3          	add	a1,t1,a3
8000082c:	0005a583          	lw	a1,0(a1)
80000830:	00052503          	lw	a0,0(a0)
80000834:	03c12223          	sw	t3,36(sp)
80000838:	02f12023          	sw	a5,32(sp)
8000083c:	01d12e23          	sw	t4,28(sp)
80000840:	00d12c23          	sw	a3,24(sp)
80000844:	00612223          	sw	t1,4(sp)
80000848:	61a030ef          	jal	80003e62 <__mulsf3>
8000084c:	00050593          	mv	a1,a0
80000850:	000d0513          	mv	a0,s10
80000854:	25f020ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<ENC_1_CONV_RELU_1_INPUT_FEATURES; j++){
80000858:	01812683          	lw	a3,24(sp)
8000085c:	00412303          	lw	t1,4(sp)
80000860:	01c12e83          	lw	t4,28(sp)
80000864:	00468693          	add	a3,a3,4
80000868:	02012783          	lw	a5,32(sp)
8000086c:	02412e03          	lw	t3,36(sp)
          acc += enc_1_conv_relu_0[l][j]*enc_1_conv_relu_1_w[k*ENC_1_CONV_RELU_1_K*ENC_1_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_1_CONV_RELU_1_K/2)*ENC_1_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
80000870:	00050d13          	mv	s10,a0
        for(int j=0; j<ENC_1_CONV_RELU_1_INPUT_FEATURES; j++){
80000874:	fb8698e3          	bne	a3,s8,80000824 <Segmenter+0x498>
      for(int l=l_min; l<l_max; l++){
80000878:	00178793          	add	a5,a5,1
8000087c:	010d8d93          	add	s11,s11,16
80000880:	f85ff06f          	j	80000804 <Segmenter+0x478>
        }
      }

      enc_1_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
80000884:	00000593          	li	a1,0
80000888:	000d0513          	mv	a0,s10
8000088c:	53c030ef          	jal	80003dc8 <__lesf2>
80000890:	00055463          	bgez	a0,80000898 <Segmenter+0x50c>
80000894:	00000d13          	li	s10,0
80000898:	01a92023          	sw	s10,0(s2)
    for(int i=0; i<ENC_1_CONV_RELU_1_N; i++){  // Iterate over the input matrix
8000089c:	00148493          	add	s1,s1,1
800008a0:	04090913          	add	s2,s2,64
800008a4:	f3549ce3          	bne	s1,s5,800007dc <Segmenter+0x450>
  for(int k=0; k<ENC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800008a8:	00340413          	add	s0,s0,3
800008ac:	00498993          	add	s3,s3,4
800008b0:	f39410e3          	bne	s0,s9,800007d0 <Segmenter+0x444>
800008b4:	00014737          	lui	a4,0x14
800008b8:	fffec7b7          	lui	a5,0xfffec
800008bc:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
800008c0:	00f70733          	add	a4,a4,a5
800008c4:	03010793          	add	a5,sp,48
800008c8:	00f707b3          	add	a5,a4,a5
800008cc:	00f12223          	sw	a5,4(sp)
800008d0:	00078c13          	mv	s8,a5
800008d4:	00000993          	li	s3,0
  }

  //-----------------------------enc_1_maxpool----------------------------------
  for(int i=0; i<ENC_1_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<ENC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      enc_1_maxpool[i][k] = max(enc_1_conv_relu_1[2*i][k], enc_1_conv_relu_1[2*i+1][k]);
800008d8:	04000d13          	li	s10,64
  for(int i=0; i<ENC_1_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
800008dc:	80000493          	li	s1,-2048
    for(int k=0; k<ENC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800008e0:	413a0bb3          	sub	s7,s4,s3
  for(int k=0; k<ENC_1_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800008e4:	00000a93          	li	s5,0
      enc_1_maxpool[i][k] = max(enc_1_conv_relu_1[2*i][k], enc_1_conv_relu_1[2*i+1][k]);
800008e8:	413d0433          	sub	s0,s10,s3
800008ec:	013b87b3          	add	a5,s7,s3
800008f0:	008787b3          	add	a5,a5,s0
800008f4:	000bad83          	lw	s11,0(s7)
800008f8:	0007ac83          	lw	s9,0(a5) # fffec000 <_timer_base+0x3ffebf00>
800008fc:	000d8513          	mv	a0,s11
80000900:	000c8593          	mv	a1,s9
80000904:	42a030ef          	jal	80003d2e <__gesf2>
80000908:	00a05463          	blez	a0,80000910 <Segmenter+0x584>
8000090c:	000d8c93          	mv	s9,s11
80000910:	015c07b3          	add	a5,s8,s5
80000914:	0197a023          	sw	s9,0(a5)
    for(int k=0; k<ENC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000918:	004a8a93          	add	s5,s5,4
8000091c:	004b8b93          	add	s7,s7,4
80000920:	fdaa96e3          	bne	s5,s10,800008ec <Segmenter+0x560>
  for(int i=0; i<ENC_1_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
80000924:	f8098993          	add	s3,s3,-128
80000928:	040c0c13          	add	s8,s8,64
8000092c:	fa999ae3          	bne	s3,s1,800008e0 <Segmenter+0x554>
80000930:	00014737          	lui	a4,0x14
80000934:	fffef7b7          	lui	a5,0xfffef
80000938:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
8000093c:	00f70733          	add	a4,a4,a5
80000940:	03010793          	add	a5,sp,48
80000944:	00f707b3          	add	a5,a4,a5
80000948:	00f12023          	sw	a5,0(sp)
8000094c:	00078a93          	mv	s5,a5
80000950:	00000413          	li	s0,0
    for(int i=0; i<ENC_2_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_2_CONV_RELU_0_K/2);
      l_max = min(ENC_2_CONV_RELU_0_N, i + ENC_2_CONV_RELU_0_K/2 + 1);
80000954:	01000993          	li	s3,16

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_2_CONV_RELU_0_INPUT_FEATURES; j++){
80000958:	04000b93          	li	s7,64
  for(int k=0; k<ENC_2_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
8000095c:	06000c13          	li	s8,96
    for(int i=0; i<ENC_2_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80000960:	00140793          	add	a5,s0,1
  for(int k=0; k<ENC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000964:	000a8913          	mv	s2,s5
    for(int i=0; i<ENC_2_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80000968:	00000493          	li	s1,0
8000096c:	00f12423          	sw	a5,8(sp)
      l_min = max(0, i - ENC_2_CONV_RELU_0_K/2);
80000970:	fff48d93          	add	s11,s1,-1
80000974:	000dd463          	bgez	s11,8000097c <Segmenter+0x5f0>
80000978:	00000d93          	li	s11,0
      l_max = min(ENC_2_CONV_RELU_0_N, i + ENC_2_CONV_RELU_0_K/2 + 1);
8000097c:	00248313          	add	t1,s1,2
80000980:	0069d463          	bge	s3,t1,80000988 <Segmenter+0x5fc>
80000984:	01000313          	li	t1,16
      for(int l=l_min; l<l_max; l++){
80000988:	00812783          	lw	a5,8(sp)
8000098c:	409d8d33          	sub	s10,s11,s1
      acc = 0; // Reset the accumulator
80000990:	00000c93          	li	s9,0
80000994:	01a78d33          	add	s10,a5,s10
80000998:	004d1d13          	sll	s10,s10,0x4
      for(int l=l_min; l<l_max; l++){
8000099c:	066ddc63          	bge	s11,t1,80000a14 <Segmenter+0x688>
        for(int j=0; j<ENC_2_CONV_RELU_0_INPUT_FEATURES; j++){
800009a0:	00412783          	lw	a5,4(sp)
800009a4:	006d9e13          	sll	t3,s11,0x6
800009a8:	002d1893          	sll	a7,s10,0x2
800009ac:	00fe0e33          	add	t3,t3,a5
800009b0:	00c12783          	lw	a5,12(sp)
      for(int l=l_min; l<l_max; l++){
800009b4:	00000713          	li	a4,0
800009b8:	011788b3          	add	a7,a5,a7
          acc += enc_1_maxpool[l][j]*enc_2_conv_relu_0_w[k*ENC_2_CONV_RELU_0_K*ENC_2_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_2_CONV_RELU_0_K/2)*ENC_2_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
800009bc:	00ee0533          	add	a0,t3,a4
800009c0:	00e885b3          	add	a1,a7,a4
800009c4:	0005a583          	lw	a1,0(a1)
800009c8:	00052503          	lw	a0,0(a0)
800009cc:	02612223          	sw	t1,36(sp)
800009d0:	03c12023          	sw	t3,32(sp)
800009d4:	00e12e23          	sw	a4,28(sp)
800009d8:	01112c23          	sw	a7,24(sp)
800009dc:	486030ef          	jal	80003e62 <__mulsf3>
800009e0:	00050593          	mv	a1,a0
800009e4:	000c8513          	mv	a0,s9
800009e8:	0cb020ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<ENC_2_CONV_RELU_0_INPUT_FEATURES; j++){
800009ec:	01c12703          	lw	a4,28(sp)
800009f0:	01812883          	lw	a7,24(sp)
800009f4:	02012e03          	lw	t3,32(sp)
800009f8:	00470713          	add	a4,a4,4
800009fc:	02412303          	lw	t1,36(sp)
          acc += enc_1_maxpool[l][j]*enc_2_conv_relu_0_w[k*ENC_2_CONV_RELU_0_K*ENC_2_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_2_CONV_RELU_0_K/2)*ENC_2_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80000a00:	00050c93          	mv	s9,a0
        for(int j=0; j<ENC_2_CONV_RELU_0_INPUT_FEATURES; j++){
80000a04:	fb771ce3          	bne	a4,s7,800009bc <Segmenter+0x630>
      for(int l=l_min; l<l_max; l++){
80000a08:	001d8d93          	add	s11,s11,1
80000a0c:	010d0d13          	add	s10,s10,16
80000a10:	f8dff06f          	j	8000099c <Segmenter+0x610>
        }
      }

      enc_2_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
80000a14:	00000593          	li	a1,0
80000a18:	000c8513          	mv	a0,s9
80000a1c:	3ac030ef          	jal	80003dc8 <__lesf2>
80000a20:	00055463          	bgez	a0,80000a28 <Segmenter+0x69c>
80000a24:	00000c93          	li	s9,0
80000a28:	01992023          	sw	s9,0(s2)
    for(int i=0; i<ENC_2_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80000a2c:	00148493          	add	s1,s1,1
80000a30:	08090913          	add	s2,s2,128
80000a34:	f3349ee3          	bne	s1,s3,80000970 <Segmenter+0x5e4>
  for(int k=0; k<ENC_2_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000a38:	00340413          	add	s0,s0,3
80000a3c:	004a8a93          	add	s5,s5,4
80000a40:	f38410e3          	bne	s0,s8,80000960 <Segmenter+0x5d4>
80000a44:	ffff0937          	lui	s2,0xffff0
80000a48:	000147b7          	lui	a5,0x14
80000a4c:	80090913          	add	s2,s2,-2048 # fffef800 <_timer_base+0x3ffef700>
80000a50:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
80000a54:	012787b3          	add	a5,a5,s2
80000a58:	03010713          	add	a4,sp,48
80000a5c:	00e78933          	add	s2,a5,a4
80000a60:	00090b93          	mv	s7,s2
80000a64:	00000413          	li	s0,0
    for(int i=0; i<ENC_2_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_2_CONV_RELU_1_K/2);
      l_max = min(ENC_2_CONV_RELU_1_N, i + ENC_2_CONV_RELU_1_K/2 + 1);
80000a68:	01000993          	li	s3,16
  for(int k=0; k<ENC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000a6c:	06000c13          	li	s8,96
    for(int i=0; i<ENC_2_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80000a70:	00140793          	add	a5,s0,1
  for(int i=0; i<ENC_1_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
80000a74:	000b8a93          	mv	s5,s7
    for(int i=0; i<ENC_2_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80000a78:	00000493          	li	s1,0
80000a7c:	00f12223          	sw	a5,4(sp)
      l_min = max(0, i - ENC_2_CONV_RELU_1_K/2);
80000a80:	fff48d93          	add	s11,s1,-1
80000a84:	000dd463          	bgez	s11,80000a8c <Segmenter+0x700>
80000a88:	00000d93          	li	s11,0
      l_max = min(ENC_2_CONV_RELU_1_N, i + ENC_2_CONV_RELU_1_K/2 + 1);
80000a8c:	00248313          	add	t1,s1,2
80000a90:	0069d463          	bge	s3,t1,80000a98 <Segmenter+0x70c>
80000a94:	01000313          	li	t1,16

      for(int l=l_min; l<l_max; l++){
80000a98:	00412783          	lw	a5,4(sp)
80000a9c:	409d8d33          	sub	s10,s11,s1
      acc = 0; // Reset the accumulator
80000aa0:	00000c93          	li	s9,0
80000aa4:	01a78d33          	add	s10,a5,s10
80000aa8:	005d1d13          	sll	s10,s10,0x5
      for(int l=l_min; l<l_max; l++){
80000aac:	066dde63          	bge	s11,t1,80000b28 <Segmenter+0x79c>
        for(int j=0; j<ENC_2_CONV_RELU_1_INPUT_FEATURES; j++){
80000ab0:	00012783          	lw	a5,0(sp)
80000ab4:	007d9e13          	sll	t3,s11,0x7
80000ab8:	002d1893          	sll	a7,s10,0x2
80000abc:	00fe0e33          	add	t3,t3,a5
80000ac0:	01012783          	lw	a5,16(sp)
      for(int l=l_min; l<l_max; l++){
80000ac4:	00000713          	li	a4,0
80000ac8:	011788b3          	add	a7,a5,a7
          acc += enc_2_conv_relu_0[l][j]*enc_2_conv_relu_1_w[k*ENC_2_CONV_RELU_1_K*ENC_2_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_2_CONV_RELU_1_K/2)*ENC_2_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
80000acc:	00ee0533          	add	a0,t3,a4
80000ad0:	00e885b3          	add	a1,a7,a4
80000ad4:	0005a583          	lw	a1,0(a1)
80000ad8:	00052503          	lw	a0,0(a0)
80000adc:	00612e23          	sw	t1,28(sp)
80000ae0:	01c12c23          	sw	t3,24(sp)
80000ae4:	00e12623          	sw	a4,12(sp)
80000ae8:	01112423          	sw	a7,8(sp)
80000aec:	376030ef          	jal	80003e62 <__mulsf3>
80000af0:	00050593          	mv	a1,a0
80000af4:	000c8513          	mv	a0,s9
80000af8:	7ba020ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<ENC_2_CONV_RELU_1_INPUT_FEATURES; j++){
80000afc:	00c12703          	lw	a4,12(sp)
80000b00:	08000793          	li	a5,128
80000b04:	00812883          	lw	a7,8(sp)
80000b08:	00470713          	add	a4,a4,4
80000b0c:	01812e03          	lw	t3,24(sp)
80000b10:	01c12303          	lw	t1,28(sp)
          acc += enc_2_conv_relu_0[l][j]*enc_2_conv_relu_1_w[k*ENC_2_CONV_RELU_1_K*ENC_2_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_2_CONV_RELU_1_K/2)*ENC_2_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
80000b14:	00050c93          	mv	s9,a0
        for(int j=0; j<ENC_2_CONV_RELU_1_INPUT_FEATURES; j++){
80000b18:	faf71ae3          	bne	a4,a5,80000acc <Segmenter+0x740>
      for(int l=l_min; l<l_max; l++){
80000b1c:	001d8d93          	add	s11,s11,1
80000b20:	020d0d13          	add	s10,s10,32
80000b24:	f89ff06f          	j	80000aac <Segmenter+0x720>
        }
      }

      enc_2_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
80000b28:	00000593          	li	a1,0
80000b2c:	000c8513          	mv	a0,s9
80000b30:	298030ef          	jal	80003dc8 <__lesf2>
80000b34:	00055463          	bgez	a0,80000b3c <Segmenter+0x7b0>
80000b38:	00000c93          	li	s9,0
80000b3c:	019aa023          	sw	s9,0(s5)
    for(int i=0; i<ENC_2_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80000b40:	00148493          	add	s1,s1,1
80000b44:	080a8a93          	add	s5,s5,128
80000b48:	f3349ce3          	bne	s1,s3,80000a80 <Segmenter+0x6f4>
  for(int k=0; k<ENC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000b4c:	00340413          	add	s0,s0,3
80000b50:	004b8b93          	add	s7,s7,4
80000b54:	f1841ee3          	bne	s0,s8,80000a70 <Segmenter+0x6e4>
80000b58:	fffec4b7          	lui	s1,0xfffec
80000b5c:	000147b7          	lui	a5,0x14
80000b60:	40048493          	add	s1,s1,1024 # fffec400 <_timer_base+0x3ffec300>
80000b64:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
80000b68:	009787b3          	add	a5,a5,s1
80000b6c:	03010713          	add	a4,sp,48
80000b70:	00e784b3          	add	s1,a5,a4
80000b74:	00048c13          	mv	s8,s1
80000b78:	00000993          	li	s3,0
  }

  //-----------------------------enc_2_maxpool----------------------------------
  for(int i=0; i<ENC_2_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<ENC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      enc_2_maxpool[i][k] = max(enc_2_conv_relu_1[2*i][k], enc_2_conv_relu_1[2*i+1][k]);
80000b7c:	08000d13          	li	s10,128
    for(int k=0; k<ENC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000b80:	41390bb3          	sub	s7,s2,s3
  for(int k=0; k<ENC_2_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000b84:	00000a93          	li	s5,0
      enc_2_maxpool[i][k] = max(enc_2_conv_relu_1[2*i][k], enc_2_conv_relu_1[2*i+1][k]);
80000b88:	413d0433          	sub	s0,s10,s3
80000b8c:	013b87b3          	add	a5,s7,s3
80000b90:	008787b3          	add	a5,a5,s0
80000b94:	0007ac83          	lw	s9,0(a5)
80000b98:	000bad83          	lw	s11,0(s7)
80000b9c:	000c8593          	mv	a1,s9
80000ba0:	000d8513          	mv	a0,s11
80000ba4:	18a030ef          	jal	80003d2e <__gesf2>
80000ba8:	80000693          	li	a3,-2048
80000bac:	00a05463          	blez	a0,80000bb4 <Segmenter+0x828>
80000bb0:	000d8c93          	mv	s9,s11
80000bb4:	015c07b3          	add	a5,s8,s5
80000bb8:	0197a023          	sw	s9,0(a5)
    for(int k=0; k<ENC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000bbc:	004a8a93          	add	s5,s5,4
80000bc0:	004b8b93          	add	s7,s7,4
80000bc4:	fdaa94e3          	bne	s5,s10,80000b8c <Segmenter+0x800>
  for(int i=0; i<ENC_2_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
80000bc8:	f0098993          	add	s3,s3,-256
80000bcc:	080c0c13          	add	s8,s8,128
80000bd0:	fad998e3          	bne	s3,a3,80000b80 <Segmenter+0x7f4>
80000bd4:	00014737          	lui	a4,0x14
80000bd8:	ffff07b7          	lui	a5,0xffff0
80000bdc:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
80000be0:	00f70733          	add	a4,a4,a5
80000be4:	03010793          	add	a5,sp,48
80000be8:	00f707b3          	add	a5,a4,a5
80000bec:	00f12023          	sw	a5,0(sp)
80000bf0:	00078c13          	mv	s8,a5
80000bf4:	00000413          	li	s0,0
    for(int i=0; i<ENC_3_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_3_CONV_RELU_0_K/2);
      l_max = min(ENC_3_CONV_RELU_0_N, i + ENC_3_CONV_RELU_0_K/2 + 1);
80000bf8:	00800993          	li	s3,8
    for(int i=0; i<ENC_3_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80000bfc:	00140793          	add	a5,s0,1
  for(int k=0; k<ENC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000c00:	000c0b93          	mv	s7,s8
    for(int i=0; i<ENC_3_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80000c04:	00000a93          	li	s5,0
80000c08:	00f12223          	sw	a5,4(sp)
      l_min = max(0, i - ENC_3_CONV_RELU_0_K/2);
80000c0c:	fffa8d93          	add	s11,s5,-1
80000c10:	000dd463          	bgez	s11,80000c18 <Segmenter+0x88c>
80000c14:	00000d93          	li	s11,0
      l_max = min(ENC_3_CONV_RELU_0_N, i + ENC_3_CONV_RELU_0_K/2 + 1);
80000c18:	002a8313          	add	t1,s5,2
80000c1c:	0069d463          	bge	s3,t1,80000c24 <Segmenter+0x898>
80000c20:	00800313          	li	t1,8

      for(int l=l_min; l<l_max; l++){
80000c24:	00412783          	lw	a5,4(sp)
80000c28:	415d8d33          	sub	s10,s11,s5
      acc = 0; // Reset the accumulator
80000c2c:	00000c93          	li	s9,0
80000c30:	01a78d33          	add	s10,a5,s10
80000c34:	005d1d13          	sll	s10,s10,0x5
      for(int l=l_min; l<l_max; l++){
80000c38:	066ddc63          	bge	s11,t1,80000cb0 <Segmenter+0x924>
        for(int j=0; j<ENC_3_CONV_RELU_0_INPUT_FEATURES; j++){
80000c3c:	01412783          	lw	a5,20(sp)
80000c40:	007d9e13          	sll	t3,s11,0x7
80000c44:	002d1893          	sll	a7,s10,0x2
80000c48:	009e0e33          	add	t3,t3,s1
80000c4c:	011788b3          	add	a7,a5,a7
      for(int l=l_min; l<l_max; l++){
80000c50:	00000713          	li	a4,0
          acc += enc_2_maxpool[l][j]*enc_3_conv_relu_0_w[k*ENC_3_CONV_RELU_0_K*ENC_3_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_3_CONV_RELU_0_K/2)*ENC_3_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80000c54:	00ee0533          	add	a0,t3,a4
80000c58:	00e885b3          	add	a1,a7,a4
80000c5c:	0005a583          	lw	a1,0(a1)
80000c60:	00052503          	lw	a0,0(a0)
80000c64:	00612c23          	sw	t1,24(sp)
80000c68:	01c12823          	sw	t3,16(sp)
80000c6c:	00e12623          	sw	a4,12(sp)
80000c70:	01112423          	sw	a7,8(sp)
80000c74:	1ee030ef          	jal	80003e62 <__mulsf3>
80000c78:	00050593          	mv	a1,a0
80000c7c:	000c8513          	mv	a0,s9
80000c80:	632020ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<ENC_3_CONV_RELU_0_INPUT_FEATURES; j++){
80000c84:	00c12703          	lw	a4,12(sp)
80000c88:	08000793          	li	a5,128
80000c8c:	00812883          	lw	a7,8(sp)
80000c90:	00470713          	add	a4,a4,4
80000c94:	01012e03          	lw	t3,16(sp)
80000c98:	01812303          	lw	t1,24(sp)
          acc += enc_2_maxpool[l][j]*enc_3_conv_relu_0_w[k*ENC_3_CONV_RELU_0_K*ENC_3_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_3_CONV_RELU_0_K/2)*ENC_3_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80000c9c:	00050c93          	mv	s9,a0
        for(int j=0; j<ENC_3_CONV_RELU_0_INPUT_FEATURES; j++){
80000ca0:	faf71ae3          	bne	a4,a5,80000c54 <Segmenter+0x8c8>
      for(int l=l_min; l<l_max; l++){
80000ca4:	001d8d93          	add	s11,s11,1
80000ca8:	020d0d13          	add	s10,s10,32
80000cac:	f8dff06f          	j	80000c38 <Segmenter+0x8ac>
        }
      }

      enc_3_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
80000cb0:	00000593          	li	a1,0
80000cb4:	000c8513          	mv	a0,s9
80000cb8:	110030ef          	jal	80003dc8 <__lesf2>
80000cbc:	00055463          	bgez	a0,80000cc4 <Segmenter+0x938>
80000cc0:	00000c93          	li	s9,0
80000cc4:	019ba023          	sw	s9,0(s7)
    for(int i=0; i<ENC_3_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80000cc8:	001a8a93          	add	s5,s5,1
80000ccc:	100b8b93          	add	s7,s7,256
80000cd0:	f33a9ee3          	bne	s5,s3,80000c0c <Segmenter+0x880>
  for(int k=0; k<ENC_3_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000cd4:	00340413          	add	s0,s0,3
80000cd8:	0c000793          	li	a5,192
80000cdc:	004c0c13          	add	s8,s8,4
80000ce0:	f0f41ee3          	bne	s0,a5,80000bfc <Segmenter+0x870>
80000ce4:	ffff1437          	lui	s0,0xffff1
80000ce8:	000147b7          	lui	a5,0x14
80000cec:	80040413          	add	s0,s0,-2048 # ffff0800 <_timer_base+0x3fff0700>
80000cf0:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
80000cf4:	008787b3          	add	a5,a5,s0
80000cf8:	03010713          	add	a4,sp,48
80000cfc:	00e78433          	add	s0,a5,a4
80000d00:	00040b93          	mv	s7,s0
80000d04:	00000993          	li	s3,0
    for(int i=0; i<ENC_3_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_3_CONV_RELU_1_K/2);
      l_max = min(ENC_3_CONV_RELU_1_N, i + ENC_3_CONV_RELU_1_K/2 + 1);
80000d08:	00800493          	li	s1,8
    for(int i=0; i<ENC_3_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80000d0c:	00198793          	add	a5,s3,1
  for(int i=0; i<ENC_2_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
80000d10:	000b8a93          	mv	s5,s7
    for(int i=0; i<ENC_3_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80000d14:	00000d93          	li	s11,0
80000d18:	00f12223          	sw	a5,4(sp)
      l_min = max(0, i - ENC_3_CONV_RELU_1_K/2);
80000d1c:	fffd8d13          	add	s10,s11,-1
80000d20:	000d5463          	bgez	s10,80000d28 <Segmenter+0x99c>
80000d24:	00000d13          	li	s10,0
      l_max = min(ENC_3_CONV_RELU_1_N, i + ENC_3_CONV_RELU_1_K/2 + 1);
80000d28:	002d8893          	add	a7,s11,2
80000d2c:	0114d463          	bge	s1,a7,80000d34 <Segmenter+0x9a8>
80000d30:	00800893          	li	a7,8

      for(int l=l_min; l<l_max; l++){
80000d34:	00412783          	lw	a5,4(sp)
80000d38:	41bd0cb3          	sub	s9,s10,s11
      acc = 0; // Reset the accumulator
80000d3c:	00000c13          	li	s8,0
80000d40:	01978cb3          	add	s9,a5,s9
80000d44:	006c9c93          	sll	s9,s9,0x6
      for(int l=l_min; l<l_max; l++){
80000d48:	091d5663          	bge	s10,a7,80000dd4 <Segmenter+0xa48>
        for(int j=0; j<ENC_3_CONV_RELU_1_INPUT_FEATURES; j++){
80000d4c:	00012783          	lw	a5,0(sp)
80000d50:	008d1313          	sll	t1,s10,0x8
80000d54:	03010713          	add	a4,sp,48
80000d58:	00f30333          	add	t1,t1,a5
80000d5c:	000147b7          	lui	a5,0x14
80000d60:	44078793          	add	a5,a5,1088 # 14440 <_reset_entry-0x7ffebbc0>
80000d64:	00e787b3          	add	a5,a5,a4
80000d68:	0007a783          	lw	a5,0(a5)
80000d6c:	002c9813          	sll	a6,s9,0x2
80000d70:	01078833          	add	a6,a5,a6
      for(int l=l_min; l<l_max; l++){
80000d74:	00000793          	li	a5,0
          acc += enc_3_conv_relu_0[l][j]*enc_3_conv_relu_1_w[k*ENC_3_CONV_RELU_1_K*ENC_3_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_3_CONV_RELU_1_K/2)*ENC_3_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
80000d78:	00f30533          	add	a0,t1,a5
80000d7c:	00f805b3          	add	a1,a6,a5
80000d80:	0005a583          	lw	a1,0(a1)
80000d84:	00052503          	lw	a0,0(a0)
80000d88:	01112a23          	sw	a7,20(sp)
80000d8c:	00612823          	sw	t1,16(sp)
80000d90:	00f12623          	sw	a5,12(sp)
80000d94:	01012423          	sw	a6,8(sp)
80000d98:	0ca030ef          	jal	80003e62 <__mulsf3>
80000d9c:	00050593          	mv	a1,a0
80000da0:	000c0513          	mv	a0,s8
80000da4:	50e020ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<ENC_3_CONV_RELU_1_INPUT_FEATURES; j++){
80000da8:	00c12783          	lw	a5,12(sp)
80000dac:	10000713          	li	a4,256
80000db0:	00812803          	lw	a6,8(sp)
80000db4:	00478793          	add	a5,a5,4
80000db8:	01012303          	lw	t1,16(sp)
80000dbc:	01412883          	lw	a7,20(sp)
          acc += enc_3_conv_relu_0[l][j]*enc_3_conv_relu_1_w[k*ENC_3_CONV_RELU_1_K*ENC_3_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_3_CONV_RELU_1_K/2)*ENC_3_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
80000dc0:	00050c13          	mv	s8,a0
        for(int j=0; j<ENC_3_CONV_RELU_1_INPUT_FEATURES; j++){
80000dc4:	fae79ae3          	bne	a5,a4,80000d78 <Segmenter+0x9ec>
      for(int l=l_min; l<l_max; l++){
80000dc8:	001d0d13          	add	s10,s10,1
80000dcc:	040c8c93          	add	s9,s9,64
80000dd0:	f79ff06f          	j	80000d48 <Segmenter+0x9bc>
        }
      }

      enc_3_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
80000dd4:	00000593          	li	a1,0
80000dd8:	000c0513          	mv	a0,s8
80000ddc:	7ed020ef          	jal	80003dc8 <__lesf2>
80000de0:	00055463          	bgez	a0,80000de8 <Segmenter+0xa5c>
80000de4:	00000c13          	li	s8,0
80000de8:	018aa023          	sw	s8,0(s5)
    for(int i=0; i<ENC_3_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80000dec:	001d8d93          	add	s11,s11,1
80000df0:	100a8a93          	add	s5,s5,256
80000df4:	f29d94e3          	bne	s11,s1,80000d1c <Segmenter+0x990>
  for(int k=0; k<ENC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000df8:	00398993          	add	s3,s3,3
80000dfc:	0c000793          	li	a5,192
80000e00:	004b8b93          	add	s7,s7,4
80000e04:	f0f994e3          	bne	s3,a5,80000d0c <Segmenter+0x980>
80000e08:	fffed4b7          	lui	s1,0xfffed
80000e0c:	000147b7          	lui	a5,0x14
80000e10:	80048493          	add	s1,s1,-2048 # fffec800 <_timer_base+0x3ffec700>
80000e14:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
80000e18:	009787b3          	add	a5,a5,s1
80000e1c:	03010713          	add	a4,sp,48
80000e20:	00e784b3          	add	s1,a5,a4
80000e24:	00048c13          	mv	s8,s1
80000e28:	00000993          	li	s3,0
  }

  //-----------------------------enc_3_maxpool----------------------------------
  for(int i=0; i<ENC_3_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<ENC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      enc_3_maxpool[i][k] = max(enc_3_conv_relu_1[2*i][k], enc_3_conv_relu_1[2*i+1][k]);
80000e2c:	10000d13          	li	s10,256
    for(int k=0; k<ENC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000e30:	41340bb3          	sub	s7,s0,s3
  for(int k=0; k<ENC_3_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000e34:	00000a93          	li	s5,0
      enc_3_maxpool[i][k] = max(enc_3_conv_relu_1[2*i][k], enc_3_conv_relu_1[2*i+1][k]);
80000e38:	413d0733          	sub	a4,s10,s3
80000e3c:	013b87b3          	add	a5,s7,s3
80000e40:	00e787b3          	add	a5,a5,a4
80000e44:	0007ac83          	lw	s9,0(a5)
80000e48:	000bad83          	lw	s11,0(s7)
80000e4c:	00e12023          	sw	a4,0(sp)
80000e50:	000c8593          	mv	a1,s9
80000e54:	000d8513          	mv	a0,s11
80000e58:	6d7020ef          	jal	80003d2e <__gesf2>
80000e5c:	00012703          	lw	a4,0(sp)
80000e60:	80000693          	li	a3,-2048
80000e64:	00a05463          	blez	a0,80000e6c <Segmenter+0xae0>
80000e68:	000d8c93          	mv	s9,s11
80000e6c:	015c07b3          	add	a5,s8,s5
80000e70:	0197a023          	sw	s9,0(a5)
    for(int k=0; k<ENC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000e74:	004a8a93          	add	s5,s5,4
80000e78:	004b8b93          	add	s7,s7,4
80000e7c:	fdaa90e3          	bne	s5,s10,80000e3c <Segmenter+0xab0>
  for(int i=0; i<ENC_3_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
80000e80:	e0098993          	add	s3,s3,-512
80000e84:	100c0c13          	add	s8,s8,256
80000e88:	fad994e3          	bne	s3,a3,80000e30 <Segmenter+0xaa4>
80000e8c:	00014737          	lui	a4,0x14
80000e90:	ffff17b7          	lui	a5,0xffff1
80000e94:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
80000e98:	00f70733          	add	a4,a4,a5
80000e9c:	03010793          	add	a5,sp,48
80000ea0:	00f707b3          	add	a5,a4,a5
80000ea4:	00f12023          	sw	a5,0(sp)
80000ea8:	00078993          	mv	s3,a5
80000eac:	00000a93          	li	s5,0

  //--------------------------CENTRAL PART--------------------------------------

  //-------------------------central_conv_relu_0----------------------------------
  for(int k=0; k<CENTRAL_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<CENTRAL_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80000eb0:	001a8793          	add	a5,s5,1
  for(int k=0; k<ENC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000eb4:	00098c13          	mv	s8,s3
    for(int i=0; i<CENTRAL_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80000eb8:	00000b93          	li	s7,0
80000ebc:	00f12223          	sw	a5,4(sp)
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - CENTRAL_CONV_RELU_0_K/2);
80000ec0:	fffb8d93          	add	s11,s7,-1
80000ec4:	000dd463          	bgez	s11,80000ecc <Segmenter+0xb40>
80000ec8:	00000d93          	li	s11,0
      l_max = min(CENTRAL_CONV_RELU_0_N, i + CENTRAL_CONV_RELU_0_K/2 + 1);
80000ecc:	002b8313          	add	t1,s7,2
80000ed0:	00400793          	li	a5,4
80000ed4:	0067d463          	bge	a5,t1,80000edc <Segmenter+0xb50>
80000ed8:	00400313          	li	t1,4

      for(int l=l_min; l<l_max; l++){
80000edc:	00412783          	lw	a5,4(sp)
80000ee0:	417d8d33          	sub	s10,s11,s7
      acc = 0; // Reset the accumulator
80000ee4:	00000c93          	li	s9,0
80000ee8:	01a78d33          	add	s10,a5,s10
80000eec:	006d1d13          	sll	s10,s10,0x6
      for(int l=l_min; l<l_max; l++){
80000ef0:	086d8463          	beq	s11,t1,80000f78 <Segmenter+0xbec>
        for(int j=0; j<CENTRAL_CONV_RELU_0_INPUT_FEATURES; j++){
80000ef4:	000147b7          	lui	a5,0x14
80000ef8:	03010713          	add	a4,sp,48
80000efc:	44478793          	add	a5,a5,1092 # 14444 <_reset_entry-0x7ffebbbc>
80000f00:	00e787b3          	add	a5,a5,a4
80000f04:	0007a783          	lw	a5,0(a5)
80000f08:	008d9e13          	sll	t3,s11,0x8
80000f0c:	002d1893          	sll	a7,s10,0x2
80000f10:	009e0e33          	add	t3,t3,s1
80000f14:	011788b3          	add	a7,a5,a7
      for(int l=l_min; l<l_max; l++){
80000f18:	00000713          	li	a4,0
          acc += enc_3_maxpool[l][j]*central_conv_relu_0_w[k*CENTRAL_CONV_RELU_0_K*CENTRAL_CONV_RELU_0_INPUT_FEATURES+(l-i+CENTRAL_CONV_RELU_0_K/2)*CENTRAL_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80000f1c:	00ee0533          	add	a0,t3,a4
80000f20:	00e885b3          	add	a1,a7,a4
80000f24:	0005a583          	lw	a1,0(a1)
80000f28:	00052503          	lw	a0,0(a0)
80000f2c:	00612a23          	sw	t1,20(sp)
80000f30:	01c12823          	sw	t3,16(sp)
80000f34:	00e12623          	sw	a4,12(sp)
80000f38:	01112423          	sw	a7,8(sp)
80000f3c:	727020ef          	jal	80003e62 <__mulsf3>
80000f40:	00050593          	mv	a1,a0
80000f44:	000c8513          	mv	a0,s9
80000f48:	36a020ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<CENTRAL_CONV_RELU_0_INPUT_FEATURES; j++){
80000f4c:	00c12703          	lw	a4,12(sp)
80000f50:	10000793          	li	a5,256
80000f54:	00812883          	lw	a7,8(sp)
80000f58:	00470713          	add	a4,a4,4
80000f5c:	01012e03          	lw	t3,16(sp)
80000f60:	01412303          	lw	t1,20(sp)
          acc += enc_3_maxpool[l][j]*central_conv_relu_0_w[k*CENTRAL_CONV_RELU_0_K*CENTRAL_CONV_RELU_0_INPUT_FEATURES+(l-i+CENTRAL_CONV_RELU_0_K/2)*CENTRAL_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80000f64:	00050c93          	mv	s9,a0
        for(int j=0; j<CENTRAL_CONV_RELU_0_INPUT_FEATURES; j++){
80000f68:	faf71ae3          	bne	a4,a5,80000f1c <Segmenter+0xb90>
      for(int l=l_min; l<l_max; l++){
80000f6c:	001d8d93          	add	s11,s11,1
80000f70:	040d0d13          	add	s10,s10,64
80000f74:	f7dff06f          	j	80000ef0 <Segmenter+0xb64>
        }
      }
      central_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
80000f78:	00000593          	li	a1,0
80000f7c:	000c8513          	mv	a0,s9
80000f80:	649020ef          	jal	80003dc8 <__lesf2>
80000f84:	00055463          	bgez	a0,80000f8c <Segmenter+0xc00>
80000f88:	00000c93          	li	s9,0
80000f8c:	019c2023          	sw	s9,0(s8)
    for(int i=0; i<CENTRAL_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80000f90:	001b8b93          	add	s7,s7,1
80000f94:	00400793          	li	a5,4
80000f98:	200c0c13          	add	s8,s8,512
80000f9c:	f2fb92e3          	bne	s7,a5,80000ec0 <Segmenter+0xb34>
  for(int k=0; k<CENTRAL_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80000fa0:	003a8a93          	add	s5,s5,3
80000fa4:	18000793          	li	a5,384
80000fa8:	00498993          	add	s3,s3,4
80000fac:	f0fa92e3          	bne	s5,a5,80000eb0 <Segmenter+0xb24>
80000fb0:	ffff2c37          	lui	s8,0xffff2
80000fb4:	000147b7          	lui	a5,0x14
80000fb8:	800c0c13          	add	s8,s8,-2048 # ffff1800 <_timer_base+0x3fff1700>
80000fbc:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
80000fc0:	018787b3          	add	a5,a5,s8
80000fc4:	03010713          	add	a4,sp,48
80000fc8:	00e78c33          	add	s8,a5,a4
80000fcc:	000c0493          	mv	s1,s8
80000fd0:	00000993          	li	s3,0
    }  
  }

  //-------------------------central_conv_relu_1----------------------------------
  for(int k=0; k<CENTRAL_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<CENTRAL_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80000fd4:	00198793          	add	a5,s3,1
  for(int i=0; i<ENC_3_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
80000fd8:	00048b93          	mv	s7,s1
    for(int i=0; i<CENTRAL_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80000fdc:	00000a93          	li	s5,0
80000fe0:	00f12223          	sw	a5,4(sp)
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - CENTRAL_CONV_RELU_1_K/2);
80000fe4:	fffa8d93          	add	s11,s5,-1
80000fe8:	000dd463          	bgez	s11,80000ff0 <Segmenter+0xc64>
80000fec:	00000d93          	li	s11,0
      l_max = min(CENTRAL_CONV_RELU_1_N, i + CENTRAL_CONV_RELU_1_K/2 + 1);
80000ff0:	002a8313          	add	t1,s5,2
80000ff4:	00400793          	li	a5,4
80000ff8:	0067d463          	bge	a5,t1,80001000 <Segmenter+0xc74>
80000ffc:	00400313          	li	t1,4

      for(int l=l_min; l<l_max; l++){
80001000:	00412783          	lw	a5,4(sp)
80001004:	415d8d33          	sub	s10,s11,s5
      acc = 0; // Reset the accumulator
80001008:	00000c93          	li	s9,0
8000100c:	01a78d33          	add	s10,a5,s10
80001010:	007d1d13          	sll	s10,s10,0x7
      for(int l=l_min; l<l_max; l++){
80001014:	086d8663          	beq	s11,t1,800010a0 <Segmenter+0xd14>
        for(int j=0; j<CENTRAL_CONV_RELU_1_INPUT_FEATURES; j++){
80001018:	00012783          	lw	a5,0(sp)
8000101c:	009d9e13          	sll	t3,s11,0x9
80001020:	03010713          	add	a4,sp,48
80001024:	00fe0e33          	add	t3,t3,a5
80001028:	000147b7          	lui	a5,0x14
8000102c:	44878793          	add	a5,a5,1096 # 14448 <_reset_entry-0x7ffebbb8>
80001030:	00e787b3          	add	a5,a5,a4
80001034:	0007a783          	lw	a5,0(a5)
80001038:	002d1893          	sll	a7,s10,0x2
      for(int l=l_min; l<l_max; l++){
8000103c:	00000713          	li	a4,0
80001040:	011788b3          	add	a7,a5,a7
          acc += central_conv_relu_0[l][j]*central_conv_relu_1_w[k*CENTRAL_CONV_RELU_1_K*CENTRAL_CONV_RELU_1_INPUT_FEATURES+(l-i+CENTRAL_CONV_RELU_1_K/2)*CENTRAL_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
80001044:	00ee0533          	add	a0,t3,a4
80001048:	00e885b3          	add	a1,a7,a4
8000104c:	0005a583          	lw	a1,0(a1)
80001050:	00052503          	lw	a0,0(a0)
80001054:	00612a23          	sw	t1,20(sp)
80001058:	01c12823          	sw	t3,16(sp)
8000105c:	00e12623          	sw	a4,12(sp)
80001060:	01112423          	sw	a7,8(sp)
80001064:	5ff020ef          	jal	80003e62 <__mulsf3>
80001068:	00050593          	mv	a1,a0
8000106c:	000c8513          	mv	a0,s9
80001070:	242020ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<CENTRAL_CONV_RELU_1_INPUT_FEATURES; j++){
80001074:	00c12703          	lw	a4,12(sp)
80001078:	20000793          	li	a5,512
8000107c:	00812883          	lw	a7,8(sp)
80001080:	00470713          	add	a4,a4,4
80001084:	01012e03          	lw	t3,16(sp)
80001088:	01412303          	lw	t1,20(sp)
          acc += central_conv_relu_0[l][j]*central_conv_relu_1_w[k*CENTRAL_CONV_RELU_1_K*CENTRAL_CONV_RELU_1_INPUT_FEATURES+(l-i+CENTRAL_CONV_RELU_1_K/2)*CENTRAL_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
8000108c:	00050c93          	mv	s9,a0
        for(int j=0; j<CENTRAL_CONV_RELU_1_INPUT_FEATURES; j++){
80001090:	faf71ae3          	bne	a4,a5,80001044 <Segmenter+0xcb8>
      for(int l=l_min; l<l_max; l++){
80001094:	001d8d93          	add	s11,s11,1
80001098:	080d0d13          	add	s10,s10,128
8000109c:	f79ff06f          	j	80001014 <Segmenter+0xc88>
        }
      }

      central_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
800010a0:	00000593          	li	a1,0
800010a4:	000c8513          	mv	a0,s9
800010a8:	521020ef          	jal	80003dc8 <__lesf2>
800010ac:	00055463          	bgez	a0,800010b4 <Segmenter+0xd28>
800010b0:	00000c93          	li	s9,0
800010b4:	019ba023          	sw	s9,0(s7)
    for(int i=0; i<CENTRAL_CONV_RELU_1_N; i++){  // Iterate over the input matrix
800010b8:	001a8a93          	add	s5,s5,1
800010bc:	00400793          	li	a5,4
800010c0:	200b8b93          	add	s7,s7,512
800010c4:	f2fa90e3          	bne	s5,a5,80000fe4 <Segmenter+0xc58>
  for(int k=0; k<CENTRAL_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800010c8:	00398993          	add	s3,s3,3
800010cc:	18000793          	li	a5,384
800010d0:	00448493          	add	s1,s1,4
800010d4:	f0f990e3          	bne	s3,a5,80000fd4 <Segmenter+0xc48>
800010d8:	00014737          	lui	a4,0x14
800010dc:	ffff84b7          	lui	s1,0xffff8
800010e0:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
800010e4:	00970733          	add	a4,a4,s1
800010e8:	03010693          	add	a3,sp,48
800010ec:	00000793          	li	a5,0
800010f0:	00d704b3          	add	s1,a4,a3
  //-----------------------------DECODER 0--------------------------------------
  //-----------------------------dec_0_upsample---------------------------------
  for(int i=0; i<DEC_0_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_0_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_0_upsample[2*i][k] = central_conv_relu_1[i][k];
      dec_0_upsample[2*i+1][k] = central_conv_relu_1[i][k];
800010f4:	20000593          	li	a1,512
  for(int i=0; i<DEC_0_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
800010f8:	fffff8b7          	lui	a7,0xfffff
    for(int k=0; k<DEC_0_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
800010fc:	40f486b3          	sub	a3,s1,a5
  for(int k=0; k<CENTRAL_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001100:	00000713          	li	a4,0
      dec_0_upsample[2*i+1][k] = central_conv_relu_1[i][k];
80001104:	40f58833          	sub	a6,a1,a5
      dec_0_upsample[2*i][k] = central_conv_relu_1[i][k];
80001108:	00ec0633          	add	a2,s8,a4
8000110c:	00062503          	lw	a0,0(a2)
      dec_0_upsample[2*i+1][k] = central_conv_relu_1[i][k];
80001110:	00f68633          	add	a2,a3,a5
80001114:	01060633          	add	a2,a2,a6
      dec_0_upsample[2*i][k] = central_conv_relu_1[i][k];
80001118:	00a6a023          	sw	a0,0(a3)
      dec_0_upsample[2*i+1][k] = central_conv_relu_1[i][k];
8000111c:	00a62023          	sw	a0,0(a2)
    for(int k=0; k<DEC_0_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
80001120:	00470713          	add	a4,a4,4
80001124:	00468693          	add	a3,a3,4
80001128:	feb710e3          	bne	a4,a1,80001108 <Segmenter+0xd7c>
  for(int i=0; i<DEC_0_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
8000112c:	c0078793          	add	a5,a5,-1024
80001130:	200c0c13          	add	s8,s8,512
80001134:	fd1794e3          	bne	a5,a7,800010fc <Segmenter+0xd70>
80001138:	00014737          	lui	a4,0x14
8000113c:	ffff27b7          	lui	a5,0xffff2
80001140:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
80001144:	00f70733          	add	a4,a4,a5
80001148:	03010793          	add	a5,sp,48
8000114c:	00f707b3          	add	a5,a4,a5
80001150:	00f12223          	sw	a5,4(sp)
80001154:	00078993          	mv	s3,a5
80001158:	00000a93          	li	s5,0
    }
  }

  //-------------------------dec_0_up_conv_relu----------------------------------
  for(int k=0; k<DEC_0_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_0_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
8000115c:	001a8793          	add	a5,s5,1
80001160:	00098c13          	mv	s8,s3
80001164:	00000b93          	li	s7,0
80001168:	00f12023          	sw	a5,0(sp)
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_0_UP_CONV_RELU_K/2);
8000116c:	fffb8d93          	add	s11,s7,-1
80001170:	000dd463          	bgez	s11,80001178 <Segmenter+0xdec>
80001174:	00000d93          	li	s11,0
      l_max = min(DEC_0_UP_CONV_RELU_N, i + DEC_0_UP_CONV_RELU_K/2 + 1);
80001178:	002b8313          	add	t1,s7,2
8000117c:	00800793          	li	a5,8
80001180:	0067d463          	bge	a5,t1,80001188 <Segmenter+0xdfc>
80001184:	00800313          	li	t1,8

      for(int l=l_min; l<l_max; l++){
80001188:	00012783          	lw	a5,0(sp)
8000118c:	417d8d33          	sub	s10,s11,s7
      acc = 0; // Reset the accumulator
80001190:	00000c93          	li	s9,0
80001194:	01a78d33          	add	s10,a5,s10
80001198:	007d1d13          	sll	s10,s10,0x7
      for(int l=l_min; l<l_max; l++){
8000119c:	086dd463          	bge	s11,t1,80001224 <Segmenter+0xe98>
        for(int j=0; j<DEC_0_UP_CONV_RELU_INPUT_FEATURES; j++){
800011a0:	000147b7          	lui	a5,0x14
800011a4:	03010713          	add	a4,sp,48
800011a8:	44c78793          	add	a5,a5,1100 # 1444c <_reset_entry-0x7ffebbb4>
800011ac:	00e787b3          	add	a5,a5,a4
800011b0:	0007a783          	lw	a5,0(a5)
800011b4:	009d9e13          	sll	t3,s11,0x9
800011b8:	002d1893          	sll	a7,s10,0x2
800011bc:	009e0e33          	add	t3,t3,s1
800011c0:	011788b3          	add	a7,a5,a7
      for(int l=l_min; l<l_max; l++){
800011c4:	00000713          	li	a4,0
          acc += dec_0_upsample[l][j]*dec_0_up_conv_relu_w[k*DEC_0_UP_CONV_RELU_K*DEC_0_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_0_UP_CONV_RELU_K/2)*DEC_0_UP_CONV_RELU_INPUT_FEATURES+j];  // Multiply the input and the weight
800011c8:	00ee0533          	add	a0,t3,a4
800011cc:	00e885b3          	add	a1,a7,a4
800011d0:	0005a583          	lw	a1,0(a1)
800011d4:	00052503          	lw	a0,0(a0)
800011d8:	00612a23          	sw	t1,20(sp)
800011dc:	01c12823          	sw	t3,16(sp)
800011e0:	00e12623          	sw	a4,12(sp)
800011e4:	01112423          	sw	a7,8(sp)
800011e8:	47b020ef          	jal	80003e62 <__mulsf3>
800011ec:	00050593          	mv	a1,a0
800011f0:	000c8513          	mv	a0,s9
800011f4:	0be020ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<DEC_0_UP_CONV_RELU_INPUT_FEATURES; j++){
800011f8:	00c12703          	lw	a4,12(sp)
800011fc:	20000793          	li	a5,512
80001200:	00812883          	lw	a7,8(sp)
80001204:	00470713          	add	a4,a4,4
80001208:	01012e03          	lw	t3,16(sp)
8000120c:	01412303          	lw	t1,20(sp)
          acc += dec_0_upsample[l][j]*dec_0_up_conv_relu_w[k*DEC_0_UP_CONV_RELU_K*DEC_0_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_0_UP_CONV_RELU_K/2)*DEC_0_UP_CONV_RELU_INPUT_FEATURES+j];  // Multiply the input and the weight
80001210:	00050c93          	mv	s9,a0
        for(int j=0; j<DEC_0_UP_CONV_RELU_INPUT_FEATURES; j++){
80001214:	faf71ae3          	bne	a4,a5,800011c8 <Segmenter+0xe3c>
      for(int l=l_min; l<l_max; l++){
80001218:	001d8d93          	add	s11,s11,1
8000121c:	080d0d13          	add	s10,s10,128
80001220:	f7dff06f          	j	8000119c <Segmenter+0xe10>
        }
      }
      dec_0_up_conv_relu[i][k] = ReLU(acc); // Save the accumulator value
80001224:	00000593          	li	a1,0
80001228:	000c8513          	mv	a0,s9
8000122c:	39d020ef          	jal	80003dc8 <__lesf2>
80001230:	00055463          	bgez	a0,80001238 <Segmenter+0xeac>
80001234:	00000c93          	li	s9,0
80001238:	019c2023          	sw	s9,0(s8)
    for(int i=0; i<DEC_0_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
8000123c:	001b8b93          	add	s7,s7,1
80001240:	00800793          	li	a5,8
80001244:	100c0c13          	add	s8,s8,256
80001248:	f2fb92e3          	bne	s7,a5,8000116c <Segmenter+0xde0>
  for(int k=0; k<DEC_0_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
8000124c:	003a8a93          	add	s5,s5,3
80001250:	0c000793          	li	a5,192
80001254:	00498993          	add	s3,s3,4
80001258:	f0fa92e3          	bne	s5,a5,8000115c <Segmenter+0xdd0>
8000125c:	00014737          	lui	a4,0x14
80001260:	ffff97b7          	lui	a5,0xffff9
80001264:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
80001268:	00f70733          	add	a4,a4,a5
8000126c:	03010793          	add	a5,sp,48
80001270:	00f707b3          	add	a5,a4,a5
80001274:	00f12023          	sw	a5,0(sp)
80001278:	00078993          	mv	s3,a5
8000127c:	00000493          	li	s1,0
  }

  //--------------------------dec_0_concatenate---------------------------------
  for(int i=0; i<DEC_0_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_0_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_0_concatenate[i][k] = enc_3_conv_relu_1[i][k];
80001280:	008485b3          	add	a1,s1,s0
80001284:	10000613          	li	a2,256
80001288:	00098513          	mv	a0,s3
8000128c:	0e6040ef          	jal	80005372 <memcpy>
      dec_0_concatenate[i][k+DEC_0_UP_CONV_RELU_OUTPUT_FEATURES] = dec_0_up_conv_relu[i][k];
80001290:	00412783          	lw	a5,4(sp)
80001294:	10098513          	add	a0,s3,256
80001298:	10000613          	li	a2,256
8000129c:	00f485b3          	add	a1,s1,a5
800012a0:	0d2040ef          	jal	80005372 <memcpy>
  for(int i=0; i<DEC_0_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
800012a4:	10048493          	add	s1,s1,256 # ffff8100 <_timer_base+0x3fff8000>
800012a8:	80048793          	add	a5,s1,-2048
800012ac:	20098993          	add	s3,s3,512
800012b0:	fc0798e3          	bnez	a5,80001280 <Segmenter+0xef4>
800012b4:	ffff3437          	lui	s0,0xffff3
800012b8:	000147b7          	lui	a5,0x14
800012bc:	80040413          	add	s0,s0,-2048 # ffff2800 <_timer_base+0x3fff2700>
800012c0:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
800012c4:	008787b3          	add	a5,a5,s0
800012c8:	03010713          	add	a4,sp,48
800012cc:	00e78433          	add	s0,a5,a4
800012d0:	00040b93          	mv	s7,s0
800012d4:	00000993          	li	s3,0
    for(int i=0; i<DEC_0_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_0_CONV_RELU_0_K/2);
      l_max = min(DEC_0_CONV_RELU_0_N, i + DEC_0_CONV_RELU_0_K/2 + 1);
800012d8:	00800493          	li	s1,8
    for(int i=0; i<DEC_0_CONV_RELU_0_N; i++){  // Iterate over the input matrix
800012dc:	00198793          	add	a5,s3,1
  for(int k=0; k<DEC_0_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800012e0:	000b8a93          	mv	s5,s7
    for(int i=0; i<DEC_0_CONV_RELU_0_N; i++){  // Iterate over the input matrix
800012e4:	00000d93          	li	s11,0
800012e8:	00f12223          	sw	a5,4(sp)
      l_min = max(0, i - DEC_0_CONV_RELU_0_K/2);
800012ec:	fffd8d13          	add	s10,s11,-1
800012f0:	000d5463          	bgez	s10,800012f8 <Segmenter+0xf6c>
800012f4:	00000d13          	li	s10,0
      l_max = min(DEC_0_CONV_RELU_0_N, i + DEC_0_CONV_RELU_0_K/2 + 1);
800012f8:	002d8893          	add	a7,s11,2
800012fc:	0114d463          	bge	s1,a7,80001304 <Segmenter+0xf78>
80001300:	00800893          	li	a7,8

      for(int l=l_min; l<l_max; l++){
80001304:	00412783          	lw	a5,4(sp)
80001308:	41bd0cb3          	sub	s9,s10,s11
      acc = 0; // Reset the accumulator
8000130c:	00000c13          	li	s8,0
80001310:	01978cb3          	add	s9,a5,s9
80001314:	007c9c93          	sll	s9,s9,0x7
      for(int l=l_min; l<l_max; l++){
80001318:	091d5663          	bge	s10,a7,800013a4 <Segmenter+0x1018>
        for(int j=0; j<DEC_0_CONV_RELU_0_INPUT_FEATURES; j++){
8000131c:	00012783          	lw	a5,0(sp)
80001320:	009d1313          	sll	t1,s10,0x9
80001324:	03010713          	add	a4,sp,48
80001328:	00f30333          	add	t1,t1,a5
8000132c:	000147b7          	lui	a5,0x14
80001330:	45078793          	add	a5,a5,1104 # 14450 <_reset_entry-0x7ffebbb0>
80001334:	00e787b3          	add	a5,a5,a4
80001338:	0007a783          	lw	a5,0(a5)
8000133c:	002c9813          	sll	a6,s9,0x2
80001340:	01078833          	add	a6,a5,a6
      for(int l=l_min; l<l_max; l++){
80001344:	00000793          	li	a5,0
          acc += dec_0_concatenate[l][j]*dec_0_conv_relu_0_w[k*DEC_0_CONV_RELU_0_K*DEC_0_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_0_CONV_RELU_0_K/2)*DEC_0_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80001348:	00f30533          	add	a0,t1,a5
8000134c:	00f805b3          	add	a1,a6,a5
80001350:	0005a583          	lw	a1,0(a1)
80001354:	00052503          	lw	a0,0(a0)
80001358:	01112a23          	sw	a7,20(sp)
8000135c:	00612823          	sw	t1,16(sp)
80001360:	00f12623          	sw	a5,12(sp)
80001364:	01012423          	sw	a6,8(sp)
80001368:	2fb020ef          	jal	80003e62 <__mulsf3>
8000136c:	00050593          	mv	a1,a0
80001370:	000c0513          	mv	a0,s8
80001374:	73f010ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<DEC_0_CONV_RELU_0_INPUT_FEATURES; j++){
80001378:	00c12783          	lw	a5,12(sp)
8000137c:	20000713          	li	a4,512
80001380:	00812803          	lw	a6,8(sp)
80001384:	00478793          	add	a5,a5,4
80001388:	01012303          	lw	t1,16(sp)
8000138c:	01412883          	lw	a7,20(sp)
          acc += dec_0_concatenate[l][j]*dec_0_conv_relu_0_w[k*DEC_0_CONV_RELU_0_K*DEC_0_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_0_CONV_RELU_0_K/2)*DEC_0_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80001390:	00050c13          	mv	s8,a0
        for(int j=0; j<DEC_0_CONV_RELU_0_INPUT_FEATURES; j++){
80001394:	fae79ae3          	bne	a5,a4,80001348 <Segmenter+0xfbc>
      for(int l=l_min; l<l_max; l++){
80001398:	001d0d13          	add	s10,s10,1
8000139c:	080c8c93          	add	s9,s9,128
800013a0:	f79ff06f          	j	80001318 <Segmenter+0xf8c>
        }
      }
      dec_0_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
800013a4:	00000593          	li	a1,0
800013a8:	000c0513          	mv	a0,s8
800013ac:	21d020ef          	jal	80003dc8 <__lesf2>
800013b0:	00055463          	bgez	a0,800013b8 <Segmenter+0x102c>
800013b4:	00000c13          	li	s8,0
800013b8:	018aa023          	sw	s8,0(s5)
    for(int i=0; i<DEC_0_CONV_RELU_0_N; i++){  // Iterate over the input matrix
800013bc:	001d8d93          	add	s11,s11,1
800013c0:	100a8a93          	add	s5,s5,256
800013c4:	f29d94e3          	bne	s11,s1,800012ec <Segmenter+0xf60>
  for(int k=0; k<DEC_0_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800013c8:	00398993          	add	s3,s3,3
800013cc:	0c000793          	li	a5,192
800013d0:	004b8b93          	add	s7,s7,4
800013d4:	f0f994e3          	bne	s3,a5,800012dc <Segmenter+0xf50>
800013d8:	000147b7          	lui	a5,0x14
800013dc:	ffff3db7          	lui	s11,0xffff3
800013e0:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
800013e4:	01b787b3          	add	a5,a5,s11
800013e8:	03010713          	add	a4,sp,48
800013ec:	00e78db3          	add	s11,a5,a4
800013f0:	000d8493          	mv	s1,s11
800013f4:	00000993          	li	s3,0
    }  
  }

  //-------------------------dec_0_conv_relu_1----------------------------------
  for(int k=0; k<DEC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_0_CONV_RELU_1_N; i++){  // Iterate over the input matrix
800013f8:	00198793          	add	a5,s3,1
  for(int i=0; i<DEC_0_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
800013fc:	00048b93          	mv	s7,s1
    for(int i=0; i<DEC_0_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80001400:	00000a93          	li	s5,0
80001404:	00f12023          	sw	a5,0(sp)
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_0_CONV_RELU_1_K/2);
80001408:	fffa8d13          	add	s10,s5,-1
8000140c:	000d5463          	bgez	s10,80001414 <Segmenter+0x1088>
80001410:	00000d13          	li	s10,0
      l_max = min(DEC_0_CONV_RELU_1_N, i + DEC_0_CONV_RELU_1_K/2 + 1);
80001414:	002a8313          	add	t1,s5,2
80001418:	00800793          	li	a5,8
8000141c:	0067d463          	bge	a5,t1,80001424 <Segmenter+0x1098>
80001420:	00800313          	li	t1,8

      for(int l=l_min; l<l_max; l++){
80001424:	00012783          	lw	a5,0(sp)
80001428:	415d0cb3          	sub	s9,s10,s5
      acc = 0; // Reset the accumulator
8000142c:	00000c13          	li	s8,0
80001430:	01978cb3          	add	s9,a5,s9
80001434:	006c9c93          	sll	s9,s9,0x6
      for(int l=l_min; l<l_max; l++){
80001438:	086d5463          	bge	s10,t1,800014c0 <Segmenter+0x1134>
        for(int j=0; j<DEC_0_CONV_RELU_1_INPUT_FEATURES; j++){
8000143c:	000147b7          	lui	a5,0x14
80001440:	03010713          	add	a4,sp,48
80001444:	45478793          	add	a5,a5,1108 # 14454 <_reset_entry-0x7ffebbac>
80001448:	00e787b3          	add	a5,a5,a4
8000144c:	0007a783          	lw	a5,0(a5)
80001450:	008d1e13          	sll	t3,s10,0x8
80001454:	002c9893          	sll	a7,s9,0x2
80001458:	008e0e33          	add	t3,t3,s0
8000145c:	011788b3          	add	a7,a5,a7
      for(int l=l_min; l<l_max; l++){
80001460:	00000713          	li	a4,0
          acc += dec_0_conv_relu_0[l][j]*dec_0_conv_relu_1_w[k*DEC_0_CONV_RELU_1_K*DEC_0_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_0_CONV_RELU_1_K/2)*DEC_0_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
80001464:	00ee0533          	add	a0,t3,a4
80001468:	00e885b3          	add	a1,a7,a4
8000146c:	0005a583          	lw	a1,0(a1)
80001470:	00052503          	lw	a0,0(a0)
80001474:	00612823          	sw	t1,16(sp)
80001478:	01c12623          	sw	t3,12(sp)
8000147c:	00e12423          	sw	a4,8(sp)
80001480:	01112223          	sw	a7,4(sp)
80001484:	1df020ef          	jal	80003e62 <__mulsf3>
80001488:	00050593          	mv	a1,a0
8000148c:	000c0513          	mv	a0,s8
80001490:	623010ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<DEC_0_CONV_RELU_1_INPUT_FEATURES; j++){
80001494:	00812703          	lw	a4,8(sp)
80001498:	10000793          	li	a5,256
8000149c:	00412883          	lw	a7,4(sp)
800014a0:	00470713          	add	a4,a4,4
800014a4:	00c12e03          	lw	t3,12(sp)
800014a8:	01012303          	lw	t1,16(sp)
          acc += dec_0_conv_relu_0[l][j]*dec_0_conv_relu_1_w[k*DEC_0_CONV_RELU_1_K*DEC_0_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_0_CONV_RELU_1_K/2)*DEC_0_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
800014ac:	00050c13          	mv	s8,a0
        for(int j=0; j<DEC_0_CONV_RELU_1_INPUT_FEATURES; j++){
800014b0:	faf71ae3          	bne	a4,a5,80001464 <Segmenter+0x10d8>
      for(int l=l_min; l<l_max; l++){
800014b4:	001d0d13          	add	s10,s10,1
800014b8:	040c8c93          	add	s9,s9,64
800014bc:	f7dff06f          	j	80001438 <Segmenter+0x10ac>
        }
      }

      dec_0_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
800014c0:	00000593          	li	a1,0
800014c4:	000c0513          	mv	a0,s8
800014c8:	101020ef          	jal	80003dc8 <__lesf2>
800014cc:	00055463          	bgez	a0,800014d4 <Segmenter+0x1148>
800014d0:	00000c13          	li	s8,0
800014d4:	018ba023          	sw	s8,0(s7)
    for(int i=0; i<DEC_0_CONV_RELU_1_N; i++){  // Iterate over the input matrix
800014d8:	001a8a93          	add	s5,s5,1
800014dc:	00800793          	li	a5,8
800014e0:	100b8b93          	add	s7,s7,256
800014e4:	f2fa92e3          	bne	s5,a5,80001408 <Segmenter+0x107c>
  for(int k=0; k<DEC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800014e8:	00398993          	add	s3,s3,3
800014ec:	0c000793          	li	a5,192
800014f0:	00448493          	add	s1,s1,4
800014f4:	f0f992e3          	bne	s3,a5,800013f8 <Segmenter+0x106c>
800014f8:	00014737          	lui	a4,0x14
800014fc:	ffffa4b7          	lui	s1,0xffffa
80001500:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
80001504:	00970733          	add	a4,a4,s1
80001508:	03010693          	add	a3,sp,48
8000150c:	00000793          	li	a5,0
80001510:	00d704b3          	add	s1,a4,a3
  //-----------------------------DECODER 1--------------------------------------
  //-----------------------------dec_1_upsample---------------------------------
  for(int i=0; i<DEC_1_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_1_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_1_upsample[2*i][k] = dec_0_conv_relu_1[i][k];
      dec_1_upsample[2*i+1][k] = dec_0_conv_relu_1[i][k];
80001514:	10000593          	li	a1,256
  for(int i=0; i<DEC_1_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
80001518:	fffff8b7          	lui	a7,0xfffff
    for(int k=0; k<DEC_1_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
8000151c:	40f486b3          	sub	a3,s1,a5
  for(int k=0; k<DEC_0_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001520:	00000713          	li	a4,0
      dec_1_upsample[2*i+1][k] = dec_0_conv_relu_1[i][k];
80001524:	40f58833          	sub	a6,a1,a5
      dec_1_upsample[2*i][k] = dec_0_conv_relu_1[i][k];
80001528:	00ed8633          	add	a2,s11,a4
8000152c:	00062503          	lw	a0,0(a2)
      dec_1_upsample[2*i+1][k] = dec_0_conv_relu_1[i][k];
80001530:	00f68633          	add	a2,a3,a5
80001534:	01060633          	add	a2,a2,a6
      dec_1_upsample[2*i][k] = dec_0_conv_relu_1[i][k];
80001538:	00a6a023          	sw	a0,0(a3)
      dec_1_upsample[2*i+1][k] = dec_0_conv_relu_1[i][k];
8000153c:	00a62023          	sw	a0,0(a2)
    for(int k=0; k<DEC_1_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
80001540:	00470713          	add	a4,a4,4
80001544:	00468693          	add	a3,a3,4
80001548:	feb710e3          	bne	a4,a1,80001528 <Segmenter+0x119c>
  for(int i=0; i<DEC_1_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
8000154c:	e0078793          	add	a5,a5,-512
80001550:	100d8d93          	add	s11,s11,256 # ffff3100 <_timer_base+0x3fff3000>
80001554:	fd1794e3          	bne	a5,a7,8000151c <Segmenter+0x1190>
80001558:	ffff4437          	lui	s0,0xffff4
8000155c:	000147b7          	lui	a5,0x14
80001560:	80040413          	add	s0,s0,-2048 # ffff3800 <_timer_base+0x3fff3700>
80001564:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
80001568:	008787b3          	add	a5,a5,s0
8000156c:	03010713          	add	a4,sp,48
80001570:	00e78433          	add	s0,a5,a4
80001574:	00040993          	mv	s3,s0
80001578:	00000a93          	li	s5,0
    }
  }

  //-------------------------dec_1_up_conv_relu----------------------------------
  for(int k=0; k<DEC_1_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_1_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
8000157c:	001a8793          	add	a5,s5,1
80001580:	00098c13          	mv	s8,s3
80001584:	00000b93          	li	s7,0
80001588:	00f12023          	sw	a5,0(sp)
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_1_UP_CONV_RELU_K/2);
8000158c:	fffb8d93          	add	s11,s7,-1
80001590:	000dd463          	bgez	s11,80001598 <Segmenter+0x120c>
80001594:	00000d93          	li	s11,0
      l_max = min(DEC_1_UP_CONV_RELU_N, i + DEC_1_UP_CONV_RELU_K/2 + 1);
80001598:	002b8313          	add	t1,s7,2
8000159c:	01000793          	li	a5,16
800015a0:	0067d463          	bge	a5,t1,800015a8 <Segmenter+0x121c>
800015a4:	01000313          	li	t1,16

      for(int l=l_min; l<l_max; l++){
800015a8:	00012783          	lw	a5,0(sp)
800015ac:	417d8d33          	sub	s10,s11,s7
      acc = 0; // Reset the accumulator
800015b0:	00000c93          	li	s9,0
800015b4:	01a78d33          	add	s10,a5,s10
800015b8:	006d1d13          	sll	s10,s10,0x6
      for(int l=l_min; l<l_max; l++){
800015bc:	086dd463          	bge	s11,t1,80001644 <Segmenter+0x12b8>
        for(int j=0; j<DEC_1_UP_CONV_RELU_INPUT_FEATURES; j++){
800015c0:	000147b7          	lui	a5,0x14
800015c4:	03010713          	add	a4,sp,48
800015c8:	45878793          	add	a5,a5,1112 # 14458 <_reset_entry-0x7ffebba8>
800015cc:	00e787b3          	add	a5,a5,a4
800015d0:	0007a783          	lw	a5,0(a5)
800015d4:	008d9e13          	sll	t3,s11,0x8
800015d8:	002d1893          	sll	a7,s10,0x2
800015dc:	009e0e33          	add	t3,t3,s1
800015e0:	011788b3          	add	a7,a5,a7
      for(int l=l_min; l<l_max; l++){
800015e4:	00000713          	li	a4,0
          acc += dec_1_upsample[l][j]*dec_1_up_conv_relu_w[k*DEC_1_UP_CONV_RELU_K*DEC_1_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_1_UP_CONV_RELU_K/2)*DEC_1_UP_CONV_RELU_INPUT_FEATURES+j];  // Multiply the input and the weight
800015e8:	00ee0533          	add	a0,t3,a4
800015ec:	00e885b3          	add	a1,a7,a4
800015f0:	0005a583          	lw	a1,0(a1)
800015f4:	00052503          	lw	a0,0(a0)
800015f8:	00612823          	sw	t1,16(sp)
800015fc:	01c12623          	sw	t3,12(sp)
80001600:	00e12423          	sw	a4,8(sp)
80001604:	01112223          	sw	a7,4(sp)
80001608:	05b020ef          	jal	80003e62 <__mulsf3>
8000160c:	00050593          	mv	a1,a0
80001610:	000c8513          	mv	a0,s9
80001614:	49f010ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<DEC_1_UP_CONV_RELU_INPUT_FEATURES; j++){
80001618:	00812703          	lw	a4,8(sp)
8000161c:	10000793          	li	a5,256
80001620:	00412883          	lw	a7,4(sp)
80001624:	00470713          	add	a4,a4,4
80001628:	00c12e03          	lw	t3,12(sp)
8000162c:	01012303          	lw	t1,16(sp)
          acc += dec_1_upsample[l][j]*dec_1_up_conv_relu_w[k*DEC_1_UP_CONV_RELU_K*DEC_1_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_1_UP_CONV_RELU_K/2)*DEC_1_UP_CONV_RELU_INPUT_FEATURES+j];  // Multiply the input and the weight
80001630:	00050c93          	mv	s9,a0
        for(int j=0; j<DEC_1_UP_CONV_RELU_INPUT_FEATURES; j++){
80001634:	faf71ae3          	bne	a4,a5,800015e8 <Segmenter+0x125c>
      for(int l=l_min; l<l_max; l++){
80001638:	001d8d93          	add	s11,s11,1
8000163c:	040d0d13          	add	s10,s10,64
80001640:	f7dff06f          	j	800015bc <Segmenter+0x1230>
        }
      }

      dec_1_up_conv_relu[i][k] = ReLU(acc); // Save the accumulator value
80001644:	00000593          	li	a1,0
80001648:	000c8513          	mv	a0,s9
8000164c:	77c020ef          	jal	80003dc8 <__lesf2>
80001650:	00055463          	bgez	a0,80001658 <Segmenter+0x12cc>
80001654:	00000c93          	li	s9,0
80001658:	019c2023          	sw	s9,0(s8)
    for(int i=0; i<DEC_1_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
8000165c:	001b8b93          	add	s7,s7,1
80001660:	01000793          	li	a5,16
80001664:	080c0c13          	add	s8,s8,128
80001668:	f2fb92e3          	bne	s7,a5,8000158c <Segmenter+0x1200>
  for(int k=0; k<DEC_1_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
8000166c:	003a8a93          	add	s5,s5,3
80001670:	06000793          	li	a5,96
80001674:	00498993          	add	s3,s3,4
80001678:	f0fa92e3          	bne	s5,a5,8000157c <Segmenter+0x11f0>
8000167c:	00014737          	lui	a4,0x14
80001680:	ffffb7b7          	lui	a5,0xffffb
80001684:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
80001688:	00f70733          	add	a4,a4,a5
8000168c:	03010793          	add	a5,sp,48
80001690:	00f707b3          	add	a5,a4,a5
80001694:	00f12223          	sw	a5,4(sp)
80001698:	00078993          	mv	s3,a5
8000169c:	00000493          	li	s1,0
  }

  //--------------------------dec_1_concatenate---------------------------------
  for(int i=0; i<DEC_1_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_1_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_1_concatenate[i][k] = enc_2_conv_relu_1[i][k];
800016a0:	012485b3          	add	a1,s1,s2
800016a4:	08000613          	li	a2,128
800016a8:	00098513          	mv	a0,s3
800016ac:	4c7030ef          	jal	80005372 <memcpy>
      dec_1_concatenate[i][k+DEC_1_UP_CONV_RELU_OUTPUT_FEATURES] = dec_1_up_conv_relu[i][k];
800016b0:	008485b3          	add	a1,s1,s0
800016b4:	08098513          	add	a0,s3,128
800016b8:	08000613          	li	a2,128
800016bc:	4b7030ef          	jal	80005372 <memcpy>
  for(int i=0; i<DEC_1_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
800016c0:	08048493          	add	s1,s1,128 # ffffa080 <_timer_base+0x3fff9f80>
800016c4:	80048793          	add	a5,s1,-2048
800016c8:	10098993          	add	s3,s3,256
800016cc:	fc079ae3          	bnez	a5,800016a0 <Segmenter+0x1314>
800016d0:	00014737          	lui	a4,0x14
800016d4:	ffff47b7          	lui	a5,0xffff4
800016d8:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
800016dc:	00f70733          	add	a4,a4,a5
800016e0:	03010793          	add	a5,sp,48
800016e4:	00f707b3          	add	a5,a4,a5
800016e8:	00f12023          	sw	a5,0(sp)
800016ec:	00078913          	mv	s2,a5
800016f0:	00000d93          	li	s11,0
    for(int i=0; i<DEC_1_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_1_CONV_RELU_0_K/2);
      l_max = min(DEC_1_CONV_RELU_0_N, i + DEC_1_CONV_RELU_0_K/2 + 1);
800016f4:	01000413          	li	s0,16
  for(int k=0; k<DEC_1_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800016f8:	06000993          	li	s3,96
    for(int i=0; i<DEC_1_CONV_RELU_0_N; i++){  // Iterate over the input matrix
800016fc:	001d8793          	add	a5,s11,1
  for(int k=0; k<DEC_1_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001700:	00090493          	mv	s1,s2
    for(int i=0; i<DEC_1_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80001704:	00000c93          	li	s9,0
80001708:	00f12423          	sw	a5,8(sp)
      l_min = max(0, i - DEC_1_CONV_RELU_0_K/2);
8000170c:	fffc8c13          	add	s8,s9,-1
80001710:	000c5463          	bgez	s8,80001718 <Segmenter+0x138c>
80001714:	00000c13          	li	s8,0
      l_max = min(DEC_1_CONV_RELU_0_N, i + DEC_1_CONV_RELU_0_K/2 + 1);
80001718:	002c8613          	add	a2,s9,2
8000171c:	00c45463          	bge	s0,a2,80001724 <Segmenter+0x1398>
80001720:	01000613          	li	a2,16

      for(int l=l_min; l<l_max; l++){
80001724:	00812783          	lw	a5,8(sp)
80001728:	419c0bb3          	sub	s7,s8,s9
      acc = 0; // Reset the accumulator
8000172c:	00000a93          	li	s5,0
80001730:	01778bb3          	add	s7,a5,s7
80001734:	006b9b93          	sll	s7,s7,0x6
      for(int l=l_min; l<l_max; l++){
80001738:	08cc5263          	bge	s8,a2,800017bc <Segmenter+0x1430>
        for(int j=0; j<DEC_1_CONV_RELU_0_INPUT_FEATURES; j++){
8000173c:	00412783          	lw	a5,4(sp)
80001740:	008c1813          	sll	a6,s8,0x8
80001744:	03010713          	add	a4,sp,48
80001748:	00f80833          	add	a6,a6,a5
8000174c:	000147b7          	lui	a5,0x14
80001750:	45c78793          	add	a5,a5,1116 # 1445c <_reset_entry-0x7ffebba4>
80001754:	00e787b3          	add	a5,a5,a4
80001758:	0007a783          	lw	a5,0(a5)
8000175c:	002b9693          	sll	a3,s7,0x2
      for(int l=l_min; l<l_max; l++){
80001760:	00000d13          	li	s10,0
80001764:	00d786b3          	add	a3,a5,a3
          acc += dec_1_concatenate[l][j]*dec_1_conv_relu_0_w[k*DEC_1_CONV_RELU_0_K*DEC_1_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_1_CONV_RELU_0_K/2)*DEC_1_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80001768:	01a80533          	add	a0,a6,s10
8000176c:	01a685b3          	add	a1,a3,s10
80001770:	0005a583          	lw	a1,0(a1)
80001774:	00052503          	lw	a0,0(a0)
80001778:	00c12a23          	sw	a2,20(sp)
8000177c:	01012823          	sw	a6,16(sp)
80001780:	00d12623          	sw	a3,12(sp)
80001784:	6de020ef          	jal	80003e62 <__mulsf3>
80001788:	00050593          	mv	a1,a0
8000178c:	000a8513          	mv	a0,s5
80001790:	323010ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<DEC_1_CONV_RELU_0_INPUT_FEATURES; j++){
80001794:	004d0d13          	add	s10,s10,4
80001798:	10000793          	li	a5,256
8000179c:	00c12683          	lw	a3,12(sp)
800017a0:	01012803          	lw	a6,16(sp)
800017a4:	01412603          	lw	a2,20(sp)
          acc += dec_1_concatenate[l][j]*dec_1_conv_relu_0_w[k*DEC_1_CONV_RELU_0_K*DEC_1_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_1_CONV_RELU_0_K/2)*DEC_1_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
800017a8:	00050a93          	mv	s5,a0
        for(int j=0; j<DEC_1_CONV_RELU_0_INPUT_FEATURES; j++){
800017ac:	fafd1ee3          	bne	s10,a5,80001768 <Segmenter+0x13dc>
      for(int l=l_min; l<l_max; l++){
800017b0:	001c0c13          	add	s8,s8,1
800017b4:	040b8b93          	add	s7,s7,64
800017b8:	f81ff06f          	j	80001738 <Segmenter+0x13ac>
        }
      }

      dec_1_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
800017bc:	00000593          	li	a1,0
800017c0:	000a8513          	mv	a0,s5
800017c4:	604020ef          	jal	80003dc8 <__lesf2>
800017c8:	00055463          	bgez	a0,800017d0 <Segmenter+0x1444>
800017cc:	00000a93          	li	s5,0
800017d0:	0154a023          	sw	s5,0(s1)
    for(int i=0; i<DEC_1_CONV_RELU_0_N; i++){  // Iterate over the input matrix
800017d4:	001c8c93          	add	s9,s9,1
800017d8:	08048493          	add	s1,s1,128
800017dc:	f28c98e3          	bne	s9,s0,8000170c <Segmenter+0x1380>
  for(int k=0; k<DEC_1_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800017e0:	003d8d93          	add	s11,s11,3
800017e4:	00490913          	add	s2,s2,4
800017e8:	f13d9ae3          	bne	s11,s3,800016fc <Segmenter+0x1370>
800017ec:	ffff5ab7          	lui	s5,0xffff5
800017f0:	000147b7          	lui	a5,0x14
800017f4:	800a8a93          	add	s5,s5,-2048 # ffff4800 <_timer_base+0x3fff4700>
800017f8:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
800017fc:	015787b3          	add	a5,a5,s5
80001800:	03010713          	add	a4,sp,48
80001804:	00e78ab3          	add	s5,a5,a4
80001808:	000a8993          	mv	s3,s5
8000180c:	00000493          	li	s1,0
    for(int i=0; i<DEC_1_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_1_CONV_RELU_1_K/2);
      l_max = min(DEC_1_CONV_RELU_1_N, i + DEC_1_CONV_RELU_1_K/2 + 1);
80001810:	01000413          	li	s0,16
    for(int i=0; i<DEC_1_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80001814:	00148793          	add	a5,s1,1
  for(int i=0; i<DEC_1_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
80001818:	00098913          	mv	s2,s3
    for(int i=0; i<DEC_1_CONV_RELU_1_N; i++){  // Iterate over the input matrix
8000181c:	00000d13          	li	s10,0
80001820:	00f12223          	sw	a5,4(sp)
      l_min = max(0, i - DEC_1_CONV_RELU_1_K/2);
80001824:	fffd0c93          	add	s9,s10,-1
80001828:	000cd463          	bgez	s9,80001830 <Segmenter+0x14a4>
8000182c:	00000c93          	li	s9,0
      l_max = min(DEC_1_CONV_RELU_1_N, i + DEC_1_CONV_RELU_1_K/2 + 1);
80001830:	002d0813          	add	a6,s10,2
80001834:	01045463          	bge	s0,a6,8000183c <Segmenter+0x14b0>
80001838:	01000813          	li	a6,16

      for(int l=l_min; l<l_max; l++){
8000183c:	00412783          	lw	a5,4(sp)
80001840:	41ac8c33          	sub	s8,s9,s10
      acc = 0; // Reset the accumulator
80001844:	00000b93          	li	s7,0
80001848:	01878c33          	add	s8,a5,s8
8000184c:	005c1c13          	sll	s8,s8,0x5
      for(int l=l_min; l<l_max; l++){
80001850:	090cd263          	bge	s9,a6,800018d4 <Segmenter+0x1548>
        for(int j=0; j<DEC_1_CONV_RELU_1_INPUT_FEATURES; j++){
80001854:	00012783          	lw	a5,0(sp)
80001858:	007c9893          	sll	a7,s9,0x7
8000185c:	03010713          	add	a4,sp,48
80001860:	00f888b3          	add	a7,a7,a5
80001864:	000147b7          	lui	a5,0x14
80001868:	46078793          	add	a5,a5,1120 # 14460 <_reset_entry-0x7ffebba0>
8000186c:	00e787b3          	add	a5,a5,a4
80001870:	0007a783          	lw	a5,0(a5)
80001874:	002c1613          	sll	a2,s8,0x2
      for(int l=l_min; l<l_max; l++){
80001878:	00000d93          	li	s11,0
8000187c:	00c78633          	add	a2,a5,a2
          acc += dec_1_conv_relu_0[l][j]*dec_1_conv_relu_1_w[k*DEC_1_CONV_RELU_1_K*DEC_1_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_1_CONV_RELU_1_K/2)*DEC_1_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
80001880:	01b88533          	add	a0,a7,s11
80001884:	01b605b3          	add	a1,a2,s11
80001888:	0005a583          	lw	a1,0(a1)
8000188c:	00052503          	lw	a0,0(a0)
80001890:	01012823          	sw	a6,16(sp)
80001894:	01112623          	sw	a7,12(sp)
80001898:	00c12423          	sw	a2,8(sp)
8000189c:	5c6020ef          	jal	80003e62 <__mulsf3>
800018a0:	00050593          	mv	a1,a0
800018a4:	000b8513          	mv	a0,s7
800018a8:	20b010ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<DEC_1_CONV_RELU_1_INPUT_FEATURES; j++){
800018ac:	004d8d93          	add	s11,s11,4
800018b0:	08000793          	li	a5,128
800018b4:	00812603          	lw	a2,8(sp)
800018b8:	00c12883          	lw	a7,12(sp)
800018bc:	01012803          	lw	a6,16(sp)
          acc += dec_1_conv_relu_0[l][j]*dec_1_conv_relu_1_w[k*DEC_1_CONV_RELU_1_K*DEC_1_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_1_CONV_RELU_1_K/2)*DEC_1_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
800018c0:	00050b93          	mv	s7,a0
        for(int j=0; j<DEC_1_CONV_RELU_1_INPUT_FEATURES; j++){
800018c4:	fafd9ee3          	bne	s11,a5,80001880 <Segmenter+0x14f4>
      for(int l=l_min; l<l_max; l++){
800018c8:	001c8c93          	add	s9,s9,1
800018cc:	020c0c13          	add	s8,s8,32
800018d0:	f81ff06f          	j	80001850 <Segmenter+0x14c4>
        }
      }

      dec_1_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
800018d4:	00000593          	li	a1,0
800018d8:	000b8513          	mv	a0,s7
800018dc:	4ec020ef          	jal	80003dc8 <__lesf2>
800018e0:	00055463          	bgez	a0,800018e8 <Segmenter+0x155c>
800018e4:	00000b93          	li	s7,0
800018e8:	01792023          	sw	s7,0(s2)
    for(int i=0; i<DEC_1_CONV_RELU_1_N; i++){  // Iterate over the input matrix
800018ec:	001d0d13          	add	s10,s10,1
800018f0:	08090913          	add	s2,s2,128
800018f4:	f28d18e3          	bne	s10,s0,80001824 <Segmenter+0x1498>
  for(int k=0; k<DEC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800018f8:	00348493          	add	s1,s1,3
800018fc:	06000793          	li	a5,96
80001900:	00498993          	add	s3,s3,4
80001904:	f0f498e3          	bne	s1,a5,80001814 <Segmenter+0x1488>
80001908:	00014737          	lui	a4,0x14
8000190c:	ffffc437          	lui	s0,0xffffc
80001910:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
80001914:	00870733          	add	a4,a4,s0
80001918:	03010693          	add	a3,sp,48
8000191c:	00000793          	li	a5,0
80001920:	00d70433          	add	s0,a4,a3
  //-----------------------------DECODER 2--------------------------------------
  //-----------------------------dec_2_upsample---------------------------------
  for(int i=0; i<DEC_2_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_2_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_2_upsample[2*i][k] = dec_1_conv_relu_1[i][k];
      dec_2_upsample[2*i+1][k] = dec_1_conv_relu_1[i][k];
80001924:	08000593          	li	a1,128
  for(int i=0; i<DEC_2_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
80001928:	fffff8b7          	lui	a7,0xfffff
    for(int k=0; k<DEC_2_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
8000192c:	40f406b3          	sub	a3,s0,a5
  for(int k=0; k<DEC_1_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001930:	00000713          	li	a4,0
      dec_2_upsample[2*i+1][k] = dec_1_conv_relu_1[i][k];
80001934:	40f58833          	sub	a6,a1,a5
      dec_2_upsample[2*i][k] = dec_1_conv_relu_1[i][k];
80001938:	00ea8633          	add	a2,s5,a4
8000193c:	00062503          	lw	a0,0(a2)
      dec_2_upsample[2*i+1][k] = dec_1_conv_relu_1[i][k];
80001940:	00f68633          	add	a2,a3,a5
80001944:	01060633          	add	a2,a2,a6
      dec_2_upsample[2*i][k] = dec_1_conv_relu_1[i][k];
80001948:	00a6a023          	sw	a0,0(a3)
      dec_2_upsample[2*i+1][k] = dec_1_conv_relu_1[i][k];
8000194c:	00a62023          	sw	a0,0(a2)
    for(int k=0; k<DEC_2_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
80001950:	00470713          	add	a4,a4,4
80001954:	00468693          	add	a3,a3,4
80001958:	feb710e3          	bne	a4,a1,80001938 <Segmenter+0x15ac>
  for(int i=0; i<DEC_2_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
8000195c:	f0078793          	add	a5,a5,-256
80001960:	080a8a93          	add	s5,s5,128
80001964:	fd1794e3          	bne	a5,a7,8000192c <Segmenter+0x15a0>
80001968:	00014737          	lui	a4,0x14
8000196c:	ffff57b7          	lui	a5,0xffff5
80001970:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
80001974:	00f70733          	add	a4,a4,a5
80001978:	03010793          	add	a5,sp,48
8000197c:	00f707b3          	add	a5,a4,a5
80001980:	00f12223          	sw	a5,4(sp)
80001984:	00078a93          	mv	s5,a5
80001988:	00000913          	li	s2,0
    for(int i=0; i<DEC_2_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_2_UP_CONV_RELU_K/2);
      l_max = min(DEC_2_UP_CONV_RELU_N, i + DEC_2_UP_CONV_RELU_K/2 + 1);
8000198c:	02000493          	li	s1,32
    for(int i=0; i<DEC_2_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
80001990:	00190793          	add	a5,s2,1
80001994:	000a8993          	mv	s3,s5
80001998:	00000d13          	li	s10,0
8000199c:	00f12023          	sw	a5,0(sp)
      l_min = max(0, i - DEC_2_UP_CONV_RELU_K/2);
800019a0:	fffd0c93          	add	s9,s10,-1
800019a4:	000cd463          	bgez	s9,800019ac <Segmenter+0x1620>
800019a8:	00000c93          	li	s9,0
      l_max = min(DEC_2_UP_CONV_RELU_N, i + DEC_2_UP_CONV_RELU_K/2 + 1);
800019ac:	002d0813          	add	a6,s10,2
800019b0:	0104d463          	bge	s1,a6,800019b8 <Segmenter+0x162c>
800019b4:	02000813          	li	a6,32

      for(int l=l_min; l<l_max; l++){
800019b8:	00012783          	lw	a5,0(sp)
800019bc:	41ac8c33          	sub	s8,s9,s10
      acc = 0; // Reset the accumulator
800019c0:	00000b93          	li	s7,0
800019c4:	01878c33          	add	s8,a5,s8
800019c8:	005c1c13          	sll	s8,s8,0x5
      for(int l=l_min; l<l_max; l++){
800019cc:	090cd063          	bge	s9,a6,80001a4c <Segmenter+0x16c0>
        for(int j=0; j<DEC_2_UP_CONV_RELU_INPUT_FEATURES; j++){
800019d0:	000147b7          	lui	a5,0x14
800019d4:	46478793          	add	a5,a5,1124 # 14464 <_reset_entry-0x7ffebb9c>
800019d8:	03010713          	add	a4,sp,48
800019dc:	00e787b3          	add	a5,a5,a4
800019e0:	0007a783          	lw	a5,0(a5)
800019e4:	007c9893          	sll	a7,s9,0x7
800019e8:	002c1613          	sll	a2,s8,0x2
800019ec:	008888b3          	add	a7,a7,s0
800019f0:	00c78633          	add	a2,a5,a2
      for(int l=l_min; l<l_max; l++){
800019f4:	00000d93          	li	s11,0
          acc += dec_2_upsample[l][j]*dec_2_up_conv_relu_w[k*DEC_2_UP_CONV_RELU_K*DEC_2_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_2_UP_CONV_RELU_K/2)*DEC_2_UP_CONV_RELU_INPUT_FEATURES+j];  // Multiply the input and the weight
800019f8:	01b88533          	add	a0,a7,s11
800019fc:	01b605b3          	add	a1,a2,s11
80001a00:	0005a583          	lw	a1,0(a1)
80001a04:	00052503          	lw	a0,0(a0)
80001a08:	01012823          	sw	a6,16(sp)
80001a0c:	01112623          	sw	a7,12(sp)
80001a10:	00c12423          	sw	a2,8(sp)
80001a14:	44e020ef          	jal	80003e62 <__mulsf3>
80001a18:	00050593          	mv	a1,a0
80001a1c:	000b8513          	mv	a0,s7
80001a20:	093010ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<DEC_2_UP_CONV_RELU_INPUT_FEATURES; j++){
80001a24:	004d8d93          	add	s11,s11,4
80001a28:	08000793          	li	a5,128
80001a2c:	00812603          	lw	a2,8(sp)
80001a30:	00c12883          	lw	a7,12(sp)
80001a34:	01012803          	lw	a6,16(sp)
          acc += dec_2_upsample[l][j]*dec_2_up_conv_relu_w[k*DEC_2_UP_CONV_RELU_K*DEC_2_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_2_UP_CONV_RELU_K/2)*DEC_2_UP_CONV_RELU_INPUT_FEATURES+j];  // Multiply the input and the weight
80001a38:	00050b93          	mv	s7,a0
        for(int j=0; j<DEC_2_UP_CONV_RELU_INPUT_FEATURES; j++){
80001a3c:	fafd9ee3          	bne	s11,a5,800019f8 <Segmenter+0x166c>
      for(int l=l_min; l<l_max; l++){
80001a40:	001c8c93          	add	s9,s9,1
80001a44:	020c0c13          	add	s8,s8,32
80001a48:	f85ff06f          	j	800019cc <Segmenter+0x1640>
        }
      }

      dec_2_up_conv_relu[i][k] = ReLU(acc); // Save the accumulator value
80001a4c:	00000593          	li	a1,0
80001a50:	000b8513          	mv	a0,s7
80001a54:	374020ef          	jal	80003dc8 <__lesf2>
80001a58:	00055463          	bgez	a0,80001a60 <Segmenter+0x16d4>
80001a5c:	00000b93          	li	s7,0
80001a60:	0179a023          	sw	s7,0(s3)
    for(int i=0; i<DEC_2_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
80001a64:	001d0d13          	add	s10,s10,1
80001a68:	04098993          	add	s3,s3,64
80001a6c:	f29d1ae3          	bne	s10,s1,800019a0 <Segmenter+0x1614>
  for(int k=0; k<DEC_2_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001a70:	00390913          	add	s2,s2,3
80001a74:	03000793          	li	a5,48
80001a78:	004a8a93          	add	s5,s5,4
80001a7c:	f0f91ae3          	bne	s2,a5,80001990 <Segmenter+0x1604>
80001a80:	00014737          	lui	a4,0x14
80001a84:	ffffd7b7          	lui	a5,0xffffd
80001a88:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
80001a8c:	00f70733          	add	a4,a4,a5
80001a90:	03010793          	add	a5,sp,48
80001a94:	00f707b3          	add	a5,a4,a5
80001a98:	00f12023          	sw	a5,0(sp)
80001a9c:	00078493          	mv	s1,a5
80001aa0:	00000413          	li	s0,0
  }

  //--------------------------dec_2_concatenate---------------------------------
  for(int i=0; i<DEC_2_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_2_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_2_concatenate[i][k] = enc_1_conv_relu_1[i][k];
80001aa4:	014405b3          	add	a1,s0,s4
80001aa8:	04000613          	li	a2,64
80001aac:	00048513          	mv	a0,s1
80001ab0:	0c3030ef          	jal	80005372 <memcpy>
      dec_2_concatenate[i][k+DEC_2_UP_CONV_RELU_OUTPUT_FEATURES] = dec_2_up_conv_relu[i][k];
80001ab4:	00412783          	lw	a5,4(sp)
80001ab8:	04048513          	add	a0,s1,64
80001abc:	04000613          	li	a2,64
80001ac0:	00f405b3          	add	a1,s0,a5
80001ac4:	0af030ef          	jal	80005372 <memcpy>
  for(int i=0; i<DEC_2_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
80001ac8:	04040413          	add	s0,s0,64 # ffffc040 <_timer_base+0x3fffbf40>
80001acc:	80040793          	add	a5,s0,-2048
80001ad0:	08048493          	add	s1,s1,128
80001ad4:	fc0798e3          	bnez	a5,80001aa4 <Segmenter+0x1718>
80001ad8:	ffff6437          	lui	s0,0xffff6
80001adc:	000147b7          	lui	a5,0x14
80001ae0:	80040413          	add	s0,s0,-2048 # ffff5800 <_timer_base+0x3fff5700>
80001ae4:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
80001ae8:	008787b3          	add	a5,a5,s0
80001aec:	03010713          	add	a4,sp,48
80001af0:	00e78433          	add	s0,a5,a4
80001af4:	00040993          	mv	s3,s0
80001af8:	00000d93          	li	s11,0
    for(int i=0; i<DEC_2_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_2_CONV_RELU_0_K/2);
      l_max = min(DEC_2_CONV_RELU_0_N, i + DEC_2_CONV_RELU_0_K/2 + 1);
80001afc:	02000493          	li	s1,32
  for(int k=0; k<DEC_2_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001b00:	03000a13          	li	s4,48
    for(int i=0; i<DEC_2_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80001b04:	001d8793          	add	a5,s11,1
  for(int k=0; k<DEC_2_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001b08:	00098913          	mv	s2,s3
    for(int i=0; i<DEC_2_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80001b0c:	00000c93          	li	s9,0
80001b10:	00f12223          	sw	a5,4(sp)
      l_min = max(0, i - DEC_2_CONV_RELU_0_K/2);
80001b14:	fffc8c13          	add	s8,s9,-1
80001b18:	000c5463          	bgez	s8,80001b20 <Segmenter+0x1794>
80001b1c:	00000c13          	li	s8,0
      l_max = min(DEC_2_CONV_RELU_0_N, i + DEC_2_CONV_RELU_0_K/2 + 1);
80001b20:	002c8613          	add	a2,s9,2
80001b24:	00c4d463          	bge	s1,a2,80001b2c <Segmenter+0x17a0>
80001b28:	02000613          	li	a2,32

      for(int l=l_min; l<l_max; l++){
80001b2c:	00412783          	lw	a5,4(sp)
80001b30:	419c0bb3          	sub	s7,s8,s9
      acc = 0; // Reset the accumulator
80001b34:	00000a93          	li	s5,0
80001b38:	01778bb3          	add	s7,a5,s7
80001b3c:	005b9b93          	sll	s7,s7,0x5
      for(int l=l_min; l<l_max; l++){
80001b40:	08cc5263          	bge	s8,a2,80001bc4 <Segmenter+0x1838>
        for(int j=0; j<DEC_2_CONV_RELU_0_INPUT_FEATURES; j++){
80001b44:	00012783          	lw	a5,0(sp)
80001b48:	007c1813          	sll	a6,s8,0x7
80001b4c:	03010713          	add	a4,sp,48
80001b50:	00f80833          	add	a6,a6,a5
80001b54:	000147b7          	lui	a5,0x14
80001b58:	46878793          	add	a5,a5,1128 # 14468 <_reset_entry-0x7ffebb98>
80001b5c:	00e787b3          	add	a5,a5,a4
80001b60:	0007a783          	lw	a5,0(a5)
80001b64:	002b9693          	sll	a3,s7,0x2
      for(int l=l_min; l<l_max; l++){
80001b68:	00000d13          	li	s10,0
80001b6c:	00d786b3          	add	a3,a5,a3
          acc += dec_2_concatenate[l][j]*dec_2_conv_relu_0_w[k*DEC_2_CONV_RELU_0_K*DEC_2_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_2_CONV_RELU_0_K/2)*DEC_2_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80001b70:	01a80533          	add	a0,a6,s10
80001b74:	01a685b3          	add	a1,a3,s10
80001b78:	0005a583          	lw	a1,0(a1)
80001b7c:	00052503          	lw	a0,0(a0)
80001b80:	00c12823          	sw	a2,16(sp)
80001b84:	01012623          	sw	a6,12(sp)
80001b88:	00d12423          	sw	a3,8(sp)
80001b8c:	2d6020ef          	jal	80003e62 <__mulsf3>
80001b90:	00050593          	mv	a1,a0
80001b94:	000a8513          	mv	a0,s5
80001b98:	71a010ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<DEC_2_CONV_RELU_0_INPUT_FEATURES; j++){
80001b9c:	004d0d13          	add	s10,s10,4
80001ba0:	08000793          	li	a5,128
80001ba4:	00812683          	lw	a3,8(sp)
80001ba8:	00c12803          	lw	a6,12(sp)
80001bac:	01012603          	lw	a2,16(sp)
          acc += dec_2_concatenate[l][j]*dec_2_conv_relu_0_w[k*DEC_2_CONV_RELU_0_K*DEC_2_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_2_CONV_RELU_0_K/2)*DEC_2_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80001bb0:	00050a93          	mv	s5,a0
        for(int j=0; j<DEC_2_CONV_RELU_0_INPUT_FEATURES; j++){
80001bb4:	fafd1ee3          	bne	s10,a5,80001b70 <Segmenter+0x17e4>
      for(int l=l_min; l<l_max; l++){
80001bb8:	001c0c13          	add	s8,s8,1
80001bbc:	020b8b93          	add	s7,s7,32
80001bc0:	f81ff06f          	j	80001b40 <Segmenter+0x17b4>
        }
      }

      dec_2_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
80001bc4:	00000593          	li	a1,0
80001bc8:	000a8513          	mv	a0,s5
80001bcc:	1fc020ef          	jal	80003dc8 <__lesf2>
80001bd0:	00055463          	bgez	a0,80001bd8 <Segmenter+0x184c>
80001bd4:	00000a93          	li	s5,0
80001bd8:	01592023          	sw	s5,0(s2)
    for(int i=0; i<DEC_2_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80001bdc:	001c8c93          	add	s9,s9,1
80001be0:	04090913          	add	s2,s2,64
80001be4:	f29c98e3          	bne	s9,s1,80001b14 <Segmenter+0x1788>
  for(int k=0; k<DEC_2_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001be8:	003d8d93          	add	s11,s11,3
80001bec:	00498993          	add	s3,s3,4
80001bf0:	f14d9ae3          	bne	s11,s4,80001b04 <Segmenter+0x1778>
80001bf4:	000147b7          	lui	a5,0x14
80001bf8:	ffff6cb7          	lui	s9,0xffff6
80001bfc:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
80001c00:	019787b3          	add	a5,a5,s9
80001c04:	03010713          	add	a4,sp,48
80001c08:	00e78cb3          	add	s9,a5,a4
80001c0c:	000c8a13          	mv	s4,s9
80001c10:	00000913          	li	s2,0
    for(int i=0; i<DEC_2_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_2_CONV_RELU_1_K/2);
      l_max = min(DEC_2_CONV_RELU_1_N, i + DEC_2_CONV_RELU_1_K/2 + 1);
80001c14:	02000493          	li	s1,32
    for(int i=0; i<DEC_2_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80001c18:	00190793          	add	a5,s2,1
  for(int i=0; i<DEC_2_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
80001c1c:	000a0993          	mv	s3,s4
    for(int i=0; i<DEC_2_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80001c20:	00000d13          	li	s10,0
80001c24:	00f12023          	sw	a5,0(sp)
      l_min = max(0, i - DEC_2_CONV_RELU_1_K/2);
80001c28:	fffd0c13          	add	s8,s10,-1
80001c2c:	000c5463          	bgez	s8,80001c34 <Segmenter+0x18a8>
80001c30:	00000c13          	li	s8,0
      l_max = min(DEC_2_CONV_RELU_1_N, i + DEC_2_CONV_RELU_1_K/2 + 1);
80001c34:	002d0813          	add	a6,s10,2
80001c38:	0104d463          	bge	s1,a6,80001c40 <Segmenter+0x18b4>
80001c3c:	02000813          	li	a6,32

      for(int l=l_min; l<l_max; l++){
80001c40:	00012783          	lw	a5,0(sp)
80001c44:	41ac0bb3          	sub	s7,s8,s10
      acc = 0; // Reset the accumulator
80001c48:	00000a93          	li	s5,0
80001c4c:	01778bb3          	add	s7,a5,s7
80001c50:	004b9b93          	sll	s7,s7,0x4
      for(int l=l_min; l<l_max; l++){
80001c54:	090c5063          	bge	s8,a6,80001cd4 <Segmenter+0x1948>
        for(int j=0; j<DEC_2_CONV_RELU_1_INPUT_FEATURES; j++){
80001c58:	000147b7          	lui	a5,0x14
80001c5c:	46c78793          	add	a5,a5,1132 # 1446c <_reset_entry-0x7ffebb94>
80001c60:	03010713          	add	a4,sp,48
80001c64:	00e787b3          	add	a5,a5,a4
80001c68:	0007a783          	lw	a5,0(a5)
80001c6c:	006c1893          	sll	a7,s8,0x6
80001c70:	002b9613          	sll	a2,s7,0x2
80001c74:	008888b3          	add	a7,a7,s0
80001c78:	00c78633          	add	a2,a5,a2
      for(int l=l_min; l<l_max; l++){
80001c7c:	00000d93          	li	s11,0
          acc += dec_2_conv_relu_0[l][j]*dec_2_conv_relu_1_w[k*DEC_2_CONV_RELU_1_K*DEC_2_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_2_CONV_RELU_1_K/2)*DEC_2_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
80001c80:	01b88533          	add	a0,a7,s11
80001c84:	01b605b3          	add	a1,a2,s11
80001c88:	0005a583          	lw	a1,0(a1)
80001c8c:	00052503          	lw	a0,0(a0)
80001c90:	01012623          	sw	a6,12(sp)
80001c94:	01112423          	sw	a7,8(sp)
80001c98:	00c12223          	sw	a2,4(sp)
80001c9c:	1c6020ef          	jal	80003e62 <__mulsf3>
80001ca0:	00050593          	mv	a1,a0
80001ca4:	000a8513          	mv	a0,s5
80001ca8:	60a010ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<DEC_2_CONV_RELU_1_INPUT_FEATURES; j++){
80001cac:	004d8d93          	add	s11,s11,4
80001cb0:	04000793          	li	a5,64
80001cb4:	00412603          	lw	a2,4(sp)
80001cb8:	00812883          	lw	a7,8(sp)
80001cbc:	00c12803          	lw	a6,12(sp)
          acc += dec_2_conv_relu_0[l][j]*dec_2_conv_relu_1_w[k*DEC_2_CONV_RELU_1_K*DEC_2_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_2_CONV_RELU_1_K/2)*DEC_2_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
80001cc0:	00050a93          	mv	s5,a0
        for(int j=0; j<DEC_2_CONV_RELU_1_INPUT_FEATURES; j++){
80001cc4:	fafd9ee3          	bne	s11,a5,80001c80 <Segmenter+0x18f4>
      for(int l=l_min; l<l_max; l++){
80001cc8:	001c0c13          	add	s8,s8,1
80001ccc:	010b8b93          	add	s7,s7,16
80001cd0:	f85ff06f          	j	80001c54 <Segmenter+0x18c8>
        }
      }

      dec_2_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
80001cd4:	00000593          	li	a1,0
80001cd8:	000a8513          	mv	a0,s5
80001cdc:	0ec020ef          	jal	80003dc8 <__lesf2>
80001ce0:	00055463          	bgez	a0,80001ce8 <Segmenter+0x195c>
80001ce4:	00000a93          	li	s5,0
80001ce8:	0159a023          	sw	s5,0(s3)
    for(int i=0; i<DEC_2_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80001cec:	001d0d13          	add	s10,s10,1
80001cf0:	04098993          	add	s3,s3,64
80001cf4:	f29d1ae3          	bne	s10,s1,80001c28 <Segmenter+0x189c>
  for(int k=0; k<DEC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001cf8:	00390913          	add	s2,s2,3
80001cfc:	03000793          	li	a5,48
80001d00:	004a0a13          	add	s4,s4,4
80001d04:	f0f91ae3          	bne	s2,a5,80001c18 <Segmenter+0x188c>
80001d08:	00014737          	lui	a4,0x14
80001d0c:	ffffe4b7          	lui	s1,0xffffe
80001d10:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
80001d14:	00970733          	add	a4,a4,s1
80001d18:	03010693          	add	a3,sp,48
80001d1c:	00000793          	li	a5,0
80001d20:	00d704b3          	add	s1,a4,a3
  //-----------------------------DECODER 3--------------------------------------
  //-----------------------------dec_3_upsample---------------------------------
  for(int i=0; i<DEC_3_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_3_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_3_upsample[2*i][k] = dec_2_conv_relu_1[i][k];
      dec_3_upsample[2*i+1][k] = dec_2_conv_relu_1[i][k];
80001d24:	04000593          	li	a1,64
  for(int i=0; i<DEC_3_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
80001d28:	fffff8b7          	lui	a7,0xfffff
    for(int k=0; k<DEC_3_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
80001d2c:	40f486b3          	sub	a3,s1,a5
  for(int k=0; k<DEC_2_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001d30:	00000713          	li	a4,0
      dec_3_upsample[2*i+1][k] = dec_2_conv_relu_1[i][k];
80001d34:	40f58833          	sub	a6,a1,a5
      dec_3_upsample[2*i][k] = dec_2_conv_relu_1[i][k];
80001d38:	00ec8633          	add	a2,s9,a4
80001d3c:	00062503          	lw	a0,0(a2)
      dec_3_upsample[2*i+1][k] = dec_2_conv_relu_1[i][k];
80001d40:	00f68633          	add	a2,a3,a5
80001d44:	01060633          	add	a2,a2,a6
      dec_3_upsample[2*i][k] = dec_2_conv_relu_1[i][k];
80001d48:	00a6a023          	sw	a0,0(a3)
      dec_3_upsample[2*i+1][k] = dec_2_conv_relu_1[i][k];
80001d4c:	00a62023          	sw	a0,0(a2)
    for(int k=0; k<DEC_3_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
80001d50:	00470713          	add	a4,a4,4
80001d54:	00468693          	add	a3,a3,4
80001d58:	feb710e3          	bne	a4,a1,80001d38 <Segmenter+0x19ac>
  for(int i=0; i<DEC_3_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
80001d5c:	f8078793          	add	a5,a5,-128
80001d60:	040c8c93          	add	s9,s9,64 # ffff6040 <_timer_base+0x3fff5f40>
80001d64:	fd1794e3          	bne	a5,a7,80001d2c <Segmenter+0x19a0>
80001d68:	ffff7937          	lui	s2,0xffff7
80001d6c:	000147b7          	lui	a5,0x14
80001d70:	80090913          	add	s2,s2,-2048 # ffff6800 <_timer_base+0x3fff6700>
80001d74:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
80001d78:	012787b3          	add	a5,a5,s2
80001d7c:	03010713          	add	a4,sp,48
80001d80:	00e78933          	add	s2,a5,a4
80001d84:	00090d93          	mv	s11,s2
80001d88:	00000c93          	li	s9,0
    for(int i=0; i<DEC_3_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_3_UP_CONV_RELU_K/2);
      l_max = min(DEC_3_UP_CONV_RELU_N, i + DEC_3_UP_CONV_RELU_K/2 + 1);
80001d8c:	04000993          	li	s3,64
  for(int k=0; k<DEC_3_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001d90:	01800a13          	li	s4,24
    for(int i=0; i<DEC_3_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
80001d94:	001c8793          	add	a5,s9,1
80001d98:	000d8d13          	mv	s10,s11
80001d9c:	00000b93          	li	s7,0
80001da0:	00f12023          	sw	a5,0(sp)
      l_min = max(0, i - DEC_3_UP_CONV_RELU_K/2);
80001da4:	fffb8a93          	add	s5,s7,-1
80001da8:	000ad463          	bgez	s5,80001db0 <Segmenter+0x1a24>
80001dac:	00000a93          	li	s5,0
      l_max = min(DEC_3_UP_CONV_RELU_N, i + DEC_3_UP_CONV_RELU_K/2 + 1);
80001db0:	002b8813          	add	a6,s7,2
80001db4:	0109d463          	bge	s3,a6,80001dbc <Segmenter+0x1a30>
80001db8:	04000813          	li	a6,64

      for(int l=l_min; l<l_max; l++){
80001dbc:	00012703          	lw	a4,0(sp)
80001dc0:	417a87b3          	sub	a5,s5,s7
      acc = 0; // Reset the accumulator
80001dc4:	00000413          	li	s0,0
80001dc8:	00e787b3          	add	a5,a5,a4
80001dcc:	00479793          	sll	a5,a5,0x4
      for(int l=l_min; l<l_max; l++){
80001dd0:	090ad263          	bge	s5,a6,80001e54 <Segmenter+0x1ac8>
        for(int j=0; j<DEC_3_UP_CONV_RELU_INPUT_FEATURES; j++){
80001dd4:	00014737          	lui	a4,0x14
80001dd8:	47070713          	add	a4,a4,1136 # 14470 <_reset_entry-0x7ffebb90>
80001ddc:	03010593          	add	a1,sp,48
80001de0:	00b70733          	add	a4,a4,a1
80001de4:	00072703          	lw	a4,0(a4)
80001de8:	006a9613          	sll	a2,s5,0x6
80001dec:	00279693          	sll	a3,a5,0x2
80001df0:	00960633          	add	a2,a2,s1
80001df4:	00d706b3          	add	a3,a4,a3
      for(int l=l_min; l<l_max; l++){
80001df8:	00000c13          	li	s8,0
          acc += dec_3_upsample[l][j]*dec_3_up_conv_relu_w[k*DEC_3_UP_CONV_RELU_K*DEC_3_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_3_UP_CONV_RELU_K/2)*DEC_3_UP_CONV_RELU_INPUT_FEATURES+j];  // Multiply the input and the weight
80001dfc:	01860533          	add	a0,a2,s8
80001e00:	018685b3          	add	a1,a3,s8
80001e04:	0005a583          	lw	a1,0(a1)
80001e08:	00052503          	lw	a0,0(a0)
80001e0c:	01012823          	sw	a6,16(sp)
80001e10:	00f12623          	sw	a5,12(sp)
80001e14:	00c12423          	sw	a2,8(sp)
80001e18:	00d12223          	sw	a3,4(sp)
80001e1c:	046020ef          	jal	80003e62 <__mulsf3>
80001e20:	00050593          	mv	a1,a0
80001e24:	00040513          	mv	a0,s0
80001e28:	48a010ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<DEC_3_UP_CONV_RELU_INPUT_FEATURES; j++){
80001e2c:	004c0c13          	add	s8,s8,4
80001e30:	00412683          	lw	a3,4(sp)
80001e34:	00812603          	lw	a2,8(sp)
80001e38:	00c12783          	lw	a5,12(sp)
80001e3c:	01012803          	lw	a6,16(sp)
          acc += dec_3_upsample[l][j]*dec_3_up_conv_relu_w[k*DEC_3_UP_CONV_RELU_K*DEC_3_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_3_UP_CONV_RELU_K/2)*DEC_3_UP_CONV_RELU_INPUT_FEATURES+j];  // Multiply the input and the weight
80001e40:	00050413          	mv	s0,a0
        for(int j=0; j<DEC_3_UP_CONV_RELU_INPUT_FEATURES; j++){
80001e44:	fb3c1ce3          	bne	s8,s3,80001dfc <Segmenter+0x1a70>
      for(int l=l_min; l<l_max; l++){
80001e48:	001a8a93          	add	s5,s5,1
80001e4c:	01078793          	add	a5,a5,16
80001e50:	f81ff06f          	j	80001dd0 <Segmenter+0x1a44>
        }
      }

      dec_3_up_conv_relu[i][k] = ReLU(acc); // Save the accumulator value
80001e54:	00000593          	li	a1,0
80001e58:	00040513          	mv	a0,s0
80001e5c:	76d010ef          	jal	80003dc8 <__lesf2>
80001e60:	00055463          	bgez	a0,80001e68 <Segmenter+0x1adc>
80001e64:	00000413          	li	s0,0
80001e68:	008d2023          	sw	s0,0(s10)
    for(int i=0; i<DEC_3_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
80001e6c:	001b8b93          	add	s7,s7,1
80001e70:	020d0d13          	add	s10,s10,32
80001e74:	f33b98e3          	bne	s7,s3,80001da4 <Segmenter+0x1a18>
  for(int k=0; k<DEC_3_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001e78:	003c8c93          	add	s9,s9,3
80001e7c:	004d8d93          	add	s11,s11,4
80001e80:	f14c9ae3          	bne	s9,s4,80001d94 <Segmenter+0x1a08>
80001e84:	00014737          	lui	a4,0x14
80001e88:	fffff7b7          	lui	a5,0xfffff
80001e8c:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
80001e90:	00f70733          	add	a4,a4,a5
80001e94:	03010793          	add	a5,sp,48
80001e98:	00f707b3          	add	a5,a4,a5
80001e9c:	00f12023          	sw	a5,0(sp)
80001ea0:	00078493          	mv	s1,a5
80001ea4:	00000413          	li	s0,0
  }

  //--------------------------dec_3_concatenate---------------------------------
  for(int i=0; i<DEC_3_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_3_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_3_concatenate[i][k] = enc_0_conv_relu_1[i][k];
80001ea8:	016405b3          	add	a1,s0,s6
80001eac:	02000613          	li	a2,32
80001eb0:	00048513          	mv	a0,s1
80001eb4:	4be030ef          	jal	80005372 <memcpy>
      dec_3_concatenate[i][k+DEC_3_UP_CONV_RELU_OUTPUT_FEATURES] = dec_3_up_conv_relu[i][k];
80001eb8:	012405b3          	add	a1,s0,s2
80001ebc:	02048513          	add	a0,s1,32 # ffffe020 <_timer_base+0x3fffdf20>
80001ec0:	02000613          	li	a2,32
80001ec4:	4ae030ef          	jal	80005372 <memcpy>
  for(int i=0; i<DEC_3_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
80001ec8:	02040413          	add	s0,s0,32
80001ecc:	80040793          	add	a5,s0,-2048
80001ed0:	04048493          	add	s1,s1,64
80001ed4:	fc079ae3          	bnez	a5,80001ea8 <Segmenter+0x1b1c>
80001ed8:	00014737          	lui	a4,0x14
80001edc:	ffff77b7          	lui	a5,0xffff7
80001ee0:	40070713          	add	a4,a4,1024 # 14400 <_reset_entry-0x7ffebc00>
80001ee4:	00f70733          	add	a4,a4,a5
80001ee8:	03010793          	add	a5,sp,48
80001eec:	00f707b3          	add	a5,a4,a5
80001ef0:	00f12223          	sw	a5,4(sp)
80001ef4:	00078d93          	mv	s11,a5
80001ef8:	00000c93          	li	s9,0
    for(int i=0; i<DEC_3_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_3_CONV_RELU_0_K/2);
      l_max = min(DEC_3_CONV_RELU_0_N, i + DEC_3_CONV_RELU_0_K/2 + 1);
80001efc:	04000993          	li	s3,64
  for(int k=0; k<DEC_3_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001f00:	01800a13          	li	s4,24
    for(int i=0; i<DEC_3_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80001f04:	001c8793          	add	a5,s9,1
  for(int k=0; k<DEC_3_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001f08:	000d8d13          	mv	s10,s11
    for(int i=0; i<DEC_3_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80001f0c:	00000c13          	li	s8,0
80001f10:	00f12423          	sw	a5,8(sp)
      l_min = max(0, i - DEC_3_CONV_RELU_0_K/2);
80001f14:	fffc0913          	add	s2,s8,-1
80001f18:	00095463          	bgez	s2,80001f20 <Segmenter+0x1b94>
80001f1c:	00000913          	li	s2,0
      l_max = min(DEC_3_CONV_RELU_0_N, i + DEC_3_CONV_RELU_0_K/2 + 1);
80001f20:	002c0713          	add	a4,s8,2
80001f24:	00e9d463          	bge	s3,a4,80001f2c <Segmenter+0x1ba0>
80001f28:	04000713          	li	a4,64

      for(int l=l_min; l<l_max; l++){
80001f2c:	00812783          	lw	a5,8(sp)
80001f30:	418904b3          	sub	s1,s2,s8
      acc = 0; // Reset the accumulator
80001f34:	00000413          	li	s0,0
80001f38:	00f484b3          	add	s1,s1,a5
80001f3c:	00449493          	sll	s1,s1,0x4
      for(int l=l_min; l<l_max; l++){
80001f40:	06e95863          	bge	s2,a4,80001fb0 <Segmenter+0x1c24>
        for(int j=0; j<DEC_3_CONV_RELU_0_INPUT_FEATURES; j++){
80001f44:	00012783          	lw	a5,0(sp)
80001f48:	00691b93          	sll	s7,s2,0x6
80001f4c:	03010693          	add	a3,sp,48
80001f50:	00fb8bb3          	add	s7,s7,a5
80001f54:	000147b7          	lui	a5,0x14
80001f58:	47478793          	add	a5,a5,1140 # 14474 <_reset_entry-0x7ffebb8c>
80001f5c:	00d787b3          	add	a5,a5,a3
80001f60:	0007a783          	lw	a5,0(a5)
80001f64:	00249b13          	sll	s6,s1,0x2
      for(int l=l_min; l<l_max; l++){
80001f68:	00000a93          	li	s5,0
80001f6c:	01678b33          	add	s6,a5,s6
          acc += dec_3_concatenate[l][j]*dec_3_conv_relu_0_w[k*DEC_3_CONV_RELU_0_K*DEC_3_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_3_CONV_RELU_0_K/2)*DEC_3_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80001f70:	015b86b3          	add	a3,s7,s5
80001f74:	015b0633          	add	a2,s6,s5
80001f78:	00062583          	lw	a1,0(a2)
80001f7c:	0006a503          	lw	a0,0(a3)
80001f80:	00e12623          	sw	a4,12(sp)
        for(int j=0; j<DEC_3_CONV_RELU_0_INPUT_FEATURES; j++){
80001f84:	004a8a93          	add	s5,s5,4
          acc += dec_3_concatenate[l][j]*dec_3_conv_relu_0_w[k*DEC_3_CONV_RELU_0_K*DEC_3_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_3_CONV_RELU_0_K/2)*DEC_3_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80001f88:	6db010ef          	jal	80003e62 <__mulsf3>
80001f8c:	00050593          	mv	a1,a0
80001f90:	00040513          	mv	a0,s0
80001f94:	31e010ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<DEC_3_CONV_RELU_0_INPUT_FEATURES; j++){
80001f98:	00c12703          	lw	a4,12(sp)
          acc += dec_3_concatenate[l][j]*dec_3_conv_relu_0_w[k*DEC_3_CONV_RELU_0_K*DEC_3_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_3_CONV_RELU_0_K/2)*DEC_3_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
80001f9c:	00050413          	mv	s0,a0
        for(int j=0; j<DEC_3_CONV_RELU_0_INPUT_FEATURES; j++){
80001fa0:	fd3a98e3          	bne	s5,s3,80001f70 <Segmenter+0x1be4>
      for(int l=l_min; l<l_max; l++){
80001fa4:	00190913          	add	s2,s2,1
80001fa8:	01048493          	add	s1,s1,16
80001fac:	f95ff06f          	j	80001f40 <Segmenter+0x1bb4>
        }
      }

      dec_3_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
80001fb0:	00000593          	li	a1,0
80001fb4:	00040513          	mv	a0,s0
80001fb8:	611010ef          	jal	80003dc8 <__lesf2>
80001fbc:	00055463          	bgez	a0,80001fc4 <Segmenter+0x1c38>
80001fc0:	00000413          	li	s0,0
80001fc4:	008d2023          	sw	s0,0(s10)
    for(int i=0; i<DEC_3_CONV_RELU_0_N; i++){  // Iterate over the input matrix
80001fc8:	001c0c13          	add	s8,s8,1
80001fcc:	020d0d13          	add	s10,s10,32
80001fd0:	f53c12e3          	bne	s8,s3,80001f14 <Segmenter+0x1b88>
  for(int k=0; k<DEC_3_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80001fd4:	003c8c93          	add	s9,s9,3
80001fd8:	004d8d93          	add	s11,s11,4
80001fdc:	f34c94e3          	bne	s9,s4,80001f04 <Segmenter+0x1b78>
80001fe0:	ffff8937          	lui	s2,0xffff8
80001fe4:	000147b7          	lui	a5,0x14
80001fe8:	80090913          	add	s2,s2,-2048 # ffff7800 <_timer_base+0x3fff7700>
80001fec:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
80001ff0:	012787b3          	add	a5,a5,s2
80001ff4:	03010713          	add	a4,sp,48
80001ff8:	00e78933          	add	s2,a5,a4
80001ffc:	00090b13          	mv	s6,s2
80002000:	00000a13          	li	s4,0
    for(int i=0; i<DEC_3_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_3_CONV_RELU_1_K/2);
      l_max = min(DEC_3_CONV_RELU_1_N, i + DEC_3_CONV_RELU_1_K/2 + 1);
80002004:	04000993          	li	s3,64
    for(int i=0; i<DEC_3_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80002008:	001a0793          	add	a5,s4,1
  for(int i=0; i<DEC_3_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
8000200c:	000b0a93          	mv	s5,s6
    for(int i=0; i<DEC_3_CONV_RELU_1_N; i++){  // Iterate over the input matrix
80002010:	00000d93          	li	s11,0
80002014:	00f12023          	sw	a5,0(sp)
      l_min = max(0, i - DEC_3_CONV_RELU_1_K/2);
80002018:	fffd8b93          	add	s7,s11,-1
8000201c:	000bd463          	bgez	s7,80002024 <Segmenter+0x1c98>
80002020:	00000b93          	li	s7,0
      l_max = min(DEC_3_CONV_RELU_1_N, i + DEC_3_CONV_RELU_1_K/2 + 1);
80002024:	002d8613          	add	a2,s11,2
80002028:	00c9d463          	bge	s3,a2,80002030 <Segmenter+0x1ca4>
8000202c:	04000613          	li	a2,64

      for(int l=l_min; l<l_max; l++){
80002030:	00012783          	lw	a5,0(sp)
80002034:	41bb84b3          	sub	s1,s7,s11
      acc = 0; // Reset the accumulator
80002038:	00000413          	li	s0,0
8000203c:	00f484b3          	add	s1,s1,a5
80002040:	00349493          	sll	s1,s1,0x3
      for(int l=l_min; l<l_max; l++){
80002044:	06cbda63          	bge	s7,a2,800020b8 <Segmenter+0x1d2c>
        for(int j=0; j<DEC_3_CONV_RELU_1_INPUT_FEATURES; j++){
80002048:	00412783          	lw	a5,4(sp)
8000204c:	005b9d13          	sll	s10,s7,0x5
80002050:	03010713          	add	a4,sp,48
80002054:	00fd0d33          	add	s10,s10,a5
80002058:	000147b7          	lui	a5,0x14
8000205c:	47878793          	add	a5,a5,1144 # 14478 <_reset_entry-0x7ffebb88>
80002060:	00e787b3          	add	a5,a5,a4
80002064:	0007a783          	lw	a5,0(a5)
80002068:	00249c93          	sll	s9,s1,0x2
      for(int l=l_min; l<l_max; l++){
8000206c:	00000c13          	li	s8,0
80002070:	01978cb3          	add	s9,a5,s9
          acc += dec_3_conv_relu_0[l][j]*dec_3_conv_relu_1_w[k*DEC_3_CONV_RELU_1_K*DEC_3_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_3_CONV_RELU_1_K/2)*DEC_3_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
80002074:	018d0533          	add	a0,s10,s8
80002078:	018c85b3          	add	a1,s9,s8
8000207c:	0005a583          	lw	a1,0(a1)
80002080:	00052503          	lw	a0,0(a0)
80002084:	00c12423          	sw	a2,8(sp)
        for(int j=0; j<DEC_3_CONV_RELU_1_INPUT_FEATURES; j++){
80002088:	004c0c13          	add	s8,s8,4
          acc += dec_3_conv_relu_0[l][j]*dec_3_conv_relu_1_w[k*DEC_3_CONV_RELU_1_K*DEC_3_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_3_CONV_RELU_1_K/2)*DEC_3_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
8000208c:	5d7010ef          	jal	80003e62 <__mulsf3>
80002090:	00050593          	mv	a1,a0
80002094:	00040513          	mv	a0,s0
80002098:	21a010ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<DEC_3_CONV_RELU_1_INPUT_FEATURES; j++){
8000209c:	02000793          	li	a5,32
800020a0:	00812603          	lw	a2,8(sp)
          acc += dec_3_conv_relu_0[l][j]*dec_3_conv_relu_1_w[k*DEC_3_CONV_RELU_1_K*DEC_3_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_3_CONV_RELU_1_K/2)*DEC_3_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
800020a4:	00050413          	mv	s0,a0
        for(int j=0; j<DEC_3_CONV_RELU_1_INPUT_FEATURES; j++){
800020a8:	fcfc16e3          	bne	s8,a5,80002074 <Segmenter+0x1ce8>
      for(int l=l_min; l<l_max; l++){
800020ac:	001b8b93          	add	s7,s7,1
800020b0:	00848493          	add	s1,s1,8
800020b4:	f91ff06f          	j	80002044 <Segmenter+0x1cb8>
        }
      }

      dec_3_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
800020b8:	00000593          	li	a1,0
800020bc:	00040513          	mv	a0,s0
800020c0:	509010ef          	jal	80003dc8 <__lesf2>
800020c4:	00055463          	bgez	a0,800020cc <Segmenter+0x1d40>
800020c8:	00000413          	li	s0,0
800020cc:	008aa023          	sw	s0,0(s5)
    for(int i=0; i<DEC_3_CONV_RELU_1_N; i++){  // Iterate over the input matrix
800020d0:	001d8d93          	add	s11,s11,1
800020d4:	020a8a93          	add	s5,s5,32
800020d8:	f53d90e3          	bne	s11,s3,80002018 <Segmenter+0x1c8c>
  for(int k=0; k<DEC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800020dc:	003a0a13          	add	s4,s4,3
800020e0:	01800793          	li	a5,24
800020e4:	004b0b13          	add	s6,s6,4
800020e8:	f2fa10e3          	bne	s4,a5,80002008 <Segmenter+0x1c7c>
800020ec:	fffed9b7          	lui	s3,0xfffed
800020f0:	000147b7          	lui	a5,0x14
800020f4:	c0098993          	add	s3,s3,-1024 # fffecc00 <_timer_base+0x3ffecb00>
800020f8:	40078793          	add	a5,a5,1024 # 14400 <_reset_entry-0x7ffebc00>
800020fc:	03010713          	add	a4,sp,48
80002100:	013787b3          	add	a5,a5,s3
80002104:	00e789b3          	add	s3,a5,a4
80002108:	00098d93          	mv	s11,s3
8000210c:	00000c93          	li	s9,0
    for(int i=0; i<FINAL_CONV_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - FINAL_CONV_K/2);
      l_max = min(FINAL_CONV_N, i + FINAL_CONV_K/2 + 1);
80002110:	04000713          	li	a4,64
  for(int k=0; k<FINAL_CONV_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80002114:	00c00813          	li	a6,12
  for(int k=0; k<DEC_3_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
80002118:	000d8d13          	mv	s10,s11
    for(int i=0; i<FINAL_CONV_N; i++){  // Iterate over the input matrix
8000211c:	00000c13          	li	s8,0
80002120:	001c8693          	add	a3,s9,1
      l_min = max(0, i - FINAL_CONV_K/2);
80002124:	fffc0493          	add	s1,s8,-1
80002128:	0004d463          	bgez	s1,80002130 <Segmenter+0x1da4>
8000212c:	00000493          	li	s1,0
      l_max = min(FINAL_CONV_N, i + FINAL_CONV_K/2 + 1);
80002130:	002c0793          	add	a5,s8,2
80002134:	00f75463          	bge	a4,a5,8000213c <Segmenter+0x1db0>
80002138:	04000793          	li	a5,64

      for(int l=l_min; l<l_max; l++){
8000213c:	41848433          	sub	s0,s1,s8
80002140:	00d40433          	add	s0,s0,a3
80002144:	00341413          	sll	s0,s0,0x3
      acc = 0; // Reset the accumulator
80002148:	00000a13          	li	s4,0
      for(int l=l_min; l<l_max; l++){
8000214c:	08f4d063          	bge	s1,a5,800021cc <Segmenter+0x1e40>
        for(int j=0; j<FINAL_CONV_INPUT_FEATURES; j++){
80002150:	000145b7          	lui	a1,0x14
80002154:	47c58593          	add	a1,a1,1148 # 1447c <_reset_entry-0x7ffebb84>
80002158:	03010713          	add	a4,sp,48
8000215c:	00e585b3          	add	a1,a1,a4
80002160:	0005a583          	lw	a1,0(a1)
80002164:	00549b93          	sll	s7,s1,0x5
80002168:	00241b13          	sll	s6,s0,0x2
8000216c:	012b8bb3          	add	s7,s7,s2
80002170:	01658b33          	add	s6,a1,s6
      for(int l=l_min; l<l_max; l++){
80002174:	00000a93          	li	s5,0
          acc += dec_3_conv_relu_1[l][j]*final_conv_w[k*FINAL_CONV_K*FINAL_CONV_INPUT_FEATURES+(l-i+FINAL_CONV_K/2)*FINAL_CONV_INPUT_FEATURES+j];  // Multiply the input and the weight
80002178:	015b8533          	add	a0,s7,s5
8000217c:	015b05b3          	add	a1,s6,s5
80002180:	0005a583          	lw	a1,0(a1)
80002184:	00052503          	lw	a0,0(a0)
80002188:	00d12223          	sw	a3,4(sp)
8000218c:	00f12023          	sw	a5,0(sp)
80002190:	4d3010ef          	jal	80003e62 <__mulsf3>
80002194:	00050593          	mv	a1,a0
80002198:	000a0513          	mv	a0,s4
8000219c:	116010ef          	jal	800032b2 <__addsf3>
        for(int j=0; j<FINAL_CONV_INPUT_FEATURES; j++){
800021a0:	004a8a93          	add	s5,s5,4
800021a4:	02000613          	li	a2,32
800021a8:	00012783          	lw	a5,0(sp)
800021ac:	00412683          	lw	a3,4(sp)
          acc += dec_3_conv_relu_1[l][j]*final_conv_w[k*FINAL_CONV_K*FINAL_CONV_INPUT_FEATURES+(l-i+FINAL_CONV_K/2)*FINAL_CONV_INPUT_FEATURES+j];  // Multiply the input and the weight
800021b0:	00050a13          	mv	s4,a0
        for(int j=0; j<FINAL_CONV_INPUT_FEATURES; j++){
800021b4:	04000713          	li	a4,64
800021b8:	00c00813          	li	a6,12
800021bc:	faca9ee3          	bne	s5,a2,80002178 <Segmenter+0x1dec>
      for(int l=l_min; l<l_max; l++){
800021c0:	00148493          	add	s1,s1,1
800021c4:	00840413          	add	s0,s0,8
800021c8:	f85ff06f          	j	8000214c <Segmenter+0x1dc0>
        }
      }

      final_conv[i][k] = acc; // Save the accumulator value
800021cc:	014d2023          	sw	s4,0(s10)
    for(int i=0; i<FINAL_CONV_N; i++){  // Iterate over the input matrix
800021d0:	001c0c13          	add	s8,s8,1
800021d4:	010d0d13          	add	s10,s10,16
800021d8:	f4ec16e3          	bne	s8,a4,80002124 <Segmenter+0x1d98>
  for(int k=0; k<FINAL_CONV_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
800021dc:	003c8c93          	add	s9,s9,3
800021e0:	004d8d93          	add	s11,s11,4
800021e4:	f30c9ae3          	bne	s9,a6,80002118 <Segmenter+0x1d8c>
800021e8:	00000413          	li	s0,0
    }  
  }

  //----------------------------softmax-----------------------------------------
  for(int i=0; i<FINAL_CONV_N; i++){  // Iterate over the input matrix
800021ec:	40000493          	li	s1,1024
    Softmax(final_conv[i], y[i]);
800021f0:	000147b7          	lui	a5,0x14
800021f4:	03010713          	add	a4,sp,48
800021f8:	48078793          	add	a5,a5,1152 # 14480 <_reset_entry-0x7ffebb80>
800021fc:	00e787b3          	add	a5,a5,a4
80002200:	0007a783          	lw	a5,0(a5)
80002204:	00898533          	add	a0,s3,s0
80002208:	008785b3          	add	a1,a5,s0
  for(int i=0; i<FINAL_CONV_N; i++){  // Iterate over the input matrix
8000220c:	01040413          	add	s0,s0,16
    Softmax(final_conv[i], y[i]);
80002210:	8bcfe0ef          	jal	800002cc <Softmax>
  for(int i=0; i<FINAL_CONV_N; i++){  // Iterate over the input matrix
80002214:	fc941ee3          	bne	s0,s1,800021f0 <Segmenter+0x1e64>
  }
  //----------------------------------------------------------------------------

  //CALLGRIND_STOP_INSTRUMENTATION;
80002218:	000142b7          	lui	t0,0x14
8000221c:	00510133          	add	sp,sp,t0
80002220:	46c12083          	lw	ra,1132(sp)
80002224:	46812403          	lw	s0,1128(sp)
80002228:	46412483          	lw	s1,1124(sp)
8000222c:	46012903          	lw	s2,1120(sp)
80002230:	45c12983          	lw	s3,1116(sp)
80002234:	45812a03          	lw	s4,1112(sp)
80002238:	45412a83          	lw	s5,1108(sp)
8000223c:	45012b03          	lw	s6,1104(sp)
80002240:	44c12b83          	lw	s7,1100(sp)
80002244:	44812c03          	lw	s8,1096(sp)
80002248:	44412c83          	lw	s9,1092(sp)
8000224c:	44012d03          	lw	s10,1088(sp)
80002250:	43c12d83          	lw	s11,1084(sp)
80002254:	47010113          	add	sp,sp,1136
80002258:	00008067          	ret

8000225c <interrupt_handler>:
 * @param[in] epc Exception program counter from epc CSR.
 **************************************************************************/
void __attribute__ ((weak)) interrupt_handler(uint32_t cause, uint32_t epc)
{
    return; // do nothing
}
8000225c:	00008067          	ret

80002260 <exception_handler>:
 * @param[in] tval Trap value from mtval CSR.
 **************************************************************************/
void __attribute__ ((weak)) exception_handler(uint32_t cause, uint32_t epc, uint32_t tval)
{
    return; // do nothing
}
80002260:	00008067          	ret

80002264 <__trap_entry>:
{
80002264:	fb010113          	add	sp,sp,-80
80002268:	04112623          	sw	ra,76(sp)
8000226c:	04512423          	sw	t0,72(sp)
80002270:	04612223          	sw	t1,68(sp)
80002274:	04712023          	sw	t2,64(sp)
80002278:	02a12e23          	sw	a0,60(sp)
8000227c:	02b12c23          	sw	a1,56(sp)
80002280:	02c12a23          	sw	a2,52(sp)
80002284:	02d12823          	sw	a3,48(sp)
80002288:	02e12623          	sw	a4,44(sp)
8000228c:	02f12423          	sw	a5,40(sp)
80002290:	03012223          	sw	a6,36(sp)
80002294:	03112023          	sw	a7,32(sp)
80002298:	01c12e23          	sw	t3,28(sp)
8000229c:	01d12c23          	sw	t4,24(sp)
800022a0:	01e12a23          	sw	t5,20(sp)
800022a4:	01f12823          	sw	t6,16(sp)
 * @return Read data word (32-bit).
 **************************************************************************/
inline uint32_t cpu_csr_read(const int csr_address) {

  uint32_t rdata;
  asm volatile ("csrr %[rd], %[addr]"
800022a8:	34202573          	csrr	a0,mcause
800022ac:	341025f3          	csrr	a1,mepc
800022b0:	34302673          	csrr	a2,mtval
	if (mcause & 0x80000000UL) { // is interrupt (async. exception)
800022b4:	04055863          	bgez	a0,80002304 <__trap_entry+0xa0>
		interrupt_handler(mcause, mepc);
800022b8:	fa5ff0ef          	jal	8000225c <interrupt_handler>
}
800022bc:	04c12083          	lw	ra,76(sp)
800022c0:	04812283          	lw	t0,72(sp)
800022c4:	04412303          	lw	t1,68(sp)
800022c8:	04012383          	lw	t2,64(sp)
800022cc:	03c12503          	lw	a0,60(sp)
800022d0:	03812583          	lw	a1,56(sp)
800022d4:	03412603          	lw	a2,52(sp)
800022d8:	03012683          	lw	a3,48(sp)
800022dc:	02c12703          	lw	a4,44(sp)
800022e0:	02812783          	lw	a5,40(sp)
800022e4:	02412803          	lw	a6,36(sp)
800022e8:	02012883          	lw	a7,32(sp)
800022ec:	01c12e03          	lw	t3,28(sp)
800022f0:	01812e83          	lw	t4,24(sp)
800022f4:	01412f03          	lw	t5,20(sp)
800022f8:	01012f83          	lw	t6,16(sp)
800022fc:	05010113          	add	sp,sp,80
80002300:	30200073          	mret
		exception_handler(mcause, mepc, mtval);
80002304:	00b12623          	sw	a1,12(sp)
80002308:	f59ff0ef          	jal	80002260 <exception_handler>
		mepc += 4; // for upcoming C ISA extension: adjust by +2 if exception was caused by compressed instruction
8000230c:	00c12583          	lw	a1,12(sp)
80002310:	00458593          	add	a1,a1,4
 * @param[in] csr_address Address of CSR to write. See #airisc_csr_enum.
 * @param[in] data Data word to write (32-bit).
 **************************************************************************/
inline void cpu_csr_write(const int csr_address, uint32_t wdata) {

  asm volatile ("csrw %[addr], %[rs]"
80002314:	34159073          	csrw	mepc,a1
}
80002318:	fa5ff06f          	j	800022bc <__trap_entry+0x58>

8000231c <_close>:
// close file
int _close(int file)
{
	// there is no file system support, so a file can never be closed
	return -1;
}
8000231c:	fff00513          	li	a0,-1
80002320:	00008067          	ret

80002324 <_fstat>:

// get status of a file
int _fstat(int file, struct stat *st)
{
	// the only files are stdout, stderr and stdin
	if ((file == STDOUT_FILENO) || (file == STDERR_FILENO) || (file == STDIN_FILENO)) {
80002324:	00200793          	li	a5,2
80002328:	00a7ea63          	bltu	a5,a0,8000233c <_fstat+0x18>
		st->st_mode = S_IFCHR;
8000232c:	000027b7          	lui	a5,0x2
80002330:	00f5a223          	sw	a5,4(a1)
		return  0;
80002334:	00000513          	li	a0,0
80002338:	00008067          	ret
	}
	// return an error for other files
	errno = EBADF;
8000233c:	00900713          	li	a4,9
80002340:	04e1a223          	sw	a4,68(gp) # 800f4a24 <errno>
	return -1;
80002344:	fff00513          	li	a0,-1
}
80002348:	00008067          	ret

8000234c <_isatty>:
}

// check if a stream is a terminal
int _isatty(int file)
{
	if ((file == STDOUT_FILENO) || (file == STDERR_FILENO) || (file == STDIN_FILENO))
8000234c:	00200793          	li	a5,2
80002350:	00a7fa63          	bgeu	a5,a0,80002364 <_isatty+0x18>
		return  1;

	errno = EBADF;
80002354:	00900713          	li	a4,9
80002358:	04e1a223          	sw	a4,68(gp) # 800f4a24 <errno>
	return -1;
8000235c:	fff00513          	li	a0,-1
80002360:	00008067          	ret
		return  1;
80002364:	00100513          	li	a0,1
}
80002368:	00008067          	ret

8000236c <_lseek>:
}

// set file position
int _lseek(int file, int ptr, int dir)
{
	if ((file == STDOUT_FILENO) || (file == STDERR_FILENO))
8000236c:	fff50513          	add	a0,a0,-1
80002370:	00100793          	li	a5,1
80002374:	00a7fa63          	bgeu	a5,a0,80002388 <_lseek+0x1c>
		return  0;

	errno = EBADF;
80002378:	00900713          	li	a4,9
8000237c:	04e1a223          	sw	a4,68(gp) # 800f4a24 <errno>
	return -1;
80002380:	fff00513          	li	a0,-1
80002384:	00008067          	ret
		return  0;
80002388:	00000513          	li	a0,0
}
8000238c:	00008067          	ret

80002390 <_read>:
	return -1;
}

// read chars
int _read(int file, char *ptr, int len)
{
80002390:	fe010113          	add	sp,sp,-32
80002394:	00112e23          	sw	ra,28(sp)
80002398:	00812c23          	sw	s0,24(sp)
8000239c:	00912a23          	sw	s1,20(sp)
800023a0:	01212823          	sw	s2,16(sp)
800023a4:	01312623          	sw	s3,12(sp)
800023a8:	01412423          	sw	s4,8(sp)
	// stdin is mapped to uart0
	if (file != STDIN_FILENO)
800023ac:	02051463          	bnez	a0,800023d4 <_read+0x44>
		return  -1;
	}

	for (int i = 0; i < len; i++)
	{
		ptr[i] = uart_readByte(uart0);
800023b0:	c00009b7          	lui	s3,0xc0000
800023b4:	00050413          	mv	s0,a0
800023b8:	00058913          	mv	s2,a1
800023bc:	00060493          	mv	s1,a2
800023c0:	20098993          	add	s3,s3,512 # c0000200 <_timer_base+0x100>
		if (ptr[i] == '\r')
800023c4:	00d00a13          	li	s4,13
	for (int i = 0; i < len; i++)
800023c8:	02944e63          	blt	s0,s1,80002404 <_read+0x74>
800023cc:	00048413          	mv	s0,s1
800023d0:	0100006f          	j	800023e0 <_read+0x50>
		errno = EBADF;
800023d4:	00900713          	li	a4,9
800023d8:	04e1a223          	sw	a4,68(gp) # 800f4a24 <errno>
		return  -1;
800023dc:	fff00413          	li	s0,-1
			return i + 1;
		}
	}

	return len;
}
800023e0:	01c12083          	lw	ra,28(sp)
800023e4:	00040513          	mv	a0,s0
800023e8:	01812403          	lw	s0,24(sp)
800023ec:	01412483          	lw	s1,20(sp)
800023f0:	01012903          	lw	s2,16(sp)
800023f4:	00c12983          	lw	s3,12(sp)
800023f8:	00812a03          	lw	s4,8(sp)
800023fc:	02010113          	add	sp,sp,32
80002400:	00008067          	ret
		ptr[i] = uart_readByte(uart0);
80002404:	00098513          	mv	a0,s3
80002408:	10c000ef          	jal	80002514 <uart_readByte>
8000240c:	008907b3          	add	a5,s2,s0
80002410:	00a78023          	sb	a0,0(a5) # 2000 <_reset_entry-0x7fffe000>
			return i + 1;
80002414:	00140413          	add	s0,s0,1
		if (ptr[i] == '\r')
80002418:	fb4518e3          	bne	a0,s4,800023c8 <_read+0x38>
8000241c:	fc5ff06f          	j	800023e0 <_read+0x50>

80002420 <_sbrk>:
{
	extern unsigned char _end;
	static unsigned char *heap = NULL;
	unsigned char *prev_heap;

	if (heap == NULL)
80002420:	0341a683          	lw	a3,52(gp) # 800f4a14 <heap.0>
{
80002424:	00050793          	mv	a5,a0
	if (heap == NULL)
80002428:	00069663          	bnez	a3,80002434 <_sbrk+0x14>
		heap = (unsigned char *)&_end;
8000242c:	04818693          	add	a3,gp,72 # 800f4a28 <_bss_end>
80002430:	02d1aa23          	sw	a3,52(gp) # 800f4a14 <heap.0>

	prev_heap = heap;
80002434:	0341a503          	lw	a0,52(gp) # 800f4a14 <heap.0>

	heap += incr;
80002438:	00f507b3          	add	a5,a0,a5
8000243c:	02f1aa23          	sw	a5,52(gp) # 800f4a14 <heap.0>

	return (void*) prev_heap;
}
80002440:	00008067          	ret

80002444 <_write>:
	return -1;
}

// write chars
int _write(int file, char *ptr, int len)
{
80002444:	ff010113          	add	sp,sp,-16
80002448:	00112623          	sw	ra,12(sp)
8000244c:	00812423          	sw	s0,8(sp)
	// stdout and stderr are mapped to uart0
	if ((file != STDOUT_FILENO) && (file != STDERR_FILENO))
80002450:	fff50513          	add	a0,a0,-1
80002454:	00100793          	li	a5,1
80002458:	02a7f263          	bgeu	a5,a0,8000247c <_write+0x38>
	{
		errno = EBADF;
8000245c:	00900713          	li	a4,9
80002460:	04e1a223          	sw	a4,68(gp) # 800f4a24 <errno>
		return  -1;
80002464:	fff00413          	li	s0,-1
	}

	uart_writeData(uart0, (uint8_t*)ptr, len);
	return len;
}
80002468:	00c12083          	lw	ra,12(sp)
8000246c:	00040513          	mv	a0,s0
80002470:	00812403          	lw	s0,8(sp)
80002474:	01010113          	add	sp,sp,16
80002478:	00008067          	ret
	uart_writeData(uart0, (uint8_t*)ptr, len);
8000247c:	c0000537          	lui	a0,0xc0000
80002480:	20050513          	add	a0,a0,512 # c0000200 <_timer_base+0x100>
80002484:	00060413          	mv	s0,a2
80002488:	0c0000ef          	jal	80002548 <uart_writeData>
	return len;
8000248c:	fddff06f          	j	80002468 <_write+0x24>

80002490 <timer_set_time>:
    uint32_t u32[sizeof(uint64_t)/sizeof(uint32_t)];
  } cycles;

  cycles.u64 = time;

  timer->TIMEL = 0;
80002490:	00052023          	sw	zero,0(a0)
  timer->TIMEH = cycles.u32[1];
80002494:	00c52223          	sw	a2,4(a0)
  timer->TIMEL = cycles.u32[0];
80002498:	00b52023          	sw	a1,0(a0)
}
8000249c:	00008067          	ret

800024a0 <timer_get_time>:
 * Get current system time.
 *
 * @param[in] timer Pointer to timer hardware handle (TIMER_t*)
 * @return Current system time (uint64_t)
 **************************************************************************/
uint64_t timer_get_time(volatile TIMER_t* const timer) {
800024a0:	00050793          	mv	a5,a0
    uint32_t u32[sizeof(uint64_t)/sizeof(uint32_t)];
  } cycles;

  uint32_t tmp1, tmp2, tmp3;
  while(1) {
    tmp1 = timer->TIMEH;
800024a4:	0047a583          	lw	a1,4(a5)
    tmp2 = timer->TIMEL;
800024a8:	0007a503          	lw	a0,0(a5)
    tmp3 = timer->TIMEH;
800024ac:	0047a703          	lw	a4,4(a5)
    if (tmp1 == tmp3) {
800024b0:	fee59ae3          	bne	a1,a4,800024a4 <timer_get_time+0x4>

  cycles.u32[0] = tmp2;
  cycles.u32[1] = tmp3;

  return cycles.u64;
}
800024b4:	00008067          	ret

800024b8 <uart_isTxFull>:
    return 0;
}

int32_t uart_isTxFull(volatile UART_t* const uart)
{
    if (uart->TX_STAT & 0x00010000)
800024b8:	01052503          	lw	a0,16(a0)
800024bc:	00f51513          	sll	a0,a0,0xf
        return -1;

    return 0;
}
800024c0:	41f55513          	sra	a0,a0,0x1f
800024c4:	00008067          	ret

800024c8 <uart_isRxEmpty>:
    return 0;
}

int32_t uart_isRxEmpty(volatile UART_t* const uart)
{
    if (uart->RX_STAT & 0x00020000)
800024c8:	01c52503          	lw	a0,28(a0)
800024cc:	00e51513          	sll	a0,a0,0xe
        return -1;

    return 0;
}
800024d0:	41f55513          	sra	a0,a0,0x1f
800024d4:	00008067          	ret

800024d8 <uart_writeByte>:
{
    return uart->RX_STAT & 0x000000FF;
}

void uart_writeByte(volatile UART_t* const uart, uint8_t data)
{
800024d8:	ff010113          	add	sp,sp,-16
800024dc:	00812423          	sw	s0,8(sp)
800024e0:	00912223          	sw	s1,4(sp)
800024e4:	00112623          	sw	ra,12(sp)
800024e8:	00050413          	mv	s0,a0
800024ec:	00058493          	mv	s1,a1
    while (uart_isTxFull(uart));
800024f0:	00040513          	mv	a0,s0
800024f4:	fc5ff0ef          	jal	800024b8 <uart_isTxFull>
800024f8:	fe051ce3          	bnez	a0,800024f0 <uart_writeByte+0x18>
    uart->DATA = data;
800024fc:	00942023          	sw	s1,0(s0)
}
80002500:	00c12083          	lw	ra,12(sp)
80002504:	00812403          	lw	s0,8(sp)
80002508:	00412483          	lw	s1,4(sp)
8000250c:	01010113          	add	sp,sp,16
80002510:	00008067          	ret

80002514 <uart_readByte>:

uint8_t uart_readByte(volatile UART_t* const uart)
{
80002514:	ff010113          	add	sp,sp,-16
80002518:	00812423          	sw	s0,8(sp)
8000251c:	00112623          	sw	ra,12(sp)
80002520:	00050413          	mv	s0,a0
    while (uart_isRxEmpty(uart));
80002524:	00040513          	mv	a0,s0
80002528:	fa1ff0ef          	jal	800024c8 <uart_isRxEmpty>
8000252c:	fe051ce3          	bnez	a0,80002524 <uart_readByte+0x10>
    return uart->DATA;
80002530:	00042503          	lw	a0,0(s0)
}
80002534:	00c12083          	lw	ra,12(sp)
80002538:	00812403          	lw	s0,8(sp)
8000253c:	0ff57513          	zext.b	a0,a0
80002540:	01010113          	add	sp,sp,16
80002544:	00008067          	ret

80002548 <uart_writeData>:

void uart_writeData(volatile UART_t* const uart, const uint8_t* data, uint32_t size)
{
80002548:	ff010113          	add	sp,sp,-16
8000254c:	00812423          	sw	s0,8(sp)
80002550:	00912223          	sw	s1,4(sp)
80002554:	01212023          	sw	s2,0(sp)
80002558:	00112623          	sw	ra,12(sp)
8000255c:	00050913          	mv	s2,a0
    for (uint32_t i = 0; i < size; i++)
80002560:	00058413          	mv	s0,a1
80002564:	00c584b3          	add	s1,a1,a2
80002568:	00941e63          	bne	s0,s1,80002584 <uart_writeData+0x3c>
        uart_writeByte(uart, data[i]);
}
8000256c:	00c12083          	lw	ra,12(sp)
80002570:	00812403          	lw	s0,8(sp)
80002574:	00412483          	lw	s1,4(sp)
80002578:	00012903          	lw	s2,0(sp)
8000257c:	01010113          	add	sp,sp,16
80002580:	00008067          	ret
        uart_writeByte(uart, data[i]);
80002584:	00044583          	lbu	a1,0(s0)
80002588:	00090513          	mv	a0,s2
8000258c:	00140413          	add	s0,s0,1
80002590:	f49ff0ef          	jal	800024d8 <uart_writeByte>
    for (uint32_t i = 0; i < size; i++)
80002594:	fd5ff06f          	j	80002568 <uart_writeData+0x20>

80002598 <number>:
    return i;
}

static char *
number(char *str, long num, int base, int size, int precision, int type)
{
80002598:	f6010113          	add	sp,sp,-160
8000259c:	08812c23          	sw	s0,152(sp)
800025a0:	08912a23          	sw	s1,148(sp)
800025a4:	09212823          	sw	s2,144(sp)
800025a8:	09412423          	sw	s4,136(sp)
800025ac:	07b12623          	sw	s11,108(sp)
800025b0:	00078913          	mv	s2,a5
800025b4:	08112e23          	sw	ra,156(sp)
800025b8:	09312623          	sw	s3,140(sp)
800025bc:	09512223          	sw	s5,132(sp)
800025c0:	09612023          	sw	s6,128(sp)
800025c4:	07712e23          	sw	s7,124(sp)
800025c8:	07812c23          	sw	s8,120(sp)
800025cc:	07912a23          	sw	s9,116(sp)
800025d0:	07a12823          	sw	s10,112(sp)
    char  c, sign, tmp[66];
    char *dig = digits;
    int   i;

    if (type & UPPERCASE)
800025d4:	0407f793          	and	a5,a5,64
{
800025d8:	00050493          	mv	s1,a0
800025dc:	00060a13          	mv	s4,a2
800025e0:	00058513          	mv	a0,a1
800025e4:	00068413          	mv	s0,a3
800025e8:	00070d93          	mv	s11,a4
    if (type & UPPERCASE)
800025ec:	08078663          	beqz	a5,80002678 <number+0xe0>
        dig = upper_digits;
800025f0:	80006ab7          	lui	s5,0x80006
800025f4:	bf8a8a93          	add	s5,s5,-1032 # 80005bf8 <_isatty_r+0x8a>
    if (type & LEFT)
800025f8:	01097b93          	and	s7,s2,16
800025fc:	000b8463          	beqz	s7,80002604 <number+0x6c>
        type &= ~ZEROPAD;
80002600:	ffe97913          	and	s2,s2,-2
    if (base < 2 || base > 36)
        return 0;

    c    = (type & ZEROPAD) ? '0' : ' ';
80002604:	03000713          	li	a4,48
80002608:	00197793          	and	a5,s2,1
8000260c:	00e12623          	sw	a4,12(sp)
80002610:	00079663          	bnez	a5,8000261c <number+0x84>
80002614:	02000793          	li	a5,32
80002618:	00f12623          	sw	a5,12(sp)
    sign = 0;
    if (type & SIGN)
8000261c:	00297793          	and	a5,s2,2
            sign = ' ';
            size--;
        }
    }

    if (type & HEX_PREP)
80002620:	02097b13          	and	s6,s2,32
    if (type & SIGN)
80002624:	1a078c63          	beqz	a5,800027dc <number+0x244>
        if (num < 0)
80002628:	04055e63          	bgez	a0,80002684 <number+0xec>
            num  = -num;
8000262c:	40a00533          	neg	a0,a0
            size--;
80002630:	fff40413          	add	s0,s0,-1
            sign = '-';
80002634:	02d00d13          	li	s10,45
    if (type & HEX_PREP)
80002638:	060b1063          	bnez	s6,80002698 <number+0x100>
8000263c:	01c10c93          	add	s9,sp,28
            size -= 2;
        else if (base == 8)
            size--;
    }

    i = 0;
80002640:	00000993          	li	s3,0
        tmp[i++] = '0';
    else
    {
        while (num != 0)
        {
            tmp[i++] = dig[((unsigned long)num) % (unsigned)base];
80002644:	000a0593          	mv	a1,s4
80002648:	00050c13          	mv	s8,a0
8000264c:	01c020ef          	jal	80004668 <__umodsi3>
80002650:	00aa8533          	add	a0,s5,a0
80002654:	00054783          	lbu	a5,0(a0)
            num      = ((unsigned long)num) / (unsigned)base;
80002658:	000a0593          	mv	a1,s4
8000265c:	000c0513          	mv	a0,s8
            tmp[i++] = dig[((unsigned long)num) % (unsigned)base];
80002660:	00fc8023          	sb	a5,0(s9)
80002664:	00198993          	add	s3,s3,1
            num      = ((unsigned long)num) / (unsigned)base;
80002668:	7d5010ef          	jal	8000463c <__hidden___udivsi3>
        while (num != 0)
8000266c:	001c8c93          	add	s9,s9,1
80002670:	fd4c7ae3          	bgeu	s8,s4,80002644 <number+0xac>
80002674:	0400006f          	j	800026b4 <number+0x11c>
    char *dig = digits;
80002678:	80006ab7          	lui	s5,0x80006
8000267c:	bd0a8a93          	add	s5,s5,-1072 # 80005bd0 <_isatty_r+0x62>
80002680:	f79ff06f          	j	800025f8 <number+0x60>
        else if (type & PLUS)
80002684:	00497793          	and	a5,s2,4
80002688:	12078e63          	beqz	a5,800027c4 <number+0x22c>
            size--;
8000268c:	fff40413          	add	s0,s0,-1
            sign = '+';
80002690:	02b00d13          	li	s10,43
    if (type & HEX_PREP)
80002694:	000b0863          	beqz	s6,800026a4 <number+0x10c>
        if (base == 16)
80002698:	01000793          	li	a5,16
8000269c:	14fa1463          	bne	s4,a5,800027e4 <number+0x24c>
            size -= 2;
800026a0:	ffe40413          	add	s0,s0,-2
    if (num == 0)
800026a4:	f8051ce3          	bnez	a0,8000263c <number+0xa4>
        tmp[i++] = '0';
800026a8:	03000793          	li	a5,48
800026ac:	00f10e23          	sb	a5,28(sp)
800026b0:	00100993          	li	s3,1
        }
    }

    if (i > precision)
800026b4:	00098a93          	mv	s5,s3
800026b8:	01b9d463          	bge	s3,s11,800026c0 <number+0x128>
800026bc:	000d8a93          	mv	s5,s11
        precision = i;
    size -= precision;
    if (!(type & (ZEROPAD | LEFT)))
800026c0:	01197913          	and	s2,s2,17
    size -= precision;
800026c4:	41540433          	sub	s0,s0,s5
    if (!(type & (ZEROPAD | LEFT)))
800026c8:	02091663          	bnez	s2,800026f4 <number+0x15c>
        while (size-- > 0)
            *str++ = ' ';
800026cc:	00040913          	mv	s2,s0
800026d0:	00045463          	bgez	s0,800026d8 <number+0x140>
800026d4:	00000913          	li	s2,0
800026d8:	00048513          	mv	a0,s1
800026dc:	00090613          	mv	a2,s2
800026e0:	02000593          	li	a1,32
800026e4:	fff40413          	add	s0,s0,-1
800026e8:	5d1020ef          	jal	800054b8 <memset>
800026ec:	012484b3          	add	s1,s1,s2
        while (size-- > 0)
800026f0:	41240433          	sub	s0,s0,s2
    if (sign)
800026f4:	000d0663          	beqz	s10,80002700 <number+0x168>
        *str++ = sign;
800026f8:	01a48023          	sb	s10,0(s1)
800026fc:	00148493          	add	s1,s1,1

    if (type & HEX_PREP)
80002700:	000b0c63          	beqz	s6,80002718 <number+0x180>
    {
        if (base == 8)
80002704:	00800793          	li	a5,8
80002708:	0efa1663          	bne	s4,a5,800027f4 <number+0x25c>
            *str++ = '0';
8000270c:	03000793          	li	a5,48
80002710:	00f48023          	sb	a5,0(s1)
80002714:	00148493          	add	s1,s1,1
            *str++ = '0';
            *str++ = digits[33];
        }
    }

    if (!(type & LEFT))
80002718:	020b9663          	bnez	s7,80002744 <number+0x1ac>
        while (size-- > 0)
            *str++ = c;
8000271c:	00040913          	mv	s2,s0
80002720:	00045463          	bgez	s0,80002728 <number+0x190>
80002724:	00000913          	li	s2,0
80002728:	00c12583          	lw	a1,12(sp)
8000272c:	00048513          	mv	a0,s1
80002730:	00090613          	mv	a2,s2
80002734:	fff40413          	add	s0,s0,-1
80002738:	581020ef          	jal	800054b8 <memset>
8000273c:	012484b3          	add	s1,s1,s2
        while (size-- > 0)
80002740:	41240433          	sub	s0,s0,s2
    while (i < precision--)
        *str++ = '0';
80002744:	413a8933          	sub	s2,s5,s3
80002748:	00090613          	mv	a2,s2
8000274c:	03000593          	li	a1,48
80002750:	00048513          	mv	a0,s1
80002754:	565020ef          	jal	800054b8 <memset>
80002758:	01248633          	add	a2,s1,s2
    while (i-- > 0)
8000275c:	fff00793          	li	a5,-1
80002760:	fff98993          	add	s3,s3,-1
80002764:	0af99863          	bne	s3,a5,80002814 <number+0x27c>
80002768:	015484b3          	add	s1,s1,s5
        *str++ = tmp[i];
    while (size-- > 0)
        *str++ = ' ';
8000276c:	00045463          	bgez	s0,80002774 <number+0x1dc>
80002770:	00000413          	li	s0,0
80002774:	00040613          	mv	a2,s0
80002778:	00048513          	mv	a0,s1
8000277c:	02000593          	li	a1,32
80002780:	539020ef          	jal	800054b8 <memset>

    return str;
}
80002784:	00848533          	add	a0,s1,s0
80002788:	09c12083          	lw	ra,156(sp)
8000278c:	09812403          	lw	s0,152(sp)
80002790:	09412483          	lw	s1,148(sp)
80002794:	09012903          	lw	s2,144(sp)
80002798:	08c12983          	lw	s3,140(sp)
8000279c:	08812a03          	lw	s4,136(sp)
800027a0:	08412a83          	lw	s5,132(sp)
800027a4:	08012b03          	lw	s6,128(sp)
800027a8:	07c12b83          	lw	s7,124(sp)
800027ac:	07812c03          	lw	s8,120(sp)
800027b0:	07412c83          	lw	s9,116(sp)
800027b4:	07012d03          	lw	s10,112(sp)
800027b8:	06c12d83          	lw	s11,108(sp)
800027bc:	0a010113          	add	sp,sp,160
800027c0:	00008067          	ret
        else if (type & SPACE)
800027c4:	00897793          	and	a5,s2,8
    sign = 0;
800027c8:	00000d13          	li	s10,0
        else if (type & SPACE)
800027cc:	ec0784e3          	beqz	a5,80002694 <number+0xfc>
            size--;
800027d0:	fff40413          	add	s0,s0,-1
            sign = ' ';
800027d4:	02000d13          	li	s10,32
800027d8:	ebdff06f          	j	80002694 <number+0xfc>
    sign = 0;
800027dc:	00000d13          	li	s10,0
800027e0:	eb5ff06f          	j	80002694 <number+0xfc>
        else if (base == 8)
800027e4:	00800793          	li	a5,8
800027e8:	eafa1ee3          	bne	s4,a5,800026a4 <number+0x10c>
            size--;
800027ec:	fff40413          	add	s0,s0,-1
800027f0:	eb5ff06f          	j	800026a4 <number+0x10c>
        else if (base == 16)
800027f4:	01000793          	li	a5,16
800027f8:	f2fa10e3          	bne	s4,a5,80002718 <number+0x180>
            *str++ = '0';
800027fc:	03000793          	li	a5,48
80002800:	00f48023          	sb	a5,0(s1)
            *str++ = digits[33];
80002804:	07800793          	li	a5,120
80002808:	00f480a3          	sb	a5,1(s1)
8000280c:	00248493          	add	s1,s1,2
80002810:	f09ff06f          	j	80002718 <number+0x180>
        *str++ = tmp[i];
80002814:	01c10713          	add	a4,sp,28
80002818:	01370733          	add	a4,a4,s3
8000281c:	00074703          	lbu	a4,0(a4)
80002820:	00160613          	add	a2,a2,1
80002824:	fee60fa3          	sb	a4,-1(a2)
80002828:	f39ff06f          	j	80002760 <number+0x1c8>

8000282c <uart_send_char>:
}

void
uart_send_char(char c)
{
    fputc(c, stdout);
8000282c:	0001a783          	lw	a5,0(gp) # 800f49e0 <_impure_ptr>
80002830:	0087a583          	lw	a1,8(a5)
80002834:	20e0206f          	j	80004a42 <fputc>

80002838 <ee_printf>:
}

int
ee_printf(const char *fmt, ...)
{
80002838:	e7010113          	add	sp,sp,-400
8000283c:	17212023          	sw	s2,352(sp)
80002840:	19112623          	sw	a7,396(sp)
        switch (*fmt)
80002844:	80006937          	lui	s2,0x80006
    char    buf[256], *p;
    va_list args;
    int     n = 0;

    va_start(args, fmt);
80002848:	17410893          	add	a7,sp,372
{
8000284c:	15512a23          	sw	s5,340(sp)
80002850:	15612823          	sw	s6,336(sp)
80002854:	16112623          	sw	ra,364(sp)
80002858:	16812423          	sw	s0,360(sp)
8000285c:	16912223          	sw	s1,356(sp)
80002860:	15312e23          	sw	s3,348(sp)
80002864:	15412c23          	sw	s4,344(sp)
80002868:	15712623          	sw	s7,332(sp)
8000286c:	15812423          	sw	s8,328(sp)
80002870:	15912223          	sw	s9,324(sp)
80002874:	15a12023          	sw	s10,320(sp)
80002878:	13b12e23          	sw	s11,316(sp)
8000287c:	16b12a23          	sw	a1,372(sp)
80002880:	16c12c23          	sw	a2,376(sp)
80002884:	16d12e23          	sw	a3,380(sp)
80002888:	18e12023          	sw	a4,384(sp)
8000288c:	18f12223          	sw	a5,388(sp)
80002890:	19012423          	sw	a6,392(sp)
    va_start(args, fmt);
80002894:	01112a23          	sw	a7,20(sp)
    ee_vsprintf(buf, fmt, args);
80002898:	00088b13          	mv	s6,a7
    for (str = buf; *fmt; fmt++)
8000289c:	03010a93          	add	s5,sp,48
        switch (*fmt)
800028a0:	c2890913          	add	s2,s2,-984 # 80005c28 <_isatty_r+0xba>
    for (str = buf; *fmt; fmt++)
800028a4:	00054783          	lbu	a5,0(a0)
800028a8:	04079e63          	bnez	a5,80002904 <ee_printf+0xcc>
    *str = '\0';
800028ac:	000a8023          	sb	zero,0(s5)
    int     n = 0;
800028b0:	00000413          	li	s0,0
    va_end(args);
    p = buf;
    while (*p)
800028b4:	03010793          	add	a5,sp,48
800028b8:	008787b3          	add	a5,a5,s0
800028bc:	0007c503          	lbu	a0,0(a5)
800028c0:	68051863          	bnez	a0,80002f50 <ee_printf+0x718>
        n++;
        p++;
    }

    return n;
}
800028c4:	16c12083          	lw	ra,364(sp)
800028c8:	00040513          	mv	a0,s0
800028cc:	16812403          	lw	s0,360(sp)
800028d0:	16412483          	lw	s1,356(sp)
800028d4:	16012903          	lw	s2,352(sp)
800028d8:	15c12983          	lw	s3,348(sp)
800028dc:	15812a03          	lw	s4,344(sp)
800028e0:	15412a83          	lw	s5,340(sp)
800028e4:	15012b03          	lw	s6,336(sp)
800028e8:	14c12b83          	lw	s7,332(sp)
800028ec:	14812c03          	lw	s8,328(sp)
800028f0:	14412c83          	lw	s9,324(sp)
800028f4:	14012d03          	lw	s10,320(sp)
800028f8:	13c12d83          	lw	s11,316(sp)
800028fc:	19010113          	add	sp,sp,400
80002900:	00008067          	ret
        if (*fmt != '%')
80002904:	02500713          	li	a4,37
80002908:	00e78a63          	beq	a5,a4,8000291c <ee_printf+0xe4>
            *str++ = *fmt;
8000290c:	00fa8023          	sb	a5,0(s5)
            continue;
80002910:	00050413          	mv	s0,a0
                    *str++ = *fmt;
80002914:	001a8a93          	add	s5,s5,1
80002918:	2780006f          	j	80002b90 <ee_printf+0x358>
        flags = 0;
8000291c:	00000793          	li	a5,0
        switch (*fmt)
80002920:	02b00693          	li	a3,43
80002924:	02300613          	li	a2,35
80002928:	0380006f          	j	80002960 <ee_printf+0x128>
8000292c:	02d00593          	li	a1,45
80002930:	02b70463          	beq	a4,a1,80002958 <ee_printf+0x120>
80002934:	03000593          	li	a1,48
80002938:	08b70e63          	beq	a4,a1,800029d4 <ee_printf+0x19c>
        if (is_digit(*fmt))
8000293c:	fd070713          	add	a4,a4,-48
80002940:	0ff77713          	zext.b	a4,a4
80002944:	00900693          	li	a3,9
80002948:	02e6ee63          	bltu	a3,a4,80002984 <ee_printf+0x14c>
    int i = 0;
8000294c:	00000b93          	li	s7,0
    while (is_digit(**s))
80002950:	00900593          	li	a1,9
80002954:	0a00006f          	j	800029f4 <ee_printf+0x1bc>
                flags |= LEFT;
80002958:	0107e793          	or	a5,a5,16
        fmt++; // This also skips first '%'
8000295c:	00040513          	mv	a0,s0
        switch (*fmt)
80002960:	00154703          	lbu	a4,1(a0)
        fmt++; // This also skips first '%'
80002964:	00150413          	add	s0,a0,1
        switch (*fmt)
80002968:	04d70a63          	beq	a4,a3,800029bc <ee_printf+0x184>
8000296c:	fce6e0e3          	bltu	a3,a4,8000292c <ee_printf+0xf4>
80002970:	02000593          	li	a1,32
80002974:	04b70863          	beq	a4,a1,800029c4 <ee_printf+0x18c>
80002978:	04c70a63          	beq	a4,a2,800029cc <ee_printf+0x194>
        else if (*fmt == '*')
8000297c:	02a00693          	li	a3,42
80002980:	08d70463          	beq	a4,a3,80002a08 <ee_printf+0x1d0>
        field_width = -1;
80002984:	fff00b93          	li	s7,-1
        if (*fmt == '.')
80002988:	00044583          	lbu	a1,0(s0)
8000298c:	02e00613          	li	a2,46
        precision = -1;
80002990:	fff00713          	li	a4,-1
        if (*fmt == '.')
80002994:	0cc59263          	bne	a1,a2,80002a58 <ee_printf+0x220>
            if (is_digit(*fmt))
80002998:	00144603          	lbu	a2,1(s0)
8000299c:	00900513          	li	a0,9
            ++fmt;
800029a0:	00140593          	add	a1,s0,1
            if (is_digit(*fmt))
800029a4:	fd060713          	add	a4,a2,-48
800029a8:	0ff77713          	zext.b	a4,a4
800029ac:	10e56c63          	bltu	a0,a4,80002ac4 <ee_printf+0x28c>
    int i = 0;
800029b0:	00000713          	li	a4,0
    while (is_digit(**s))
800029b4:	00900313          	li	t1,9
800029b8:	0840006f          	j	80002a3c <ee_printf+0x204>
                flags |= PLUS;
800029bc:	0047e793          	or	a5,a5,4
                goto repeat;
800029c0:	f9dff06f          	j	8000295c <ee_printf+0x124>
                flags |= SPACE;
800029c4:	0087e793          	or	a5,a5,8
                goto repeat;
800029c8:	f95ff06f          	j	8000295c <ee_printf+0x124>
                flags |= HEX_PREP;
800029cc:	0207e793          	or	a5,a5,32
                goto repeat;
800029d0:	f8dff06f          	j	8000295c <ee_printf+0x124>
                flags |= ZEROPAD;
800029d4:	0017e793          	or	a5,a5,1
                goto repeat;
800029d8:	f85ff06f          	j	8000295c <ee_printf+0x124>
        i = i * 10 + *((*s)++) - '0';
800029dc:	002b9713          	sll	a4,s7,0x2
800029e0:	01770733          	add	a4,a4,s7
800029e4:	00171713          	sll	a4,a4,0x1
800029e8:	00c70733          	add	a4,a4,a2
800029ec:	00140413          	add	s0,s0,1
800029f0:	fd070b93          	add	s7,a4,-48
    while (is_digit(**s))
800029f4:	00044603          	lbu	a2,0(s0)
800029f8:	fd060713          	add	a4,a2,-48
800029fc:	0ff77713          	zext.b	a4,a4
80002a00:	fce5fee3          	bgeu	a1,a4,800029dc <ee_printf+0x1a4>
80002a04:	f85ff06f          	j	80002988 <ee_printf+0x150>
            field_width = va_arg(args, int);
80002a08:	000b2b83          	lw	s7,0(s6)
            fmt++;
80002a0c:	00250413          	add	s0,a0,2
            field_width = va_arg(args, int);
80002a10:	004b0b13          	add	s6,s6,4
            if (field_width < 0)
80002a14:	f60bdae3          	bgez	s7,80002988 <ee_printf+0x150>
                field_width = -field_width;
80002a18:	41700bb3          	neg	s7,s7
                flags |= LEFT;
80002a1c:	0107e793          	or	a5,a5,16
80002a20:	f69ff06f          	j	80002988 <ee_printf+0x150>
        i = i * 10 + *((*s)++) - '0';
80002a24:	00271613          	sll	a2,a4,0x2
80002a28:	00e60733          	add	a4,a2,a4
80002a2c:	00171713          	sll	a4,a4,0x1
80002a30:	00a70733          	add	a4,a4,a0
80002a34:	00158593          	add	a1,a1,1
80002a38:	fd070713          	add	a4,a4,-48
    while (is_digit(**s))
80002a3c:	0005c503          	lbu	a0,0(a1)
80002a40:	fd050613          	add	a2,a0,-48
80002a44:	0ff67613          	zext.b	a2,a2
80002a48:	fcc37ee3          	bgeu	t1,a2,80002a24 <ee_printf+0x1ec>
            if (precision < 0)
80002a4c:	00075463          	bgez	a4,80002a54 <ee_printf+0x21c>
80002a50:	00000713          	li	a4,0
80002a54:	00058413          	mv	s0,a1
        if (*fmt == 'l' || *fmt == 'L')
80002a58:	00044603          	lbu	a2,0(s0)
80002a5c:	04c00593          	li	a1,76
        qualifier = -1;
80002a60:	fff00513          	li	a0,-1
        if (*fmt == 'l' || *fmt == 'L')
80002a64:	0df67313          	and	t1,a2,223
80002a68:	00b31663          	bne	t1,a1,80002a74 <ee_printf+0x23c>
            qualifier = *fmt;
80002a6c:	00060513          	mv	a0,a2
            fmt++;
80002a70:	00140413          	add	s0,s0,1
        switch (*fmt)
80002a74:	00044583          	lbu	a1,0(s0)
80002a78:	07800613          	li	a2,120
80002a7c:	02b66663          	bltu	a2,a1,80002aa8 <ee_printf+0x270>
80002a80:	06000613          	li	a2,96
80002a84:	06b66263          	bltu	a2,a1,80002ae8 <ee_printf+0x2b0>
80002a88:	04100613          	li	a2,65
80002a8c:	20c58463          	beq	a1,a2,80002c94 <ee_printf+0x45c>
80002a90:	05800513          	li	a0,88
                flags |= UPPERCASE;
80002a94:	0407e793          	or	a5,a5,64
                base = 16;
80002a98:	01000613          	li	a2,16
        switch (*fmt)
80002a9c:	06a58863          	beq	a1,a0,80002b0c <ee_printf+0x2d4>
                if (*fmt != '%')
80002aa0:	02500793          	li	a5,37
80002aa4:	00f58863          	beq	a1,a5,80002ab4 <ee_printf+0x27c>
                    *str++ = '%';
80002aa8:	02500793          	li	a5,37
80002aac:	00fa8023          	sb	a5,0(s5)
80002ab0:	001a8a93          	add	s5,s5,1
                if (*fmt)
80002ab4:	00044783          	lbu	a5,0(s0)
80002ab8:	48078463          	beqz	a5,80002f40 <ee_printf+0x708>
                    *str++ = *fmt;
80002abc:	00fa8023          	sb	a5,0(s5)
80002ac0:	e55ff06f          	j	80002914 <ee_printf+0xdc>
            else if (*fmt == '*')
80002ac4:	02a00713          	li	a4,42
80002ac8:	00e61a63          	bne	a2,a4,80002adc <ee_printf+0x2a4>
                precision = va_arg(args, int);
80002acc:	000b2703          	lw	a4,0(s6)
                ++fmt;
80002ad0:	00240593          	add	a1,s0,2
                precision = va_arg(args, int);
80002ad4:	004b0b13          	add	s6,s6,4
80002ad8:	f75ff06f          	j	80002a4c <ee_printf+0x214>
            ++fmt;
80002adc:	00058413          	mv	s0,a1
                precision = 0;
80002ae0:	00000713          	li	a4,0
80002ae4:	f75ff06f          	j	80002a58 <ee_printf+0x220>
        switch (*fmt)
80002ae8:	f9f58613          	add	a2,a1,-97
80002aec:	0ff67613          	zext.b	a2,a2
80002af0:	01700313          	li	t1,23
80002af4:	fac366e3          	bltu	t1,a2,80002aa0 <ee_printf+0x268>
80002af8:	00261613          	sll	a2,a2,0x2
80002afc:	01260633          	add	a2,a2,s2
80002b00:	00062603          	lw	a2,0(a2)
80002b04:	00060067          	jr	a2
                base = 8;
80002b08:	00800613          	li	a2,8
            num = va_arg(args, unsigned long);
80002b0c:	000b2583          	lw	a1,0(s6)
                *str++ = (unsigned char)va_arg(args, int);
80002b10:	004b0493          	add	s1,s6,4
        str = number(str, num, base, field_width, precision, flags);
80002b14:	000b8693          	mv	a3,s7
80002b18:	16c0006f          	j	80002c84 <ee_printf+0x44c>
                if (!(flags & LEFT))
80002b1c:	0107f793          	and	a5,a5,16
80002b20:	02079e63          	bnez	a5,80002b5c <ee_printf+0x324>
                        *str++ = ' ';
80002b24:	fffb8493          	add	s1,s7,-1
80002b28:	00000993          	li	s3,0
80002b2c:	01705463          	blez	s7,80002b34 <ee_printf+0x2fc>
80002b30:	00048993          	mv	s3,s1
80002b34:	000a8513          	mv	a0,s5
80002b38:	00098613          	mv	a2,s3
80002b3c:	02000593          	li	a1,32
80002b40:	179020ef          	jal	800054b8 <memset>
80002b44:	013a8ab3          	add	s5,s5,s3
80002b48:	000b8693          	mv	a3,s7
80002b4c:	01704463          	bgtz	s7,80002b54 <ee_printf+0x31c>
80002b50:	00100693          	li	a3,1
80002b54:	40d484b3          	sub	s1,s1,a3
                    while (--field_width > 0)
80002b58:	00148b93          	add	s7,s1,1
                *str++ = (unsigned char)va_arg(args, int);
80002b5c:	000b2703          	lw	a4,0(s6)
80002b60:	001a8793          	add	a5,s5,1
80002b64:	004b0993          	add	s3,s6,4
80002b68:	00ea8023          	sb	a4,0(s5)
                    *str++ = ' ';
80002b6c:	00000a93          	li	s5,0
80002b70:	01705463          	blez	s7,80002b78 <ee_printf+0x340>
80002b74:	fffb8a93          	add	s5,s7,-1
80002b78:	000a8613          	mv	a2,s5
80002b7c:	02000593          	li	a1,32
80002b80:	00078513          	mv	a0,a5
80002b84:	135020ef          	jal	800054b8 <memset>
80002b88:	01550ab3          	add	s5,a0,s5
                *str++ = (unsigned char)va_arg(args, int);
80002b8c:	00098b13          	mv	s6,s3
    for (str = buf; *fmt; fmt++)
80002b90:	00140513          	add	a0,s0,1
80002b94:	d11ff06f          	j	800028a4 <ee_printf+0x6c>
                s = va_arg(args, char *);
80002b98:	000b2c83          	lw	s9,0(s6)
80002b9c:	004b0493          	add	s1,s6,4
                if (!s)
80002ba0:	000c9663          	bnez	s9,80002bac <ee_printf+0x374>
                    s = "<NULL>";
80002ba4:	80006cb7          	lui	s9,0x80006
80002ba8:	c20c8c93          	add	s9,s9,-992 # 80005c20 <_isatty_r+0xb2>
    for (sc = s; *sc != '\0' && count--; ++sc)
80002bac:	00ec8733          	add	a4,s9,a4
80002bb0:	000c8993          	mv	s3,s9
80002bb4:	0009c603          	lbu	a2,0(s3)
80002bb8:	00060463          	beqz	a2,80002bc0 <ee_printf+0x388>
80002bbc:	08e99463          	bne	s3,a4,80002c44 <ee_printf+0x40c>
                if (!(flags & LEFT))
80002bc0:	0107f793          	and	a5,a5,16
    return sc - s;
80002bc4:	419989b3          	sub	s3,s3,s9
                if (!(flags & LEFT))
80002bc8:	02079e63          	bnez	a5,80002c04 <ee_printf+0x3cc>
                        *str++ = ' ';
80002bcc:	413b8c33          	sub	s8,s7,s3
80002bd0:	00000a13          	li	s4,0
80002bd4:	013bc463          	blt	s7,s3,80002bdc <ee_printf+0x3a4>
80002bd8:	000c0a13          	mv	s4,s8
80002bdc:	000a8513          	mv	a0,s5
80002be0:	000a0613          	mv	a2,s4
80002be4:	02000593          	li	a1,32
80002be8:	0d1020ef          	jal	800054b8 <memset>
80002bec:	014a8ab3          	add	s5,s5,s4
80002bf0:	fffb8713          	add	a4,s7,-1
80002bf4:	00000793          	li	a5,0
80002bf8:	013bc463          	blt	s7,s3,80002c00 <ee_printf+0x3c8>
80002bfc:	418007b3          	neg	a5,s8
                    while (len < field_width--)
80002c00:	00f70bb3          	add	s7,a4,a5
                for (i = 0; i < len; ++i)
80002c04:	00000793          	li	a5,0
80002c08:	0537c263          	blt	a5,s3,80002c4c <ee_printf+0x414>
80002c0c:	00098793          	mv	a5,s3
80002c10:	0009d463          	bgez	s3,80002c18 <ee_printf+0x3e0>
80002c14:	00000793          	li	a5,0
80002c18:	00fa87b3          	add	a5,s5,a5
                    *str++ = ' ';
80002c1c:	00000a93          	li	s5,0
80002c20:	013bc463          	blt	s7,s3,80002c28 <ee_printf+0x3f0>
80002c24:	413b8ab3          	sub	s5,s7,s3
80002c28:	000a8613          	mv	a2,s5
80002c2c:	02000593          	li	a1,32
80002c30:	00078513          	mv	a0,a5
80002c34:	085020ef          	jal	800054b8 <memset>
80002c38:	01550ab3          	add	s5,a0,s5
        str = number(str, num, base, field_width, precision, flags);
80002c3c:	00048b13          	mv	s6,s1
80002c40:	f51ff06f          	j	80002b90 <ee_printf+0x358>
    for (sc = s; *sc != '\0' && count--; ++sc)
80002c44:	00198993          	add	s3,s3,1
80002c48:	f6dff06f          	j	80002bb4 <ee_printf+0x37c>
                    *str++ = *s++;
80002c4c:	00fc8733          	add	a4,s9,a5
80002c50:	00074603          	lbu	a2,0(a4)
80002c54:	00fa8733          	add	a4,s5,a5
                for (i = 0; i < len; ++i)
80002c58:	00178793          	add	a5,a5,1
                    *str++ = *s++;
80002c5c:	00c70023          	sb	a2,0(a4)
                for (i = 0; i < len; ++i)
80002c60:	fa9ff06f          	j	80002c08 <ee_printf+0x3d0>
                if (field_width == -1)
80002c64:	fff00613          	li	a2,-1
80002c68:	00cb9663          	bne	s7,a2,80002c74 <ee_printf+0x43c>
                    flags |= ZEROPAD;
80002c6c:	0017e793          	or	a5,a5,1
                    field_width = 2 * sizeof(void *);
80002c70:	00800b93          	li	s7,8
                str = number(str,
80002c74:	000b2583          	lw	a1,0(s6)
                             (unsigned long)va_arg(args, void *),
80002c78:	004b0493          	add	s1,s6,4
                str = number(str,
80002c7c:	000b8693          	mv	a3,s7
80002c80:	01000613          	li	a2,16
        str = number(str, num, base, field_width, precision, flags);
80002c84:	000a8513          	mv	a0,s5
80002c88:	911ff0ef          	jal	80002598 <number>
80002c8c:	00050a93          	mv	s5,a0
80002c90:	fadff06f          	j	80002c3c <ee_printf+0x404>
                flags |= UPPERCASE;
80002c94:	0407e793          	or	a5,a5,64
                if (qualifier == 'l')
80002c98:	06c00713          	li	a4,108
                s = va_arg(args, char *);
80002c9c:	000b2a03          	lw	s4,0(s6)
                *str++ = (unsigned char)va_arg(args, int);
80002ca0:	004b0b13          	add	s6,s6,4
                if (qualifier == 'l')
80002ca4:	10e51463          	bne	a0,a4,80002dac <ee_printf+0x574>
    if (type & UPPERCASE)
80002ca8:	0407f713          	and	a4,a5,64
80002cac:	06070863          	beqz	a4,80002d1c <ee_printf+0x4e4>
        dig = upper_digits;
80002cb0:	80006737          	lui	a4,0x80006
80002cb4:	bf870713          	add	a4,a4,-1032 # 80005bf8 <_isatty_r+0x8a>
    for (i = 0; i < 6; i++)
80002cb8:	00000513          	li	a0,0
    len = 0;
80002cbc:	00000593          	li	a1,0
    for (i = 0; i < 6; i++)
80002cc0:	00600f13          	li	t5,6
            tmp[len++] = ':';
80002cc4:	03a00e93          	li	t4,58
        tmp[len++] = dig[addr[i] >> 4];
80002cc8:	00aa0633          	add	a2,s4,a0
80002ccc:	00064603          	lbu	a2,0(a2)
80002cd0:	12058693          	add	a3,a1,288
80002cd4:	01010813          	add	a6,sp,16
80002cd8:	00465313          	srl	t1,a2,0x4
        tmp[len++] = dig[addr[i] & 0x0F];
80002cdc:	00f67613          	and	a2,a2,15
        tmp[len++] = dig[addr[i] >> 4];
80002ce0:	00670333          	add	t1,a4,t1
        tmp[len++] = dig[addr[i] & 0x0F];
80002ce4:	00c70633          	add	a2,a4,a2
        tmp[len++] = dig[addr[i] >> 4];
80002ce8:	00034e03          	lbu	t3,0(t1)
        tmp[len++] = dig[addr[i] & 0x0F];
80002cec:	00064603          	lbu	a2,0(a2)
        tmp[len++] = dig[addr[i] >> 4];
80002cf0:	01068333          	add	t1,a3,a6
80002cf4:	efc30423          	sb	t3,-280(t1)
        tmp[len++] = dig[addr[i] & 0x0F];
80002cf8:	eec304a3          	sb	a2,-279(t1)
    for (i = 0; i < 6; i++)
80002cfc:	00150513          	add	a0,a0,1
        tmp[len++] = dig[addr[i] & 0x0F];
80002d00:	00258e13          	add	t3,a1,2
    for (i = 0; i < 6; i++)
80002d04:	03e50263          	beq	a0,t5,80002d28 <ee_printf+0x4f0>
            tmp[len++] = ':';
80002d08:	120e0693          	add	a3,t3,288
80002d0c:	01068633          	add	a2,a3,a6
80002d10:	00358593          	add	a1,a1,3
80002d14:	efd60423          	sb	t4,-280(a2)
80002d18:	fb1ff06f          	j	80002cc8 <ee_printf+0x490>
    char *dig = digits;
80002d1c:	80006737          	lui	a4,0x80006
80002d20:	bd070713          	add	a4,a4,-1072 # 80005bd0 <_isatty_r+0x62>
80002d24:	f95ff06f          	j	80002cb8 <ee_printf+0x480>
    if (!(type & LEFT))
80002d28:	0107f793          	and	a5,a5,16
80002d2c:	04079263          	bnez	a5,80002d70 <ee_printf+0x538>
            *str++ = ' ';
80002d30:	01000793          	li	a5,16
80002d34:	fefb8993          	add	s3,s7,-17
80002d38:	00000493          	li	s1,0
80002d3c:	0177d463          	bge	a5,s7,80002d44 <ee_printf+0x50c>
80002d40:	00098493          	mv	s1,s3
80002d44:	000a8513          	mv	a0,s5
80002d48:	00048613          	mv	a2,s1
80002d4c:	02000593          	li	a1,32
80002d50:	768020ef          	jal	800054b8 <memset>
        while (len < size--)
80002d54:	01000713          	li	a4,16
80002d58:	009a8ab3          	add	s5,s5,s1
80002d5c:	00000793          	li	a5,0
80002d60:	01775463          	bge	a4,s7,80002d68 <ee_printf+0x530>
80002d64:	413007b3          	neg	a5,s3
80002d68:	fffb8693          	add	a3,s7,-1
80002d6c:	00d78bb3          	add	s7,a5,a3
        *str++ = tmp[i];
80002d70:	000a8513          	mv	a0,s5
80002d74:	01100613          	li	a2,17
80002d78:	01810593          	add	a1,sp,24
80002d7c:	5f6020ef          	jal	80005372 <memcpy>
        *str++ = ' ';
80002d80:	01000793          	li	a5,16
80002d84:	011a8813          	add	a6,s5,17
80002d88:	00000a93          	li	s5,0
80002d8c:	0177d463          	bge	a5,s7,80002d94 <ee_printf+0x55c>
80002d90:	fefb8a93          	add	s5,s7,-17
        *str++ = ' ';
80002d94:	000a8613          	mv	a2,s5
80002d98:	02000593          	li	a1,32
80002d9c:	00080513          	mv	a0,a6
80002da0:	718020ef          	jal	800054b8 <memset>
80002da4:	01550ab3          	add	s5,a0,s5
    return str;
80002da8:	de9ff06f          	j	80002b90 <ee_printf+0x358>
80002dac:	800064b7          	lui	s1,0x80006
    for (i = 0; i < 4; i++)
80002db0:	00000d13          	li	s10,0
    len = 0;
80002db4:	00000c93          	li	s9,0
80002db8:	bd048493          	add	s1,s1,-1072 # 80005bd0 <_isatty_r+0x62>
        n = addr[i];
80002dbc:	01aa0733          	add	a4,s4,s10
80002dc0:	00074983          	lbu	s3,0(a4)
        if (n == 0)
80002dc4:	01010693          	add	a3,sp,16
80002dc8:	120c8713          	add	a4,s9,288
            tmp[len++] = digits[0];
80002dcc:	001c8c13          	add	s8,s9,1
80002dd0:	00d70db3          	add	s11,a4,a3
        if (n == 0)
80002dd4:	02099a63          	bnez	s3,80002e08 <ee_printf+0x5d0>
            tmp[len++] = digits[0];
80002dd8:	03000713          	li	a4,48
80002ddc:	eeed8423          	sb	a4,-280(s11)
    for (i = 0; i < 4; i++)
80002de0:	001d0d13          	add	s10,s10,1
80002de4:	00400713          	li	a4,4
80002de8:	0eed0463          	beq	s10,a4,80002ed0 <ee_printf+0x698>
            tmp[len++] = '.';
80002dec:	01010693          	add	a3,sp,16
80002df0:	120c0713          	add	a4,s8,288
80002df4:	00d70733          	add	a4,a4,a3
80002df8:	02e00693          	li	a3,46
80002dfc:	001c0c93          	add	s9,s8,1
80002e00:	eed70423          	sb	a3,-280(a4)
80002e04:	fb9ff06f          	j	80002dbc <ee_printf+0x584>
            if (n >= 100)
80002e08:	06300713          	li	a4,99
80002e0c:	09375463          	bge	a4,s3,80002e94 <ee_printf+0x65c>
                tmp[len++] = digits[n / 100];
80002e10:	06400593          	li	a1,100
80002e14:	00098513          	mv	a0,s3
80002e18:	00f12623          	sw	a5,12(sp)
80002e1c:	019010ef          	jal	80004634 <__divsi3>
80002e20:	00a48533          	add	a0,s1,a0
80002e24:	00054583          	lbu	a1,0(a0)
                n          = n % 100;
80002e28:	00098513          	mv	a0,s3
                tmp[len++] = digits[n / 10];
80002e2c:	002c8c93          	add	s9,s9,2
                tmp[len++] = digits[n / 100];
80002e30:	eebd8423          	sb	a1,-280(s11)
                n          = n % 100;
80002e34:	06400593          	li	a1,100
80002e38:	055010ef          	jal	8000468c <__modsi3>
                tmp[len++] = digits[n / 10];
80002e3c:	120c0793          	add	a5,s8,288
80002e40:	01010713          	add	a4,sp,16
80002e44:	00a00593          	li	a1,10
                n          = n % 100;
80002e48:	00050993          	mv	s3,a0
                tmp[len++] = digits[n / 10];
80002e4c:	00e78c33          	add	s8,a5,a4
80002e50:	7e4010ef          	jal	80004634 <__divsi3>
80002e54:	00a48533          	add	a0,s1,a0
80002e58:	00054583          	lbu	a1,0(a0)
                n          = n % 10;
80002e5c:	00098513          	mv	a0,s3
                tmp[len++] = digits[n / 10];
80002e60:	eebc0423          	sb	a1,-280(s8)
                n          = n % 10;
80002e64:	00a00593          	li	a1,10
80002e68:	025010ef          	jal	8000468c <__modsi3>
80002e6c:	00050993          	mv	s3,a0
                tmp[len++] = digits[n / 10];
80002e70:	00c12783          	lw	a5,12(sp)
            tmp[len++] = digits[n];
80002e74:	013489b3          	add	s3,s1,s3
80002e78:	0009c583          	lbu	a1,0(s3)
80002e7c:	120c8713          	add	a4,s9,288
80002e80:	01010693          	add	a3,sp,16
80002e84:	00d70633          	add	a2,a4,a3
80002e88:	001c8c13          	add	s8,s9,1
80002e8c:	eeb60423          	sb	a1,-280(a2)
80002e90:	f51ff06f          	j	80002de0 <ee_printf+0x5a8>
            else if (n >= 10)
80002e94:	00900593          	li	a1,9
80002e98:	fd35dee3          	bge	a1,s3,80002e74 <ee_printf+0x63c>
                tmp[len++] = digits[n / 10];
80002e9c:	00a00593          	li	a1,10
80002ea0:	00098513          	mv	a0,s3
80002ea4:	00f12623          	sw	a5,12(sp)
80002ea8:	78c010ef          	jal	80004634 <__divsi3>
80002eac:	00a48533          	add	a0,s1,a0
80002eb0:	00054603          	lbu	a2,0(a0)
                n          = n % 10;
80002eb4:	00a00593          	li	a1,10
80002eb8:	00098513          	mv	a0,s3
                tmp[len++] = digits[n / 10];
80002ebc:	eecd8423          	sb	a2,-280(s11)
                n          = n % 10;
80002ec0:	7cc010ef          	jal	8000468c <__modsi3>
80002ec4:	00050993          	mv	s3,a0
                tmp[len++] = digits[n / 10];
80002ec8:	000c0c93          	mv	s9,s8
80002ecc:	fa5ff06f          	j	80002e70 <ee_printf+0x638>
    if (!(type & LEFT))
80002ed0:	0107f793          	and	a5,a5,16
80002ed4:	02079e63          	bnez	a5,80002f10 <ee_printf+0x6d8>
            *str++ = ' ';
80002ed8:	418b89b3          	sub	s3,s7,s8
80002edc:	00000493          	li	s1,0
80002ee0:	018bc463          	blt	s7,s8,80002ee8 <ee_printf+0x6b0>
80002ee4:	00098493          	mv	s1,s3
80002ee8:	000a8513          	mv	a0,s5
80002eec:	00048613          	mv	a2,s1
80002ef0:	02000593          	li	a1,32
80002ef4:	5c4020ef          	jal	800054b8 <memset>
80002ef8:	009a8ab3          	add	s5,s5,s1
        while (len < size--)
80002efc:	00000793          	li	a5,0
80002f00:	018bc463          	blt	s7,s8,80002f08 <ee_printf+0x6d0>
80002f04:	413007b3          	neg	a5,s3
80002f08:	fffb8693          	add	a3,s7,-1
80002f0c:	00d78bb3          	add	s7,a5,a3
        *str++ = tmp[i];
80002f10:	000a8513          	mv	a0,s5
80002f14:	000c0613          	mv	a2,s8
80002f18:	01810593          	add	a1,sp,24
80002f1c:	456020ef          	jal	80005372 <memcpy>
80002f20:	018a8833          	add	a6,s5,s8
        *str++ = ' ';
80002f24:	00000a93          	li	s5,0
80002f28:	e78bc6e3          	blt	s7,s8,80002d94 <ee_printf+0x55c>
80002f2c:	418b8ab3          	sub	s5,s7,s8
80002f30:	e65ff06f          	j	80002d94 <ee_printf+0x55c>
                flags |= SIGN;
80002f34:	0027e793          	or	a5,a5,2
        base = 10;
80002f38:	00a00613          	li	a2,10
80002f3c:	bd1ff06f          	j	80002b0c <ee_printf+0x2d4>
                    --fmt;
80002f40:	fff40413          	add	s0,s0,-1
80002f44:	c4dff06f          	j	80002b90 <ee_printf+0x358>
        switch (*fmt)
80002f48:	01000613          	li	a2,16
80002f4c:	bc1ff06f          	j	80002b0c <ee_printf+0x2d4>
        uart_send_char(*p);
80002f50:	8ddff0ef          	jal	8000282c <uart_send_char>
        n++;
80002f54:	00140413          	add	s0,s0,1
        p++;
80002f58:	95dff06f          	j	800028b4 <ee_printf+0x7c>

80002f5c <exp>:
80002f5c:	1101                	add	sp,sp,-32
80002f5e:	cc22                	sw	s0,24(sp)
80002f60:	ca26                	sw	s1,20(sp)
80002f62:	ce06                	sw	ra,28(sp)
80002f64:	c42a                	sw	a0,8(sp)
80002f66:	c62e                	sw	a1,12(sp)
80002f68:	2885                	jal	80002fd8 <__ieee754_exp>
80002f6a:	84aa                	mv	s1,a0
80002f6c:	842e                	mv	s0,a1
80002f6e:	4522                	lw	a0,8(sp)
80002f70:	45b2                	lw	a1,12(sp)
80002f72:	2625                	jal	8000329a <finite>
80002f74:	c10d                	beqz	a0,80002f96 <exp+0x3a>
80002f76:	800067b7          	lui	a5,0x80006
80002f7a:	e187b787          	fld	fa5,-488(a5) # 80005e18 <__clz_tab+0x124>
80002f7e:	2722                	fld	fa4,8(sp)
80002f80:	a2e797d3          	flt.d	a5,fa5,fa4
80002f84:	e385                	bnez	a5,80002fa4 <exp+0x48>
80002f86:	800067b7          	lui	a5,0x80006
80002f8a:	e207b787          	fld	fa5,-480(a5) # 80005e20 <__clz_tab+0x12c>
80002f8e:	2722                	fld	fa4,8(sp)
80002f90:	a2f717d3          	flt.d	a5,fa4,fa5
80002f94:	eb95                	bnez	a5,80002fc8 <exp+0x6c>
80002f96:	40f2                	lw	ra,28(sp)
80002f98:	85a2                	mv	a1,s0
80002f9a:	4462                	lw	s0,24(sp)
80002f9c:	8526                	mv	a0,s1
80002f9e:	44d2                	lw	s1,20(sp)
80002fa0:	6105                	add	sp,sp,32
80002fa2:	8082                	ret
80002fa4:	79a010ef          	jal	8000473e <__errno>
80002fa8:	800067b7          	lui	a5,0x80006
80002fac:	e147a403          	lw	s0,-492(a5) # 80005e14 <__clz_tab+0x120>
80002fb0:	e107a483          	lw	s1,-496(a5)
80002fb4:	40f2                	lw	ra,28(sp)
80002fb6:	85a2                	mv	a1,s0
80002fb8:	4462                	lw	s0,24(sp)
80002fba:	02200793          	li	a5,34
80002fbe:	c11c                	sw	a5,0(a0)
80002fc0:	8526                	mv	a0,s1
80002fc2:	44d2                	lw	s1,20(sp)
80002fc4:	6105                	add	sp,sp,32
80002fc6:	8082                	ret
80002fc8:	776010ef          	jal	8000473e <__errno>
80002fcc:	02200793          	li	a5,34
80002fd0:	c11c                	sw	a5,0(a0)
80002fd2:	4481                	li	s1,0
80002fd4:	4401                	li	s0,0
80002fd6:	b7c1                	j	80002f96 <exp+0x3a>

80002fd8 <__ieee754_exp>:
80002fd8:	1141                	add	sp,sp,-16
80002fda:	40863737          	lui	a4,0x40863
80002fde:	00159793          	sll	a5,a1,0x1
80002fe2:	c42a                	sw	a0,8(sp)
80002fe4:	c62e                	sw	a1,12(sp)
80002fe6:	e4170713          	add	a4,a4,-447 # 40862e41 <_reset_entry-0x3f79d1bf>
80002fea:	8385                	srl	a5,a5,0x1
80002fec:	01f5d613          	srl	a2,a1,0x1f
80002ff0:	02f77563          	bgeu	a4,a5,8000301a <__ieee754_exp+0x42>
80002ff4:	7ff00737          	lui	a4,0x7ff00
80002ff8:	0ae7e563          	bltu	a5,a4,800030a2 <__ieee754_exp+0xca>
80002ffc:	47a2                	lw	a5,8(sp)
80002ffe:	00c59693          	sll	a3,a1,0xc
80003002:	82b1                	srl	a3,a3,0xc
80003004:	8edd                	or	a3,a3,a5
80003006:	1e068563          	beqz	a3,800031f0 <__ieee754_exp+0x218>
8000300a:	27a2                	fld	fa5,8(sp)
8000300c:	02f7f7d3          	fadd.d	fa5,fa5,fa5
80003010:	a43e                	fsd	fa5,8(sp)
80003012:	4522                	lw	a0,8(sp)
80003014:	45b2                	lw	a1,12(sp)
80003016:	0141                	add	sp,sp,16
80003018:	8082                	ret
8000301a:	3fd63737          	lui	a4,0x3fd63
8000301e:	e4270713          	add	a4,a4,-446 # 3fd62e42 <_reset_entry-0x4029d1be>
80003022:	18f76c63          	bltu	a4,a5,800031ba <__ieee754_exp+0x1e2>
80003026:	3df00737          	lui	a4,0x3df00
8000302a:	16e7e663          	bltu	a5,a4,80003196 <__ieee754_exp+0x1be>
8000302e:	800067b7          	lui	a5,0x80006
80003032:	27a2                	fld	fa5,8(sp)
80003034:	80006737          	lui	a4,0x80006
80003038:	e4073707          	fld	fa4,-448(a4) # 80005e40 <__clz_tab+0x14c>
8000303c:	12f7f7d3          	fmul.d	fa5,fa5,fa5
80003040:	80006737          	lui	a4,0x80006
80003044:	e4873687          	fld	fa3,-440(a4) # 80005e48 <__clz_tab+0x154>
80003048:	80006737          	lui	a4,0x80006
8000304c:	6ae7f743          	fmadd.d	fa4,fa5,fa4,fa3
80003050:	e5073687          	fld	fa3,-432(a4) # 80005e50 <__clz_tab+0x15c>
80003054:	80006737          	lui	a4,0x80006
80003058:	6af77743          	fmadd.d	fa4,fa4,fa5,fa3
8000305c:	e5873687          	fld	fa3,-424(a4) # 80005e58 <__clz_tab+0x164>
80003060:	80006737          	lui	a4,0x80006
80003064:	6ae7f743          	fmadd.d	fa4,fa5,fa4,fa3
80003068:	e6073687          	fld	fa3,-416(a4) # 80005e60 <__clz_tab+0x16c>
8000306c:	6ae7f743          	fmadd.d	fa4,fa5,fa4,fa3
80003070:	26a2                	fld	fa3,8(sp)
80003072:	6ae7f7cb          	fnmsub.d	fa5,fa5,fa4,fa3
80003076:	12f6f6d3          	fmul.d	fa3,fa3,fa5
8000307a:	e707b707          	fld	fa4,-400(a5) # 80005e70 <__clz_tab+0x17c>
8000307e:	800067b7          	lui	a5,0x80006
80003082:	e787b607          	fld	fa2,-392(a5) # 80005e78 <__clz_tab+0x184>
80003086:	0ac7f7d3          	fsub.d	fa5,fa5,fa2
8000308a:	1af6f6d3          	fdiv.d	fa3,fa3,fa5
8000308e:	27a2                	fld	fa5,8(sp)
80003090:	0af6f6d3          	fsub.d	fa3,fa3,fa5
80003094:	0ad777d3          	fsub.d	fa5,fa4,fa3
80003098:	a43e                	fsd	fa5,8(sp)
8000309a:	4522                	lw	a0,8(sp)
8000309c:	45b2                	lw	a1,12(sp)
8000309e:	0141                	add	sp,sp,16
800030a0:	8082                	ret
800030a2:	800067b7          	lui	a5,0x80006
800030a6:	e187b787          	fld	fa5,-488(a5) # 80005e18 <__clz_tab+0x124>
800030aa:	2722                	fld	fa4,8(sp)
800030ac:	a2e797d3          	flt.d	a5,fa5,fa4
800030b0:	14079463          	bnez	a5,800031f8 <__ieee754_exp+0x220>
800030b4:	800067b7          	lui	a5,0x80006
800030b8:	e207b787          	fld	fa5,-480(a5) # 80005e20 <__clz_tab+0x12c>
800030bc:	a2f717d3          	flt.d	a5,fa4,fa5
800030c0:	16079263          	bnez	a5,80003224 <__ieee754_exp+0x24c>
800030c4:	800067b7          	lui	a5,0x80006
800030c8:	060e                	sll	a2,a2,0x3
800030ca:	ca878793          	add	a5,a5,-856 # 80005ca8 <halF>
800030ce:	97b2                	add	a5,a5,a2
800030d0:	2398                	fld	fa4,0(a5)
800030d2:	800067b7          	lui	a5,0x80006
800030d6:	e287b787          	fld	fa5,-472(a5) # 80005e28 <__clz_tab+0x134>
800030da:	26a2                	fld	fa3,8(sp)
800030dc:	80006737          	lui	a4,0x80006
800030e0:	e3073607          	fld	fa2,-464(a4) # 80005e30 <__clz_tab+0x13c>
800030e4:	72f6f7c3          	fmadd.d	fa5,fa3,fa5,fa4
800030e8:	80006737          	lui	a4,0x80006
800030ec:	c20797d3          	fcvt.w.d	a5,fa5,rtz
800030f0:	e3873787          	fld	fa5,-456(a4) # 80005e38 <__clz_tab+0x144>
800030f4:	d2078753          	fcvt.d.w	fa4,a5
800030f8:	6ac7764b          	fnmsub.d	fa2,fa4,fa2,fa3
800030fc:	12f77753          	fmul.d	fa4,fa4,fa5
80003100:	0ae677d3          	fsub.d	fa5,fa2,fa4
80003104:	80006737          	lui	a4,0x80006
80003108:	12f7f6d3          	fmul.d	fa3,fa5,fa5
8000310c:	a43e                	fsd	fa5,8(sp)
8000310e:	e4073787          	fld	fa5,-448(a4) # 80005e40 <__clz_tab+0x14c>
80003112:	80006737          	lui	a4,0x80006
80003116:	e4873587          	fld	fa1,-440(a4) # 80005e48 <__clz_tab+0x154>
8000311a:	80006737          	lui	a4,0x80006
8000311e:	5af6f7c3          	fmadd.d	fa5,fa3,fa5,fa1
80003122:	e5073587          	fld	fa1,-432(a4) # 80005e50 <__clz_tab+0x15c>
80003126:	80006737          	lui	a4,0x80006
8000312a:	5ad7f7c3          	fmadd.d	fa5,fa5,fa3,fa1
8000312e:	e5873587          	fld	fa1,-424(a4) # 80005e58 <__clz_tab+0x164>
80003132:	80006737          	lui	a4,0x80006
80003136:	5ad7f7c3          	fmadd.d	fa5,fa5,fa3,fa1
8000313a:	e6073587          	fld	fa1,-416(a4) # 80005e60 <__clz_tab+0x16c>
8000313e:	5ad7f7c3          	fmadd.d	fa5,fa5,fa3,fa1
80003142:	0ae675d3          	fsub.d	fa1,fa2,fa4
80003146:	5ad7f7cb          	fnmsub.d	fa5,fa5,fa3,fa1
8000314a:	12f5f6d3          	fmul.d	fa3,fa1,fa5
8000314e:	cff1                	beqz	a5,8000322a <__ieee754_exp+0x252>
80003150:	80006737          	lui	a4,0x80006
80003154:	e7873587          	fld	fa1,-392(a4) # 80005e78 <__clz_tab+0x184>
80003158:	800066b7          	lui	a3,0x80006
8000315c:	c0300713          	li	a4,-1021
80003160:	0af5f7d3          	fsub.d	fa5,fa1,fa5
80003164:	1af6f6d3          	fdiv.d	fa3,fa3,fa5
80003168:	e706b787          	fld	fa5,-400(a3) # 80005e70 <__clz_tab+0x17c>
8000316c:	0ad77753          	fsub.d	fa4,fa4,fa3
80003170:	0ac77753          	fsub.d	fa4,fa4,fa2
80003174:	0ae7f7d3          	fsub.d	fa5,fa5,fa4
80003178:	a43e                	fsd	fa5,8(sp)
8000317a:	4622                	lw	a2,8(sp)
8000317c:	46b2                	lw	a3,12(sp)
8000317e:	08e7c063          	blt	a5,a4,800031fe <__ieee754_exp+0x226>
80003182:	07d2                	sll	a5,a5,0x14
80003184:	97b6                	add	a5,a5,a3
80003186:	c432                	sw	a2,8(sp)
80003188:	c63e                	sw	a5,12(sp)
8000318a:	27a2                	fld	fa5,8(sp)
8000318c:	a43e                	fsd	fa5,8(sp)
8000318e:	4522                	lw	a0,8(sp)
80003190:	45b2                	lw	a1,12(sp)
80003192:	0141                	add	sp,sp,16
80003194:	8082                	ret
80003196:	80006737          	lui	a4,0x80006
8000319a:	e6873707          	fld	fa4,-408(a4) # 80005e68 <__clz_tab+0x174>
8000319e:	26a2                	fld	fa3,8(sp)
800031a0:	800067b7          	lui	a5,0x80006
800031a4:	e707b787          	fld	fa5,-400(a5) # 80005e70 <__clz_tab+0x17c>
800031a8:	02e6f753          	fadd.d	fa4,fa3,fa4
800031ac:	a2e79753          	flt.d	a4,fa5,fa4
800031b0:	e80701e3          	beqz	a4,80003032 <__ieee754_exp+0x5a>
800031b4:	02f6f7d3          	fadd.d	fa5,fa3,fa5
800031b8:	bfd1                	j	8000318c <__ieee754_exp+0x1b4>
800031ba:	3ff0a737          	lui	a4,0x3ff0a
800031be:	2b170713          	add	a4,a4,689 # 3ff0a2b1 <_reset_entry-0x400f5d4f>
800031c2:	f0f761e3          	bltu	a4,a5,800030c4 <__ieee754_exp+0xec>
800031c6:	800067b7          	lui	a5,0x80006
800031ca:	00361693          	sll	a3,a2,0x3
800031ce:	c9878793          	add	a5,a5,-872 # 80005c98 <ln2HI>
800031d2:	97b6                	add	a5,a5,a3
800031d4:	2390                	fld	fa2,0(a5)
800031d6:	27a2                	fld	fa5,8(sp)
800031d8:	80006737          	lui	a4,0x80006
800031dc:	c8870713          	add	a4,a4,-888 # 80005c88 <ln2LO>
800031e0:	4785                	li	a5,1
800031e2:	9736                	add	a4,a4,a3
800031e4:	8f91                	sub	a5,a5,a2
800031e6:	0ac7f653          	fsub.d	fa2,fa5,fa2
800031ea:	2318                	fld	fa4,0(a4)
800031ec:	8f91                	sub	a5,a5,a2
800031ee:	bf09                	j	80003100 <__ieee754_exp+0x128>
800031f0:	d20007d3          	fcvt.d.w	fa5,zero
800031f4:	fe41                	bnez	a2,8000318c <__ieee754_exp+0x1b4>
800031f6:	bf51                	j	8000318a <__ieee754_exp+0x1b2>
800031f8:	4501                	li	a0,0
800031fa:	0141                	add	sp,sp,16
800031fc:	a841                	j	8000328c <__math_oflow>
800031fe:	3e878793          	add	a5,a5,1000
80003202:	07d2                	sll	a5,a5,0x14
80003204:	00d785b3          	add	a1,a5,a3
80003208:	c432                	sw	a2,8(sp)
8000320a:	c62e                	sw	a1,12(sp)
8000320c:	800067b7          	lui	a5,0x80006
80003210:	2722                	fld	fa4,8(sp)
80003212:	e807b787          	fld	fa5,-384(a5) # 80005e80 <__clz_tab+0x18c>
80003216:	12e7f7d3          	fmul.d	fa5,fa5,fa4
8000321a:	a43e                	fsd	fa5,8(sp)
8000321c:	4522                	lw	a0,8(sp)
8000321e:	45b2                	lw	a1,12(sp)
80003220:	0141                	add	sp,sp,16
80003222:	8082                	ret
80003224:	4501                	li	a0,0
80003226:	0141                	add	sp,sp,16
80003228:	a899                	j	8000327e <__math_uflow>
8000322a:	800067b7          	lui	a5,0x80006
8000322e:	b5b1                	j	8000307a <__ieee754_exp+0xa2>

80003230 <with_errno>:
80003230:	1141                	add	sp,sp,-16
80003232:	c422                	sw	s0,8(sp)
80003234:	c226                	sw	s1,4(sp)
80003236:	c04a                	sw	s2,0(sp)
80003238:	c606                	sw	ra,12(sp)
8000323a:	892a                	mv	s2,a0
8000323c:	84ae                	mv	s1,a1
8000323e:	8432                	mv	s0,a2
80003240:	4fe010ef          	jal	8000473e <__errno>
80003244:	c100                	sw	s0,0(a0)
80003246:	40b2                	lw	ra,12(sp)
80003248:	4422                	lw	s0,8(sp)
8000324a:	854a                	mv	a0,s2
8000324c:	85a6                	mv	a1,s1
8000324e:	4902                	lw	s2,0(sp)
80003250:	4492                	lw	s1,4(sp)
80003252:	0141                	add	sp,sp,16
80003254:	8082                	ret

80003256 <xflow>:
80003256:	1101                	add	sp,sp,-32
80003258:	c42e                	sw	a1,8(sp)
8000325a:	c632                	sw	a2,12(sp)
8000325c:	27a2                	fld	fa5,8(sp)
8000325e:	22f78753          	fmv.d	fa4,fa5
80003262:	c119                	beqz	a0,80003268 <xflow+0x12>
80003264:	22f79753          	fneg.d	fa4,fa5
80003268:	ac3a                	fsd	fa4,24(sp)
8000326a:	2762                	fld	fa4,24(sp)
8000326c:	02200613          	li	a2,34
80003270:	12e7f7d3          	fmul.d	fa5,fa5,fa4
80003274:	a43e                	fsd	fa5,8(sp)
80003276:	4522                	lw	a0,8(sp)
80003278:	45b2                	lw	a1,12(sp)
8000327a:	6105                	add	sp,sp,32
8000327c:	bf55                	j	80003230 <with_errno>

8000327e <__math_uflow>:
8000327e:	800067b7          	lui	a5,0x80006
80003282:	e887a583          	lw	a1,-376(a5) # 80005e88 <__clz_tab+0x194>
80003286:	e8c7a603          	lw	a2,-372(a5)
8000328a:	b7f1                	j	80003256 <xflow>

8000328c <__math_oflow>:
8000328c:	800067b7          	lui	a5,0x80006
80003290:	e987a583          	lw	a1,-360(a5) # 80005e98 <__clz_tab+0x1a4>
80003294:	e9c7a603          	lw	a2,-356(a5)
80003298:	bf7d                	j	80003256 <xflow>

8000329a <finite>:
8000329a:	1141                	add	sp,sp,-16
8000329c:	c42a                	sw	a0,8(sp)
8000329e:	c62e                	sw	a1,12(sp)
800032a0:	27a2                	fld	fa5,8(sp)
800032a2:	e2079553          	fclass.d	a0,fa5
800032a6:	38157513          	and	a0,a0,897
800032aa:	00153513          	seqz	a0,a0
800032ae:	0141                	add	sp,sp,16
800032b0:	8082                	ret

800032b2 <__addsf3>:
#include "soft-fp.h"
#include "single.h"

SFtype
__addsf3 (SFtype a, SFtype b)
{
800032b2:	1101                	add	sp,sp,-32
800032b4:	cc22                	sw	s0,24(sp)
800032b6:	ce06                	sw	ra,28(sp)
800032b8:	842a                	mv	s0,a0
800032ba:	ca26                	sw	s1,20(sp)
800032bc:	c84a                	sw	s2,16(sp)
800032be:	c64e                	sw	s3,12(sp)
800032c0:	852e                	mv	a0,a1
  FP_DECL_S (A);
  FP_DECL_S (B);
  FP_DECL_S (R);
  SFtype r;

  FP_INIT_ROUNDMODE;
800032c2:	00202973          	frrm	s2
  FP_UNPACK_SEMIRAW_S (A, a);
800032c6:	008007b7          	lui	a5,0x800
800032ca:	17fd                	add	a5,a5,-1 # 7fffff <_reset_entry-0x7f800001>
800032cc:	0087f733          	and	a4,a5,s0
800032d0:	01745993          	srl	s3,s0,0x17
  FP_UNPACK_SEMIRAW_S (B, b);
800032d4:	8fed                	and	a5,a5,a1
800032d6:	81dd                	srl	a1,a1,0x17
  FP_UNPACK_SEMIRAW_S (A, a);
800032d8:	0ff9f993          	zext.b	s3,s3
  FP_UNPACK_SEMIRAW_S (B, b);
800032dc:	0ff5f593          	zext.b	a1,a1
  FP_UNPACK_SEMIRAW_S (A, a);
800032e0:	807d                	srl	s0,s0,0x1f
  FP_UNPACK_SEMIRAW_S (B, b);
800032e2:	817d                	srl	a0,a0,0x1f
  FP_UNPACK_SEMIRAW_S (A, a);
800032e4:	070e                	sll	a4,a4,0x3
  FP_UNPACK_SEMIRAW_S (B, b);
800032e6:	00379613          	sll	a2,a5,0x3
  FP_ADD_S (R, A, B);
800032ea:	40b986b3          	sub	a3,s3,a1
800032ee:	26a41d63          	bne	s0,a0,80003568 <__addsf3+0x2b6>
800032f2:	0cd05763          	blez	a3,800033c0 <__addsf3+0x10e>
800032f6:	e1bd                	bnez	a1,8000335c <__addsf3+0xaa>
800032f8:	ea09                	bnez	a2,8000330a <__addsf3+0x58>
800032fa:	0ff00793          	li	a5,255
800032fe:	04f68663          	beq	a3,a5,8000334a <__addsf3+0x98>
80003302:	863a                	mv	a2,a4
  FP_DECL_EX;
80003304:	4781                	li	a5,0
  FP_ADD_S (R, A, B);
80003306:	85b6                	mv	a1,a3
80003308:	a819                	j	8000331e <__addsf3+0x6c>
8000330a:	fff68793          	add	a5,a3,-1
8000330e:	eb95                	bnez	a5,80003342 <__addsf3+0x90>
80003310:	963a                	add	a2,a2,a4
80003312:	04000737          	lui	a4,0x4000
80003316:	8f71                	and	a4,a4,a2
80003318:	4589                	li	a1,2
8000331a:	eb41                	bnez	a4,800033aa <__addsf3+0xf8>
8000331c:	4585                	li	a1,1
  FP_PACK_SEMIRAW_S (r, R);
8000331e:	00767713          	and	a4,a2,7
80003322:	16070763          	beqz	a4,80003490 <__addsf3+0x1de>
80003326:	8732                	mv	a4,a2
80003328:	4681                	li	a3,0
8000332a:	4609                	li	a2,2
8000332c:	0017e793          	or	a5,a5,1
80003330:	52c91d63          	bne	s2,a2,8000386a <__addsf3+0x5b8>
80003334:	54040663          	beqz	s0,80003880 <__addsf3+0x5ce>
80003338:	0721                	add	a4,a4,8 # 4000008 <_reset_entry-0x7bfffff8>
8000333a:	14068c63          	beqz	a3,80003492 <__addsf3+0x1e0>
8000333e:	8436                	mv	s0,a3
80003340:	ae51                	j	800036d4 <__addsf3+0x422>
  FP_ADD_S (R, A, B);
80003342:	0ff00593          	li	a1,255
80003346:	02b69363          	bne	a3,a1,8000336c <__addsf3+0xba>
8000334a:	c751                	beqz	a4,800033d6 <__addsf3+0x124>
8000334c:	01975793          	srl	a5,a4,0x19
80003350:	0017c793          	xor	a5,a5,1
80003354:	8b85                	and	a5,a5,1
80003356:	0792                	sll	a5,a5,0x4
80003358:	863a                	mv	a2,a4
8000335a:	a865                	j	80003412 <__addsf3+0x160>
8000335c:	0ff00793          	li	a5,255
80003360:	fef985e3          	beq	s3,a5,8000334a <__addsf3+0x98>
80003364:	040007b7          	lui	a5,0x4000
80003368:	8e5d                	or	a2,a2,a5
8000336a:	87b6                	mv	a5,a3
8000336c:	46ed                	li	a3,27
8000336e:	00f6d763          	bge	a3,a5,8000337c <__addsf3+0xca>
80003372:	00170613          	add	a2,a4,1
  FP_UNPACK_SEMIRAW_S (A, a);
80003376:	85ce                	mv	a1,s3
  FP_ADD_S (R, A, B);
80003378:	4781                	li	a5,0
8000337a:	b755                	j	8000331e <__addsf3+0x6c>
8000337c:	02000693          	li	a3,32
80003380:	00f655b3          	srl	a1,a2,a5
80003384:	40f687b3          	sub	a5,a3,a5
80003388:	00f617b3          	sll	a5,a2,a5
8000338c:	00f037b3          	snez	a5,a5
80003390:	8fcd                	or	a5,a5,a1
80003392:	00e78633          	add	a2,a5,a4
  FP_UNPACK_SEMIRAW_S (A, a);
80003396:	85ce                	mv	a1,s3
  FP_ADD_S (R, A, B);
80003398:	040007b7          	lui	a5,0x4000
8000339c:	8ff1                	and	a5,a5,a2
8000339e:	dfe9                	beqz	a5,80003378 <__addsf3+0xc6>
800033a0:	0585                	add	a1,a1,1
800033a2:	0ff00793          	li	a5,255
800033a6:	18f58163          	beq	a1,a5,80003528 <__addsf3+0x276>
800033aa:	7e000737          	lui	a4,0x7e000
800033ae:	00165793          	srl	a5,a2,0x1
800033b2:	177d                	add	a4,a4,-1 # 7dffffff <_reset_entry-0x2000001>
800033b4:	00167693          	and	a3,a2,1
800033b8:	8ff9                	and	a5,a5,a4
800033ba:	00d7e633          	or	a2,a5,a3
800033be:	bf6d                	j	80003378 <__addsf3+0xc6>
800033c0:	cad1                	beqz	a3,80003454 <__addsf3+0x1a2>
800033c2:	413586b3          	sub	a3,a1,s3
800033c6:	04099963          	bnez	s3,80003418 <__addsf3+0x166>
800033ca:	e315                	bnez	a4,800033ee <__addsf3+0x13c>
800033cc:	0ff00793          	li	a5,255
800033d0:	14f69a63          	bne	a3,a5,80003524 <__addsf3+0x272>
800033d4:	ea0d                	bnez	a2,80003406 <__addsf3+0x154>
  FP_PACK_SEMIRAW_S (r, R);
800033d6:	01f41513          	sll	a0,s0,0x1f
800033da:	7f8007b7          	lui	a5,0x7f800
800033de:	8d5d                	or	a0,a0,a5
  FP_HANDLE_EXCEPTIONS;

  return r;
}
800033e0:	40f2                	lw	ra,28(sp)
800033e2:	4462                	lw	s0,24(sp)
800033e4:	44d2                	lw	s1,20(sp)
800033e6:	4942                	lw	s2,16(sp)
800033e8:	49b2                	lw	s3,12(sp)
800033ea:	6105                	add	sp,sp,32
800033ec:	8082                	ret
  FP_ADD_S (R, A, B);
800033ee:	fff68793          	add	a5,a3,-1
800033f2:	df99                	beqz	a5,80003310 <__addsf3+0x5e>
800033f4:	0ff00513          	li	a0,255
800033f8:	fca68ee3          	beq	a3,a0,800033d4 <__addsf3+0x122>
800033fc:	46ed                	li	a3,27
800033fe:	02f6de63          	bge	a3,a5,8000343a <__addsf3+0x188>
80003402:	0605                	add	a2,a2,1
80003404:	bf95                	j	80003378 <__addsf3+0xc6>
80003406:	01965793          	srl	a5,a2,0x19
8000340a:	0017c793          	xor	a5,a5,1
8000340e:	8b85                	and	a5,a5,1
80003410:	0792                	sll	a5,a5,0x4
80003412:	0ff00593          	li	a1,255
80003416:	b721                	j	8000331e <__addsf3+0x6c>
80003418:	0ff00793          	li	a5,255
8000341c:	00f59a63          	bne	a1,a5,80003430 <__addsf3+0x17e>
80003420:	da5d                	beqz	a2,800033d6 <__addsf3+0x124>
80003422:	01965793          	srl	a5,a2,0x19
80003426:	0017c793          	xor	a5,a5,1
8000342a:	8b85                	and	a5,a5,1
8000342c:	0792                	sll	a5,a5,0x4
8000342e:	bdc5                	j	8000331e <__addsf3+0x6c>
80003430:	040007b7          	lui	a5,0x4000
80003434:	8f5d                	or	a4,a4,a5
80003436:	87b6                	mv	a5,a3
80003438:	b7d1                	j	800033fc <__addsf3+0x14a>
8000343a:	02000693          	li	a3,32
8000343e:	00f75533          	srl	a0,a4,a5
80003442:	40f687b3          	sub	a5,a3,a5
80003446:	00f717b3          	sll	a5,a4,a5
8000344a:	00f037b3          	snez	a5,a5
8000344e:	8fc9                	or	a5,a5,a0
80003450:	963e                	add	a2,a2,a5
80003452:	b799                	j	80003398 <__addsf3+0xe6>
80003454:	00198693          	add	a3,s3,1
80003458:	0fe6f793          	and	a5,a3,254
8000345c:	efc5                	bnez	a5,80003514 <__addsf3+0x262>
8000345e:	02099163          	bnez	s3,80003480 <__addsf3+0x1ce>
80003462:	34070863          	beqz	a4,800037b2 <__addsf3+0x500>
80003466:	22060863          	beqz	a2,80003696 <__addsf3+0x3e4>
8000346a:	9732                	add	a4,a4,a2
8000346c:	040006b7          	lui	a3,0x4000
80003470:	8ef9                	and	a3,a3,a4
80003472:	22068263          	beqz	a3,80003696 <__addsf3+0x3e4>
80003476:	fc000637          	lui	a2,0xfc000
8000347a:	167d                	add	a2,a2,-1 # fbffffff <_timer_base+0x3bfffeff>
8000347c:	8e79                	and	a2,a2,a4
8000347e:	bd79                	j	8000331c <__addsf3+0x6a>
80003480:	0ff00693          	li	a3,255
80003484:	04d99f63          	bne	s3,a3,800034e2 <__addsf3+0x230>
80003488:	e70d                	bnez	a4,800034b2 <__addsf3+0x200>
8000348a:	f93594e3          	bne	a1,s3,80003412 <__addsf3+0x160>
8000348e:	fa51                	bnez	a2,80003422 <__addsf3+0x170>
  FP_PACK_SEMIRAW_S (r, R);
80003490:	8732                	mv	a4,a2
80003492:	040006b7          	lui	a3,0x4000
80003496:	8ef9                	and	a3,a3,a4
80003498:	44068d63          	beqz	a3,800038f2 <__addsf3+0x640>
8000349c:	0585                	add	a1,a1,1
8000349e:	0ff00693          	li	a3,255
800034a2:	40d58b63          	beq	a1,a3,800038b8 <__addsf3+0x606>
800034a6:	1f8006b7          	lui	a3,0x1f800
800034aa:	830d                	srl	a4,a4,0x3
800034ac:	16fd                	add	a3,a3,-1 # 1f7fffff <_reset_entry-0x60800001>
800034ae:	8f75                	and	a4,a4,a3
800034b0:	a669                	j	8000383a <__addsf3+0x588>
  FP_ADD_S (R, A, B);
800034b2:	020006b7          	lui	a3,0x2000
800034b6:	8ef9                	and	a3,a3,a4
800034b8:	ca91                	beqz	a3,800034cc <__addsf3+0x21a>
800034ba:	05359b63          	bne	a1,s3,80003510 <__addsf3+0x25e>
800034be:	2e060563          	beqz	a2,800037a8 <__addsf3+0x4f6>
800034c2:	02000737          	lui	a4,0x2000
800034c6:	8f71                	and	a4,a4,a2
800034c8:	cf05                	beqz	a4,80003500 <__addsf3+0x24e>
800034ca:	a035                	j	800034f6 <__addsf3+0x244>
800034cc:	47c1                	li	a5,16
800034ce:	05359163          	bne	a1,s3,80003510 <__addsf3+0x25e>
800034d2:	2c060863          	beqz	a2,800037a2 <__addsf3+0x4f0>
800034d6:	020007b7          	lui	a5,0x2000
800034da:	8ff1                	and	a5,a5,a2
800034dc:	c395                	beqz	a5,80003500 <__addsf3+0x24e>
800034de:	47c1                	li	a5,16
800034e0:	a819                	j	800034f6 <__addsf3+0x244>
800034e2:	02d59363          	bne	a1,a3,80003508 <__addsf3+0x256>
800034e6:	2c060163          	beqz	a2,800037a8 <__addsf3+0x4f6>
800034ea:	020006b7          	lui	a3,0x2000
800034ee:	8ef1                	and	a3,a3,a2
800034f0:	c691                	beqz	a3,800034fc <__addsf3+0x24a>
800034f2:	e20706e3          	beqz	a4,8000331e <__addsf3+0x6c>
  FP_PACK_SEMIRAW_S (r, R);
800034f6:	0ff00593          	li	a1,255
800034fa:	a111                	j	800038fe <__addsf3+0x64c>
  FP_ADD_S (R, A, B);
800034fc:	2a070463          	beqz	a4,800037a4 <__addsf3+0x4f2>
  FP_PACK_SEMIRAW_S (r, R);
80003500:	7fc00537          	lui	a0,0x7fc00
  FP_HANDLE_EXCEPTIONS;
80003504:	47c1                	li	a5,16
80003506:	a80d                	j	80003538 <__addsf3+0x286>
  FP_ADD_S (R, A, B);
80003508:	0ff00593          	li	a1,255
8000350c:	e00709e3          	beqz	a4,8000331e <__addsf3+0x6c>
80003510:	f27d                	bnez	a2,800034f6 <__addsf3+0x244>
80003512:	b599                	j	80003358 <__addsf3+0xa6>
80003514:	0ff00793          	li	a5,255
80003518:	00f68863          	beq	a3,a5,80003528 <__addsf3+0x276>
8000351c:	00c707b3          	add	a5,a4,a2
80003520:	0017d613          	srl	a2,a5,0x1
80003524:	85b6                	mv	a1,a3
80003526:	bd89                	j	80003378 <__addsf3+0xc6>
80003528:	00091b63          	bnez	s2,8000353e <__addsf3+0x28c>
  FP_PACK_SEMIRAW_S (r, R);
8000352c:	01f41513          	sll	a0,s0,0x1f
80003530:	7f8007b7          	lui	a5,0x7f800
80003534:	8d5d                	or	a0,a0,a5
  FP_ADD_S (R, A, B);
80003536:	4795                	li	a5,5
  FP_HANDLE_EXCEPTIONS;
80003538:	0017a073          	csrs	fflags,a5
  return r;
8000353c:	b555                	j	800033e0 <__addsf3+0x12e>
  FP_ADD_S (R, A, B);
8000353e:	478d                	li	a5,3
80003540:	00f91c63          	bne	s2,a5,80003558 <__addsf3+0x2a6>
  FP_PACK_SEMIRAW_S (r, R);
80003544:	7f800537          	lui	a0,0x7f800
  FP_ADD_S (R, A, B);
80003548:	d47d                	beqz	s0,80003536 <__addsf3+0x284>
8000354a:	0fe00593          	li	a1,254
8000354e:	577d                	li	a4,-1
  FP_PACK_SEMIRAW_S (r, R);
80003550:	4415                	li	s0,5
80003552:	87a2                	mv	a5,s0
80003554:	4405                	li	s0,1
80003556:	bf35                	j	80003492 <__addsf3+0x1e0>
  FP_ADD_S (R, A, B);
80003558:	4789                	li	a5,2
8000355a:	34f91763          	bne	s2,a5,800038a8 <__addsf3+0x5f6>
8000355e:	34040563          	beqz	s0,800038a8 <__addsf3+0x5f6>
  FP_PACK_SEMIRAW_S (r, R);
80003562:	ff800537          	lui	a0,0xff800
80003566:	bfc1                	j	80003536 <__addsf3+0x284>
  FP_ADD_S (R, A, B);
80003568:	06d05463          	blez	a3,800035d0 <__addsf3+0x31e>
8000356c:	e9a9                	bnez	a1,800035be <__addsf3+0x30c>
8000356e:	d80606e3          	beqz	a2,800032fa <__addsf3+0x48>
80003572:	fff68593          	add	a1,a3,-1 # 1ffffff <_reset_entry-0x7e000001>
80003576:	e589                	bnez	a1,80003580 <__addsf3+0x2ce>
80003578:	40c70633          	sub	a2,a4,a2
  FP_UNPACK_SEMIRAW_S (B, b);
8000357c:	4585                	li	a1,1
  FP_ADD_S (R, A, B);
8000357e:	a035                	j	800035aa <__addsf3+0x2f8>
80003580:	0ff00793          	li	a5,255
80003584:	dcf683e3          	beq	a3,a5,8000334a <__addsf3+0x98>
80003588:	46ed                	li	a3,27
8000358a:	4785                	li	a5,1
8000358c:	00b6cc63          	blt	a3,a1,800035a4 <__addsf3+0x2f2>
80003590:	02000793          	li	a5,32
80003594:	8f8d                	sub	a5,a5,a1
80003596:	00f617b3          	sll	a5,a2,a5
8000359a:	00b656b3          	srl	a3,a2,a1
8000359e:	00f037b3          	snez	a5,a5
800035a2:	8fd5                	or	a5,a5,a3
800035a4:	40f70633          	sub	a2,a4,a5
  FP_UNPACK_SEMIRAW_S (A, a);
800035a8:	85ce                	mv	a1,s3
  FP_ADD_S (R, A, B);
800035aa:	040004b7          	lui	s1,0x4000
800035ae:	009677b3          	and	a5,a2,s1
800035b2:	dc0783e3          	beqz	a5,80003378 <__addsf3+0xc6>
800035b6:	14fd                	add	s1,s1,-1 # 3ffffff <_reset_entry-0x7c000001>
800035b8:	8cf1                	and	s1,s1,a2
800035ba:	89ae                	mv	s3,a1
800035bc:	a25d                	j	80003762 <__addsf3+0x4b0>
800035be:	0ff00793          	li	a5,255
800035c2:	d8f984e3          	beq	s3,a5,8000334a <__addsf3+0x98>
800035c6:	040007b7          	lui	a5,0x4000
800035ca:	8e5d                	or	a2,a2,a5
800035cc:	85b6                	mv	a1,a3
800035ce:	bf6d                	j	80003588 <__addsf3+0x2d6>
800035d0:	c6c9                	beqz	a3,8000365a <__addsf3+0x3a8>
800035d2:	413586b3          	sub	a3,a1,s3
800035d6:	06099163          	bnez	s3,80003638 <__addsf3+0x386>
800035da:	eb01                	bnez	a4,800035ea <__addsf3+0x338>
800035dc:	0ff00793          	li	a5,255
800035e0:	1cf69663          	bne	a3,a5,800037ac <__addsf3+0x4fa>
800035e4:	e221                	bnez	a2,80003624 <__addsf3+0x372>
  FP_PACK_SEMIRAW_S (r, R);
800035e6:	057e                	sll	a0,a0,0x1f
800035e8:	bbcd                	j	800033da <__addsf3+0x128>
  FP_ADD_S (R, A, B);
800035ea:	fff68813          	add	a6,a3,-1
800035ee:	00081563          	bnez	a6,800035f8 <__addsf3+0x346>
800035f2:	8e19                	sub	a2,a2,a4
800035f4:	842a                	mv	s0,a0
800035f6:	b759                	j	8000357c <__addsf3+0x2ca>
800035f8:	0ff00793          	li	a5,255
800035fc:	fef684e3          	beq	a3,a5,800035e4 <__addsf3+0x332>
80003600:	46ed                	li	a3,27
80003602:	4785                	li	a5,1
80003604:	0106cd63          	blt	a3,a6,8000361e <__addsf3+0x36c>
80003608:	02000793          	li	a5,32
8000360c:	410787b3          	sub	a5,a5,a6
80003610:	00f717b3          	sll	a5,a4,a5
80003614:	010756b3          	srl	a3,a4,a6
80003618:	00f037b3          	snez	a5,a5
8000361c:	8fd5                	or	a5,a5,a3
8000361e:	8e1d                	sub	a2,a2,a5
80003620:	842a                	mv	s0,a0
80003622:	b761                	j	800035aa <__addsf3+0x2f8>
80003624:	01965793          	srl	a5,a2,0x19
80003628:	0017c793          	xor	a5,a5,1
8000362c:	8b85                	and	a5,a5,1
8000362e:	0792                	sll	a5,a5,0x4
80003630:	0ff00593          	li	a1,255
80003634:	842a                	mv	s0,a0
80003636:	b1e5                	j	8000331e <__addsf3+0x6c>
80003638:	0ff00793          	li	a5,255
8000363c:	00f59a63          	bne	a1,a5,80003650 <__addsf3+0x39e>
80003640:	d25d                	beqz	a2,800035e6 <__addsf3+0x334>
80003642:	01965793          	srl	a5,a2,0x19
80003646:	0017c793          	xor	a5,a5,1
8000364a:	8b85                	and	a5,a5,1
8000364c:	0792                	sll	a5,a5,0x4
8000364e:	b7dd                	j	80003634 <__addsf3+0x382>
80003650:	040007b7          	lui	a5,0x4000
80003654:	8f5d                	or	a4,a4,a5
80003656:	8836                	mv	a6,a3
80003658:	b765                	j	80003600 <__addsf3+0x34e>
8000365a:	00198793          	add	a5,s3,1
8000365e:	0fe7f793          	and	a5,a5,254
80003662:	e7fd                	bnez	a5,80003750 <__addsf3+0x49e>
80003664:	06099e63          	bnez	s3,800036e0 <__addsf3+0x42e>
80003668:	eb09                	bnez	a4,8000367a <__addsf3+0x3c8>
8000366a:	14061663          	bnez	a2,800037b6 <__addsf3+0x504>
8000366e:	ffe90513          	add	a0,s2,-2
80003672:	00153513          	seqz	a0,a0
  FP_PACK_SEMIRAW_S (r, R);
80003676:	057e                	sll	a0,a0,0x1f
  FP_HANDLE_EXCEPTIONS;
80003678:	b3a5                	j	800033e0 <__addsf3+0x12e>
  FP_ADD_S (R, A, B);
8000367a:	ce11                	beqz	a2,80003696 <__addsf3+0x3e4>
8000367c:	40c707b3          	sub	a5,a4,a2
80003680:	040006b7          	lui	a3,0x4000
80003684:	8efd                	and	a3,a3,a5
80003686:	cab1                	beqz	a3,800036da <__addsf3+0x428>
80003688:	40e60733          	sub	a4,a2,a4
8000368c:	842a                	mv	s0,a0
  FP_PACK_SEMIRAW_S (r, R);
8000368e:	01f41513          	sll	a0,s0,0x1f
80003692:	d40707e3          	beqz	a4,800033e0 <__addsf3+0x12e>
80003696:	00171793          	sll	a5,a4,0x1
8000369a:	0077f613          	and	a2,a5,7
8000369e:	00777693          	and	a3,a4,7
800036a2:	16060563          	beqz	a2,8000380c <__addsf3+0x55a>
800036a6:	4609                	li	a2,2
800036a8:	12c90b63          	beq	s2,a2,800037de <__addsf3+0x52c>
800036ac:	460d                	li	a2,3
800036ae:	10c90763          	beq	s2,a2,800037bc <__addsf3+0x50a>
800036b2:	14091563          	bnez	s2,800037fc <__addsf3+0x54a>
800036b6:	00f7f613          	and	a2,a5,15
800036ba:	4591                	li	a1,4
800036bc:	00b60363          	beq	a2,a1,800036c2 <__addsf3+0x410>
800036c0:	0791                	add	a5,a5,4 # 4000004 <_reset_entry-0x7bfffffc>
800036c2:	08000637          	lui	a2,0x8000
800036c6:	8ff1                	and	a5,a5,a2
800036c8:	12079063          	bnez	a5,800037e8 <__addsf3+0x536>
800036cc:	4581                	li	a1,0
800036ce:	18069c63          	bnez	a3,80003866 <__addsf3+0x5b4>
800036d2:	4785                	li	a5,1
800036d4:	0027e793          	or	a5,a5,2
800036d8:	bb6d                	j	80003492 <__addsf3+0x1e0>
  FP_ADD_S (R, A, B);
800036da:	dbd1                	beqz	a5,8000366e <__addsf3+0x3bc>
800036dc:	873e                	mv	a4,a5
800036de:	bf65                	j	80003696 <__addsf3+0x3e4>
800036e0:	0ff00693          	li	a3,255
800036e4:	02d99f63          	bne	s3,a3,80003722 <__addsf3+0x470>
800036e8:	ef09                	bnez	a4,80003702 <__addsf3+0x450>
800036ea:	05359f63          	bne	a1,s3,80003748 <__addsf3+0x496>
800036ee:	e00609e3          	beqz	a2,80003500 <__addsf3+0x24e>
800036f2:	01965713          	srl	a4,a2,0x19
800036f6:	00174713          	xor	a4,a4,1
800036fa:	8b05                	and	a4,a4,1
800036fc:	00471793          	sll	a5,a4,0x4
80003700:	bf15                	j	80003634 <__addsf3+0x382>
80003702:	020006b7          	lui	a3,0x2000
80003706:	8ef9                	and	a3,a3,a4
80003708:	c691                	beqz	a3,80003714 <__addsf3+0x462>
8000370a:	e13593e3          	bne	a1,s3,80003510 <__addsf3+0x25e>
8000370e:	da061ae3          	bnez	a2,800034c2 <__addsf3+0x210>
80003712:	b199                	j	80003358 <__addsf3+0xa6>
80003714:	47c1                	li	a5,16
80003716:	df359de3          	bne	a1,s3,80003510 <__addsf3+0x25e>
8000371a:	47c1                	li	a5,16
8000371c:	c2060ee3          	beqz	a2,80003358 <__addsf3+0xa6>
80003720:	bb5d                	j	800034d6 <__addsf3+0x224>
80003722:	02d59163          	bne	a1,a3,80003744 <__addsf3+0x492>
80003726:	e601                	bnez	a2,8000372e <__addsf3+0x47c>
80003728:	c20718e3          	bnez	a4,80003358 <__addsf3+0xa6>
8000372c:	bbd1                	j	80003500 <__addsf3+0x24e>
8000372e:	020006b7          	lui	a3,0x2000
80003732:	8ef1                	and	a3,a3,a2
80003734:	c681                	beqz	a3,8000373c <__addsf3+0x48a>
80003736:	dc0710e3          	bnez	a4,800034f6 <__addsf3+0x244>
8000373a:	bded                	j	80003634 <__addsf3+0x382>
8000373c:	dc0712e3          	bnez	a4,80003500 <__addsf3+0x24e>
80003740:	842a                	mv	s0,a0
80003742:	a08d                	j	800037a4 <__addsf3+0x4f2>
80003744:	dc0716e3          	bnez	a4,80003510 <__addsf3+0x25e>
80003748:	842a                	mv	s0,a0
8000374a:	cc0614e3          	bnez	a2,80003412 <__addsf3+0x160>
8000374e:	bb4d                	j	80003500 <__addsf3+0x24e>
80003750:	40c704b3          	sub	s1,a4,a2
80003754:	040007b7          	lui	a5,0x4000
80003758:	8fe5                	and	a5,a5,s1
8000375a:	cb95                	beqz	a5,8000378e <__addsf3+0x4dc>
8000375c:	40e604b3          	sub	s1,a2,a4
80003760:	842a                	mv	s0,a0
80003762:	8526                	mv	a0,s1
80003764:	79f000ef          	jal	80004702 <__clzsi2>
80003768:	156d                	add	a0,a0,-5 # ff7ffffb <_timer_base+0x3f7ffefb>
8000376a:	00a494b3          	sll	s1,s1,a0
8000376e:	03354263          	blt	a0,s3,80003792 <__addsf3+0x4e0>
80003772:	41350533          	sub	a0,a0,s3
80003776:	0505                	add	a0,a0,1
80003778:	02000793          	li	a5,32
8000377c:	8f89                	sub	a5,a5,a0
8000377e:	00a4d733          	srl	a4,s1,a0
80003782:	00f494b3          	sll	s1,s1,a5
80003786:	009034b3          	snez	s1,s1
8000378a:	8f45                	or	a4,a4,s1
  FP_PACK_SEMIRAW_S (r, R);
8000378c:	b709                	j	8000368e <__addsf3+0x3dc>
  FP_ADD_S (R, A, B);
8000378e:	f8f1                	bnez	s1,80003762 <__addsf3+0x4b0>
80003790:	bdf9                	j	8000366e <__addsf3+0x3bc>
80003792:	fc0007b7          	lui	a5,0xfc000
80003796:	17fd                	add	a5,a5,-1 # fbffffff <_timer_base+0x3bfffeff>
80003798:	40a985b3          	sub	a1,s3,a0
8000379c:	00f4f633          	and	a2,s1,a5
800037a0:	bee1                	j	80003378 <__addsf3+0xc6>
800037a2:	863a                	mv	a2,a4
800037a4:	47c1                	li	a5,16
800037a6:	bea5                	j	8000331e <__addsf3+0x6c>
800037a8:	863a                	mv	a2,a4
800037aa:	be95                	j	8000331e <__addsf3+0x6c>
800037ac:	85b6                	mv	a1,a3
800037ae:	842a                	mv	s0,a0
800037b0:	b6e1                	j	80003378 <__addsf3+0xc6>
800037b2:	8732                	mv	a4,a2
800037b4:	bde9                	j	8000368e <__addsf3+0x3dc>
800037b6:	8732                	mv	a4,a2
800037b8:	842a                	mv	s0,a0
800037ba:	bdf1                	j	80003696 <__addsf3+0x3e4>
  FP_PACK_SEMIRAW_S (r, R);
800037bc:	c809                	beqz	s0,800037ce <__addsf3+0x51c>
800037be:	08000637          	lui	a2,0x8000
800037c2:	8ff1                	and	a5,a5,a2
800037c4:	e3bd                	bnez	a5,8000382a <__addsf3+0x578>
800037c6:	e6f1                	bnez	a3,80003892 <__addsf3+0x5e0>
800037c8:	87a2                	mv	a5,s0
800037ca:	4581                	li	a1,0
800037cc:	b721                	j	800036d4 <__addsf3+0x422>
800037ce:	07a1                	add	a5,a5,8
800037d0:	08000637          	lui	a2,0x8000
800037d4:	8ff1                	and	a5,a5,a2
800037d6:	eb89                	bnez	a5,800037e8 <__addsf3+0x536>
800037d8:	e2e1                	bnez	a3,80003898 <__addsf3+0x5e6>
800037da:	4581                	li	a1,0
800037dc:	bddd                	j	800036d2 <__addsf3+0x420>
800037de:	e419                	bnez	s0,800037ec <__addsf3+0x53a>
800037e0:	08000637          	lui	a2,0x8000
800037e4:	8ff1                	and	a5,a5,a2
800037e6:	dbf5                	beqz	a5,800037da <__addsf3+0x528>
800037e8:	4785                	li	a5,1
800037ea:	a089                	j	8000382c <__addsf3+0x57a>
800037ec:	07a1                	add	a5,a5,8
800037ee:	08000637          	lui	a2,0x8000
800037f2:	8ff1                	and	a5,a5,a2
800037f4:	eb9d                	bnez	a5,8000382a <__addsf3+0x578>
800037f6:	dae9                	beqz	a3,800037c8 <__addsf3+0x516>
800037f8:	0721                	add	a4,a4,8 # 2000008 <_reset_entry-0x7dfffff8>
800037fa:	b7f9                	j	800037c8 <__addsf3+0x516>
800037fc:	08000637          	lui	a2,0x8000
80003800:	8ff1                	and	a5,a5,a2
80003802:	f3fd                	bnez	a5,800037e8 <__addsf3+0x536>
80003804:	daf9                	beqz	a3,800037da <__addsf3+0x528>
80003806:	4685                	li	a3,1
80003808:	4581                	li	a1,0
8000380a:	a8b9                	j	80003868 <__addsf3+0x5b6>
8000380c:	08000637          	lui	a2,0x8000
80003810:	8ff1                	and	a5,a5,a2
80003812:	e3a9                	bnez	a5,80003854 <__addsf3+0x5a2>
80003814:	e2b1                	bnez	a3,80003858 <__addsf3+0x5a6>
80003816:	040007b7          	lui	a5,0x4000
8000381a:	8ff9                	and	a5,a5,a4
8000381c:	ebd9                	bnez	a5,800038b2 <__addsf3+0x600>
8000381e:	00671513          	sll	a0,a4,0x6
80003822:	8125                	srl	a0,a0,0x9
80003824:	047e                	sll	s0,s0,0x1f
80003826:	8d41                	or	a0,a0,s0
  FP_HANDLE_EXCEPTIONS;
80003828:	be65                	j	800033e0 <__addsf3+0x12e>
  FP_PACK_SEMIRAW_S (r, R);
8000382a:	87a2                	mv	a5,s0
8000382c:	ea95                	bnez	a3,80003860 <__addsf3+0x5ae>
8000382e:	040006b7          	lui	a3,0x4000
80003832:	8ef9                	and	a3,a3,a4
80003834:	e2c1                	bnez	a3,800038b4 <__addsf3+0x602>
80003836:	830d                	srl	a4,a4,0x3
80003838:	4581                	li	a1,0
8000383a:	01759513          	sll	a0,a1,0x17
8000383e:	7f8006b7          	lui	a3,0x7f800
80003842:	0726                	sll	a4,a4,0x9
80003844:	8d75                	and	a0,a0,a3
80003846:	8325                	srl	a4,a4,0x9
80003848:	8d59                	or	a0,a0,a4
8000384a:	047e                	sll	s0,s0,0x1f
8000384c:	8d41                	or	a0,a0,s0
  FP_HANDLE_EXCEPTIONS;
8000384e:	b80789e3          	beqz	a5,800033e0 <__addsf3+0x12e>
80003852:	b1dd                	j	80003538 <__addsf3+0x286>
  FP_PACK_SEMIRAW_S (r, R);
80003854:	4781                	li	a5,0
80003856:	bfd9                	j	8000382c <__addsf3+0x57a>
80003858:	4685                	li	a3,1
8000385a:	4581                	li	a1,0
8000385c:	4781                	li	a5,0
8000385e:	b4f1                	j	8000332a <__addsf3+0x78>
80003860:	4681                	li	a3,0
80003862:	4581                	li	a1,0
80003864:	b4d9                	j	8000332a <__addsf3+0x78>
80003866:	4685                	li	a3,1
80003868:	4785                	li	a5,1
8000386a:	460d                	li	a2,3
8000386c:	00c90d63          	beq	s2,a2,80003886 <__addsf3+0x5d4>
80003870:	00091863          	bnez	s2,80003880 <__addsf3+0x5ce>
80003874:	00f77613          	and	a2,a4,15
80003878:	4511                	li	a0,4
8000387a:	00a60363          	beq	a2,a0,80003880 <__addsf3+0x5ce>
8000387e:	0711                	add	a4,a4,4
80003880:	e4069ae3          	bnez	a3,800036d4 <__addsf3+0x422>
80003884:	b139                	j	80003492 <__addsf3+0x1e0>
80003886:	cc19                	beqz	s0,800038a4 <__addsf3+0x5f2>
80003888:	843e                	mv	s0,a5
8000388a:	cc0684e3          	beqz	a3,80003552 <__addsf3+0x2a0>
8000388e:	87a2                	mv	a5,s0
80003890:	b47d                	j	8000333e <__addsf3+0x8c>
80003892:	86a2                	mv	a3,s0
80003894:	4581                	li	a1,0
80003896:	bfd5                	j	8000388a <__addsf3+0x5d8>
80003898:	4685                	li	a3,1
8000389a:	4785                	li	a5,1
8000389c:	85a2                	mv	a1,s0
8000389e:	0721                	add	a4,a4,8
800038a0:	4401                	li	s0,0
800038a2:	bff9                	j	80003880 <__addsf3+0x5ce>
800038a4:	842e                	mv	s0,a1
800038a6:	bfdd                	j	8000389c <__addsf3+0x5ea>
  FP_ADD_S (R, A, B);
800038a8:	577d                	li	a4,-1
800038aa:	0fe00593          	li	a1,254
  FP_PACK_SEMIRAW_S (r, R);
800038ae:	4795                	li	a5,5
800038b0:	b6cd                	j	80003492 <__addsf3+0x1e0>
800038b2:	4781                	li	a5,0
800038b4:	4585                	li	a1,1
800038b6:	bec5                	j	800034a6 <__addsf3+0x1f4>
800038b8:	0057e793          	or	a5,a5,5
800038bc:	02090663          	beqz	s2,800038e8 <__addsf3+0x636>
800038c0:	470d                	li	a4,3
800038c2:	00e91a63          	bne	s2,a4,800038d6 <__addsf3+0x624>
800038c6:	c00d                	beqz	s0,800038e8 <__addsf3+0x636>
800038c8:	7f800737          	lui	a4,0x7f800
800038cc:	01f41513          	sll	a0,s0,0x1f
800038d0:	177d                	add	a4,a4,-1 # 7f7fffff <_reset_entry-0x800001>
800038d2:	8d59                	or	a0,a0,a4
  FP_HANDLE_EXCEPTIONS;
800038d4:	b195                	j	80003538 <__addsf3+0x286>
  FP_PACK_SEMIRAW_S (r, R);
800038d6:	4709                	li	a4,2
800038d8:	fee918e3          	bne	s2,a4,800038c8 <__addsf3+0x616>
800038dc:	e411                	bnez	s0,800038e8 <__addsf3+0x636>
800038de:	80006737          	lui	a4,0x80006
800038e2:	e0472503          	lw	a0,-508(a4) # 80005e04 <__clz_tab+0x110>
800038e6:	b989                	j	80003538 <__addsf3+0x286>
800038e8:	01f41513          	sll	a0,s0,0x1f
800038ec:	7f800737          	lui	a4,0x7f800
800038f0:	b7cd                	j	800038d2 <__addsf3+0x620>
800038f2:	0ff00693          	li	a3,255
800038f6:	830d                	srl	a4,a4,0x3
800038f8:	f4d591e3          	bne	a1,a3,8000383a <__addsf3+0x588>
800038fc:	df1d                	beqz	a4,8000383a <__addsf3+0x588>
800038fe:	00400737          	lui	a4,0x400
80003902:	4401                	li	s0,0
80003904:	bf1d                	j	8000383a <__addsf3+0x588>

80003906 <__divsf3>:
#include "soft-fp.h"
#include "single.h"

SFtype
__divsf3 (SFtype a, SFtype b)
{
80003906:	7179                	add	sp,sp,-48
80003908:	c85a                	sw	s6,16(sp)
8000390a:	d606                	sw	ra,44(sp)
8000390c:	d422                	sw	s0,40(sp)
8000390e:	d226                	sw	s1,36(sp)
80003910:	d04a                	sw	s2,32(sp)
80003912:	ce4e                	sw	s3,28(sp)
80003914:	cc52                	sw	s4,24(sp)
80003916:	ca56                	sw	s5,20(sp)
80003918:	c65e                	sw	s7,12(sp)
8000391a:	8b2e                	mv	s6,a1
  FP_DECL_S (A);
  FP_DECL_S (B);
  FP_DECL_S (R);
  SFtype r;

  FP_INIT_ROUNDMODE;
8000391c:	002029f3          	frrm	s3
  FP_UNPACK_S (A, a);
80003920:	01755913          	srl	s2,a0,0x17
80003924:	00951a93          	sll	s5,a0,0x9
80003928:	0ff97913          	zext.b	s2,s2
8000392c:	009ada93          	srl	s5,s5,0x9
80003930:	01f55a13          	srl	s4,a0,0x1f
80003934:	02090063          	beqz	s2,80003954 <__divsf3+0x4e>
80003938:	0ff00793          	li	a5,255
8000393c:	02f90a63          	beq	s2,a5,80003970 <__divsf3+0x6a>
80003940:	0a8e                	sll	s5,s5,0x3
80003942:	040007b7          	lui	a5,0x4000
80003946:	00faeab3          	or	s5,s5,a5
8000394a:	f8190913          	add	s2,s2,-127
8000394e:	4b81                	li	s7,0
  FP_DECL_EX;
80003950:	4481                	li	s1,0
80003952:	a80d                	j	80003984 <__divsf3+0x7e>
  FP_UNPACK_S (A, a);
80003954:	080a8063          	beqz	s5,800039d4 <__divsf3+0xce>
80003958:	8556                	mv	a0,s5
8000395a:	5a9000ef          	jal	80004702 <__clzsi2>
8000395e:	ffb50793          	add	a5,a0,-5
80003962:	f8a00913          	li	s2,-118
80003966:	00fa9ab3          	sll	s5,s5,a5
8000396a:	40a90933          	sub	s2,s2,a0
8000396e:	b7c5                	j	8000394e <__divsf3+0x48>
80003970:	060a8563          	beqz	s5,800039da <__divsf3+0xd4>
80003974:	004004b7          	lui	s1,0x400
80003978:	009ab4b3          	sltu	s1,s5,s1
8000397c:	0492                	sll	s1,s1,0x4
8000397e:	0ff00913          	li	s2,255
80003982:	4b8d                	li	s7,3
  FP_UNPACK_S (B, b);
80003984:	017b5793          	srl	a5,s6,0x17
80003988:	009b1413          	sll	s0,s6,0x9
8000398c:	0ff7f793          	zext.b	a5,a5
80003990:	8025                	srl	s0,s0,0x9
80003992:	01fb5b13          	srl	s6,s6,0x1f
80003996:	c7b1                	beqz	a5,800039e2 <__divsf3+0xdc>
80003998:	0ff00713          	li	a4,255
8000399c:	04e78f63          	beq	a5,a4,800039fa <__divsf3+0xf4>
800039a0:	040e                	sll	s0,s0,0x3
800039a2:	04000737          	lui	a4,0x4000
800039a6:	8c59                	or	s0,s0,a4
800039a8:	f8178793          	add	a5,a5,-127 # 3ffff81 <_reset_entry-0x7c00007f>
800039ac:	4701                	li	a4,0
  FP_DIV_S (R, A, B);
800039ae:	40f90933          	sub	s2,s2,a5
800039b2:	002b9793          	sll	a5,s7,0x2
800039b6:	8fd9                	or	a5,a5,a4
800039b8:	17fd                	add	a5,a5,-1
800039ba:	4639                	li	a2,14
800039bc:	016a46b3          	xor	a3,s4,s6
800039c0:	08f66063          	bltu	a2,a5,80003a40 <__divsf3+0x13a>
800039c4:	80006637          	lui	a2,0x80006
800039c8:	078a                	sll	a5,a5,0x2
800039ca:	cb860613          	add	a2,a2,-840 # 80005cb8 <halF+0x10>
800039ce:	97b2                	add	a5,a5,a2
800039d0:	439c                	lw	a5,0(a5)
800039d2:	8782                	jr	a5
  FP_UNPACK_S (A, a);
800039d4:	4901                	li	s2,0
800039d6:	4b85                	li	s7,1
800039d8:	bfa5                	j	80003950 <__divsf3+0x4a>
800039da:	0ff00913          	li	s2,255
800039de:	4b89                	li	s7,2
800039e0:	bf85                	j	80003950 <__divsf3+0x4a>
  FP_UNPACK_S (B, b);
800039e2:	c40d                	beqz	s0,80003a0c <__divsf3+0x106>
800039e4:	8522                	mv	a0,s0
800039e6:	51d000ef          	jal	80004702 <__clzsi2>
800039ea:	ffb50793          	add	a5,a0,-5
800039ee:	00f41433          	sll	s0,s0,a5
800039f2:	f8a00793          	li	a5,-118
800039f6:	8f89                	sub	a5,a5,a0
800039f8:	bf55                	j	800039ac <__divsf3+0xa6>
800039fa:	cc01                	beqz	s0,80003a12 <__divsf3+0x10c>
800039fc:	004007b7          	lui	a5,0x400
80003a00:	00f46d63          	bltu	s0,a5,80003a1a <__divsf3+0x114>
80003a04:	0ff00793          	li	a5,255
80003a08:	470d                	li	a4,3
80003a0a:	b755                	j	800039ae <__divsf3+0xa8>
80003a0c:	4781                	li	a5,0
80003a0e:	4705                	li	a4,1
80003a10:	bf79                	j	800039ae <__divsf3+0xa8>
80003a12:	0ff00793          	li	a5,255
80003a16:	4709                	li	a4,2
80003a18:	bf59                	j	800039ae <__divsf3+0xa8>
80003a1a:	0ff00793          	li	a5,255
80003a1e:	470d                	li	a4,3
80003a20:	44c1                	li	s1,16
80003a22:	b771                	j	800039ae <__divsf3+0xa8>
80003a24:	86da                	mv	a3,s6
  FP_PACK_S (r, R);
80003a26:	4785                	li	a5,1
80003a28:	26f70b63          	beq	a4,a5,80003c9e <__divsf3+0x398>
80003a2c:	cf41                	beqz	a4,80003ac4 <__divsf3+0x1be>
80003a2e:	4789                	li	a5,2
80003a30:	26f70a63          	beq	a4,a5,80003ca4 <__divsf3+0x39e>
80003a34:	00400737          	lui	a4,0x400
80003a38:	0ff00793          	li	a5,255
80003a3c:	4681                	li	a3,0
80003a3e:	a8e1                	j	80003b16 <__divsf3+0x210>
  FP_DIV_S (R, A, B);
80003a40:	00541613          	sll	a2,s0,0x5
80003a44:	0e8afc63          	bgeu	s5,s0,80003b3c <__divsf3+0x236>
80003a48:	197d                	add	s2,s2,-1
80003a4a:	4781                	li	a5,0
80003a4c:	01065593          	srl	a1,a2,0x10
80003a50:	02bad833          	divu	a6,s5,a1
80003a54:	6741                	lui	a4,0x10
80003a56:	177d                	add	a4,a4,-1 # ffff <_reset_entry-0x7fff0001>
80003a58:	8f71                	and	a4,a4,a2
80003a5a:	83c1                	srl	a5,a5,0x10
80003a5c:	02bafab3          	remu	s5,s5,a1
80003a60:	8442                	mv	s0,a6
80003a62:	03070533          	mul	a0,a4,a6
80003a66:	0ac2                	sll	s5,s5,0x10
80003a68:	0157e7b3          	or	a5,a5,s5
80003a6c:	00a7fc63          	bgeu	a5,a0,80003a84 <__divsf3+0x17e>
80003a70:	97b2                	add	a5,a5,a2
80003a72:	fff80413          	add	s0,a6,-1
80003a76:	00c7e763          	bltu	a5,a2,80003a84 <__divsf3+0x17e>
80003a7a:	00a7f563          	bgeu	a5,a0,80003a84 <__divsf3+0x17e>
80003a7e:	ffe80413          	add	s0,a6,-2
80003a82:	97b2                	add	a5,a5,a2
80003a84:	8f89                	sub	a5,a5,a0
80003a86:	02b7d533          	divu	a0,a5,a1
80003a8a:	02b7f7b3          	remu	a5,a5,a1
80003a8e:	85aa                	mv	a1,a0
80003a90:	02a70733          	mul	a4,a4,a0
80003a94:	07c2                	sll	a5,a5,0x10
80003a96:	02e7f163          	bgeu	a5,a4,80003ab8 <__divsf3+0x1b2>
80003a9a:	00c78833          	add	a6,a5,a2
80003a9e:	00f838b3          	sltu	a7,a6,a5
80003aa2:	fff50593          	add	a1,a0,-1
80003aa6:	87c2                	mv	a5,a6
80003aa8:	00089863          	bnez	a7,80003ab8 <__divsf3+0x1b2>
80003aac:	00e87663          	bgeu	a6,a4,80003ab8 <__divsf3+0x1b2>
80003ab0:	ffe50593          	add	a1,a0,-2
80003ab4:	00c807b3          	add	a5,a6,a2
80003ab8:	0442                	sll	s0,s0,0x10
80003aba:	8f99                	sub	a5,a5,a4
80003abc:	8c4d                	or	s0,s0,a1
80003abe:	00f037b3          	snez	a5,a5
80003ac2:	8c5d                	or	s0,s0,a5
  FP_PACK_S (r, R);
80003ac4:	07f90793          	add	a5,s2,127
80003ac8:	01f69513          	sll	a0,a3,0x1f
80003acc:	0cf05963          	blez	a5,80003b9e <__divsf3+0x298>
80003ad0:	00747713          	and	a4,s0,7
80003ad4:	c30d                	beqz	a4,80003af6 <__divsf3+0x1f0>
80003ad6:	4709                	li	a4,2
80003ad8:	0014e493          	or	s1,s1,1
80003adc:	08e98563          	beq	s3,a4,80003b66 <__divsf3+0x260>
80003ae0:	470d                	li	a4,3
80003ae2:	06e98f63          	beq	s3,a4,80003b60 <__divsf3+0x25a>
80003ae6:	00099863          	bnez	s3,80003af6 <__divsf3+0x1f0>
80003aea:	00f47713          	and	a4,s0,15
80003aee:	4611                	li	a2,4
80003af0:	00c70363          	beq	a4,a2,80003af6 <__divsf3+0x1f0>
80003af4:	0411                	add	s0,s0,4
80003af6:	08000737          	lui	a4,0x8000
80003afa:	8f61                	and	a4,a4,s0
80003afc:	c719                	beqz	a4,80003b0a <__divsf3+0x204>
80003afe:	f80007b7          	lui	a5,0xf8000
80003b02:	17fd                	add	a5,a5,-1 # f7ffffff <_timer_base+0x37fffeff>
80003b04:	8c7d                	and	s0,s0,a5
80003b06:	08090793          	add	a5,s2,128
80003b0a:	0fe00713          	li	a4,254
80003b0e:	04f74e63          	blt	a4,a5,80003b6a <__divsf3+0x264>
80003b12:	00345713          	srl	a4,s0,0x3
80003b16:	0726                	sll	a4,a4,0x9
80003b18:	07de                	sll	a5,a5,0x17
80003b1a:	8325                	srl	a4,a4,0x9
80003b1c:	8fd9                	or	a5,a5,a4
80003b1e:	01f69513          	sll	a0,a3,0x1f
80003b22:	8d5d                	or	a0,a0,a5
  FP_HANDLE_EXCEPTIONS;
80003b24:	e49d                	bnez	s1,80003b52 <__divsf3+0x24c>

  return r;
}
80003b26:	50b2                	lw	ra,44(sp)
80003b28:	5422                	lw	s0,40(sp)
80003b2a:	5492                	lw	s1,36(sp)
80003b2c:	5902                	lw	s2,32(sp)
80003b2e:	49f2                	lw	s3,28(sp)
80003b30:	4a62                	lw	s4,24(sp)
80003b32:	4ad2                	lw	s5,20(sp)
80003b34:	4b42                	lw	s6,16(sp)
80003b36:	4bb2                	lw	s7,12(sp)
80003b38:	6145                	add	sp,sp,48
80003b3a:	8082                	ret
  FP_DIV_S (R, A, B);
80003b3c:	01fa9793          	sll	a5,s5,0x1f
80003b40:	001ada93          	srl	s5,s5,0x1
80003b44:	b721                	j	80003a4c <__divsf3+0x146>
  FP_PACK_S (r, R);
80003b46:	06fe                	sll	a3,a3,0x1f
80003b48:	7f800537          	lui	a0,0x7f800
  FP_DIV_S (R, A, B);
80003b4c:	0084e493          	or	s1,s1,8
  FP_PACK_S (r, R);
80003b50:	8d55                	or	a0,a0,a3
  FP_HANDLE_EXCEPTIONS;
80003b52:	0014a073          	csrs	fflags,s1
  return r;
80003b56:	bfc1                	j	80003b26 <__divsf3+0x220>
  FP_UNPACK_S (A, a);
80003b58:	86d2                	mv	a3,s4
80003b5a:	8456                	mv	s0,s5
  FP_DIV_S (R, A, B);
80003b5c:	875e                	mv	a4,s7
80003b5e:	b5e1                	j	80003a26 <__divsf3+0x120>
  FP_PACK_S (r, R);
80003b60:	fad9                	bnez	a3,80003af6 <__divsf3+0x1f0>
80003b62:	0421                	add	s0,s0,8
80003b64:	bf49                	j	80003af6 <__divsf3+0x1f0>
80003b66:	dac1                	beqz	a3,80003af6 <__divsf3+0x1f0>
80003b68:	bfed                	j	80003b62 <__divsf3+0x25c>
80003b6a:	4789                	li	a5,2
80003b6c:	02f98763          	beq	s3,a5,80003b9a <__divsf3+0x294>
80003b70:	478d                	li	a5,3
80003b72:	00f98863          	beq	s3,a5,80003b82 <__divsf3+0x27c>
80003b76:	00098763          	beqz	s3,80003b84 <__divsf3+0x27e>
80003b7a:	577d                	li	a4,-1
80003b7c:	0fe00793          	li	a5,254
80003b80:	a029                	j	80003b8a <__divsf3+0x284>
80003b82:	fee5                	bnez	a3,80003b7a <__divsf3+0x274>
80003b84:	4701                	li	a4,0
80003b86:	0ff00793          	li	a5,255
80003b8a:	0054e493          	or	s1,s1,5
80003b8e:	0726                	sll	a4,a4,0x9
80003b90:	07de                	sll	a5,a5,0x17
80003b92:	8325                	srl	a4,a4,0x9
80003b94:	8fd9                	or	a5,a5,a4
80003b96:	8d5d                	or	a0,a0,a5
  FP_HANDLE_EXCEPTIONS;
80003b98:	bf6d                	j	80003b52 <__divsf3+0x24c>
  FP_PACK_S (r, R);
80003b9a:	d2e5                	beqz	a3,80003b7a <__divsf3+0x274>
80003b9c:	b7e5                	j	80003b84 <__divsf3+0x27e>
80003b9e:	ebc1                	bnez	a5,80003c2e <__divsf3+0x328>
80003ba0:	00747713          	and	a4,s0,7
80003ba4:	87a2                	mv	a5,s0
80003ba6:	c315                	beqz	a4,80003bca <__divsf3+0x2c4>
80003ba8:	4709                	li	a4,2
80003baa:	0014e493          	or	s1,s1,1
80003bae:	06e98e63          	beq	s3,a4,80003c2a <__divsf3+0x324>
80003bb2:	470d                	li	a4,3
80003bb4:	06e98763          	beq	s3,a4,80003c22 <__divsf3+0x31c>
80003bb8:	00099963          	bnez	s3,80003bca <__divsf3+0x2c4>
80003bbc:	00f47713          	and	a4,s0,15
80003bc0:	4611                	li	a2,4
80003bc2:	00c70463          	beq	a4,a2,80003bca <__divsf3+0x2c4>
80003bc6:	00440793          	add	a5,s0,4
80003bca:	83ed                	srl	a5,a5,0x1b
80003bcc:	0017c793          	xor	a5,a5,1
80003bd0:	8b85                	and	a5,a5,1
80003bd2:	4705                	li	a4,1
80003bd4:	09e90913          	add	s2,s2,158
80003bd8:	01241933          	sll	s2,s0,s2
80003bdc:	00e45733          	srl	a4,s0,a4
80003be0:	01203933          	snez	s2,s2
80003be4:	01276733          	or	a4,a4,s2
80003be8:	00777613          	and	a2,a4,7
80003bec:	c20d                	beqz	a2,80003c0e <__divsf3+0x308>
80003bee:	4609                	li	a2,2
80003bf0:	0014e493          	or	s1,s1,1
80003bf4:	04c98763          	beq	s3,a2,80003c42 <__divsf3+0x33c>
80003bf8:	460d                	li	a2,3
80003bfa:	04c98163          	beq	s3,a2,80003c3c <__divsf3+0x336>
80003bfe:	00099863          	bnez	s3,80003c0e <__divsf3+0x308>
80003c02:	00f77613          	and	a2,a4,15
80003c06:	4591                	li	a1,4
80003c08:	00b60363          	beq	a2,a1,80003c0e <__divsf3+0x308>
80003c0c:	0711                	add	a4,a4,4 # 8000004 <_reset_entry-0x77fffffc>
80003c0e:	04000637          	lui	a2,0x4000
80003c12:	8e79                	and	a2,a2,a4
80003c14:	ca0d                	beqz	a2,80003c46 <__divsf3+0x340>
80003c16:	0014e493          	or	s1,s1,1
80003c1a:	e3a9                	bnez	a5,80003c5c <__divsf3+0x356>
80003c1c:	008007b7          	lui	a5,0x800
80003c20:	bf9d                	j	80003b96 <__divsf3+0x290>
80003c22:	f6c5                	bnez	a3,80003bca <__divsf3+0x2c4>
80003c24:	00840793          	add	a5,s0,8
80003c28:	b74d                	j	80003bca <__divsf3+0x2c4>
80003c2a:	d2c5                	beqz	a3,80003bca <__divsf3+0x2c4>
80003c2c:	bfe5                	j	80003c24 <__divsf3+0x31e>
80003c2e:	4705                	li	a4,1
80003c30:	8f1d                	sub	a4,a4,a5
80003c32:	47ed                	li	a5,27
80003c34:	02e7c663          	blt	a5,a4,80003c60 <__divsf3+0x35a>
80003c38:	4785                	li	a5,1
80003c3a:	bf69                	j	80003bd4 <__divsf3+0x2ce>
80003c3c:	fae9                	bnez	a3,80003c0e <__divsf3+0x308>
80003c3e:	0721                	add	a4,a4,8
80003c40:	b7f9                	j	80003c0e <__divsf3+0x308>
80003c42:	d6f1                	beqz	a3,80003c0e <__divsf3+0x308>
80003c44:	bfed                	j	80003c3e <__divsf3+0x338>
80003c46:	830d                	srl	a4,a4,0x3
80003c48:	ec0787e3          	beqz	a5,80003b16 <__divsf3+0x210>
80003c4c:	0014f793          	and	a5,s1,1
80003c50:	ec0783e3          	beqz	a5,80003b16 <__divsf3+0x210>
80003c54:	4781                	li	a5,0
80003c56:	0024e493          	or	s1,s1,2
80003c5a:	bf15                	j	80003b8e <__divsf3+0x288>
80003c5c:	4701                	li	a4,0
80003c5e:	bfe5                	j	80003c56 <__divsf3+0x350>
80003c60:	cc11                	beqz	s0,80003c7c <__divsf3+0x376>
80003c62:	4789                	li	a5,2
80003c64:	0014e493          	or	s1,s1,1
80003c68:	02f98263          	beq	s3,a5,80003c8c <__divsf3+0x386>
80003c6c:	478d                	li	a5,3
80003c6e:	00f98b63          	beq	s3,a5,80003c84 <__divsf3+0x37e>
80003c72:	4415                	li	s0,5
80003c74:	00098363          	beqz	s3,80003c7a <__divsf3+0x374>
80003c78:	4405                	li	s0,1
80003c7a:	800d                	srl	s0,s0,0x3
80003c7c:	0024e493          	or	s1,s1,2
80003c80:	8d41                	or	a0,a0,s0
  FP_HANDLE_EXCEPTIONS;
80003c82:	bdc1                	j	80003b52 <__divsf3+0x24c>
  FP_PACK_S (r, R);
80003c84:	4405                	li	s0,1
80003c86:	faf5                	bnez	a3,80003c7a <__divsf3+0x374>
80003c88:	4425                	li	s0,9
80003c8a:	bfc5                	j	80003c7a <__divsf3+0x374>
80003c8c:	4405                	li	s0,1
80003c8e:	d6f5                	beqz	a3,80003c7a <__divsf3+0x374>
80003c90:	bfe5                	j	80003c88 <__divsf3+0x382>
80003c92:	800067b7          	lui	a5,0x80006
80003c96:	e087a503          	lw	a0,-504(a5) # 80005e08 <__clz_tab+0x114>
  FP_DIV_S (R, A, B);
80003c9a:	44c1                	li	s1,16
80003c9c:	bd5d                	j	80003b52 <__divsf3+0x24c>
  FP_PACK_S (r, R);
80003c9e:	4701                	li	a4,0
80003ca0:	4781                	li	a5,0
80003ca2:	bd95                	j	80003b16 <__divsf3+0x210>
80003ca4:	4701                	li	a4,0
80003ca6:	0ff00793          	li	a5,255
80003caa:	b5b5                	j	80003b16 <__divsf3+0x210>

80003cac <__eqsf2>:
#include "soft-fp.h"
#include "single.h"

CMPtype
__eqsf2 (SFtype a, SFtype b)
{
80003cac:	872e                	mv	a4,a1
  FP_DECL_EX;
  FP_DECL_S (A);
  FP_DECL_S (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
80003cae:	002027f3          	frrm	a5
  FP_UNPACK_RAW_S (A, a);
80003cb2:	008007b7          	lui	a5,0x800
80003cb6:	17fd                	add	a5,a5,-1 # 7fffff <_reset_entry-0x7f800001>
80003cb8:	01755613          	srl	a2,a0,0x17
80003cbc:	00a7f833          	and	a6,a5,a0
80003cc0:	01f55693          	srl	a3,a0,0x1f
  FP_UNPACK_RAW_S (B, b);
80003cc4:	8fed                	and	a5,a5,a1
  FP_UNPACK_RAW_S (A, a);
80003cc6:	0ff67613          	zext.b	a2,a2
  FP_UNPACK_RAW_S (B, b);
80003cca:	81dd                	srl	a1,a1,0x17
  FP_CMP_EQ_S (r, A, B, 1);
80003ccc:	0ff00513          	li	a0,255
  FP_UNPACK_RAW_S (B, b);
80003cd0:	0ff5f593          	zext.b	a1,a1
80003cd4:	837d                	srl	a4,a4,0x1f
  FP_CMP_EQ_S (r, A, B, 1);
80003cd6:	00a61b63          	bne	a2,a0,80003cec <__eqsf2+0x40>
80003cda:	00081e63          	bnez	a6,80003cf6 <__eqsf2+0x4a>
80003cde:	4505                	li	a0,1
80003ce0:	04c59663          	bne	a1,a2,80003d2c <__eqsf2+0x80>
80003ce4:	e38d                	bnez	a5,80003d06 <__eqsf2+0x5a>
80003ce6:	00e6c533          	xor	a0,a3,a4
80003cea:	8082                	ret
80003cec:	02a59463          	bne	a1,a0,80003d14 <__eqsf2+0x68>
80003cf0:	eb99                	bnez	a5,80003d06 <__eqsf2+0x5a>
  FP_HANDLE_EXCEPTIONS;
80003cf2:	4505                	li	a0,1
80003cf4:	8082                	ret
  FP_CMP_EQ_S (r, A, B, 1);
80003cf6:	00400737          	lui	a4,0x400
80003cfa:	00e86a63          	bltu	a6,a4,80003d0e <__eqsf2+0x62>
80003cfe:	4505                	li	a0,1
80003d00:	02c59663          	bne	a1,a2,80003d2c <__eqsf2+0x80>
80003d04:	c785                	beqz	a5,80003d2c <__eqsf2+0x80>
80003d06:	00400737          	lui	a4,0x400
80003d0a:	fee7f4e3          	bgeu	a5,a4,80003cf2 <__eqsf2+0x46>
  FP_HANDLE_EXCEPTIONS;
80003d0e:	00186073          	csrs	fflags,16
80003d12:	b7c5                	j	80003cf2 <__eqsf2+0x46>
  FP_CMP_EQ_S (r, A, B, 1);
80003d14:	4505                	li	a0,1
80003d16:	00b61b63          	bne	a2,a1,80003d2c <__eqsf2+0x80>
80003d1a:	00f81963          	bne	a6,a5,80003d2c <__eqsf2+0x80>
80003d1e:	00e68663          	beq	a3,a4,80003d2a <__eqsf2+0x7e>
80003d22:	e609                	bnez	a2,80003d2c <__eqsf2+0x80>
80003d24:	01003533          	snez	a0,a6
80003d28:	8082                	ret
80003d2a:	4501                	li	a0,0

  return r;
}
80003d2c:	8082                	ret

80003d2e <__gesf2>:
#include "soft-fp.h"
#include "single.h"

CMPtype
__gesf2 (SFtype a, SFtype b)
{
80003d2e:	872e                	mv	a4,a1
  FP_DECL_EX;
  FP_DECL_S (A);
  FP_DECL_S (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
80003d30:	002026f3          	frrm	a3
  FP_UNPACK_RAW_S (A, a);
80003d34:	008006b7          	lui	a3,0x800
80003d38:	16fd                	add	a3,a3,-1 # 7fffff <_reset_entry-0x7f800001>
80003d3a:	01755613          	srl	a2,a0,0x17
80003d3e:	00a6f5b3          	and	a1,a3,a0
80003d42:	01f55793          	srl	a5,a0,0x1f
80003d46:	0ff67613          	zext.b	a2,a2
  FP_UNPACK_RAW_S (B, b);
80003d4a:	01775513          	srl	a0,a4,0x17
  FP_CMP_S (r, A, B, -2, 2);
80003d4e:	0ff00813          	li	a6,255
  FP_UNPACK_RAW_S (B, b);
80003d52:	8ef9                	and	a3,a3,a4
80003d54:	0ff57513          	zext.b	a0,a0
80003d58:	837d                	srl	a4,a4,0x1f
  FP_CMP_S (r, A, B, -2, 2);
80003d5a:	01061e63          	bne	a2,a6,80003d76 <__gesf2+0x48>
80003d5e:	e1ad                	bnez	a1,80003dc0 <__gesf2+0x92>
80003d60:	00c50663          	beq	a0,a2,80003d6c <__gesf2+0x3e>
80003d64:	4505                	li	a0,1
80003d66:	cfa1                	beqz	a5,80003dbe <__gesf2+0x90>
80003d68:	557d                	li	a0,-1
80003d6a:	8082                	ret
80003d6c:	eab1                	bnez	a3,80003dc0 <__gesf2+0x92>
80003d6e:	fee79be3          	bne	a5,a4,80003d64 <__gesf2+0x36>
80003d72:	4501                	li	a0,0
80003d74:	8082                	ret
80003d76:	01051a63          	bne	a0,a6,80003d8a <__gesf2+0x5c>
80003d7a:	e2b9                	bnez	a3,80003dc0 <__gesf2+0x92>
80003d7c:	c615                	beqz	a2,80003da8 <__gesf2+0x7a>
80003d7e:	fee793e3          	bne	a5,a4,80003d64 <__gesf2+0x36>
80003d82:	557d                	li	a0,-1
80003d84:	cf8d                	beqz	a5,80003dbe <__gesf2+0x90>
80003d86:	853e                	mv	a0,a5
80003d88:	8082                	ret
80003d8a:	ce11                	beqz	a2,80003da6 <__gesf2+0x78>
80003d8c:	dd61                	beqz	a0,80003d64 <__gesf2+0x36>
80003d8e:	fce79be3          	bne	a5,a4,80003d64 <__gesf2+0x36>
80003d92:	fcc549e3          	blt	a0,a2,80003d64 <__gesf2+0x36>
80003d96:	fea646e3          	blt	a2,a0,80003d82 <__gesf2+0x54>
80003d9a:	fcb6e5e3          	bltu	a3,a1,80003d64 <__gesf2+0x36>
80003d9e:	4501                	li	a0,0
80003da0:	00d5ff63          	bgeu	a1,a3,80003dbe <__gesf2+0x90>
80003da4:	bff9                	j	80003d82 <__gesf2+0x54>
80003da6:	c511                	beqz	a0,80003db2 <__gesf2+0x84>
80003da8:	f9f9                	bnez	a1,80003d7e <__gesf2+0x50>
80003daa:	557d                	li	a0,-1
80003dac:	cb09                	beqz	a4,80003dbe <__gesf2+0x90>
80003dae:	853a                	mv	a0,a4
80003db0:	8082                	ret
80003db2:	c689                	beqz	a3,80003dbc <__gesf2+0x8e>
80003db4:	d9fd                	beqz	a1,80003daa <__gesf2+0x7c>
80003db6:	fee782e3          	beq	a5,a4,80003d9a <__gesf2+0x6c>
80003dba:	b76d                	j	80003d64 <__gesf2+0x36>
80003dbc:	f5c5                	bnez	a1,80003d64 <__gesf2+0x36>
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80003dbe:	8082                	ret
  FP_HANDLE_EXCEPTIONS;
80003dc0:	00186073          	csrs	fflags,16
80003dc4:	5579                	li	a0,-2
80003dc6:	8082                	ret

80003dc8 <__lesf2>:
#include "soft-fp.h"
#include "single.h"

CMPtype
__lesf2 (SFtype a, SFtype b)
{
80003dc8:	872e                	mv	a4,a1
  FP_DECL_EX;
  FP_DECL_S (A);
  FP_DECL_S (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
80003dca:	002026f3          	frrm	a3
  FP_UNPACK_RAW_S (A, a);
80003dce:	008006b7          	lui	a3,0x800
80003dd2:	16fd                	add	a3,a3,-1 # 7fffff <_reset_entry-0x7f800001>
80003dd4:	01755613          	srl	a2,a0,0x17
80003dd8:	00a6f5b3          	and	a1,a3,a0
80003ddc:	01f55793          	srl	a5,a0,0x1f
80003de0:	0ff67613          	zext.b	a2,a2
  FP_UNPACK_RAW_S (B, b);
80003de4:	01775513          	srl	a0,a4,0x17
  FP_CMP_S (r, A, B, 2, 2);
80003de8:	0ff00813          	li	a6,255
  FP_UNPACK_RAW_S (B, b);
80003dec:	8ef9                	and	a3,a3,a4
80003dee:	0ff57513          	zext.b	a0,a0
80003df2:	837d                	srl	a4,a4,0x1f
  FP_CMP_S (r, A, B, 2, 2);
80003df4:	01061e63          	bne	a2,a6,80003e10 <__lesf2+0x48>
80003df8:	e1ad                	bnez	a1,80003e5a <__lesf2+0x92>
80003dfa:	00c50663          	beq	a0,a2,80003e06 <__lesf2+0x3e>
80003dfe:	4505                	li	a0,1
80003e00:	cfa1                	beqz	a5,80003e58 <__lesf2+0x90>
80003e02:	557d                	li	a0,-1
80003e04:	8082                	ret
80003e06:	eab1                	bnez	a3,80003e5a <__lesf2+0x92>
80003e08:	fee79be3          	bne	a5,a4,80003dfe <__lesf2+0x36>
80003e0c:	4501                	li	a0,0
80003e0e:	8082                	ret
80003e10:	01051a63          	bne	a0,a6,80003e24 <__lesf2+0x5c>
80003e14:	e2b9                	bnez	a3,80003e5a <__lesf2+0x92>
80003e16:	c615                	beqz	a2,80003e42 <__lesf2+0x7a>
80003e18:	fee793e3          	bne	a5,a4,80003dfe <__lesf2+0x36>
80003e1c:	557d                	li	a0,-1
80003e1e:	cf8d                	beqz	a5,80003e58 <__lesf2+0x90>
80003e20:	853e                	mv	a0,a5
80003e22:	8082                	ret
80003e24:	ce11                	beqz	a2,80003e40 <__lesf2+0x78>
80003e26:	dd61                	beqz	a0,80003dfe <__lesf2+0x36>
80003e28:	fce79be3          	bne	a5,a4,80003dfe <__lesf2+0x36>
80003e2c:	fcc549e3          	blt	a0,a2,80003dfe <__lesf2+0x36>
80003e30:	fea646e3          	blt	a2,a0,80003e1c <__lesf2+0x54>
80003e34:	fcb6e5e3          	bltu	a3,a1,80003dfe <__lesf2+0x36>
80003e38:	4501                	li	a0,0
80003e3a:	00d5ff63          	bgeu	a1,a3,80003e58 <__lesf2+0x90>
80003e3e:	bff9                	j	80003e1c <__lesf2+0x54>
80003e40:	c511                	beqz	a0,80003e4c <__lesf2+0x84>
80003e42:	f9f9                	bnez	a1,80003e18 <__lesf2+0x50>
80003e44:	557d                	li	a0,-1
80003e46:	cb09                	beqz	a4,80003e58 <__lesf2+0x90>
80003e48:	853a                	mv	a0,a4
80003e4a:	8082                	ret
80003e4c:	c689                	beqz	a3,80003e56 <__lesf2+0x8e>
80003e4e:	d9fd                	beqz	a1,80003e44 <__lesf2+0x7c>
80003e50:	fee782e3          	beq	a5,a4,80003e34 <__lesf2+0x6c>
80003e54:	b76d                	j	80003dfe <__lesf2+0x36>
80003e56:	f5c5                	bnez	a1,80003dfe <__lesf2+0x36>
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80003e58:	8082                	ret
  FP_HANDLE_EXCEPTIONS;
80003e5a:	00186073          	csrs	fflags,16
80003e5e:	4509                	li	a0,2
80003e60:	8082                	ret

80003e62 <__mulsf3>:
#include "soft-fp.h"
#include "single.h"

SFtype
__mulsf3 (SFtype a, SFtype b)
{
80003e62:	7179                	add	sp,sp,-48
80003e64:	c65e                	sw	s7,12(sp)
80003e66:	d606                	sw	ra,44(sp)
80003e68:	d422                	sw	s0,40(sp)
80003e6a:	d226                	sw	s1,36(sp)
80003e6c:	d04a                	sw	s2,32(sp)
80003e6e:	ce4e                	sw	s3,28(sp)
80003e70:	cc52                	sw	s4,24(sp)
80003e72:	ca56                	sw	s5,20(sp)
80003e74:	c85a                	sw	s6,16(sp)
80003e76:	8bae                	mv	s7,a1
  FP_DECL_S (A);
  FP_DECL_S (B);
  FP_DECL_S (R);
  SFtype r;

  FP_INIT_ROUNDMODE;
80003e78:	002029f3          	frrm	s3
  FP_UNPACK_S (A, a);
80003e7c:	01755493          	srl	s1,a0,0x17
80003e80:	00951b13          	sll	s6,a0,0x9
80003e84:	0ff4f493          	zext.b	s1,s1
80003e88:	009b5b13          	srl	s6,s6,0x9
80003e8c:	01f55a13          	srl	s4,a0,0x1f
80003e90:	cc99                	beqz	s1,80003eae <__mulsf3+0x4c>
80003e92:	0ff00793          	li	a5,255
80003e96:	02f48963          	beq	s1,a5,80003ec8 <__mulsf3+0x66>
80003e9a:	0b0e                	sll	s6,s6,0x3
80003e9c:	040007b7          	lui	a5,0x4000
80003ea0:	00fb6b33          	or	s6,s6,a5
80003ea4:	f8148493          	add	s1,s1,-127 # 3fff81 <_reset_entry-0x7fc0007f>
80003ea8:	4a81                	li	s5,0
  FP_DECL_EX;
80003eaa:	4901                	li	s2,0
80003eac:	a805                	j	80003edc <__mulsf3+0x7a>
  FP_UNPACK_S (A, a);
80003eae:	080b0b63          	beqz	s6,80003f44 <__mulsf3+0xe2>
80003eb2:	855a                	mv	a0,s6
80003eb4:	04f000ef          	jal	80004702 <__clzsi2>
80003eb8:	ffb50793          	add	a5,a0,-5 # 7f7ffffb <_reset_entry-0x800005>
80003ebc:	f8a00493          	li	s1,-118
80003ec0:	00fb1b33          	sll	s6,s6,a5
80003ec4:	8c89                	sub	s1,s1,a0
80003ec6:	b7cd                	j	80003ea8 <__mulsf3+0x46>
80003ec8:	080b0163          	beqz	s6,80003f4a <__mulsf3+0xe8>
80003ecc:	00400937          	lui	s2,0x400
80003ed0:	012b3933          	sltu	s2,s6,s2
80003ed4:	0912                	sll	s2,s2,0x4
80003ed6:	0ff00493          	li	s1,255
80003eda:	4a8d                	li	s5,3
  FP_UNPACK_S (B, b);
80003edc:	017bd793          	srl	a5,s7,0x17
80003ee0:	009b9413          	sll	s0,s7,0x9
80003ee4:	0ff7f793          	zext.b	a5,a5
80003ee8:	8025                	srl	s0,s0,0x9
80003eea:	01fbdb93          	srl	s7,s7,0x1f
80003eee:	c3b5                	beqz	a5,80003f52 <__mulsf3+0xf0>
80003ef0:	0ff00713          	li	a4,255
80003ef4:	06e78a63          	beq	a5,a4,80003f68 <__mulsf3+0x106>
80003ef8:	040e                	sll	s0,s0,0x3
80003efa:	04000737          	lui	a4,0x4000
80003efe:	8c59                	or	s0,s0,a4
80003f00:	f8178793          	add	a5,a5,-127 # 3ffff81 <_reset_entry-0x7c00007f>
80003f04:	4701                	li	a4,0
  FP_MUL_S (R, A, B);
80003f06:	94be                	add	s1,s1,a5
80003f08:	002a9793          	sll	a5,s5,0x2
80003f0c:	8fd9                	or	a5,a5,a4
80003f0e:	45a9                	li	a1,10
80003f10:	017a46b3          	xor	a3,s4,s7
80003f14:	00148613          	add	a2,s1,1
80003f18:	16f5c963          	blt	a1,a5,8000408a <__mulsf3+0x228>
80003f1c:	4589                	li	a1,2
80003f1e:	06f5ca63          	blt	a1,a5,80003f92 <__mulsf3+0x130>
80003f22:	17fd                	add	a5,a5,-1
80003f24:	4585                	li	a1,1
80003f26:	08f5e363          	bltu	a1,a5,80003fac <__mulsf3+0x14a>
80003f2a:	8aba                	mv	s5,a4
  FP_PACK_S (r, R);
80003f2c:	4789                	li	a5,2
80003f2e:	2afa8b63          	beq	s5,a5,800041e4 <__mulsf3+0x382>
80003f32:	478d                	li	a5,3
80003f34:	2afa8c63          	beq	s5,a5,800041ec <__mulsf3+0x38a>
80003f38:	4785                	li	a5,1
80003f3a:	0cfa9b63          	bne	s5,a5,80004010 <__mulsf3+0x1ae>
80003f3e:	4701                	li	a4,0
80003f40:	4781                	li	a5,0
80003f42:	a205                	j	80004062 <__mulsf3+0x200>
  FP_UNPACK_S (A, a);
80003f44:	4481                	li	s1,0
80003f46:	4a85                	li	s5,1
80003f48:	b78d                	j	80003eaa <__mulsf3+0x48>
80003f4a:	0ff00493          	li	s1,255
80003f4e:	4a89                	li	s5,2
80003f50:	bfa9                	j	80003eaa <__mulsf3+0x48>
  FP_UNPACK_S (B, b);
80003f52:	c405                	beqz	s0,80003f7a <__mulsf3+0x118>
80003f54:	8522                	mv	a0,s0
80003f56:	2775                	jal	80004702 <__clzsi2>
80003f58:	ffb50793          	add	a5,a0,-5
80003f5c:	00f41433          	sll	s0,s0,a5
80003f60:	f8a00793          	li	a5,-118
80003f64:	8f89                	sub	a5,a5,a0
80003f66:	bf79                	j	80003f04 <__mulsf3+0xa2>
80003f68:	cc01                	beqz	s0,80003f80 <__mulsf3+0x11e>
80003f6a:	004007b7          	lui	a5,0x400
80003f6e:	00f46d63          	bltu	s0,a5,80003f88 <__mulsf3+0x126>
80003f72:	0ff00793          	li	a5,255
80003f76:	470d                	li	a4,3
80003f78:	b779                	j	80003f06 <__mulsf3+0xa4>
80003f7a:	4781                	li	a5,0
80003f7c:	4705                	li	a4,1
80003f7e:	b761                	j	80003f06 <__mulsf3+0xa4>
80003f80:	0ff00793          	li	a5,255
80003f84:	4709                	li	a4,2
80003f86:	b741                	j	80003f06 <__mulsf3+0xa4>
80003f88:	0ff00793          	li	a5,255
80003f8c:	470d                	li	a4,3
80003f8e:	4941                	li	s2,16
80003f90:	bf9d                	j	80003f06 <__mulsf3+0xa4>
80003f92:	4585                	li	a1,1
80003f94:	00f597b3          	sll	a5,a1,a5
  FP_MUL_S (R, A, B);
80003f98:	5307f593          	and	a1,a5,1328
80003f9c:	edf5                	bnez	a1,80004098 <__mulsf3+0x236>
80003f9e:	2407f593          	and	a1,a5,576
80003fa2:	eded                	bnez	a1,8000409c <__mulsf3+0x23a>
80003fa4:	0887f793          	and	a5,a5,136
80003fa8:	10079263          	bnez	a5,800040ac <__mulsf3+0x24a>
80003fac:	68c1                	lui	a7,0x10
80003fae:	fff88813          	add	a6,a7,-1 # ffff <_reset_entry-0x7fff0001>
80003fb2:	010b5713          	srl	a4,s6,0x10
80003fb6:	01045793          	srl	a5,s0,0x10
80003fba:	010475b3          	and	a1,s0,a6
80003fbe:	010b7b33          	and	s6,s6,a6
80003fc2:	02bb0533          	mul	a0,s6,a1
80003fc6:	02b705b3          	mul	a1,a4,a1
80003fca:	01055413          	srl	s0,a0,0x10
80003fce:	02f70733          	mul	a4,a4,a5
80003fd2:	036787b3          	mul	a5,a5,s6
80003fd6:	97ae                	add	a5,a5,a1
80003fd8:	943e                	add	s0,s0,a5
80003fda:	00b47363          	bgeu	s0,a1,80003fe0 <__mulsf3+0x17e>
80003fde:	9746                	add	a4,a4,a7
80003fe0:	010477b3          	and	a5,s0,a6
80003fe4:	07c2                	sll	a5,a5,0x10
80003fe6:	01057533          	and	a0,a0,a6
80003fea:	97aa                	add	a5,a5,a0
80003fec:	00679593          	sll	a1,a5,0x6
80003ff0:	8041                	srl	s0,s0,0x10
80003ff2:	00b035b3          	snez	a1,a1
80003ff6:	83e9                	srl	a5,a5,0x1a
80003ff8:	943a                	add	s0,s0,a4
80003ffa:	8fcd                	or	a5,a5,a1
80003ffc:	041a                	sll	s0,s0,0x6
80003ffe:	8c5d                	or	s0,s0,a5
80004000:	080007b7          	lui	a5,0x8000
80004004:	8fe1                	and	a5,a5,s0
80004006:	c7cd                	beqz	a5,800040b0 <__mulsf3+0x24e>
80004008:	00145793          	srl	a5,s0,0x1
8000400c:	8805                	and	s0,s0,1
8000400e:	8c5d                	or	s0,s0,a5
  FP_PACK_S (r, R);
80004010:	07f60793          	add	a5,a2,127 # 400007f <_reset_entry-0x7bffff81>
80004014:	01f69513          	sll	a0,a3,0x1f
80004018:	0cf05c63          	blez	a5,800040f0 <__mulsf3+0x28e>
8000401c:	00747713          	and	a4,s0,7
80004020:	c30d                	beqz	a4,80004042 <__mulsf3+0x1e0>
80004022:	4709                	li	a4,2
80004024:	00196913          	or	s2,s2,1
80004028:	08e98963          	beq	s3,a4,800040ba <__mulsf3+0x258>
8000402c:	470d                	li	a4,3
8000402e:	08e98363          	beq	s3,a4,800040b4 <__mulsf3+0x252>
80004032:	00099863          	bnez	s3,80004042 <__mulsf3+0x1e0>
80004036:	00f47713          	and	a4,s0,15
8000403a:	4591                	li	a1,4
8000403c:	00b70363          	beq	a4,a1,80004042 <__mulsf3+0x1e0>
80004040:	0411                	add	s0,s0,4
80004042:	08000737          	lui	a4,0x8000
80004046:	8f61                	and	a4,a4,s0
80004048:	c719                	beqz	a4,80004056 <__mulsf3+0x1f4>
8000404a:	f80007b7          	lui	a5,0xf8000
8000404e:	17fd                	add	a5,a5,-1 # f7ffffff <_timer_base+0x37fffeff>
80004050:	8c7d                	and	s0,s0,a5
80004052:	08060793          	add	a5,a2,128
80004056:	0fe00713          	li	a4,254
8000405a:	06f74263          	blt	a4,a5,800040be <__mulsf3+0x25c>
8000405e:	00345713          	srl	a4,s0,0x3
80004062:	0726                	sll	a4,a4,0x9
80004064:	07de                	sll	a5,a5,0x17
80004066:	8325                	srl	a4,a4,0x9
80004068:	8fd9                	or	a5,a5,a4
8000406a:	01f69513          	sll	a0,a3,0x1f
8000406e:	8d5d                	or	a0,a0,a5
  FP_HANDLE_EXCEPTIONS;
80004070:	02091b63          	bnez	s2,800040a6 <__mulsf3+0x244>

  return r;
}
80004074:	50b2                	lw	ra,44(sp)
80004076:	5422                	lw	s0,40(sp)
80004078:	5492                	lw	s1,36(sp)
8000407a:	5902                	lw	s2,32(sp)
8000407c:	49f2                	lw	s3,28(sp)
8000407e:	4a62                	lw	s4,24(sp)
80004080:	4ad2                	lw	s5,20(sp)
80004082:	4b42                	lw	s6,16(sp)
80004084:	4bb2                	lw	s7,12(sp)
80004086:	6145                	add	sp,sp,48
80004088:	8082                	ret
  FP_MUL_S (R, A, B);
8000408a:	46bd                	li	a3,15
8000408c:	16d78063          	beq	a5,a3,800041ec <__mulsf3+0x38a>
80004090:	46ad                	li	a3,11
80004092:	00d78d63          	beq	a5,a3,800040ac <__mulsf3+0x24a>
  FP_UNPACK_S (A, a);
80004096:	86d2                	mv	a3,s4
  FP_MUL_S (R, A, B);
80004098:	845a                	mv	s0,s6
8000409a:	bd49                	j	80003f2c <__mulsf3+0xca>
  FP_PACK_S (r, R);
8000409c:	800067b7          	lui	a5,0x80006
800040a0:	e087a503          	lw	a0,-504(a5) # 80005e08 <__clz_tab+0x114>
  FP_MUL_S (R, A, B);
800040a4:	4941                	li	s2,16
  FP_HANDLE_EXCEPTIONS;
800040a6:	00192073          	csrs	fflags,s2
  return r;
800040aa:	b7e9                	j	80004074 <__mulsf3+0x212>
  FP_UNPACK_S (B, b);
800040ac:	86de                	mv	a3,s7
800040ae:	bdb5                	j	80003f2a <__mulsf3+0xc8>
  FP_MUL_S (R, A, B);
800040b0:	8626                	mv	a2,s1
800040b2:	bfb9                	j	80004010 <__mulsf3+0x1ae>
  FP_PACK_S (r, R);
800040b4:	f6d9                	bnez	a3,80004042 <__mulsf3+0x1e0>
800040b6:	0421                	add	s0,s0,8
800040b8:	b769                	j	80004042 <__mulsf3+0x1e0>
800040ba:	d6c1                	beqz	a3,80004042 <__mulsf3+0x1e0>
800040bc:	bfed                	j	800040b6 <__mulsf3+0x254>
800040be:	4789                	li	a5,2
800040c0:	02f98663          	beq	s3,a5,800040ec <__mulsf3+0x28a>
800040c4:	478d                	li	a5,3
800040c6:	00f98863          	beq	s3,a5,800040d6 <__mulsf3+0x274>
800040ca:	00098763          	beqz	s3,800040d8 <__mulsf3+0x276>
800040ce:	577d                	li	a4,-1
800040d0:	0fe00793          	li	a5,254
800040d4:	a029                	j	800040de <__mulsf3+0x27c>
800040d6:	fee5                	bnez	a3,800040ce <__mulsf3+0x26c>
800040d8:	4701                	li	a4,0
800040da:	0ff00793          	li	a5,255
800040de:	00596913          	or	s2,s2,5
800040e2:	0726                	sll	a4,a4,0x9
800040e4:	07de                	sll	a5,a5,0x17
800040e6:	8325                	srl	a4,a4,0x9
800040e8:	8fd9                	or	a5,a5,a4
800040ea:	a059                	j	80004170 <__mulsf3+0x30e>
800040ec:	d2ed                	beqz	a3,800040ce <__mulsf3+0x26c>
800040ee:	b7ed                	j	800040d8 <__mulsf3+0x276>
800040f0:	ebc1                	bnez	a5,80004180 <__mulsf3+0x31e>
800040f2:	00747713          	and	a4,s0,7
800040f6:	87a2                	mv	a5,s0
800040f8:	c315                	beqz	a4,8000411c <__mulsf3+0x2ba>
800040fa:	4709                	li	a4,2
800040fc:	00196913          	or	s2,s2,1
80004100:	06e98e63          	beq	s3,a4,8000417c <__mulsf3+0x31a>
80004104:	470d                	li	a4,3
80004106:	06e98763          	beq	s3,a4,80004174 <__mulsf3+0x312>
8000410a:	00099963          	bnez	s3,8000411c <__mulsf3+0x2ba>
8000410e:	00f47713          	and	a4,s0,15
80004112:	4591                	li	a1,4
80004114:	00b70463          	beq	a4,a1,8000411c <__mulsf3+0x2ba>
80004118:	00440793          	add	a5,s0,4
8000411c:	83ed                	srl	a5,a5,0x1b
8000411e:	0017c793          	xor	a5,a5,1
80004122:	8b85                	and	a5,a5,1
80004124:	4705                	li	a4,1
80004126:	09e60613          	add	a2,a2,158
8000412a:	00c41633          	sll	a2,s0,a2
8000412e:	00c03633          	snez	a2,a2
80004132:	00e45733          	srl	a4,s0,a4
80004136:	8f51                	or	a4,a4,a2
80004138:	00777613          	and	a2,a4,7
8000413c:	c20d                	beqz	a2,8000415e <__mulsf3+0x2fc>
8000413e:	4609                	li	a2,2
80004140:	00196913          	or	s2,s2,1
80004144:	04c98863          	beq	s3,a2,80004194 <__mulsf3+0x332>
80004148:	460d                	li	a2,3
8000414a:	04c98263          	beq	s3,a2,8000418e <__mulsf3+0x32c>
8000414e:	00099863          	bnez	s3,8000415e <__mulsf3+0x2fc>
80004152:	00f77613          	and	a2,a4,15
80004156:	4591                	li	a1,4
80004158:	00b60363          	beq	a2,a1,8000415e <__mulsf3+0x2fc>
8000415c:	0711                	add	a4,a4,4 # 8000004 <_reset_entry-0x77fffffc>
8000415e:	04000637          	lui	a2,0x4000
80004162:	8e79                	and	a2,a2,a4
80004164:	ca15                	beqz	a2,80004198 <__mulsf3+0x336>
80004166:	00196913          	or	s2,s2,1
8000416a:	e3b1                	bnez	a5,800041ae <__mulsf3+0x34c>
8000416c:	008007b7          	lui	a5,0x800
80004170:	8d5d                	or	a0,a0,a5
  FP_HANDLE_EXCEPTIONS;
80004172:	bf15                	j	800040a6 <__mulsf3+0x244>
  FP_PACK_S (r, R);
80004174:	f6c5                	bnez	a3,8000411c <__mulsf3+0x2ba>
80004176:	00840793          	add	a5,s0,8
8000417a:	b74d                	j	8000411c <__mulsf3+0x2ba>
8000417c:	d2c5                	beqz	a3,8000411c <__mulsf3+0x2ba>
8000417e:	bfe5                	j	80004176 <__mulsf3+0x314>
80004180:	4705                	li	a4,1
80004182:	8f1d                	sub	a4,a4,a5
80004184:	47ed                	li	a5,27
80004186:	02e7c663          	blt	a5,a4,800041b2 <__mulsf3+0x350>
8000418a:	4785                	li	a5,1
8000418c:	bf69                	j	80004126 <__mulsf3+0x2c4>
8000418e:	fae1                	bnez	a3,8000415e <__mulsf3+0x2fc>
80004190:	0721                	add	a4,a4,8
80004192:	b7f1                	j	8000415e <__mulsf3+0x2fc>
80004194:	d6e9                	beqz	a3,8000415e <__mulsf3+0x2fc>
80004196:	bfed                	j	80004190 <__mulsf3+0x32e>
80004198:	830d                	srl	a4,a4,0x3
8000419a:	ec0784e3          	beqz	a5,80004062 <__mulsf3+0x200>
8000419e:	00197793          	and	a5,s2,1
800041a2:	ec0780e3          	beqz	a5,80004062 <__mulsf3+0x200>
800041a6:	4781                	li	a5,0
800041a8:	00296913          	or	s2,s2,2
800041ac:	bf1d                	j	800040e2 <__mulsf3+0x280>
800041ae:	4701                	li	a4,0
800041b0:	bfe5                	j	800041a8 <__mulsf3+0x346>
800041b2:	cc11                	beqz	s0,800041ce <__mulsf3+0x36c>
800041b4:	4789                	li	a5,2
800041b6:	00196913          	or	s2,s2,1
800041ba:	02f98263          	beq	s3,a5,800041de <__mulsf3+0x37c>
800041be:	478d                	li	a5,3
800041c0:	00f98b63          	beq	s3,a5,800041d6 <__mulsf3+0x374>
800041c4:	4415                	li	s0,5
800041c6:	00098363          	beqz	s3,800041cc <__mulsf3+0x36a>
800041ca:	4405                	li	s0,1
800041cc:	800d                	srl	s0,s0,0x3
800041ce:	00296913          	or	s2,s2,2
800041d2:	8d41                	or	a0,a0,s0
  FP_HANDLE_EXCEPTIONS;
800041d4:	bdc9                	j	800040a6 <__mulsf3+0x244>
  FP_PACK_S (r, R);
800041d6:	4405                	li	s0,1
800041d8:	faf5                	bnez	a3,800041cc <__mulsf3+0x36a>
800041da:	4425                	li	s0,9
800041dc:	bfc5                	j	800041cc <__mulsf3+0x36a>
800041de:	4405                	li	s0,1
800041e0:	d6f5                	beqz	a3,800041cc <__mulsf3+0x36a>
800041e2:	bfe5                	j	800041da <__mulsf3+0x378>
800041e4:	4701                	li	a4,0
800041e6:	0ff00793          	li	a5,255
800041ea:	bda5                	j	80004062 <__mulsf3+0x200>
800041ec:	00400737          	lui	a4,0x400
800041f0:	0ff00793          	li	a5,255
800041f4:	4681                	li	a3,0
800041f6:	b5b5                	j	80004062 <__mulsf3+0x200>

800041f8 <__floatundisf>:
#include "soft-fp.h"
#include "single.h"

SFtype
__floatundisf (UDItype i)
{
800041f8:	1101                	add	sp,sp,-32
800041fa:	ce06                	sw	ra,28(sp)
800041fc:	cc22                	sw	s0,24(sp)
800041fe:	ca26                	sw	s1,20(sp)
80004200:	c84a                	sw	s2,16(sp)
80004202:	c64e                	sw	s3,12(sp)
80004204:	c452                	sw	s4,8(sp)
80004206:	c256                	sw	s5,4(sp)
  FP_DECL_EX;
  FP_DECL_S (A);
  SFtype a;

  FP_INIT_ROUNDMODE;
80004208:	00202973          	frrm	s2
  FP_FROM_INT_S (A, i, DI_BITS, UDItype);
8000420c:	00b567b3          	or	a5,a0,a1
80004210:	10078063          	beqz	a5,80004310 <__floatundisf+0x118>
80004214:	8a2a                	mv	s4,a0
80004216:	8aae                	mv	s5,a1
80004218:	c5b9                	beqz	a1,80004266 <__floatundisf+0x6e>
8000421a:	852e                	mv	a0,a1
8000421c:	21dd                	jal	80004702 <__clzsi2>
8000421e:	0be00413          	li	s0,190
80004222:	89aa                	mv	s3,a0
80004224:	8c09                	sub	s0,s0,a0
80004226:	01b98613          	add	a2,s3,27
8000422a:	8552                	mv	a0,s4
8000422c:	85d6                	mv	a1,s5
8000422e:	2175                	jal	800046da <__ashldi3>
80004230:	02500613          	li	a2,37
80004234:	00b564b3          	or	s1,a0,a1
80004238:	41360633          	sub	a2,a2,s3
8000423c:	8552                	mv	a0,s4
8000423e:	85d6                	mv	a1,s5
80004240:	009034b3          	snez	s1,s1
80004244:	21bd                	jal	800046b2 <__lshrdi3>
80004246:	8cc9                	or	s1,s1,a0
80004248:	fc0007b7          	lui	a5,0xfc000
8000424c:	17fd                	add	a5,a5,-1 # fbffffff <_timer_base+0x3bfffeff>
8000424e:	0074f693          	and	a3,s1,7
80004252:	8fe5                	and	a5,a5,s1
80004254:	4701                	li	a4,0
80004256:	c6d1                	beqz	a3,800042e2 <__floatundisf+0xea>
80004258:	06090f63          	beqz	s2,800042d6 <__floatundisf+0xde>
8000425c:	470d                	li	a4,3
8000425e:	0ae90763          	beq	s2,a4,8000430c <__floatundisf+0x114>
80004262:	4705                	li	a4,1
80004264:	a8bd                	j	800042e2 <__floatundisf+0xea>
80004266:	84aa                	mv	s1,a0
80004268:	2969                	jal	80004702 <__clzsi2>
8000426a:	02050993          	add	s3,a0,32
8000426e:	0be00413          	li	s0,190
80004272:	41340433          	sub	s0,s0,s3
80004276:	09600793          	li	a5,150
8000427a:	0287ce63          	blt	a5,s0,800042b6 <__floatundisf+0xbe>
8000427e:	008007b7          	lui	a5,0x800
80004282:	02800713          	li	a4,40
80004286:	17fd                	add	a5,a5,-1 # 7fffff <_reset_entry-0x7f800001>
80004288:	02e99063          	bne	s3,a4,800042a8 <__floatundisf+0xb0>
  FP_PACK_RAW_S (a, A);
8000428c:	00fa77b3          	and	a5,s4,a5
80004290:	4b000537          	lui	a0,0x4b000
80004294:	8d5d                	or	a0,a0,a5
  FP_HANDLE_EXCEPTIONS;

  return a;
}
80004296:	40f2                	lw	ra,28(sp)
80004298:	4462                	lw	s0,24(sp)
8000429a:	44d2                	lw	s1,20(sp)
8000429c:	4942                	lw	s2,16(sp)
8000429e:	49b2                	lw	s3,12(sp)
800042a0:	4a22                	lw	s4,8(sp)
800042a2:	4a92                	lw	s5,4(sp)
800042a4:	6105                	add	sp,sp,32
800042a6:	8082                	ret
  FP_FROM_INT_S (A, i, DI_BITS, UDItype);
800042a8:	1561                	add	a0,a0,-8 # 4afffff8 <_reset_entry-0x35000008>
800042aa:	00aa1533          	sll	a0,s4,a0
  FP_PACK_RAW_S (a, A);
800042ae:	8d7d                	and	a0,a0,a5
800042b0:	045e                	sll	s0,s0,0x17
800042b2:	8d41                	or	a0,a0,s0
  FP_HANDLE_EXCEPTIONS;
800042b4:	b7cd                	j	80004296 <__floatundisf+0x9e>
  FP_FROM_INT_S (A, i, DI_BITS, UDItype);
800042b6:	09900793          	li	a5,153
800042ba:	f687c6e3          	blt	a5,s0,80004226 <__floatundisf+0x2e>
800042be:	02500713          	li	a4,37
800042c2:	ffb50793          	add	a5,a0,-5
800042c6:	00e98563          	beq	s3,a4,800042d0 <__floatundisf+0xd8>
800042ca:	00fa14b3          	sll	s1,s4,a5
800042ce:	bfad                	j	80004248 <__floatundisf+0x50>
800042d0:	09900413          	li	s0,153
800042d4:	bf95                	j	80004248 <__floatundisf+0x50>
800042d6:	88bd                	and	s1,s1,15
800042d8:	4691                	li	a3,4
800042da:	4705                	li	a4,1
800042dc:	00d48363          	beq	s1,a3,800042e2 <__floatundisf+0xea>
800042e0:	0791                	add	a5,a5,4
800042e2:	040006b7          	lui	a3,0x4000
800042e6:	8efd                	and	a3,a3,a5
800042e8:	ca89                	beqz	a3,800042fa <__floatundisf+0x102>
800042ea:	fc0006b7          	lui	a3,0xfc000
800042ee:	16fd                	add	a3,a3,-1 # fbffffff <_timer_base+0x3bfffeff>
800042f0:	0bf00413          	li	s0,191
800042f4:	8ff5                	and	a5,a5,a3
800042f6:	41340433          	sub	s0,s0,s3
  FP_PACK_RAW_S (a, A);
800042fa:	00679513          	sll	a0,a5,0x6
800042fe:	8125                	srl	a0,a0,0x9
80004300:	045e                	sll	s0,s0,0x17
80004302:	8d41                	or	a0,a0,s0
  FP_HANDLE_EXCEPTIONS;
80004304:	db49                	beqz	a4,80004296 <__floatundisf+0x9e>
80004306:	0010e073          	csrs	fflags,1
8000430a:	b771                	j	80004296 <__floatundisf+0x9e>
  FP_FROM_INT_S (A, i, DI_BITS, UDItype);
8000430c:	07a1                	add	a5,a5,8
8000430e:	bf91                	j	80004262 <__floatundisf+0x6a>
  FP_PACK_RAW_S (a, A);
80004310:	00000513          	li	a0,0
  return a;
80004314:	b749                	j	80004296 <__floatundisf+0x9e>

80004316 <__extendsfdf2>:
#include "single.h"
#include "double.h"

DFtype
__extendsfdf2 (SFtype a)
{
80004316:	1101                	add	sp,sp,-32
80004318:	ce06                	sw	ra,28(sp)
8000431a:	cc22                	sw	s0,24(sp)
8000431c:	ca26                	sw	s1,20(sp)
8000431e:	c84a                	sw	s2,16(sp)
  FP_DECL_EX;
  FP_DECL_S (A);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_EXCEPTIONS;
80004320:	00202773          	frrm	a4
  FP_UNPACK_RAW_S (A, a);
80004324:	01755493          	srl	s1,a0,0x17
80004328:	0ff4f493          	zext.b	s1,s1
#if _FP_W_TYPE_SIZE < _FP_FRACBITS_D
  FP_EXTEND (D, S, 2, 1, R, A);
8000432c:	00148793          	add	a5,s1,1
  FP_UNPACK_RAW_S (A, a);
80004330:	00951413          	sll	s0,a0,0x9
  FP_EXTEND (D, S, 2, 1, R, A);
80004334:	0fe7f793          	and	a5,a5,254
  FP_UNPACK_RAW_S (A, a);
80004338:	8025                	srl	s0,s0,0x9
8000433a:	01f55913          	srl	s2,a0,0x1f
  FP_EXTEND (D, S, 2, 1, R, A);
8000433e:	cf85                	beqz	a5,80004376 <__extendsfdf2+0x60>
80004340:	38048513          	add	a0,s1,896
80004344:	00345793          	srl	a5,s0,0x3
  FP_DECL_EX;
80004348:	4481                	li	s1,0
  FP_EXTEND (D, S, 2, 1, R, A);
8000434a:	0476                	sll	s0,s0,0x1d
#else
  FP_EXTEND (D, S, 1, 1, R, A);
#endif
  FP_PACK_RAW_D (r, R);
8000434c:	07b2                	sll	a5,a5,0xc
8000434e:	83b1                	srl	a5,a5,0xc
80004350:	0552                	sll	a0,a0,0x14
80004352:	8d5d                	or	a0,a0,a5
80004354:	01f91793          	sll	a5,s2,0x1f
80004358:	00f566b3          	or	a3,a0,a5
8000435c:	c422                	sw	s0,8(sp)
8000435e:	c636                	sw	a3,12(sp)
  FP_HANDLE_EXCEPTIONS;
80004360:	c099                	beqz	s1,80004366 <__extendsfdf2+0x50>
80004362:	00186073          	csrs	fflags,16

  return r;
}
80004366:	40f2                	lw	ra,28(sp)
80004368:	4462                	lw	s0,24(sp)
8000436a:	4522                	lw	a0,8(sp)
8000436c:	45b2                	lw	a1,12(sp)
8000436e:	44d2                	lw	s1,20(sp)
80004370:	4942                	lw	s2,16(sp)
80004372:	6105                	add	sp,sp,32
80004374:	8082                	ret
  FP_EXTEND (D, S, 2, 1, R, A);
80004376:	e895                	bnez	s1,800043aa <__extendsfdf2+0x94>
80004378:	c821                	beqz	s0,800043c8 <__extendsfdf2+0xb2>
8000437a:	8522                	mv	a0,s0
8000437c:	2659                	jal	80004702 <__clzsi2>
8000437e:	47a9                	li	a5,10
80004380:	00a7cf63          	blt	a5,a0,8000439e <__extendsfdf2+0x88>
80004384:	47ad                	li	a5,11
80004386:	8f89                	sub	a5,a5,a0
80004388:	01550713          	add	a4,a0,21
8000438c:	00f457b3          	srl	a5,s0,a5
80004390:	00e41433          	sll	s0,s0,a4
80004394:	38900713          	li	a4,905
80004398:	40a70533          	sub	a0,a4,a0
8000439c:	bf45                	j	8000434c <__extendsfdf2+0x36>
8000439e:	ff550793          	add	a5,a0,-11
800043a2:	00f417b3          	sll	a5,s0,a5
800043a6:	4401                	li	s0,0
800043a8:	b7f5                	j	80004394 <__extendsfdf2+0x7e>
800043aa:	c015                	beqz	s0,800043ce <__extendsfdf2+0xb8>
800043ac:	004004b7          	lui	s1,0x400
800043b0:	009434b3          	sltu	s1,s0,s1
800043b4:	00345793          	srl	a5,s0,0x3
800043b8:	00080737          	lui	a4,0x80
800043bc:	0492                	sll	s1,s1,0x4
800043be:	0476                	sll	s0,s0,0x1d
800043c0:	8fd9                	or	a5,a5,a4
800043c2:	7ff00513          	li	a0,2047
800043c6:	b759                	j	8000434c <__extendsfdf2+0x36>
800043c8:	4781                	li	a5,0
800043ca:	4501                	li	a0,0
800043cc:	b741                	j	8000434c <__extendsfdf2+0x36>
800043ce:	4781                	li	a5,0
  FP_DECL_EX;
800043d0:	4481                	li	s1,0
800043d2:	bfc5                	j	800043c2 <__extendsfdf2+0xac>

800043d4 <__truncdfsf2>:
  FP_DECL_EX;
  FP_DECL_D (A);
  FP_DECL_S (R);
  SFtype r;

  FP_INIT_ROUNDMODE;
800043d4:	00202873          	frrm	a6
  FP_UNPACK_SEMIRAW_D (A, a);
800043d8:	00c59793          	sll	a5,a1,0xc
800043dc:	0145d893          	srl	a7,a1,0x14
800043e0:	83a5                	srl	a5,a5,0x9
800043e2:	7ff8f893          	and	a7,a7,2047
800043e6:	01d55613          	srl	a2,a0,0x1d
800043ea:	8e5d                	or	a2,a2,a5
#if _FP_W_TYPE_SIZE < _FP_FRACBITS_D
  FP_TRUNC (S, D, 1, 2, R, A);
800043ec:	00188793          	add	a5,a7,1
800043f0:	7fe7f793          	and	a5,a5,2046
  FP_UNPACK_SEMIRAW_D (A, a);
800043f4:	81fd                	srl	a1,a1,0x1f
800043f6:	00351693          	sll	a3,a0,0x3
  FP_TRUNC (S, D, 1, 2, R, A);
800043fa:	cbf1                	beqz	a5,800044ce <__truncdfsf2+0xfa>
800043fc:	c8088713          	add	a4,a7,-896
80004400:	0fe00793          	li	a5,254
80004404:	02e7d663          	bge	a5,a4,80004430 <__truncdfsf2+0x5c>
80004408:	20080863          	beqz	a6,80004618 <__truncdfsf2+0x244>
8000440c:	478d                	li	a5,3
8000440e:	00f81963          	bne	a6,a5,80004420 <__truncdfsf2+0x4c>
80004412:	20058e63          	beqz	a1,8000462e <__truncdfsf2+0x25a>
80004416:	57fd                	li	a5,-1
80004418:	0fe00713          	li	a4,254
#else
  FP_TRUNC (S, D, 1, 1, R, A);
#endif
  FP_PACK_SEMIRAW_S (r, R);
8000441c:	4695                	li	a3,5
8000441e:	a251                	j	800045a2 <__truncdfsf2+0x1ce>
  FP_TRUNC (S, D, 1, 2, R, A);
80004420:	4789                	li	a5,2
80004422:	fef81ae3          	bne	a6,a5,80004416 <__truncdfsf2+0x42>
80004426:	d9e5                	beqz	a1,80004416 <__truncdfsf2+0x42>
  FP_PACK_SEMIRAW_S (r, R);
80004428:	ff800537          	lui	a0,0xff800
  FP_TRUNC (S, D, 1, 2, R, A);
8000442c:	4695                	li	a3,5
8000442e:	aae1                	j	80004606 <__truncdfsf2+0x232>
80004430:	08e04063          	bgtz	a4,800044b0 <__truncdfsf2+0xdc>
80004434:	57a5                	li	a5,-23
80004436:	0af74263          	blt	a4,a5,800044da <__truncdfsf2+0x106>
8000443a:	008007b7          	lui	a5,0x800
8000443e:	4579                	li	a0,30
80004440:	8e5d                	or	a2,a2,a5
80004442:	8d19                	sub	a0,a0,a4
80004444:	47fd                	li	a5,31
80004446:	04a7c363          	blt	a5,a0,8000448c <__truncdfsf2+0xb8>
8000444a:	c8288893          	add	a7,a7,-894
8000444e:	00a6d533          	srl	a0,a3,a0
80004452:	011696b3          	sll	a3,a3,a7
80004456:	00d036b3          	snez	a3,a3
8000445a:	01161633          	sll	a2,a2,a7
8000445e:	8ed1                	or	a3,a3,a2
80004460:	00d567b3          	or	a5,a0,a3
  FP_PACK_SEMIRAW_S (r, R);
80004464:	00179713          	sll	a4,a5,0x1
80004468:	00777693          	and	a3,a4,7
8000446c:	eaad                	bnez	a3,800044de <__truncdfsf2+0x10a>
8000446e:	0077f693          	and	a3,a5,7
80004472:	4701                	li	a4,0
80004474:	4605                	li	a2,1
80004476:	eee9                	bnez	a3,80004550 <__truncdfsf2+0x17c>
80004478:	0ff00613          	li	a2,255
8000447c:	838d                	srl	a5,a5,0x3
8000447e:	08c71e63          	bne	a4,a2,8000451a <__truncdfsf2+0x146>
80004482:	cfc1                	beqz	a5,8000451a <__truncdfsf2+0x146>
80004484:	004007b7          	lui	a5,0x400
80004488:	4581                	li	a1,0
8000448a:	a841                	j	8000451a <__truncdfsf2+0x146>
  FP_TRUNC (S, D, 1, 2, R, A);
8000448c:	57f9                	li	a5,-2
8000448e:	8f99                	sub	a5,a5,a4
80004490:	02000313          	li	t1,32
80004494:	00f657b3          	srl	a5,a2,a5
80004498:	4701                	li	a4,0
8000449a:	00650663          	beq	a0,t1,800044a6 <__truncdfsf2+0xd2>
8000449e:	ca288713          	add	a4,a7,-862
800044a2:	00e61733          	sll	a4,a2,a4
800044a6:	8f55                	or	a4,a4,a3
800044a8:	00e03733          	snez	a4,a4
800044ac:	8fd9                	or	a5,a5,a4
  FP_PACK_SEMIRAW_S (r, R);
800044ae:	bf5d                	j	80004464 <__truncdfsf2+0x90>
  FP_TRUNC (S, D, 1, 2, R, A);
800044b0:	00651793          	sll	a5,a0,0x6
800044b4:	060e                	sll	a2,a2,0x3
800044b6:	00f037b3          	snez	a5,a5
800044ba:	82f5                	srl	a3,a3,0x1d
800044bc:	8fd1                	or	a5,a5,a2
800044be:	8fd5                	or	a5,a5,a3
  FP_PACK_SEMIRAW_S (r, R);
800044c0:	0077f693          	and	a3,a5,7
800044c4:	4601                	li	a2,0
800044c6:	e6c9                	bnez	a3,80004550 <__truncdfsf2+0x17c>
800044c8:	838d                	srl	a5,a5,0x3
  FP_DECL_EX;
800044ca:	4681                	li	a3,0
800044cc:	a0b9                	j	8000451a <__truncdfsf2+0x146>
  FP_TRUNC (S, D, 1, 2, R, A);
800044ce:	8ed1                	or	a3,a3,a2
800044d0:	02089463          	bnez	a7,800044f8 <__truncdfsf2+0x124>
  FP_PACK_SEMIRAW_S (r, R);
800044d4:	01f59513          	sll	a0,a1,0x1f
  FP_TRUNC (S, D, 1, 2, R, A);
800044d8:	cea1                	beqz	a3,80004530 <__truncdfsf2+0x15c>
800044da:	4785                	li	a5,1
  FP_PACK_SEMIRAW_S (r, R);
800044dc:	4709                	li	a4,2
800044de:	4609                	li	a2,2
800044e0:	0077f693          	and	a3,a5,7
800044e4:	08c80663          	beq	a6,a2,80004570 <__truncdfsf2+0x19c>
800044e8:	460d                	li	a2,3
800044ea:	04c80f63          	beq	a6,a2,80004548 <__truncdfsf2+0x174>
800044ee:	04080263          	beqz	a6,80004532 <__truncdfsf2+0x15e>
800044f2:	4701                	li	a4,0
800044f4:	4605                	li	a2,1
800044f6:	a8a1                	j	8000454e <__truncdfsf2+0x17a>
  FP_TRUNC (S, D, 1, 2, R, A);
800044f8:	12068663          	beqz	a3,80004624 <__truncdfsf2+0x250>
800044fc:	7ff00793          	li	a5,2047
  FP_DECL_EX;
80004500:	4681                	li	a3,0
  FP_TRUNC (S, D, 1, 2, R, A);
80004502:	00f89763          	bne	a7,a5,80004510 <__truncdfsf2+0x13c>
80004506:	8259                	srl	a2,a2,0x16
80004508:	00164613          	xor	a2,a2,1
8000450c:	00461693          	sll	a3,a2,0x4
  FP_PACK_SEMIRAW_S (r, R);
80004510:	4581                	li	a1,0
80004512:	0ff00713          	li	a4,255
80004516:	004007b7          	lui	a5,0x400
8000451a:	01771513          	sll	a0,a4,0x17
8000451e:	07a6                	sll	a5,a5,0x9
80004520:	7f800737          	lui	a4,0x7f800
80004524:	8d79                	and	a0,a0,a4
80004526:	83a5                	srl	a5,a5,0x9
80004528:	8d5d                	or	a0,a0,a5
8000452a:	05fe                	sll	a1,a1,0x1f
8000452c:	8d4d                	or	a0,a0,a1
  FP_HANDLE_EXCEPTIONS;
8000452e:	eee1                	bnez	a3,80004606 <__truncdfsf2+0x232>

  return r;
}
80004530:	8082                	ret
  FP_PACK_SEMIRAW_S (r, R);
80004532:	00f77513          	and	a0,a4,15
80004536:	4611                	li	a2,4
80004538:	0711                	add	a4,a4,4 # 7f800004 <_reset_entry-0x7ffffc>
8000453a:	02c51d63          	bne	a0,a2,80004574 <__truncdfsf2+0x1a0>
8000453e:	4701                	li	a4,0
80004540:	4605                	li	a2,1
80004542:	ea91                	bnez	a3,80004556 <__truncdfsf2+0x182>
80004544:	468d                	li	a3,3
80004546:	bf0d                	j	80004478 <__truncdfsf2+0xa4>
80004548:	c58d                	beqz	a1,80004572 <__truncdfsf2+0x19e>
8000454a:	862e                	mv	a2,a1
8000454c:	4701                	li	a4,0
8000454e:	dafd                	beqz	a3,80004544 <__truncdfsf2+0x170>
80004550:	4689                	li	a3,2
80004552:	06d80a63          	beq	a6,a3,800045c6 <__truncdfsf2+0x1f2>
80004556:	468d                	li	a3,3
80004558:	04d80263          	beq	a6,a3,8000459c <__truncdfsf2+0x1c8>
8000455c:	06081a63          	bnez	a6,800045d0 <__truncdfsf2+0x1fc>
80004560:	00f7f693          	and	a3,a5,15
80004564:	4511                	li	a0,4
80004566:	02a69563          	bne	a3,a0,80004590 <__truncdfsf2+0x1bc>
8000456a:	4685                	li	a3,1
8000456c:	d611                	beqz	a2,80004478 <__truncdfsf2+0xa4>
8000456e:	bfd9                	j	80004544 <__truncdfsf2+0x170>
80004570:	d1c9                	beqz	a1,800044f2 <__truncdfsf2+0x11e>
80004572:	0721                	add	a4,a4,8
80004574:	08000637          	lui	a2,0x8000
80004578:	00c77533          	and	a0,a4,a2
8000457c:	00153613          	seqz	a2,a0
80004580:	4701                	li	a4,0
80004582:	f6f9                	bnez	a3,80004550 <__truncdfsf2+0x17c>
80004584:	468d                	li	a3,3
80004586:	ee0509e3          	beqz	a0,80004478 <__truncdfsf2+0xa4>
8000458a:	838d                	srl	a5,a5,0x3
8000458c:	4685                	li	a3,1
8000458e:	b771                	j	8000451a <__truncdfsf2+0x146>
80004590:	0791                	add	a5,a5,4 # 400004 <_reset_entry-0x7fbffffc>
80004592:	4685                	li	a3,1
80004594:	c619                	beqz	a2,800045a2 <__truncdfsf2+0x1ce>
80004596:	00266693          	or	a3,a2,2
8000459a:	a021                	j	800045a2 <__truncdfsf2+0x1ce>
8000459c:	c19d                	beqz	a1,800045c2 <__truncdfsf2+0x1ee>
8000459e:	86ae                	mv	a3,a1
800045a0:	ea1d                	bnez	a2,800045d6 <__truncdfsf2+0x202>
800045a2:	04000637          	lui	a2,0x4000
800045a6:	8e7d                	and	a2,a2,a5
800045a8:	ec0608e3          	beqz	a2,80004478 <__truncdfsf2+0xa4>
800045ac:	0705                	add	a4,a4,1
800045ae:	0ff00613          	li	a2,255
800045b2:	02c70463          	beq	a4,a2,800045da <__truncdfsf2+0x206>
800045b6:	1f800637          	lui	a2,0x1f800
800045ba:	838d                	srl	a5,a5,0x3
800045bc:	167d                	add	a2,a2,-1 # 1f7fffff <_reset_entry-0x60800001>
800045be:	8ff1                	and	a5,a5,a2
800045c0:	bfa9                	j	8000451a <__truncdfsf2+0x146>
800045c2:	07a1                	add	a5,a5,8
800045c4:	b7f9                	j	80004592 <__truncdfsf2+0x1be>
800045c6:	d5f1                	beqz	a1,80004592 <__truncdfsf2+0x1be>
800045c8:	07a1                	add	a5,a5,8
800045ca:	86ae                	mv	a3,a1
800045cc:	da79                	beqz	a2,800045a2 <__truncdfsf2+0x1ce>
800045ce:	b7e1                	j	80004596 <__truncdfsf2+0x1c2>
800045d0:	4685                	li	a3,1
800045d2:	f271                	bnez	a2,80004596 <__truncdfsf2+0x1c2>
800045d4:	b7f9                	j	800045a2 <__truncdfsf2+0x1ce>
800045d6:	862e                	mv	a2,a1
800045d8:	bf7d                	j	80004596 <__truncdfsf2+0x1c2>
800045da:	0056e693          	or	a3,a3,5
800045de:	02080763          	beqz	a6,8000460c <__truncdfsf2+0x238>
800045e2:	478d                	li	a5,3
800045e4:	00f81963          	bne	a6,a5,800045f6 <__truncdfsf2+0x222>
800045e8:	c195                	beqz	a1,8000460c <__truncdfsf2+0x238>
800045ea:	7f8007b7          	lui	a5,0x7f800
800045ee:	01f59513          	sll	a0,a1,0x1f
800045f2:	17fd                	add	a5,a5,-1 # 7f7fffff <_reset_entry-0x800001>
800045f4:	a005                	j	80004614 <__truncdfsf2+0x240>
800045f6:	4789                	li	a5,2
800045f8:	fef819e3          	bne	a6,a5,800045ea <__truncdfsf2+0x216>
800045fc:	e981                	bnez	a1,8000460c <__truncdfsf2+0x238>
800045fe:	800067b7          	lui	a5,0x80006
80004602:	e047a503          	lw	a0,-508(a5) # 80005e04 <__clz_tab+0x110>
  FP_HANDLE_EXCEPTIONS;
80004606:	0016a073          	csrs	fflags,a3
  return r;
8000460a:	8082                	ret
  FP_PACK_SEMIRAW_S (r, R);
8000460c:	01f59513          	sll	a0,a1,0x1f
80004610:	7f8007b7          	lui	a5,0x7f800
80004614:	8d5d                	or	a0,a0,a5
  FP_HANDLE_EXCEPTIONS;
80004616:	bfc5                	j	80004606 <__truncdfsf2+0x232>
  FP_PACK_SEMIRAW_S (r, R);
80004618:	01f59513          	sll	a0,a1,0x1f
8000461c:	7f8007b7          	lui	a5,0x7f800
80004620:	8d5d                	or	a0,a0,a5
  FP_HANDLE_EXCEPTIONS;
80004622:	b529                	j	8000442c <__truncdfsf2+0x58>
  FP_PACK_SEMIRAW_S (r, R);
80004624:	05fe                	sll	a1,a1,0x1f
80004626:	7f800537          	lui	a0,0x7f800
8000462a:	8d4d                	or	a0,a0,a1
  FP_HANDLE_EXCEPTIONS;
8000462c:	8082                	ret
  FP_PACK_SEMIRAW_S (r, R);
8000462e:	7f800537          	lui	a0,0x7f800
80004632:	bbed                	j	8000442c <__truncdfsf2+0x58>

80004634 <__divsi3>:
  li    t0, -1
  beq   a1, t0, .L20
#endif

FUNC_BEGIN (__divdi3)
  bltz  a0, .L10
80004634:	02054e63          	bltz	a0,80004670 <__umodsi3+0x8>
  bltz  a1, .L11
80004638:	0405c363          	bltz	a1,8000467e <__umodsi3+0x16>

8000463c <__hidden___udivsi3>:
  /* Since the quotient is positive, fall into __udivdi3.  */

FUNC_BEGIN (__udivdi3)
  mv    a2, a1
8000463c:	862e                	mv	a2,a1
  mv    a1, a0
8000463e:	85aa                	mv	a1,a0
  li    a0, -1
80004640:	557d                	li	a0,-1
  beqz  a2, .L5
80004642:	c215                	beqz	a2,80004666 <__hidden___udivsi3+0x2a>
  li    a3, 1
80004644:	4685                	li	a3,1
  bgeu  a2, a1, .L2
80004646:	00b67863          	bgeu	a2,a1,80004656 <__hidden___udivsi3+0x1a>
.L1:
  blez  a2, .L2
8000464a:	00c05663          	blez	a2,80004656 <__hidden___udivsi3+0x1a>
  slli  a2, a2, 1
8000464e:	0606                	sll	a2,a2,0x1
  slli  a3, a3, 1
80004650:	0686                	sll	a3,a3,0x1
  bgtu  a1, a2, .L1
80004652:	feb66ce3          	bltu	a2,a1,8000464a <__hidden___udivsi3+0xe>
.L2:
  li    a0, 0
80004656:	4501                	li	a0,0
.L3:
  bltu  a1, a2, .L4
80004658:	00c5e463          	bltu	a1,a2,80004660 <__hidden___udivsi3+0x24>
  sub   a1, a1, a2
8000465c:	8d91                	sub	a1,a1,a2
  or    a0, a0, a3
8000465e:	8d55                	or	a0,a0,a3
.L4:
  srli  a3, a3, 1
80004660:	8285                	srl	a3,a3,0x1
  srli  a2, a2, 1
80004662:	8205                	srl	a2,a2,0x1
  bnez  a3, .L3
80004664:	faf5                	bnez	a3,80004658 <__hidden___udivsi3+0x1c>
.L5:
  ret
80004666:	8082                	ret

80004668 <__umodsi3>:
FUNC_END (__udivdi3)
HIDDEN_DEF (__udivdi3)

FUNC_BEGIN (__umoddi3)
  /* Call __udivdi3(a0, a1), then return the remainder, which is in a1.  */
  move  t0, ra
80004668:	8286                	mv	t0,ra
  jal   HIDDEN_JUMPTARGET(__udivdi3)
8000466a:	3fc9                	jal	8000463c <__hidden___udivsi3>
  move  a0, a1
8000466c:	852e                	mv	a0,a1
  jr    t0
8000466e:	8282                	jr	t0
FUNC_END (__umoddi3)

  /* Handle negative arguments to __divdi3.  */
.L10:
  neg   a0, a0
80004670:	40a00533          	neg	a0,a0
  /* Zero is handled as a negative so that the result will not be inverted.  */
  bgtz  a1, .L12     /* Compute __udivdi3(-a0, a1), then negate the result.  */
80004674:	00b04763          	bgtz	a1,80004682 <__umodsi3+0x1a>

  neg   a1, a1
80004678:	40b005b3          	neg	a1,a1
  j     HIDDEN_JUMPTARGET(__udivdi3)     /* Compute __udivdi3(-a0, -a1).  */
8000467c:	b7c1                	j	8000463c <__hidden___udivsi3>
.L11:                /* Compute __udivdi3(a0, -a1), then negate the result.  */
  neg   a1, a1
8000467e:	40b005b3          	neg	a1,a1
.L12:
  move  t0, ra
80004682:	8286                	mv	t0,ra
  jal   HIDDEN_JUMPTARGET(__udivdi3)
80004684:	3f65                	jal	8000463c <__hidden___udivsi3>
  neg   a0, a0
80004686:	40a00533          	neg	a0,a0
  jr    t0
8000468a:	8282                	jr	t0

8000468c <__modsi3>:
FUNC_END (__divdi3)

FUNC_BEGIN (__moddi3)
  move   t0, ra
8000468c:	8286                	mv	t0,ra
  bltz   a1, .L31
8000468e:	0005c763          	bltz	a1,8000469c <__modsi3+0x10>
  bltz   a0, .L32
80004692:	00054963          	bltz	a0,800046a4 <__modsi3+0x18>
.L30:
  jal    HIDDEN_JUMPTARGET(__udivdi3)    /* The dividend is not negative.  */
80004696:	375d                	jal	8000463c <__hidden___udivsi3>
  move   a0, a1
80004698:	852e                	mv	a0,a1
  jr     t0
8000469a:	8282                	jr	t0
.L31:
  neg    a1, a1
8000469c:	40b005b3          	neg	a1,a1
  bgez   a0, .L30
800046a0:	fe055be3          	bgez	a0,80004696 <__modsi3+0xa>
.L32:
  neg    a0, a0
800046a4:	40a00533          	neg	a0,a0
  jal    HIDDEN_JUMPTARGET(__udivdi3)    /* The dividend is hella negative.  */
800046a8:	3f51                	jal	8000463c <__hidden___udivsi3>
  neg    a0, a1
800046aa:	40b00533          	neg	a0,a1
  jr     t0
800046ae:	8282                	jr	t0
800046b0:	0000                	unimp

800046b2 <__lshrdi3>:
   parameter b will be promoted to int if shift_count_type is smaller than an int.  */
#ifdef L_lshrdi3
DWtype
__lshrdi3 (DWtype u, shift_count_type b)
{
  if (b == 0)
800046b2:	ca19                	beqz	a2,800046c8 <__lshrdi3+0x16>
    return u;

  const DWunion uu = {.ll = u};
  const shift_count_type bm = W_TYPE_SIZE - b;
800046b4:	02000793          	li	a5,32
800046b8:	8f91                	sub	a5,a5,a2
  DWunion w;

  if (bm <= 0)
800046ba:	00f04863          	bgtz	a5,800046ca <__lshrdi3+0x18>
    {
      w.s.high = 0;
      w.s.low = (UWtype) uu.s.high >> -bm;
800046be:	1601                	add	a2,a2,-32
800046c0:	00c5d533          	srl	a0,a1,a2
800046c4:	4701                	li	a4,0

      w.s.high = (UWtype) uu.s.high >> b;
      w.s.low = ((UWtype) uu.s.low >> b) | carries;
    }

  return w.ll;
800046c6:	85ba                	mv	a1,a4
}
800046c8:	8082                	ret
      w.s.high = (UWtype) uu.s.high >> b;
800046ca:	00c5d733          	srl	a4,a1,a2
      w.s.low = ((UWtype) uu.s.low >> b) | carries;
800046ce:	00c55533          	srl	a0,a0,a2
      const UWtype carries = (UWtype) uu.s.high << bm;
800046d2:	00f595b3          	sll	a1,a1,a5
      w.s.low = ((UWtype) uu.s.low >> b) | carries;
800046d6:	8d4d                	or	a0,a0,a1
800046d8:	b7fd                	j	800046c6 <__lshrdi3+0x14>

800046da <__ashldi3>:

#ifdef L_ashldi3
DWtype
__ashldi3 (DWtype u, shift_count_type b)
{
  if (b == 0)
800046da:	ca19                	beqz	a2,800046f0 <__ashldi3+0x16>
    return u;

  const DWunion uu = {.ll = u};
  const shift_count_type bm = W_TYPE_SIZE - b;
800046dc:	02000793          	li	a5,32
800046e0:	8f91                	sub	a5,a5,a2
  DWunion w;

  if (bm <= 0)
800046e2:	00f04863          	bgtz	a5,800046f2 <__ashldi3+0x18>
    {
      w.s.low = 0;
      w.s.high = (UWtype) uu.s.low << -bm;
800046e6:	1601                	add	a2,a2,-32
800046e8:	00c515b3          	sll	a1,a0,a2
800046ec:	4701                	li	a4,0

      w.s.low = (UWtype) uu.s.low << b;
      w.s.high = ((UWtype) uu.s.high << b) | carries;
    }

  return w.ll;
800046ee:	853a                	mv	a0,a4
}
800046f0:	8082                	ret
      w.s.low = (UWtype) uu.s.low << b;
800046f2:	00c51733          	sll	a4,a0,a2
      w.s.high = ((UWtype) uu.s.high << b) | carries;
800046f6:	00c595b3          	sll	a1,a1,a2
      const UWtype carries = (UWtype) uu.s.low >> bm;
800046fa:	00f55533          	srl	a0,a0,a5
      w.s.high = ((UWtype) uu.s.high << b) | carries;
800046fe:	8dc9                	or	a1,a1,a0
80004700:	b7fd                	j	800046ee <__ashldi3+0x14>

80004702 <__clzsi2>:
int
__clzSI2 (UWtype x)
{
  Wtype ret;

  count_leading_zeros (ret, x);
80004702:	67c1                	lui	a5,0x10
80004704:	02f57663          	bgeu	a0,a5,80004730 <__clzsi2+0x2e>
80004708:	10053793          	sltiu	a5,a0,256
8000470c:	0017c793          	xor	a5,a5,1
80004710:	078e                	sll	a5,a5,0x3
80004712:	80006737          	lui	a4,0x80006
80004716:	02000693          	li	a3,32
8000471a:	8e9d                	sub	a3,a3,a5
8000471c:	00f55533          	srl	a0,a0,a5
80004720:	cf470793          	add	a5,a4,-780 # 80005cf4 <__clz_tab>
80004724:	97aa                	add	a5,a5,a0
80004726:	0007c503          	lbu	a0,0(a5) # 10000 <_reset_entry-0x7fff0000>

  return ret;
}
8000472a:	40a68533          	sub	a0,a3,a0
8000472e:	8082                	ret
  count_leading_zeros (ret, x);
80004730:	01000737          	lui	a4,0x1000
80004734:	47c1                	li	a5,16
80004736:	fce56ee3          	bltu	a0,a4,80004712 <__clzsi2+0x10>
8000473a:	47e1                	li	a5,24
8000473c:	bfd9                	j	80004712 <__clzsi2+0x10>

8000473e <__errno>:
8000473e:	0001a503          	lw	a0,0(gp) # 800f49e0 <_impure_ptr>
80004742:	8082                	ret

80004744 <__sflush_r>:
80004744:	00c59783          	lh	a5,12(a1)
80004748:	1101                	add	sp,sp,-32
8000474a:	cc22                	sw	s0,24(sp)
8000474c:	c64e                	sw	s3,12(sp)
8000474e:	ce06                	sw	ra,28(sp)
80004750:	ca26                	sw	s1,20(sp)
80004752:	c84a                	sw	s2,16(sp)
80004754:	0087f713          	and	a4,a5,8
80004758:	842e                	mv	s0,a1
8000475a:	89aa                	mv	s3,a0
8000475c:	e361                	bnez	a4,8000481c <__sflush_r+0xd8>
8000475e:	6705                	lui	a4,0x1
80004760:	80070713          	add	a4,a4,-2048 # 800 <_reset_entry-0x7ffff800>
80004764:	41d4                	lw	a3,4(a1)
80004766:	8f5d                	or	a4,a4,a5
80004768:	00e59623          	sh	a4,12(a1)
8000476c:	10d05363          	blez	a3,80004872 <__sflush_r+0x12e>
80004770:	02842803          	lw	a6,40(s0)
80004774:	08080c63          	beqz	a6,8000480c <__sflush_r+0xc8>
80004778:	83b1                	srl	a5,a5,0xc
8000477a:	0009a483          	lw	s1,0(s3)
8000477e:	8b85                	and	a5,a5,1
80004780:	0009a023          	sw	zero,0(s3)
80004784:	4c4c                	lw	a1,28(s0)
80004786:	ebfd                	bnez	a5,8000487c <__sflush_r+0x138>
80004788:	4601                	li	a2,0
8000478a:	4685                	li	a3,1
8000478c:	854e                	mv	a0,s3
8000478e:	9802                	jalr	a6
80004790:	57fd                	li	a5,-1
80004792:	862a                	mv	a2,a0
80004794:	10f50763          	beq	a0,a5,800048a2 <__sflush_r+0x15e>
80004798:	00c41703          	lh	a4,12(s0)
8000479c:	02842803          	lw	a6,40(s0)
800047a0:	4c4c                	lw	a1,28(s0)
800047a2:	8b11                	and	a4,a4,4
800047a4:	c719                	beqz	a4,800047b2 <__sflush_r+0x6e>
800047a6:	4058                	lw	a4,4(s0)
800047a8:	581c                	lw	a5,48(s0)
800047aa:	8e19                	sub	a2,a2,a4
800047ac:	c399                	beqz	a5,800047b2 <__sflush_r+0x6e>
800047ae:	5c5c                	lw	a5,60(s0)
800047b0:	8e1d                	sub	a2,a2,a5
800047b2:	4681                	li	a3,0
800047b4:	854e                	mv	a0,s3
800047b6:	9802                	jalr	a6
800047b8:	57fd                	li	a5,-1
800047ba:	0cf51363          	bne	a0,a5,80004880 <__sflush_r+0x13c>
800047be:	0009a683          	lw	a3,0(s3)
800047c2:	47f5                	li	a5,29
800047c4:	08d7e963          	bltu	a5,a3,80004856 <__sflush_r+0x112>
800047c8:	dfc00737          	lui	a4,0xdfc00
800047cc:	1779                	add	a4,a4,-2 # dfbffffe <_timer_base+0x1fbffefe>
800047ce:	40d75733          	sra	a4,a4,a3
800047d2:	8b05                	and	a4,a4,1
800047d4:	00c41783          	lh	a5,12(s0)
800047d8:	e349                	bnez	a4,8000485a <__sflush_r+0x116>
800047da:	4810                	lw	a2,16(s0)
800047dc:	777d                	lui	a4,0xfffff
800047de:	7ff70713          	add	a4,a4,2047 # fffff7ff <_timer_base+0x3ffff6ff>
800047e2:	8f7d                	and	a4,a4,a5
800047e4:	83b1                	srl	a5,a5,0xc
800047e6:	00e41623          	sh	a4,12(s0)
800047ea:	00042223          	sw	zero,4(s0)
800047ee:	c010                	sw	a2,0(s0)
800047f0:	8b85                	and	a5,a5,1
800047f2:	e7f1                	bnez	a5,800048be <__sflush_r+0x17a>
800047f4:	580c                	lw	a1,48(s0)
800047f6:	0099a023          	sw	s1,0(s3)
800047fa:	c989                	beqz	a1,8000480c <__sflush_r+0xc8>
800047fc:	04040793          	add	a5,s0,64
80004800:	00f58463          	beq	a1,a5,80004808 <__sflush_r+0xc4>
80004804:	854e                	mv	a0,s3
80004806:	2699                	jal	80004b4c <_free_r>
80004808:	02042823          	sw	zero,48(s0)
8000480c:	4501                	li	a0,0
8000480e:	40f2                	lw	ra,28(sp)
80004810:	4462                	lw	s0,24(sp)
80004812:	44d2                	lw	s1,20(sp)
80004814:	4942                	lw	s2,16(sp)
80004816:	49b2                	lw	s3,12(sp)
80004818:	6105                	add	sp,sp,32
8000481a:	8082                	ret
8000481c:	0105a903          	lw	s2,16(a1)
80004820:	fe0906e3          	beqz	s2,8000480c <__sflush_r+0xc8>
80004824:	4184                	lw	s1,0(a1)
80004826:	8b8d                	and	a5,a5,3
80004828:	0125a023          	sw	s2,0(a1)
8000482c:	412484b3          	sub	s1,s1,s2
80004830:	4701                	li	a4,0
80004832:	e391                	bnez	a5,80004836 <__sflush_r+0xf2>
80004834:	49d8                	lw	a4,20(a1)
80004836:	c418                	sw	a4,8(s0)
80004838:	00904663          	bgtz	s1,80004844 <__sflush_r+0x100>
8000483c:	bfc1                	j	8000480c <__sflush_r+0xc8>
8000483e:	992a                	add	s2,s2,a0
80004840:	fc9056e3          	blez	s1,8000480c <__sflush_r+0xc8>
80004844:	505c                	lw	a5,36(s0)
80004846:	4c4c                	lw	a1,28(s0)
80004848:	86a6                	mv	a3,s1
8000484a:	864a                	mv	a2,s2
8000484c:	854e                	mv	a0,s3
8000484e:	9782                	jalr	a5
80004850:	8c89                	sub	s1,s1,a0
80004852:	fea046e3          	bgtz	a0,8000483e <__sflush_r+0xfa>
80004856:	00c41783          	lh	a5,12(s0)
8000485a:	0407e793          	or	a5,a5,64
8000485e:	40f2                	lw	ra,28(sp)
80004860:	00f41623          	sh	a5,12(s0)
80004864:	4462                	lw	s0,24(sp)
80004866:	44d2                	lw	s1,20(sp)
80004868:	4942                	lw	s2,16(sp)
8000486a:	49b2                	lw	s3,12(sp)
8000486c:	557d                	li	a0,-1
8000486e:	6105                	add	sp,sp,32
80004870:	8082                	ret
80004872:	5dd4                	lw	a3,60(a1)
80004874:	eed04ee3          	bgtz	a3,80004770 <__sflush_r+0x2c>
80004878:	4501                	li	a0,0
8000487a:	bf51                	j	8000480e <__sflush_r+0xca>
8000487c:	4830                	lw	a2,80(s0)
8000487e:	b715                	j	800047a2 <__sflush_r+0x5e>
80004880:	00c41783          	lh	a5,12(s0)
80004884:	4814                	lw	a3,16(s0)
80004886:	777d                	lui	a4,0xfffff
80004888:	7ff70713          	add	a4,a4,2047 # fffff7ff <_timer_base+0x3ffff6ff>
8000488c:	8f7d                	and	a4,a4,a5
8000488e:	83b1                	srl	a5,a5,0xc
80004890:	00e41623          	sh	a4,12(s0)
80004894:	00042223          	sw	zero,4(s0)
80004898:	c014                	sw	a3,0(s0)
8000489a:	8b85                	and	a5,a5,1
8000489c:	dfa1                	beqz	a5,800047f4 <__sflush_r+0xb0>
8000489e:	c828                	sw	a0,80(s0)
800048a0:	bf91                	j	800047f4 <__sflush_r+0xb0>
800048a2:	0009a783          	lw	a5,0(s3)
800048a6:	ee0789e3          	beqz	a5,80004798 <__sflush_r+0x54>
800048aa:	4775                	li	a4,29
800048ac:	00e78563          	beq	a5,a4,800048b6 <__sflush_r+0x172>
800048b0:	4759                	li	a4,22
800048b2:	fae792e3          	bne	a5,a4,80004856 <__sflush_r+0x112>
800048b6:	0099a023          	sw	s1,0(s3)
800048ba:	4501                	li	a0,0
800048bc:	bf89                	j	8000480e <__sflush_r+0xca>
800048be:	fa9d                	bnez	a3,800047f4 <__sflush_r+0xb0>
800048c0:	c828                	sw	a0,80(s0)
800048c2:	bf0d                	j	800047f4 <__sflush_r+0xb0>

800048c4 <_fflush_r>:
800048c4:	1101                	add	sp,sp,-32
800048c6:	cc22                	sw	s0,24(sp)
800048c8:	ce06                	sw	ra,28(sp)
800048ca:	842a                	mv	s0,a0
800048cc:	c119                	beqz	a0,800048d2 <_fflush_r+0xe>
800048ce:	5d1c                	lw	a5,56(a0)
800048d0:	cb89                	beqz	a5,800048e2 <_fflush_r+0x1e>
800048d2:	00c59783          	lh	a5,12(a1)
800048d6:	ef81                	bnez	a5,800048ee <_fflush_r+0x2a>
800048d8:	40f2                	lw	ra,28(sp)
800048da:	4462                	lw	s0,24(sp)
800048dc:	4501                	li	a0,0
800048de:	6105                	add	sp,sp,32
800048e0:	8082                	ret
800048e2:	c62e                	sw	a1,12(sp)
800048e4:	2a89                	jal	80004a36 <__sinit>
800048e6:	45b2                	lw	a1,12(sp)
800048e8:	00c59783          	lh	a5,12(a1)
800048ec:	d7f5                	beqz	a5,800048d8 <_fflush_r+0x14>
800048ee:	8522                	mv	a0,s0
800048f0:	4462                	lw	s0,24(sp)
800048f2:	40f2                	lw	ra,28(sp)
800048f4:	6105                	add	sp,sp,32
800048f6:	b5b9                	j	80004744 <__sflush_r>

800048f8 <_cleanup_r>:
800048f8:	800065b7          	lui	a1,0x80006
800048fc:	90258593          	add	a1,a1,-1790 # 80005902 <_fclose_r>
80004900:	a9a5                	j	80004d78 <_fwalk_reent>

80004902 <__sinit.part.0>:
80004902:	1101                	add	sp,sp,-32
80004904:	800057b7          	lui	a5,0x80005
80004908:	ce06                	sw	ra,28(sp)
8000490a:	cc22                	sw	s0,24(sp)
8000490c:	ca26                	sw	s1,20(sp)
8000490e:	c84a                	sw	s2,16(sp)
80004910:	c64e                	sw	s3,12(sp)
80004912:	c452                	sw	s4,8(sp)
80004914:	c256                	sw	s5,4(sp)
80004916:	c05a                	sw	s6,0(sp)
80004918:	4140                	lw	s0,4(a0)
8000491a:	8f878793          	add	a5,a5,-1800 # 800048f8 <_cleanup_r>
8000491e:	dd5c                	sw	a5,60(a0)
80004920:	2ec50713          	add	a4,a0,748 # 7f8002ec <_reset_entry-0x7ffd14>
80004924:	478d                	li	a5,3
80004926:	2ee52423          	sw	a4,744(a0)
8000492a:	2ef52223          	sw	a5,740(a0)
8000492e:	2e052023          	sw	zero,736(a0)
80004932:	4791                	li	a5,4
80004934:	892a                	mv	s2,a0
80004936:	c45c                	sw	a5,12(s0)
80004938:	4621                	li	a2,8
8000493a:	4581                	li	a1,0
8000493c:	00042023          	sw	zero,0(s0)
80004940:	00042223          	sw	zero,4(s0)
80004944:	00042423          	sw	zero,8(s0)
80004948:	06042223          	sw	zero,100(s0)
8000494c:	00042823          	sw	zero,16(s0)
80004950:	00042a23          	sw	zero,20(s0)
80004954:	00042c23          	sw	zero,24(s0)
80004958:	05c40513          	add	a0,s0,92
8000495c:	35d000ef          	jal	800054b8 <memset>
80004960:	80005b37          	lui	s6,0x80005
80004964:	00892483          	lw	s1,8(s2) # 400008 <_reset_entry-0x7fbffff8>
80004968:	80005ab7          	lui	s5,0x80005
8000496c:	80005a37          	lui	s4,0x80005
80004970:	800059b7          	lui	s3,0x80005
80004974:	5f2b0b13          	add	s6,s6,1522 # 800055f2 <__sread>
80004978:	628a8a93          	add	s5,s5,1576 # 80005628 <__swrite>
8000497c:	678a0a13          	add	s4,s4,1656 # 80005678 <__sseek>
80004980:	6c098993          	add	s3,s3,1728 # 800056c0 <__sclose>
80004984:	67c1                	lui	a5,0x10
80004986:	03642023          	sw	s6,32(s0)
8000498a:	03542223          	sw	s5,36(s0)
8000498e:	03442423          	sw	s4,40(s0)
80004992:	03342623          	sw	s3,44(s0)
80004996:	cc40                	sw	s0,28(s0)
80004998:	07a5                	add	a5,a5,9 # 10009 <_reset_entry-0x7ffefff7>
8000499a:	c4dc                	sw	a5,12(s1)
8000499c:	4621                	li	a2,8
8000499e:	4581                	li	a1,0
800049a0:	0004a023          	sw	zero,0(s1) # 400000 <_reset_entry-0x7fc00000>
800049a4:	0004a223          	sw	zero,4(s1)
800049a8:	0004a423          	sw	zero,8(s1)
800049ac:	0604a223          	sw	zero,100(s1)
800049b0:	0004a823          	sw	zero,16(s1)
800049b4:	0004aa23          	sw	zero,20(s1)
800049b8:	0004ac23          	sw	zero,24(s1)
800049bc:	05c48513          	add	a0,s1,92
800049c0:	2f9000ef          	jal	800054b8 <memset>
800049c4:	00c92403          	lw	s0,12(s2)
800049c8:	000207b7          	lui	a5,0x20
800049cc:	0364a023          	sw	s6,32(s1)
800049d0:	0354a223          	sw	s5,36(s1)
800049d4:	0344a423          	sw	s4,40(s1)
800049d8:	0334a623          	sw	s3,44(s1)
800049dc:	ccc4                	sw	s1,28(s1)
800049de:	07c9                	add	a5,a5,18 # 20012 <_reset_entry-0x7ffdffee>
800049e0:	c45c                	sw	a5,12(s0)
800049e2:	00042023          	sw	zero,0(s0)
800049e6:	00042223          	sw	zero,4(s0)
800049ea:	00042423          	sw	zero,8(s0)
800049ee:	06042223          	sw	zero,100(s0)
800049f2:	00042823          	sw	zero,16(s0)
800049f6:	00042a23          	sw	zero,20(s0)
800049fa:	00042c23          	sw	zero,24(s0)
800049fe:	05c40513          	add	a0,s0,92
80004a02:	4621                	li	a2,8
80004a04:	4581                	li	a1,0
80004a06:	2b3000ef          	jal	800054b8 <memset>
80004a0a:	40f2                	lw	ra,28(sp)
80004a0c:	03642023          	sw	s6,32(s0)
80004a10:	03542223          	sw	s5,36(s0)
80004a14:	03442423          	sw	s4,40(s0)
80004a18:	03342623          	sw	s3,44(s0)
80004a1c:	cc40                	sw	s0,28(s0)
80004a1e:	4462                	lw	s0,24(sp)
80004a20:	4785                	li	a5,1
80004a22:	02f92c23          	sw	a5,56(s2)
80004a26:	44d2                	lw	s1,20(sp)
80004a28:	4942                	lw	s2,16(sp)
80004a2a:	49b2                	lw	s3,12(sp)
80004a2c:	4a22                	lw	s4,8(sp)
80004a2e:	4a92                	lw	s5,4(sp)
80004a30:	4b02                	lw	s6,0(sp)
80004a32:	6105                	add	sp,sp,32
80004a34:	8082                	ret

80004a36 <__sinit>:
80004a36:	5d1c                	lw	a5,56(a0)
80004a38:	c391                	beqz	a5,80004a3c <__sinit+0x6>
80004a3a:	8082                	ret
80004a3c:	b5d9                	j	80004902 <__sinit.part.0>

80004a3e <__sfp_lock_acquire>:
80004a3e:	8082                	ret

80004a40 <__sfp_lock_release>:
80004a40:	8082                	ret

80004a42 <fputc>:
80004a42:	1101                	add	sp,sp,-32
80004a44:	ca26                	sw	s1,20(sp)
80004a46:	0001a483          	lw	s1,0(gp) # 800f49e0 <_impure_ptr>
80004a4a:	cc22                	sw	s0,24(sp)
80004a4c:	ce06                	sw	ra,28(sp)
80004a4e:	842a                	mv	s0,a0
80004a50:	862e                	mv	a2,a1
80004a52:	c099                	beqz	s1,80004a58 <fputc+0x16>
80004a54:	5c9c                	lw	a5,56(s1)
80004a56:	cb89                	beqz	a5,80004a68 <fputc+0x26>
80004a58:	85a2                	mv	a1,s0
80004a5a:	4462                	lw	s0,24(sp)
80004a5c:	40f2                	lw	ra,28(sp)
80004a5e:	8526                	mv	a0,s1
80004a60:	44d2                	lw	s1,20(sp)
80004a62:	6105                	add	sp,sp,32
80004a64:	3010006f          	j	80005564 <_putc_r>
80004a68:	8526                	mv	a0,s1
80004a6a:	c62e                	sw	a1,12(sp)
80004a6c:	37e9                	jal	80004a36 <__sinit>
80004a6e:	85a2                	mv	a1,s0
80004a70:	4462                	lw	s0,24(sp)
80004a72:	4632                	lw	a2,12(sp)
80004a74:	40f2                	lw	ra,28(sp)
80004a76:	8526                	mv	a0,s1
80004a78:	44d2                	lw	s1,20(sp)
80004a7a:	6105                	add	sp,sp,32
80004a7c:	2e90006f          	j	80005564 <_putc_r>

80004a80 <_malloc_trim_r>:
80004a80:	1101                	add	sp,sp,-32
80004a82:	c64e                	sw	s3,12(sp)
80004a84:	800f49b7          	lui	s3,0x800f4
80004a88:	cc22                	sw	s0,24(sp)
80004a8a:	ca26                	sw	s1,20(sp)
80004a8c:	c84a                	sw	s2,16(sp)
80004a8e:	c452                	sw	s4,8(sp)
80004a90:	ce06                	sw	ra,28(sp)
80004a92:	8a2e                	mv	s4,a1
80004a94:	892a                	mv	s2,a0
80004a96:	5d898993          	add	s3,s3,1496 # 800f45d8 <__malloc_av_>
80004a9a:	2c7000ef          	jal	80005560 <__malloc_lock>
80004a9e:	0089a703          	lw	a4,8(s3)
80004aa2:	6785                	lui	a5,0x1
80004aa4:	fef78413          	add	s0,a5,-17 # fef <_reset_entry-0x7ffff011>
80004aa8:	4344                	lw	s1,4(a4)
80004aaa:	98f1                	and	s1,s1,-4
80004aac:	9426                	add	s0,s0,s1
80004aae:	41440433          	sub	s0,s0,s4
80004ab2:	8031                	srl	s0,s0,0xc
80004ab4:	147d                	add	s0,s0,-1
80004ab6:	0432                	sll	s0,s0,0xc
80004ab8:	00f44b63          	blt	s0,a5,80004ace <_malloc_trim_r+0x4e>
80004abc:	4581                	li	a1,0
80004abe:	854a                	mv	a0,s2
80004ac0:	2fd000ef          	jal	800055bc <_sbrk_r>
80004ac4:	0089a783          	lw	a5,8(s3)
80004ac8:	97a6                	add	a5,a5,s1
80004aca:	00f50e63          	beq	a0,a5,80004ae6 <_malloc_trim_r+0x66>
80004ace:	854a                	mv	a0,s2
80004ad0:	293000ef          	jal	80005562 <__malloc_unlock>
80004ad4:	40f2                	lw	ra,28(sp)
80004ad6:	4462                	lw	s0,24(sp)
80004ad8:	44d2                	lw	s1,20(sp)
80004ada:	4942                	lw	s2,16(sp)
80004adc:	49b2                	lw	s3,12(sp)
80004ade:	4a22                	lw	s4,8(sp)
80004ae0:	4501                	li	a0,0
80004ae2:	6105                	add	sp,sp,32
80004ae4:	8082                	ret
80004ae6:	408005b3          	neg	a1,s0
80004aea:	854a                	mv	a0,s2
80004aec:	2d1000ef          	jal	800055bc <_sbrk_r>
80004af0:	57fd                	li	a5,-1
80004af2:	02f50963          	beq	a0,a5,80004b24 <_malloc_trim_r+0xa4>
80004af6:	00c18793          	add	a5,gp,12 # 800f49ec <__malloc_current_mallinfo>
80004afa:	4398                	lw	a4,0(a5)
80004afc:	0089a683          	lw	a3,8(s3)
80004b00:	8c81                	sub	s1,s1,s0
80004b02:	0014e493          	or	s1,s1,1
80004b06:	8f01                	sub	a4,a4,s0
80004b08:	854a                	mv	a0,s2
80004b0a:	c2c4                	sw	s1,4(a3)
80004b0c:	c398                	sw	a4,0(a5)
80004b0e:	255000ef          	jal	80005562 <__malloc_unlock>
80004b12:	40f2                	lw	ra,28(sp)
80004b14:	4462                	lw	s0,24(sp)
80004b16:	44d2                	lw	s1,20(sp)
80004b18:	4942                	lw	s2,16(sp)
80004b1a:	49b2                	lw	s3,12(sp)
80004b1c:	4a22                	lw	s4,8(sp)
80004b1e:	4505                	li	a0,1
80004b20:	6105                	add	sp,sp,32
80004b22:	8082                	ret
80004b24:	4581                	li	a1,0
80004b26:	854a                	mv	a0,s2
80004b28:	295000ef          	jal	800055bc <_sbrk_r>
80004b2c:	0089a703          	lw	a4,8(s3)
80004b30:	46bd                	li	a3,15
80004b32:	40e507b3          	sub	a5,a0,a4
80004b36:	f8f6dce3          	bge	a3,a5,80004ace <_malloc_trim_r+0x4e>
80004b3a:	0041a683          	lw	a3,4(gp) # 800f49e4 <__malloc_sbrk_base>
80004b3e:	0017e793          	or	a5,a5,1
80004b42:	c35c                	sw	a5,4(a4)
80004b44:	8d15                	sub	a0,a0,a3
80004b46:	00a1a623          	sw	a0,12(gp) # 800f49ec <__malloc_current_mallinfo>
80004b4a:	b751                	j	80004ace <_malloc_trim_r+0x4e>

80004b4c <_free_r>:
80004b4c:	10058e63          	beqz	a1,80004c68 <_free_r+0x11c>
80004b50:	1141                	add	sp,sp,-16
80004b52:	c422                	sw	s0,8(sp)
80004b54:	c226                	sw	s1,4(sp)
80004b56:	842e                	mv	s0,a1
80004b58:	84aa                	mv	s1,a0
80004b5a:	c606                	sw	ra,12(sp)
80004b5c:	205000ef          	jal	80005560 <__malloc_lock>
80004b60:	ffc42503          	lw	a0,-4(s0)
80004b64:	ff840713          	add	a4,s0,-8
80004b68:	800f45b7          	lui	a1,0x800f4
80004b6c:	ffe57793          	and	a5,a0,-2
80004b70:	00f70633          	add	a2,a4,a5
80004b74:	5d858593          	add	a1,a1,1496 # 800f45d8 <__malloc_av_>
80004b78:	4254                	lw	a3,4(a2)
80004b7a:	0085a803          	lw	a6,8(a1)
80004b7e:	9af1                	and	a3,a3,-4
80004b80:	12c80763          	beq	a6,a2,80004cae <_free_r+0x162>
80004b84:	c254                	sw	a3,4(a2)
80004b86:	8905                	and	a0,a0,1
80004b88:	00d60833          	add	a6,a2,a3
80004b8c:	ed25                	bnez	a0,80004c04 <_free_r+0xb8>
80004b8e:	ff842303          	lw	t1,-8(s0)
80004b92:	00482803          	lw	a6,4(a6)
80004b96:	800f4537          	lui	a0,0x800f4
80004b9a:	40670733          	sub	a4,a4,t1
80004b9e:	00872883          	lw	a7,8(a4)
80004ba2:	5e050513          	add	a0,a0,1504 # 800f45e0 <__malloc_av_+0x8>
80004ba6:	979a                	add	a5,a5,t1
80004ba8:	00187813          	and	a6,a6,1
80004bac:	0ea88463          	beq	a7,a0,80004c94 <_free_r+0x148>
80004bb0:	00c72303          	lw	t1,12(a4)
80004bb4:	0068a623          	sw	t1,12(a7)
80004bb8:	01132423          	sw	a7,8(t1)
80004bbc:	12080163          	beqz	a6,80004cde <_free_r+0x192>
80004bc0:	0017e693          	or	a3,a5,1
80004bc4:	c354                	sw	a3,4(a4)
80004bc6:	c21c                	sw	a5,0(a2)
80004bc8:	1ff00693          	li	a3,511
80004bcc:	04f6e963          	bltu	a3,a5,80004c1e <_free_r+0xd2>
80004bd0:	ff87f693          	and	a3,a5,-8
80004bd4:	06a1                	add	a3,a3,8
80004bd6:	41c8                	lw	a0,4(a1)
80004bd8:	96ae                	add	a3,a3,a1
80004bda:	4290                	lw	a2,0(a3)
80004bdc:	0057d813          	srl	a6,a5,0x5
80004be0:	4785                	li	a5,1
80004be2:	010797b3          	sll	a5,a5,a6
80004be6:	8fc9                	or	a5,a5,a0
80004be8:	ff868513          	add	a0,a3,-8
80004bec:	c748                	sw	a0,12(a4)
80004bee:	c710                	sw	a2,8(a4)
80004bf0:	c1dc                	sw	a5,4(a1)
80004bf2:	c298                	sw	a4,0(a3)
80004bf4:	c658                	sw	a4,12(a2)
80004bf6:	4422                	lw	s0,8(sp)
80004bf8:	40b2                	lw	ra,12(sp)
80004bfa:	8526                	mv	a0,s1
80004bfc:	4492                	lw	s1,4(sp)
80004bfe:	0141                	add	sp,sp,16
80004c00:	1630006f          	j	80005562 <__malloc_unlock>
80004c04:	00482503          	lw	a0,4(a6)
80004c08:	8905                	and	a0,a0,1
80004c0a:	c125                	beqz	a0,80004c6a <_free_r+0x11e>
80004c0c:	0017e693          	or	a3,a5,1
80004c10:	fed42e23          	sw	a3,-4(s0)
80004c14:	c21c                	sw	a5,0(a2)
80004c16:	1ff00693          	li	a3,511
80004c1a:	faf6fbe3          	bgeu	a3,a5,80004bd0 <_free_r+0x84>
80004c1e:	0097d693          	srl	a3,a5,0x9
80004c22:	4611                	li	a2,4
80004c24:	0ad66f63          	bltu	a2,a3,80004ce2 <_free_r+0x196>
80004c28:	0067d693          	srl	a3,a5,0x6
80004c2c:	03968513          	add	a0,a3,57
80004c30:	03868613          	add	a2,a3,56
80004c34:	050e                	sll	a0,a0,0x3
80004c36:	952e                	add	a0,a0,a1
80004c38:	4114                	lw	a3,0(a0)
80004c3a:	1561                	add	a0,a0,-8
80004c3c:	00d51663          	bne	a0,a3,80004c48 <_free_r+0xfc>
80004c40:	a0c5                	j	80004d20 <_free_r+0x1d4>
80004c42:	4694                	lw	a3,8(a3)
80004c44:	00d50663          	beq	a0,a3,80004c50 <_free_r+0x104>
80004c48:	42d0                	lw	a2,4(a3)
80004c4a:	9a71                	and	a2,a2,-4
80004c4c:	fec7ebe3          	bltu	a5,a2,80004c42 <_free_r+0xf6>
80004c50:	46c8                	lw	a0,12(a3)
80004c52:	c748                	sw	a0,12(a4)
80004c54:	c714                	sw	a3,8(a4)
80004c56:	4422                	lw	s0,8(sp)
80004c58:	c518                	sw	a4,8(a0)
80004c5a:	40b2                	lw	ra,12(sp)
80004c5c:	8526                	mv	a0,s1
80004c5e:	4492                	lw	s1,4(sp)
80004c60:	c6d8                	sw	a4,12(a3)
80004c62:	0141                	add	sp,sp,16
80004c64:	0ff0006f          	j	80005562 <__malloc_unlock>
80004c68:	8082                	ret
80004c6a:	800f4537          	lui	a0,0x800f4
80004c6e:	97b6                	add	a5,a5,a3
80004c70:	5e050513          	add	a0,a0,1504 # 800f45e0 <__malloc_av_+0x8>
80004c74:	4614                	lw	a3,8(a2)
80004c76:	08a68b63          	beq	a3,a0,80004d0c <_free_r+0x1c0>
80004c7a:	00c62803          	lw	a6,12(a2)
80004c7e:	0017e513          	or	a0,a5,1
80004c82:	00f70633          	add	a2,a4,a5
80004c86:	0106a623          	sw	a6,12(a3)
80004c8a:	00d82423          	sw	a3,8(a6)
80004c8e:	c348                	sw	a0,4(a4)
80004c90:	c21c                	sw	a5,0(a2)
80004c92:	bf1d                	j	80004bc8 <_free_r+0x7c>
80004c94:	0c081d63          	bnez	a6,80004d6e <_free_r+0x222>
80004c98:	460c                	lw	a1,8(a2)
80004c9a:	4650                	lw	a2,12(a2)
80004c9c:	96be                	add	a3,a3,a5
80004c9e:	0016e793          	or	a5,a3,1
80004ca2:	c5d0                	sw	a2,12(a1)
80004ca4:	c60c                	sw	a1,8(a2)
80004ca6:	c35c                	sw	a5,4(a4)
80004ca8:	9736                	add	a4,a4,a3
80004caa:	c314                	sw	a3,0(a4)
80004cac:	b7a9                	j	80004bf6 <_free_r+0xaa>
80004cae:	8905                	and	a0,a0,1
80004cb0:	96be                	add	a3,a3,a5
80004cb2:	e909                	bnez	a0,80004cc4 <_free_r+0x178>
80004cb4:	ff842503          	lw	a0,-8(s0)
80004cb8:	8f09                	sub	a4,a4,a0
80004cba:	475c                	lw	a5,12(a4)
80004cbc:	4710                	lw	a2,8(a4)
80004cbe:	96aa                	add	a3,a3,a0
80004cc0:	c65c                	sw	a5,12(a2)
80004cc2:	c790                	sw	a2,8(a5)
80004cc4:	0016e613          	or	a2,a3,1
80004cc8:	0081a783          	lw	a5,8(gp) # 800f49e8 <__malloc_trim_threshold>
80004ccc:	c350                	sw	a2,4(a4)
80004cce:	c598                	sw	a4,8(a1)
80004cd0:	f2f6e3e3          	bltu	a3,a5,80004bf6 <_free_r+0xaa>
80004cd4:	0401a583          	lw	a1,64(gp) # 800f4a20 <__malloc_top_pad>
80004cd8:	8526                	mv	a0,s1
80004cda:	335d                	jal	80004a80 <_malloc_trim_r>
80004cdc:	bf29                	j	80004bf6 <_free_r+0xaa>
80004cde:	97b6                	add	a5,a5,a3
80004ce0:	bf51                	j	80004c74 <_free_r+0x128>
80004ce2:	4651                	li	a2,20
80004ce4:	00d67e63          	bgeu	a2,a3,80004d00 <_free_r+0x1b4>
80004ce8:	05400613          	li	a2,84
80004cec:	04d66463          	bltu	a2,a3,80004d34 <_free_r+0x1e8>
80004cf0:	00c7d693          	srl	a3,a5,0xc
80004cf4:	06f68513          	add	a0,a3,111
80004cf8:	06e68613          	add	a2,a3,110
80004cfc:	050e                	sll	a0,a0,0x3
80004cfe:	bf25                	j	80004c36 <_free_r+0xea>
80004d00:	05c68513          	add	a0,a3,92
80004d04:	05b68613          	add	a2,a3,91
80004d08:	050e                	sll	a0,a0,0x3
80004d0a:	b735                	j	80004c36 <_free_r+0xea>
80004d0c:	c9d8                	sw	a4,20(a1)
80004d0e:	c998                	sw	a4,16(a1)
80004d10:	0017e693          	or	a3,a5,1
80004d14:	c748                	sw	a0,12(a4)
80004d16:	c708                	sw	a0,8(a4)
80004d18:	c354                	sw	a3,4(a4)
80004d1a:	973e                	add	a4,a4,a5
80004d1c:	c31c                	sw	a5,0(a4)
80004d1e:	bde1                	j	80004bf6 <_free_r+0xaa>
80004d20:	0045a803          	lw	a6,4(a1)
80004d24:	8609                	sra	a2,a2,0x2
80004d26:	4785                	li	a5,1
80004d28:	00c797b3          	sll	a5,a5,a2
80004d2c:	0107e7b3          	or	a5,a5,a6
80004d30:	c1dc                	sw	a5,4(a1)
80004d32:	b705                	j	80004c52 <_free_r+0x106>
80004d34:	15400613          	li	a2,340
80004d38:	00d66a63          	bltu	a2,a3,80004d4c <_free_r+0x200>
80004d3c:	00f7d693          	srl	a3,a5,0xf
80004d40:	07868513          	add	a0,a3,120
80004d44:	07768613          	add	a2,a3,119
80004d48:	050e                	sll	a0,a0,0x3
80004d4a:	b5f5                	j	80004c36 <_free_r+0xea>
80004d4c:	55400613          	li	a2,1364
80004d50:	00d66a63          	bltu	a2,a3,80004d64 <_free_r+0x218>
80004d54:	0127d693          	srl	a3,a5,0x12
80004d58:	07d68513          	add	a0,a3,125
80004d5c:	07c68613          	add	a2,a3,124
80004d60:	050e                	sll	a0,a0,0x3
80004d62:	bdd1                	j	80004c36 <_free_r+0xea>
80004d64:	3f800513          	li	a0,1016
80004d68:	07e00613          	li	a2,126
80004d6c:	b5e9                	j	80004c36 <_free_r+0xea>
80004d6e:	0017e693          	or	a3,a5,1
80004d72:	c354                	sw	a3,4(a4)
80004d74:	c21c                	sw	a5,0(a2)
80004d76:	b541                	j	80004bf6 <_free_r+0xaa>

80004d78 <_fwalk_reent>:
80004d78:	7179                	add	sp,sp,-48
80004d7a:	d04a                	sw	s2,32(sp)
80004d7c:	ce4e                	sw	s3,28(sp)
80004d7e:	cc52                	sw	s4,24(sp)
80004d80:	ca56                	sw	s5,20(sp)
80004d82:	c85a                	sw	s6,16(sp)
80004d84:	c65e                	sw	s7,12(sp)
80004d86:	d606                	sw	ra,44(sp)
80004d88:	d422                	sw	s0,40(sp)
80004d8a:	d226                	sw	s1,36(sp)
80004d8c:	8aaa                	mv	s5,a0
80004d8e:	8bae                	mv	s7,a1
80004d90:	2e050b13          	add	s6,a0,736
80004d94:	4a01                	li	s4,0
80004d96:	4985                	li	s3,1
80004d98:	597d                	li	s2,-1
80004d9a:	004b2483          	lw	s1,4(s6)
80004d9e:	008b2403          	lw	s0,8(s6)
80004da2:	14fd                	add	s1,s1,-1
80004da4:	0204c463          	bltz	s1,80004dcc <_fwalk_reent+0x54>
80004da8:	00c45783          	lhu	a5,12(s0)
80004dac:	14fd                	add	s1,s1,-1
80004dae:	00f9fb63          	bgeu	s3,a5,80004dc4 <_fwalk_reent+0x4c>
80004db2:	00e41783          	lh	a5,14(s0)
80004db6:	85a2                	mv	a1,s0
80004db8:	8556                	mv	a0,s5
80004dba:	01278563          	beq	a5,s2,80004dc4 <_fwalk_reent+0x4c>
80004dbe:	9b82                	jalr	s7
80004dc0:	00aa6a33          	or	s4,s4,a0
80004dc4:	06840413          	add	s0,s0,104
80004dc8:	ff2490e3          	bne	s1,s2,80004da8 <_fwalk_reent+0x30>
80004dcc:	000b2b03          	lw	s6,0(s6)
80004dd0:	fc0b15e3          	bnez	s6,80004d9a <_fwalk_reent+0x22>
80004dd4:	50b2                	lw	ra,44(sp)
80004dd6:	5422                	lw	s0,40(sp)
80004dd8:	5492                	lw	s1,36(sp)
80004dda:	5902                	lw	s2,32(sp)
80004ddc:	49f2                	lw	s3,28(sp)
80004dde:	4ad2                	lw	s5,20(sp)
80004de0:	4b42                	lw	s6,16(sp)
80004de2:	4bb2                	lw	s7,12(sp)
80004de4:	8552                	mv	a0,s4
80004de6:	4a62                	lw	s4,24(sp)
80004de8:	6145                	add	sp,sp,48
80004dea:	8082                	ret

80004dec <_malloc_r>:
80004dec:	7179                	add	sp,sp,-48
80004dee:	ce4e                	sw	s3,28(sp)
80004df0:	d606                	sw	ra,44(sp)
80004df2:	d422                	sw	s0,40(sp)
80004df4:	d226                	sw	s1,36(sp)
80004df6:	d04a                	sw	s2,32(sp)
80004df8:	cc52                	sw	s4,24(sp)
80004dfa:	ca56                	sw	s5,20(sp)
80004dfc:	c85a                	sw	s6,16(sp)
80004dfe:	c65e                	sw	s7,12(sp)
80004e00:	c462                	sw	s8,8(sp)
80004e02:	c266                	sw	s9,4(sp)
80004e04:	00b58793          	add	a5,a1,11
80004e08:	4759                	li	a4,22
80004e0a:	89aa                	mv	s3,a0
80004e0c:	04f76f63          	bltu	a4,a5,80004e6a <_malloc_r+0x7e>
80004e10:	47c1                	li	a5,16
80004e12:	18b7e063          	bltu	a5,a1,80004f92 <_malloc_r+0x1a6>
80004e16:	27a9                	jal	80005560 <__malloc_lock>
80004e18:	44c1                	li	s1,16
80004e1a:	47e1                	li	a5,24
80004e1c:	4589                	li	a1,2
80004e1e:	800f4937          	lui	s2,0x800f4
80004e22:	5d890913          	add	s2,s2,1496 # 800f45d8 <__malloc_av_>
80004e26:	97ca                	add	a5,a5,s2
80004e28:	43c0                	lw	s0,4(a5)
80004e2a:	ff878713          	add	a4,a5,-8
80004e2e:	22e40b63          	beq	s0,a4,80005064 <_malloc_r+0x278>
80004e32:	405c                	lw	a5,4(s0)
80004e34:	4454                	lw	a3,12(s0)
80004e36:	4410                	lw	a2,8(s0)
80004e38:	9bf1                	and	a5,a5,-4
80004e3a:	97a2                	add	a5,a5,s0
80004e3c:	43d8                	lw	a4,4(a5)
80004e3e:	c654                	sw	a3,12(a2)
80004e40:	c690                	sw	a2,8(a3)
80004e42:	00176713          	or	a4,a4,1
80004e46:	854e                	mv	a0,s3
80004e48:	c3d8                	sw	a4,4(a5)
80004e4a:	2f21                	jal	80005562 <__malloc_unlock>
80004e4c:	00840513          	add	a0,s0,8
80004e50:	50b2                	lw	ra,44(sp)
80004e52:	5422                	lw	s0,40(sp)
80004e54:	5492                	lw	s1,36(sp)
80004e56:	5902                	lw	s2,32(sp)
80004e58:	49f2                	lw	s3,28(sp)
80004e5a:	4a62                	lw	s4,24(sp)
80004e5c:	4ad2                	lw	s5,20(sp)
80004e5e:	4b42                	lw	s6,16(sp)
80004e60:	4bb2                	lw	s7,12(sp)
80004e62:	4c22                	lw	s8,8(sp)
80004e64:	4c92                	lw	s9,4(sp)
80004e66:	6145                	add	sp,sp,48
80004e68:	8082                	ret
80004e6a:	ff87f493          	and	s1,a5,-8
80004e6e:	1207c263          	bltz	a5,80004f92 <_malloc_r+0x1a6>
80004e72:	12b4e063          	bltu	s1,a1,80004f92 <_malloc_r+0x1a6>
80004e76:	25ed                	jal	80005560 <__malloc_lock>
80004e78:	1f700793          	li	a5,503
80004e7c:	2a97f363          	bgeu	a5,s1,80005122 <_malloc_r+0x336>
80004e80:	0094d793          	srl	a5,s1,0x9
80004e84:	10078c63          	beqz	a5,80004f9c <_malloc_r+0x1b0>
80004e88:	4711                	li	a4,4
80004e8a:	22f76263          	bltu	a4,a5,800050ae <_malloc_r+0x2c2>
80004e8e:	0064d793          	srl	a5,s1,0x6
80004e92:	03978593          	add	a1,a5,57
80004e96:	03878513          	add	a0,a5,56
80004e9a:	00359693          	sll	a3,a1,0x3
80004e9e:	800f4937          	lui	s2,0x800f4
80004ea2:	5d890913          	add	s2,s2,1496 # 800f45d8 <__malloc_av_>
80004ea6:	96ca                	add	a3,a3,s2
80004ea8:	42c0                	lw	s0,4(a3)
80004eaa:	16e1                	add	a3,a3,-8
80004eac:	02868063          	beq	a3,s0,80004ecc <_malloc_r+0xe0>
80004eb0:	463d                	li	a2,15
80004eb2:	a031                	j	80004ebe <_malloc_r+0xd2>
80004eb4:	1a075563          	bgez	a4,8000505e <_malloc_r+0x272>
80004eb8:	4440                	lw	s0,12(s0)
80004eba:	00868963          	beq	a3,s0,80004ecc <_malloc_r+0xe0>
80004ebe:	405c                	lw	a5,4(s0)
80004ec0:	9bf1                	and	a5,a5,-4
80004ec2:	40978733          	sub	a4,a5,s1
80004ec6:	fee657e3          	bge	a2,a4,80004eb4 <_malloc_r+0xc8>
80004eca:	85aa                	mv	a1,a0
80004ecc:	01092403          	lw	s0,16(s2)
80004ed0:	800f4837          	lui	a6,0x800f4
80004ed4:	5e080813          	add	a6,a6,1504 # 800f45e0 <__malloc_av_+0x8>
80004ed8:	17040263          	beq	s0,a6,8000503c <_malloc_r+0x250>
80004edc:	405c                	lw	a5,4(s0)
80004ede:	46bd                	li	a3,15
80004ee0:	9bf1                	and	a5,a5,-4
80004ee2:	40978733          	sub	a4,a5,s1
80004ee6:	24e6c363          	blt	a3,a4,8000512c <_malloc_r+0x340>
80004eea:	01092a23          	sw	a6,20(s2)
80004eee:	01092823          	sw	a6,16(s2)
80004ef2:	20075e63          	bgez	a4,8000510e <_malloc_r+0x322>
80004ef6:	1ff00713          	li	a4,511
80004efa:	00492503          	lw	a0,4(s2)
80004efe:	16f76863          	bltu	a4,a5,8000506e <_malloc_r+0x282>
80004f02:	ff87f713          	and	a4,a5,-8
80004f06:	0721                	add	a4,a4,8
80004f08:	974a                	add	a4,a4,s2
80004f0a:	4314                	lw	a3,0(a4)
80004f0c:	0057d613          	srl	a2,a5,0x5
80004f10:	4785                	li	a5,1
80004f12:	00c797b3          	sll	a5,a5,a2
80004f16:	8d5d                	or	a0,a0,a5
80004f18:	ff870793          	add	a5,a4,-8
80004f1c:	c45c                	sw	a5,12(s0)
80004f1e:	c414                	sw	a3,8(s0)
80004f20:	00a92223          	sw	a0,4(s2)
80004f24:	c300                	sw	s0,0(a4)
80004f26:	c6c0                	sw	s0,12(a3)
80004f28:	4025d793          	sra	a5,a1,0x2
80004f2c:	4605                	li	a2,1
80004f2e:	00f61633          	sll	a2,a2,a5
80004f32:	06c56c63          	bltu	a0,a2,80004faa <_malloc_r+0x1be>
80004f36:	00a677b3          	and	a5,a2,a0
80004f3a:	ef81                	bnez	a5,80004f52 <_malloc_r+0x166>
80004f3c:	0606                	sll	a2,a2,0x1
80004f3e:	99f1                	and	a1,a1,-4
80004f40:	00a677b3          	and	a5,a2,a0
80004f44:	0591                	add	a1,a1,4
80004f46:	e791                	bnez	a5,80004f52 <_malloc_r+0x166>
80004f48:	0606                	sll	a2,a2,0x1
80004f4a:	00a677b3          	and	a5,a2,a0
80004f4e:	0591                	add	a1,a1,4
80004f50:	dfe5                	beqz	a5,80004f48 <_malloc_r+0x15c>
80004f52:	48bd                	li	a7,15
80004f54:	00359313          	sll	t1,a1,0x3
80004f58:	934a                	add	t1,t1,s2
80004f5a:	851a                	mv	a0,t1
80004f5c:	455c                	lw	a5,12(a0)
80004f5e:	8e2e                	mv	t3,a1
80004f60:	16f50763          	beq	a0,a5,800050ce <_malloc_r+0x2e2>
80004f64:	43d8                	lw	a4,4(a5)
80004f66:	843e                	mv	s0,a5
80004f68:	47dc                	lw	a5,12(a5)
80004f6a:	9b71                	and	a4,a4,-4
80004f6c:	409706b3          	sub	a3,a4,s1
80004f70:	16d8c663          	blt	a7,a3,800050dc <_malloc_r+0x2f0>
80004f74:	fe06c6e3          	bltz	a3,80004f60 <_malloc_r+0x174>
80004f78:	9722                	add	a4,a4,s0
80004f7a:	4354                	lw	a3,4(a4)
80004f7c:	4410                	lw	a2,8(s0)
80004f7e:	854e                	mv	a0,s3
80004f80:	0016e693          	or	a3,a3,1
80004f84:	c354                	sw	a3,4(a4)
80004f86:	c65c                	sw	a5,12(a2)
80004f88:	c790                	sw	a2,8(a5)
80004f8a:	2be1                	jal	80005562 <__malloc_unlock>
80004f8c:	00840513          	add	a0,s0,8
80004f90:	b5c1                	j	80004e50 <_malloc_r+0x64>
80004f92:	47b1                	li	a5,12
80004f94:	00f9a023          	sw	a5,0(s3)
80004f98:	4501                	li	a0,0
80004f9a:	bd5d                	j	80004e50 <_malloc_r+0x64>
80004f9c:	20000693          	li	a3,512
80004fa0:	04000593          	li	a1,64
80004fa4:	03f00513          	li	a0,63
80004fa8:	bddd                	j	80004e9e <_malloc_r+0xb2>
80004faa:	00892403          	lw	s0,8(s2)
80004fae:	405c                	lw	a5,4(s0)
80004fb0:	ffc7fb13          	and	s6,a5,-4
80004fb4:	009b6763          	bltu	s6,s1,80004fc2 <_malloc_r+0x1d6>
80004fb8:	409b0733          	sub	a4,s6,s1
80004fbc:	47bd                	li	a5,15
80004fbe:	08e7c263          	blt	a5,a4,80005042 <_malloc_r+0x256>
80004fc2:	0401aa83          	lw	s5,64(gp) # 800f4a20 <__malloc_top_pad>
80004fc6:	0041a703          	lw	a4,4(gp) # 800f49e4 <__malloc_sbrk_base>
80004fca:	57fd                	li	a5,-1
80004fcc:	01640a33          	add	s4,s0,s6
80004fd0:	9aa6                	add	s5,s5,s1
80004fd2:	2af70d63          	beq	a4,a5,8000528c <_malloc_r+0x4a0>
80004fd6:	6785                	lui	a5,0x1
80004fd8:	07bd                	add	a5,a5,15 # 100f <_reset_entry-0x7fffeff1>
80004fda:	9abe                	add	s5,s5,a5
80004fdc:	77fd                	lui	a5,0xfffff
80004fde:	00fafab3          	and	s5,s5,a5
80004fe2:	85d6                	mv	a1,s5
80004fe4:	854e                	mv	a0,s3
80004fe6:	2bd9                	jal	800055bc <_sbrk_r>
80004fe8:	57fd                	li	a5,-1
80004fea:	8baa                	mv	s7,a0
80004fec:	18f50063          	beq	a0,a5,8000516c <_malloc_r+0x380>
80004ff0:	17456c63          	bltu	a0,s4,80005168 <_malloc_r+0x37c>
80004ff4:	00c18c13          	add	s8,gp,12 # 800f49ec <__malloc_current_mallinfo>
80004ff8:	000c2583          	lw	a1,0(s8)
80004ffc:	95d6                	add	a1,a1,s5
80004ffe:	00bc2023          	sw	a1,0(s8)
80005002:	872e                	mv	a4,a1
80005004:	1eaa1063          	bne	s4,a0,800051e4 <_malloc_r+0x3f8>
80005008:	01451793          	sll	a5,a0,0x14
8000500c:	1c079c63          	bnez	a5,800051e4 <_malloc_r+0x3f8>
80005010:	00892b83          	lw	s7,8(s2)
80005014:	015b07b3          	add	a5,s6,s5
80005018:	0017e793          	or	a5,a5,1
8000501c:	00fba223          	sw	a5,4(s7)
80005020:	03c1a683          	lw	a3,60(gp) # 800f4a1c <__malloc_max_sbrked_mem>
80005024:	00b6f463          	bgeu	a3,a1,8000502c <_malloc_r+0x240>
80005028:	02b1ae23          	sw	a1,60(gp) # 800f4a1c <__malloc_max_sbrked_mem>
8000502c:	0381a683          	lw	a3,56(gp) # 800f4a18 <__malloc_max_total_mem>
80005030:	00b6f463          	bgeu	a3,a1,80005038 <_malloc_r+0x24c>
80005034:	02b1ac23          	sw	a1,56(gp) # 800f4a18 <__malloc_max_total_mem>
80005038:	845e                	mv	s0,s7
8000503a:	aa25                	j	80005172 <_malloc_r+0x386>
8000503c:	00492503          	lw	a0,4(s2)
80005040:	b5e5                	j	80004f28 <_malloc_r+0x13c>
80005042:	0014e793          	or	a5,s1,1
80005046:	c05c                	sw	a5,4(s0)
80005048:	94a2                	add	s1,s1,s0
8000504a:	00992423          	sw	s1,8(s2)
8000504e:	00176713          	or	a4,a4,1
80005052:	854e                	mv	a0,s3
80005054:	c0d8                	sw	a4,4(s1)
80005056:	2331                	jal	80005562 <__malloc_unlock>
80005058:	00840513          	add	a0,s0,8
8000505c:	bbd5                	j	80004e50 <_malloc_r+0x64>
8000505e:	4454                	lw	a3,12(s0)
80005060:	4410                	lw	a2,8(s0)
80005062:	bbe1                	j	80004e3a <_malloc_r+0x4e>
80005064:	47c0                	lw	s0,12(a5)
80005066:	0589                	add	a1,a1,2
80005068:	e68782e3          	beq	a5,s0,80004ecc <_malloc_r+0xe0>
8000506c:	b3d9                	j	80004e32 <_malloc_r+0x46>
8000506e:	0097d713          	srl	a4,a5,0x9
80005072:	4691                	li	a3,4
80005074:	0ee6f263          	bgeu	a3,a4,80005158 <_malloc_r+0x36c>
80005078:	46d1                	li	a3,20
8000507a:	24e6e263          	bltu	a3,a4,800052be <_malloc_r+0x4d2>
8000507e:	05c70613          	add	a2,a4,92
80005082:	05b70693          	add	a3,a4,91
80005086:	060e                	sll	a2,a2,0x3
80005088:	964a                	add	a2,a2,s2
8000508a:	4218                	lw	a4,0(a2)
8000508c:	1661                	add	a2,a2,-8
8000508e:	00e61663          	bne	a2,a4,8000509a <_malloc_r+0x2ae>
80005092:	aafd                	j	80005290 <_malloc_r+0x4a4>
80005094:	4718                	lw	a4,8(a4)
80005096:	00e60663          	beq	a2,a4,800050a2 <_malloc_r+0x2b6>
8000509a:	4354                	lw	a3,4(a4)
8000509c:	9af1                	and	a3,a3,-4
8000509e:	fed7ebe3          	bltu	a5,a3,80005094 <_malloc_r+0x2a8>
800050a2:	4750                	lw	a2,12(a4)
800050a4:	c450                	sw	a2,12(s0)
800050a6:	c418                	sw	a4,8(s0)
800050a8:	c600                	sw	s0,8(a2)
800050aa:	c740                	sw	s0,12(a4)
800050ac:	bdb5                	j	80004f28 <_malloc_r+0x13c>
800050ae:	4751                	li	a4,20
800050b0:	0cf77d63          	bgeu	a4,a5,8000518a <_malloc_r+0x39e>
800050b4:	05400713          	li	a4,84
800050b8:	20f76f63          	bltu	a4,a5,800052d6 <_malloc_r+0x4ea>
800050bc:	00c4d793          	srl	a5,s1,0xc
800050c0:	06f78593          	add	a1,a5,111 # fffff06f <_timer_base+0x3fffef6f>
800050c4:	06e78513          	add	a0,a5,110
800050c8:	00359693          	sll	a3,a1,0x3
800050cc:	bbc9                	j	80004e9e <_malloc_r+0xb2>
800050ce:	0e05                	add	t3,t3,1
800050d0:	003e7793          	and	a5,t3,3
800050d4:	0521                	add	a0,a0,8
800050d6:	c7f1                	beqz	a5,800051a2 <_malloc_r+0x3b6>
800050d8:	455c                	lw	a5,12(a0)
800050da:	b559                	j	80004f60 <_malloc_r+0x174>
800050dc:	4410                	lw	a2,8(s0)
800050de:	0014e593          	or	a1,s1,1
800050e2:	c04c                	sw	a1,4(s0)
800050e4:	c65c                	sw	a5,12(a2)
800050e6:	c790                	sw	a2,8(a5)
800050e8:	94a2                	add	s1,s1,s0
800050ea:	00992a23          	sw	s1,20(s2)
800050ee:	00992823          	sw	s1,16(s2)
800050f2:	0016e793          	or	a5,a3,1
800050f6:	0104a623          	sw	a6,12(s1)
800050fa:	0104a423          	sw	a6,8(s1)
800050fe:	c0dc                	sw	a5,4(s1)
80005100:	9722                	add	a4,a4,s0
80005102:	854e                	mv	a0,s3
80005104:	c314                	sw	a3,0(a4)
80005106:	29b1                	jal	80005562 <__malloc_unlock>
80005108:	00840513          	add	a0,s0,8
8000510c:	b391                	j	80004e50 <_malloc_r+0x64>
8000510e:	97a2                	add	a5,a5,s0
80005110:	43d8                	lw	a4,4(a5)
80005112:	854e                	mv	a0,s3
80005114:	00176713          	or	a4,a4,1
80005118:	c3d8                	sw	a4,4(a5)
8000511a:	21a1                	jal	80005562 <__malloc_unlock>
8000511c:	00840513          	add	a0,s0,8
80005120:	bb05                	j	80004e50 <_malloc_r+0x64>
80005122:	0034d593          	srl	a1,s1,0x3
80005126:	00848793          	add	a5,s1,8
8000512a:	b9d5                	j	80004e1e <_malloc_r+0x32>
8000512c:	0014e693          	or	a3,s1,1
80005130:	c054                	sw	a3,4(s0)
80005132:	94a2                	add	s1,s1,s0
80005134:	00992a23          	sw	s1,20(s2)
80005138:	00992823          	sw	s1,16(s2)
8000513c:	00176693          	or	a3,a4,1
80005140:	0104a623          	sw	a6,12(s1)
80005144:	0104a423          	sw	a6,8(s1)
80005148:	c0d4                	sw	a3,4(s1)
8000514a:	97a2                	add	a5,a5,s0
8000514c:	854e                	mv	a0,s3
8000514e:	c398                	sw	a4,0(a5)
80005150:	2909                	jal	80005562 <__malloc_unlock>
80005152:	00840513          	add	a0,s0,8
80005156:	b9ed                	j	80004e50 <_malloc_r+0x64>
80005158:	0067d713          	srl	a4,a5,0x6
8000515c:	03970613          	add	a2,a4,57
80005160:	03870693          	add	a3,a4,56
80005164:	060e                	sll	a2,a2,0x3
80005166:	b70d                	j	80005088 <_malloc_r+0x29c>
80005168:	07240763          	beq	s0,s2,800051d6 <_malloc_r+0x3ea>
8000516c:	00892403          	lw	s0,8(s2)
80005170:	405c                	lw	a5,4(s0)
80005172:	9bf1                	and	a5,a5,-4
80005174:	40978733          	sub	a4,a5,s1
80005178:	0097e563          	bltu	a5,s1,80005182 <_malloc_r+0x396>
8000517c:	47bd                	li	a5,15
8000517e:	ece7c2e3          	blt	a5,a4,80005042 <_malloc_r+0x256>
80005182:	854e                	mv	a0,s3
80005184:	2ef9                	jal	80005562 <__malloc_unlock>
80005186:	4501                	li	a0,0
80005188:	b1e1                	j	80004e50 <_malloc_r+0x64>
8000518a:	05c78593          	add	a1,a5,92
8000518e:	05b78513          	add	a0,a5,91
80005192:	00359693          	sll	a3,a1,0x3
80005196:	b321                	j	80004e9e <_malloc_r+0xb2>
80005198:	00832783          	lw	a5,8(t1)
8000519c:	15fd                	add	a1,a1,-1
8000519e:	1c679763          	bne	a5,t1,8000536c <_malloc_r+0x580>
800051a2:	0035f793          	and	a5,a1,3
800051a6:	1361                	add	t1,t1,-8
800051a8:	fbe5                	bnez	a5,80005198 <_malloc_r+0x3ac>
800051aa:	00492703          	lw	a4,4(s2)
800051ae:	fff64793          	not	a5,a2
800051b2:	8ff9                	and	a5,a5,a4
800051b4:	00f92223          	sw	a5,4(s2)
800051b8:	0606                	sll	a2,a2,0x1
800051ba:	dec7e8e3          	bltu	a5,a2,80004faa <_malloc_r+0x1be>
800051be:	de0606e3          	beqz	a2,80004faa <_malloc_r+0x1be>
800051c2:	00f67733          	and	a4,a2,a5
800051c6:	e711                	bnez	a4,800051d2 <_malloc_r+0x3e6>
800051c8:	0606                	sll	a2,a2,0x1
800051ca:	00f67733          	and	a4,a2,a5
800051ce:	0e11                	add	t3,t3,4
800051d0:	df65                	beqz	a4,800051c8 <_malloc_r+0x3dc>
800051d2:	85f2                	mv	a1,t3
800051d4:	b341                	j	80004f54 <_malloc_r+0x168>
800051d6:	00c18c13          	add	s8,gp,12 # 800f49ec <__malloc_current_mallinfo>
800051da:	000c2703          	lw	a4,0(s8)
800051de:	9756                	add	a4,a4,s5
800051e0:	00ec2023          	sw	a4,0(s8)
800051e4:	0041a683          	lw	a3,4(gp) # 800f49e4 <__malloc_sbrk_base>
800051e8:	57fd                	li	a5,-1
800051ea:	10f68363          	beq	a3,a5,800052f0 <_malloc_r+0x504>
800051ee:	414b87b3          	sub	a5,s7,s4
800051f2:	97ba                	add	a5,a5,a4
800051f4:	00fc2023          	sw	a5,0(s8)
800051f8:	007bfc93          	and	s9,s7,7
800051fc:	0a0c8263          	beqz	s9,800052a0 <_malloc_r+0x4b4>
80005200:	6705                	lui	a4,0x1
80005202:	419b8bb3          	sub	s7,s7,s9
80005206:	00870593          	add	a1,a4,8 # 1008 <_reset_entry-0x7fffeff8>
8000520a:	0ba1                	add	s7,s7,8
8000520c:	419585b3          	sub	a1,a1,s9
80005210:	9ade                	add	s5,s5,s7
80005212:	415585b3          	sub	a1,a1,s5
80005216:	177d                	add	a4,a4,-1
80005218:	00e5fa33          	and	s4,a1,a4
8000521c:	85d2                	mv	a1,s4
8000521e:	854e                	mv	a0,s3
80005220:	2e71                	jal	800055bc <_sbrk_r>
80005222:	57fd                	li	a5,-1
80005224:	10f50663          	beq	a0,a5,80005330 <_malloc_r+0x544>
80005228:	41750533          	sub	a0,a0,s7
8000522c:	01450ab3          	add	s5,a0,s4
80005230:	000c2703          	lw	a4,0(s8)
80005234:	01792423          	sw	s7,8(s2)
80005238:	001ae793          	or	a5,s5,1
8000523c:	00ea05b3          	add	a1,s4,a4
80005240:	00bc2023          	sw	a1,0(s8)
80005244:	00fba223          	sw	a5,4(s7)
80005248:	dd240ce3          	beq	s0,s2,80005020 <_malloc_r+0x234>
8000524c:	46bd                	li	a3,15
8000524e:	0b66f463          	bgeu	a3,s6,800052f6 <_malloc_r+0x50a>
80005252:	4058                	lw	a4,4(s0)
80005254:	ff4b0793          	add	a5,s6,-12
80005258:	9be1                	and	a5,a5,-8
8000525a:	8b05                	and	a4,a4,1
8000525c:	8f5d                	or	a4,a4,a5
8000525e:	c058                	sw	a4,4(s0)
80005260:	4615                	li	a2,5
80005262:	00f40733          	add	a4,s0,a5
80005266:	c350                	sw	a2,4(a4)
80005268:	c710                	sw	a2,8(a4)
8000526a:	00f6e563          	bltu	a3,a5,80005274 <_malloc_r+0x488>
8000526e:	004ba783          	lw	a5,4(s7)
80005272:	b37d                	j	80005020 <_malloc_r+0x234>
80005274:	00840593          	add	a1,s0,8
80005278:	854e                	mv	a0,s3
8000527a:	8d3ff0ef          	jal	80004b4c <_free_r>
8000527e:	00892b83          	lw	s7,8(s2)
80005282:	000c2583          	lw	a1,0(s8)
80005286:	004ba783          	lw	a5,4(s7)
8000528a:	bb59                	j	80005020 <_malloc_r+0x234>
8000528c:	0ac1                	add	s5,s5,16
8000528e:	bb91                	j	80004fe2 <_malloc_r+0x1f6>
80005290:	8689                	sra	a3,a3,0x2
80005292:	4785                	li	a5,1
80005294:	00d797b3          	sll	a5,a5,a3
80005298:	8d5d                	or	a0,a0,a5
8000529a:	00a92223          	sw	a0,4(s2)
8000529e:	b519                	j	800050a4 <_malloc_r+0x2b8>
800052a0:	015b85b3          	add	a1,s7,s5
800052a4:	40b005b3          	neg	a1,a1
800052a8:	05d2                	sll	a1,a1,0x14
800052aa:	0145da13          	srl	s4,a1,0x14
800052ae:	85d2                	mv	a1,s4
800052b0:	854e                	mv	a0,s3
800052b2:	2629                	jal	800055bc <_sbrk_r>
800052b4:	57fd                	li	a5,-1
800052b6:	f6f519e3          	bne	a0,a5,80005228 <_malloc_r+0x43c>
800052ba:	4a01                	li	s4,0
800052bc:	bf95                	j	80005230 <_malloc_r+0x444>
800052be:	05400693          	li	a3,84
800052c2:	02e6ee63          	bltu	a3,a4,800052fe <_malloc_r+0x512>
800052c6:	00c7d713          	srl	a4,a5,0xc
800052ca:	06f70613          	add	a2,a4,111
800052ce:	06e70693          	add	a3,a4,110
800052d2:	060e                	sll	a2,a2,0x3
800052d4:	bb55                	j	80005088 <_malloc_r+0x29c>
800052d6:	15400713          	li	a4,340
800052da:	02f76e63          	bltu	a4,a5,80005316 <_malloc_r+0x52a>
800052de:	00f4d793          	srl	a5,s1,0xf
800052e2:	07878593          	add	a1,a5,120
800052e6:	07778513          	add	a0,a5,119
800052ea:	00359693          	sll	a3,a1,0x3
800052ee:	be45                	j	80004e9e <_malloc_r+0xb2>
800052f0:	0171a223          	sw	s7,4(gp) # 800f49e4 <__malloc_sbrk_base>
800052f4:	b711                	j	800051f8 <_malloc_r+0x40c>
800052f6:	4785                	li	a5,1
800052f8:	00fba223          	sw	a5,4(s7)
800052fc:	b559                	j	80005182 <_malloc_r+0x396>
800052fe:	15400693          	li	a3,340
80005302:	02e6ed63          	bltu	a3,a4,8000533c <_malloc_r+0x550>
80005306:	00f7d713          	srl	a4,a5,0xf
8000530a:	07870613          	add	a2,a4,120
8000530e:	07770693          	add	a3,a4,119
80005312:	060e                	sll	a2,a2,0x3
80005314:	bb95                	j	80005088 <_malloc_r+0x29c>
80005316:	55400713          	li	a4,1364
8000531a:	02f76d63          	bltu	a4,a5,80005354 <_malloc_r+0x568>
8000531e:	0124d793          	srl	a5,s1,0x12
80005322:	07d78593          	add	a1,a5,125
80005326:	07c78513          	add	a0,a5,124
8000532a:	00359693          	sll	a3,a1,0x3
8000532e:	be85                	j	80004e9e <_malloc_r+0xb2>
80005330:	1ce1                	add	s9,s9,-8
80005332:	9ae6                	add	s5,s5,s9
80005334:	417a8ab3          	sub	s5,s5,s7
80005338:	4a01                	li	s4,0
8000533a:	bddd                	j	80005230 <_malloc_r+0x444>
8000533c:	55400693          	li	a3,1364
80005340:	02e6e163          	bltu	a3,a4,80005362 <_malloc_r+0x576>
80005344:	0127d713          	srl	a4,a5,0x12
80005348:	07d70613          	add	a2,a4,125
8000534c:	07c70693          	add	a3,a4,124
80005350:	060e                	sll	a2,a2,0x3
80005352:	bb1d                	j	80005088 <_malloc_r+0x29c>
80005354:	3f800693          	li	a3,1016
80005358:	07f00593          	li	a1,127
8000535c:	07e00513          	li	a0,126
80005360:	be3d                	j	80004e9e <_malloc_r+0xb2>
80005362:	3f800613          	li	a2,1016
80005366:	07e00693          	li	a3,126
8000536a:	bb39                	j	80005088 <_malloc_r+0x29c>
8000536c:	00492783          	lw	a5,4(s2)
80005370:	b5a1                	j	800051b8 <_malloc_r+0x3cc>

80005372 <memcpy>:
80005372:	00b547b3          	xor	a5,a0,a1
80005376:	8b8d                	and	a5,a5,3
80005378:	00c508b3          	add	a7,a0,a2
8000537c:	e7b1                	bnez	a5,800053c8 <memcpy+0x56>
8000537e:	478d                	li	a5,3
80005380:	04c7f463          	bgeu	a5,a2,800053c8 <memcpy+0x56>
80005384:	00357793          	and	a5,a0,3
80005388:	872a                	mv	a4,a0
8000538a:	ebb9                	bnez	a5,800053e0 <memcpy+0x6e>
8000538c:	ffc8f613          	and	a2,a7,-4
80005390:	40e606b3          	sub	a3,a2,a4
80005394:	02000793          	li	a5,32
80005398:	06d7c863          	blt	a5,a3,80005408 <memcpy+0x96>
8000539c:	86ae                	mv	a3,a1
8000539e:	87ba                	mv	a5,a4
800053a0:	02c77163          	bgeu	a4,a2,800053c2 <memcpy+0x50>
800053a4:	0006a803          	lw	a6,0(a3)
800053a8:	0791                	add	a5,a5,4
800053aa:	0691                	add	a3,a3,4
800053ac:	ff07ae23          	sw	a6,-4(a5)
800053b0:	fec7eae3          	bltu	a5,a2,800053a4 <memcpy+0x32>
800053b4:	fff60793          	add	a5,a2,-1
800053b8:	8f99                	sub	a5,a5,a4
800053ba:	9bf1                	and	a5,a5,-4
800053bc:	0791                	add	a5,a5,4
800053be:	973e                	add	a4,a4,a5
800053c0:	95be                	add	a1,a1,a5
800053c2:	01176663          	bltu	a4,a7,800053ce <memcpy+0x5c>
800053c6:	8082                	ret
800053c8:	872a                	mv	a4,a0
800053ca:	03157e63          	bgeu	a0,a7,80005406 <memcpy+0x94>
800053ce:	0005c783          	lbu	a5,0(a1)
800053d2:	0705                	add	a4,a4,1
800053d4:	0585                	add	a1,a1,1
800053d6:	fef70fa3          	sb	a5,-1(a4)
800053da:	fee89ae3          	bne	a7,a4,800053ce <memcpy+0x5c>
800053de:	8082                	ret
800053e0:	0005c683          	lbu	a3,0(a1)
800053e4:	0705                	add	a4,a4,1
800053e6:	00377793          	and	a5,a4,3
800053ea:	fed70fa3          	sb	a3,-1(a4)
800053ee:	0585                	add	a1,a1,1
800053f0:	dfd1                	beqz	a5,8000538c <memcpy+0x1a>
800053f2:	0005c683          	lbu	a3,0(a1)
800053f6:	0705                	add	a4,a4,1
800053f8:	00377793          	and	a5,a4,3
800053fc:	fed70fa3          	sb	a3,-1(a4)
80005400:	0585                	add	a1,a1,1
80005402:	fff9                	bnez	a5,800053e0 <memcpy+0x6e>
80005404:	b761                	j	8000538c <memcpy+0x1a>
80005406:	8082                	ret
80005408:	1141                	add	sp,sp,-16
8000540a:	c622                	sw	s0,12(sp)
8000540c:	02000413          	li	s0,32
80005410:	0005a383          	lw	t2,0(a1)
80005414:	0045a283          	lw	t0,4(a1)
80005418:	0085af83          	lw	t6,8(a1)
8000541c:	00c5af03          	lw	t5,12(a1)
80005420:	0105ae83          	lw	t4,16(a1)
80005424:	0145ae03          	lw	t3,20(a1)
80005428:	0185a303          	lw	t1,24(a1)
8000542c:	01c5a803          	lw	a6,28(a1)
80005430:	5194                	lw	a3,32(a1)
80005432:	02470713          	add	a4,a4,36
80005436:	40e607b3          	sub	a5,a2,a4
8000543a:	fc772e23          	sw	t2,-36(a4)
8000543e:	fe572023          	sw	t0,-32(a4)
80005442:	fff72223          	sw	t6,-28(a4)
80005446:	ffe72423          	sw	t5,-24(a4)
8000544a:	ffd72623          	sw	t4,-20(a4)
8000544e:	ffc72823          	sw	t3,-16(a4)
80005452:	fe672a23          	sw	t1,-12(a4)
80005456:	ff072c23          	sw	a6,-8(a4)
8000545a:	fed72e23          	sw	a3,-4(a4)
8000545e:	02458593          	add	a1,a1,36
80005462:	faf447e3          	blt	s0,a5,80005410 <memcpy+0x9e>
80005466:	86ae                	mv	a3,a1
80005468:	87ba                	mv	a5,a4
8000546a:	02c77163          	bgeu	a4,a2,8000548c <memcpy+0x11a>
8000546e:	0006a803          	lw	a6,0(a3)
80005472:	0791                	add	a5,a5,4
80005474:	0691                	add	a3,a3,4
80005476:	ff07ae23          	sw	a6,-4(a5)
8000547a:	fec7eae3          	bltu	a5,a2,8000546e <memcpy+0xfc>
8000547e:	fff60793          	add	a5,a2,-1
80005482:	8f99                	sub	a5,a5,a4
80005484:	9bf1                	and	a5,a5,-4
80005486:	0791                	add	a5,a5,4
80005488:	973e                	add	a4,a4,a5
8000548a:	95be                	add	a1,a1,a5
8000548c:	01176563          	bltu	a4,a7,80005496 <memcpy+0x124>
80005490:	4432                	lw	s0,12(sp)
80005492:	0141                	add	sp,sp,16
80005494:	8082                	ret
80005496:	0005c783          	lbu	a5,0(a1)
8000549a:	0705                	add	a4,a4,1
8000549c:	0585                	add	a1,a1,1
8000549e:	fef70fa3          	sb	a5,-1(a4)
800054a2:	fee887e3          	beq	a7,a4,80005490 <memcpy+0x11e>
800054a6:	0005c783          	lbu	a5,0(a1)
800054aa:	0705                	add	a4,a4,1
800054ac:	0585                	add	a1,a1,1
800054ae:	fef70fa3          	sb	a5,-1(a4)
800054b2:	fee892e3          	bne	a7,a4,80005496 <memcpy+0x124>
800054b6:	bfe9                	j	80005490 <memcpy+0x11e>

800054b8 <memset>:
800054b8:	433d                	li	t1,15
800054ba:	872a                	mv	a4,a0
800054bc:	02c37363          	bgeu	t1,a2,800054e2 <memset+0x2a>
800054c0:	00f77793          	and	a5,a4,15
800054c4:	efbd                	bnez	a5,80005542 <memset+0x8a>
800054c6:	e5ad                	bnez	a1,80005530 <memset+0x78>
800054c8:	ff067693          	and	a3,a2,-16
800054cc:	8a3d                	and	a2,a2,15
800054ce:	96ba                	add	a3,a3,a4
800054d0:	c30c                	sw	a1,0(a4)
800054d2:	c34c                	sw	a1,4(a4)
800054d4:	c70c                	sw	a1,8(a4)
800054d6:	c74c                	sw	a1,12(a4)
800054d8:	0741                	add	a4,a4,16
800054da:	fed76be3          	bltu	a4,a3,800054d0 <memset+0x18>
800054de:	e211                	bnez	a2,800054e2 <memset+0x2a>
800054e0:	8082                	ret
800054e2:	40c306b3          	sub	a3,t1,a2
800054e6:	068a                	sll	a3,a3,0x2
800054e8:	00000297          	auipc	t0,0x0
800054ec:	9696                	add	a3,a3,t0
800054ee:	00a68067          	jr	10(a3)
800054f2:	00b70723          	sb	a1,14(a4)
800054f6:	00b706a3          	sb	a1,13(a4)
800054fa:	00b70623          	sb	a1,12(a4)
800054fe:	00b705a3          	sb	a1,11(a4)
80005502:	00b70523          	sb	a1,10(a4)
80005506:	00b704a3          	sb	a1,9(a4)
8000550a:	00b70423          	sb	a1,8(a4)
8000550e:	00b703a3          	sb	a1,7(a4)
80005512:	00b70323          	sb	a1,6(a4)
80005516:	00b702a3          	sb	a1,5(a4)
8000551a:	00b70223          	sb	a1,4(a4)
8000551e:	00b701a3          	sb	a1,3(a4)
80005522:	00b70123          	sb	a1,2(a4)
80005526:	00b700a3          	sb	a1,1(a4)
8000552a:	00b70023          	sb	a1,0(a4)
8000552e:	8082                	ret
80005530:	0ff5f593          	zext.b	a1,a1
80005534:	00859693          	sll	a3,a1,0x8
80005538:	8dd5                	or	a1,a1,a3
8000553a:	01059693          	sll	a3,a1,0x10
8000553e:	8dd5                	or	a1,a1,a3
80005540:	b761                	j	800054c8 <memset+0x10>
80005542:	00279693          	sll	a3,a5,0x2
80005546:	00000297          	auipc	t0,0x0
8000554a:	9696                	add	a3,a3,t0
8000554c:	8286                	mv	t0,ra
8000554e:	fa8680e7          	jalr	-88(a3)
80005552:	8096                	mv	ra,t0
80005554:	17c1                	add	a5,a5,-16
80005556:	8f1d                	sub	a4,a4,a5
80005558:	963e                	add	a2,a2,a5
8000555a:	f8c374e3          	bgeu	t1,a2,800054e2 <memset+0x2a>
8000555e:	b7a5                	j	800054c6 <memset+0xe>

80005560 <__malloc_lock>:
80005560:	8082                	ret

80005562 <__malloc_unlock>:
80005562:	8082                	ret

80005564 <_putc_r>:
80005564:	1101                	add	sp,sp,-32
80005566:	cc4a                	sw	s2,24(sp)
80005568:	ce06                	sw	ra,28(sp)
8000556a:	892a                	mv	s2,a0
8000556c:	c119                	beqz	a0,80005572 <_putc_r+0xe>
8000556e:	5d1c                	lw	a5,56(a0)
80005570:	cb95                	beqz	a5,800055a4 <_putc_r+0x40>
80005572:	461c                	lw	a5,8(a2)
80005574:	17fd                	add	a5,a5,-1
80005576:	c61c                	sw	a5,8(a2)
80005578:	0007da63          	bgez	a5,8000558c <_putc_r+0x28>
8000557c:	4e18                	lw	a4,24(a2)
8000557e:	02e7ca63          	blt	a5,a4,800055b2 <_putc_r+0x4e>
80005582:	0ff5f793          	zext.b	a5,a1
80005586:	4729                	li	a4,10
80005588:	02e78563          	beq	a5,a4,800055b2 <_putc_r+0x4e>
8000558c:	421c                	lw	a5,0(a2)
8000558e:	0ff5f513          	zext.b	a0,a1
80005592:	00178713          	add	a4,a5,1
80005596:	c218                	sw	a4,0(a2)
80005598:	00b78023          	sb	a1,0(a5)
8000559c:	40f2                	lw	ra,28(sp)
8000559e:	4962                	lw	s2,24(sp)
800055a0:	6105                	add	sp,sp,32
800055a2:	8082                	ret
800055a4:	c632                	sw	a2,12(sp)
800055a6:	c42e                	sw	a1,8(sp)
800055a8:	c8eff0ef          	jal	80004a36 <__sinit>
800055ac:	4632                	lw	a2,12(sp)
800055ae:	45a2                	lw	a1,8(sp)
800055b0:	b7c9                	j	80005572 <_putc_r+0xe>
800055b2:	40f2                	lw	ra,28(sp)
800055b4:	854a                	mv	a0,s2
800055b6:	4962                	lw	s2,24(sp)
800055b8:	6105                	add	sp,sp,32
800055ba:	a231                	j	800056c6 <__swbuf_r>

800055bc <_sbrk_r>:
800055bc:	1141                	add	sp,sp,-16
800055be:	c422                	sw	s0,8(sp)
800055c0:	c226                	sw	s1,4(sp)
800055c2:	842a                	mv	s0,a0
800055c4:	852e                	mv	a0,a1
800055c6:	c606                	sw	ra,12(sp)
800055c8:	0401a223          	sw	zero,68(gp) # 800f4a24 <errno>
800055cc:	e55fc0ef          	jal	80002420 <_sbrk>
800055d0:	57fd                	li	a5,-1
800055d2:	00f50763          	beq	a0,a5,800055e0 <_sbrk_r+0x24>
800055d6:	40b2                	lw	ra,12(sp)
800055d8:	4422                	lw	s0,8(sp)
800055da:	4492                	lw	s1,4(sp)
800055dc:	0141                	add	sp,sp,16
800055de:	8082                	ret
800055e0:	0441a783          	lw	a5,68(gp) # 800f4a24 <errno>
800055e4:	dbed                	beqz	a5,800055d6 <_sbrk_r+0x1a>
800055e6:	40b2                	lw	ra,12(sp)
800055e8:	c01c                	sw	a5,0(s0)
800055ea:	4422                	lw	s0,8(sp)
800055ec:	4492                	lw	s1,4(sp)
800055ee:	0141                	add	sp,sp,16
800055f0:	8082                	ret

800055f2 <__sread>:
800055f2:	1141                	add	sp,sp,-16
800055f4:	c422                	sw	s0,8(sp)
800055f6:	842e                	mv	s0,a1
800055f8:	00e59583          	lh	a1,14(a1)
800055fc:	c606                	sw	ra,12(sp)
800055fe:	29ed                	jal	80005af8 <_read_r>
80005600:	00054963          	bltz	a0,80005612 <__sread+0x20>
80005604:	483c                	lw	a5,80(s0)
80005606:	40b2                	lw	ra,12(sp)
80005608:	97aa                	add	a5,a5,a0
8000560a:	c83c                	sw	a5,80(s0)
8000560c:	4422                	lw	s0,8(sp)
8000560e:	0141                	add	sp,sp,16
80005610:	8082                	ret
80005612:	00c45783          	lhu	a5,12(s0)
80005616:	777d                	lui	a4,0xfffff
80005618:	177d                	add	a4,a4,-1 # ffffefff <_timer_base+0x3fffeeff>
8000561a:	8ff9                	and	a5,a5,a4
8000561c:	40b2                	lw	ra,12(sp)
8000561e:	00f41623          	sh	a5,12(s0)
80005622:	4422                	lw	s0,8(sp)
80005624:	0141                	add	sp,sp,16
80005626:	8082                	ret

80005628 <__swrite>:
80005628:	00c59783          	lh	a5,12(a1)
8000562c:	1101                	add	sp,sp,-32
8000562e:	cc22                	sw	s0,24(sp)
80005630:	ca26                	sw	s1,20(sp)
80005632:	c84a                	sw	s2,16(sp)
80005634:	c64e                	sw	s3,12(sp)
80005636:	ce06                	sw	ra,28(sp)
80005638:	1007f713          	and	a4,a5,256
8000563c:	842e                	mv	s0,a1
8000563e:	84aa                	mv	s1,a0
80005640:	8932                	mv	s2,a2
80005642:	89b6                	mv	s3,a3
80005644:	e315                	bnez	a4,80005668 <__swrite+0x40>
80005646:	777d                	lui	a4,0xfffff
80005648:	177d                	add	a4,a4,-1 # ffffefff <_timer_base+0x3fffeeff>
8000564a:	8ff9                	and	a5,a5,a4
8000564c:	00e41583          	lh	a1,14(s0)
80005650:	00f41623          	sh	a5,12(s0)
80005654:	4462                	lw	s0,24(sp)
80005656:	40f2                	lw	ra,28(sp)
80005658:	86ce                	mv	a3,s3
8000565a:	864a                	mv	a2,s2
8000565c:	49b2                	lw	s3,12(sp)
8000565e:	4942                	lw	s2,16(sp)
80005660:	8526                	mv	a0,s1
80005662:	44d2                	lw	s1,20(sp)
80005664:	6105                	add	sp,sp,32
80005666:	aa81                	j	800057b6 <_write_r>
80005668:	00e59583          	lh	a1,14(a1)
8000566c:	4689                	li	a3,2
8000566e:	4601                	li	a2,0
80005670:	2681                	jal	800059b0 <_lseek_r>
80005672:	00c41783          	lh	a5,12(s0)
80005676:	bfc1                	j	80005646 <__swrite+0x1e>

80005678 <__sseek>:
80005678:	1141                	add	sp,sp,-16
8000567a:	c422                	sw	s0,8(sp)
8000567c:	842e                	mv	s0,a1
8000567e:	00e59583          	lh	a1,14(a1)
80005682:	c606                	sw	ra,12(sp)
80005684:	2635                	jal	800059b0 <_lseek_r>
80005686:	57fd                	li	a5,-1
80005688:	00f50f63          	beq	a0,a5,800056a6 <__sseek+0x2e>
8000568c:	00c45783          	lhu	a5,12(s0)
80005690:	6705                	lui	a4,0x1
80005692:	40b2                	lw	ra,12(sp)
80005694:	8fd9                	or	a5,a5,a4
80005696:	07c2                	sll	a5,a5,0x10
80005698:	87c1                	sra	a5,a5,0x10
8000569a:	c828                	sw	a0,80(s0)
8000569c:	00f41623          	sh	a5,12(s0)
800056a0:	4422                	lw	s0,8(sp)
800056a2:	0141                	add	sp,sp,16
800056a4:	8082                	ret
800056a6:	00c45783          	lhu	a5,12(s0)
800056aa:	777d                	lui	a4,0xfffff
800056ac:	177d                	add	a4,a4,-1 # ffffefff <_timer_base+0x3fffeeff>
800056ae:	8ff9                	and	a5,a5,a4
800056b0:	07c2                	sll	a5,a5,0x10
800056b2:	87c1                	sra	a5,a5,0x10
800056b4:	40b2                	lw	ra,12(sp)
800056b6:	00f41623          	sh	a5,12(s0)
800056ba:	4422                	lw	s0,8(sp)
800056bc:	0141                	add	sp,sp,16
800056be:	8082                	ret

800056c0 <__sclose>:
800056c0:	00e59583          	lh	a1,14(a1)
800056c4:	a421                	j	800058cc <_close_r>

800056c6 <__swbuf_r>:
800056c6:	1101                	add	sp,sp,-32
800056c8:	cc22                	sw	s0,24(sp)
800056ca:	ca26                	sw	s1,20(sp)
800056cc:	c84a                	sw	s2,16(sp)
800056ce:	ce06                	sw	ra,28(sp)
800056d0:	c64e                	sw	s3,12(sp)
800056d2:	892a                	mv	s2,a0
800056d4:	84ae                	mv	s1,a1
800056d6:	8432                	mv	s0,a2
800056d8:	c119                	beqz	a0,800056de <__swbuf_r+0x18>
800056da:	5d1c                	lw	a5,56(a0)
800056dc:	cbf1                	beqz	a5,800057b0 <__swbuf_r+0xea>
800056de:	4c1c                	lw	a5,24(s0)
800056e0:	00c41703          	lh	a4,12(s0)
800056e4:	c41c                	sw	a5,8(s0)
800056e6:	00877793          	and	a5,a4,8
800056ea:	cfa1                	beqz	a5,80005742 <__swbuf_r+0x7c>
800056ec:	481c                	lw	a5,16(s0)
800056ee:	cbb1                	beqz	a5,80005742 <__swbuf_r+0x7c>
800056f0:	01271693          	sll	a3,a4,0x12
800056f4:	0ff4f993          	zext.b	s3,s1
800056f8:	0ff4f493          	zext.b	s1,s1
800056fc:	0606d263          	bgez	a3,80005760 <__swbuf_r+0x9a>
80005700:	4018                	lw	a4,0(s0)
80005702:	4854                	lw	a3,20(s0)
80005704:	40f707b3          	sub	a5,a4,a5
80005708:	06d7db63          	bge	a5,a3,8000577e <__swbuf_r+0xb8>
8000570c:	4414                	lw	a3,8(s0)
8000570e:	00170613          	add	a2,a4,1
80005712:	c010                	sw	a2,0(s0)
80005714:	16fd                	add	a3,a3,-1
80005716:	c414                	sw	a3,8(s0)
80005718:	01370023          	sb	s3,0(a4)
8000571c:	4858                	lw	a4,20(s0)
8000571e:	0785                	add	a5,a5,1
80005720:	08f70163          	beq	a4,a5,800057a2 <__swbuf_r+0xdc>
80005724:	00c45783          	lhu	a5,12(s0)
80005728:	8b85                	and	a5,a5,1
8000572a:	c781                	beqz	a5,80005732 <__swbuf_r+0x6c>
8000572c:	47a9                	li	a5,10
8000572e:	06f48a63          	beq	s1,a5,800057a2 <__swbuf_r+0xdc>
80005732:	40f2                	lw	ra,28(sp)
80005734:	4462                	lw	s0,24(sp)
80005736:	4942                	lw	s2,16(sp)
80005738:	49b2                	lw	s3,12(sp)
8000573a:	8526                	mv	a0,s1
8000573c:	44d2                	lw	s1,20(sp)
8000573e:	6105                	add	sp,sp,32
80005740:	8082                	ret
80005742:	85a2                	mv	a1,s0
80005744:	854a                	mv	a0,s2
80005746:	2075                	jal	800057f2 <__swsetup_r>
80005748:	e135                	bnez	a0,800057ac <__swbuf_r+0xe6>
8000574a:	00c41703          	lh	a4,12(s0)
8000574e:	0ff4f993          	zext.b	s3,s1
80005752:	481c                	lw	a5,16(s0)
80005754:	01271693          	sll	a3,a4,0x12
80005758:	0ff4f493          	zext.b	s1,s1
8000575c:	fa06c2e3          	bltz	a3,80005700 <__swbuf_r+0x3a>
80005760:	5074                	lw	a3,100(s0)
80005762:	6609                	lui	a2,0x2
80005764:	8f51                	or	a4,a4,a2
80005766:	7679                	lui	a2,0xffffe
80005768:	167d                	add	a2,a2,-1 # ffffdfff <_timer_base+0x3fffdeff>
8000576a:	8ef1                	and	a3,a3,a2
8000576c:	00e41623          	sh	a4,12(s0)
80005770:	4018                	lw	a4,0(s0)
80005772:	d074                	sw	a3,100(s0)
80005774:	4854                	lw	a3,20(s0)
80005776:	40f707b3          	sub	a5,a4,a5
8000577a:	f8d7c9e3          	blt	a5,a3,8000570c <__swbuf_r+0x46>
8000577e:	85a2                	mv	a1,s0
80005780:	854a                	mv	a0,s2
80005782:	942ff0ef          	jal	800048c4 <_fflush_r>
80005786:	e11d                	bnez	a0,800057ac <__swbuf_r+0xe6>
80005788:	4018                	lw	a4,0(s0)
8000578a:	4414                	lw	a3,8(s0)
8000578c:	4785                	li	a5,1
8000578e:	00170613          	add	a2,a4,1
80005792:	16fd                	add	a3,a3,-1
80005794:	c010                	sw	a2,0(s0)
80005796:	c414                	sw	a3,8(s0)
80005798:	01370023          	sb	s3,0(a4)
8000579c:	4858                	lw	a4,20(s0)
8000579e:	f8f713e3          	bne	a4,a5,80005724 <__swbuf_r+0x5e>
800057a2:	85a2                	mv	a1,s0
800057a4:	854a                	mv	a0,s2
800057a6:	91eff0ef          	jal	800048c4 <_fflush_r>
800057aa:	d541                	beqz	a0,80005732 <__swbuf_r+0x6c>
800057ac:	54fd                	li	s1,-1
800057ae:	b751                	j	80005732 <__swbuf_r+0x6c>
800057b0:	a86ff0ef          	jal	80004a36 <__sinit>
800057b4:	b72d                	j	800056de <__swbuf_r+0x18>

800057b6 <_write_r>:
800057b6:	1141                	add	sp,sp,-16
800057b8:	872e                	mv	a4,a1
800057ba:	c422                	sw	s0,8(sp)
800057bc:	c226                	sw	s1,4(sp)
800057be:	85b2                	mv	a1,a2
800057c0:	842a                	mv	s0,a0
800057c2:	8636                	mv	a2,a3
800057c4:	853a                	mv	a0,a4
800057c6:	c606                	sw	ra,12(sp)
800057c8:	0401a223          	sw	zero,68(gp) # 800f4a24 <errno>
800057cc:	c79fc0ef          	jal	80002444 <_write>
800057d0:	57fd                	li	a5,-1
800057d2:	00f50763          	beq	a0,a5,800057e0 <_write_r+0x2a>
800057d6:	40b2                	lw	ra,12(sp)
800057d8:	4422                	lw	s0,8(sp)
800057da:	4492                	lw	s1,4(sp)
800057dc:	0141                	add	sp,sp,16
800057de:	8082                	ret
800057e0:	0441a783          	lw	a5,68(gp) # 800f4a24 <errno>
800057e4:	dbed                	beqz	a5,800057d6 <_write_r+0x20>
800057e6:	40b2                	lw	ra,12(sp)
800057e8:	c01c                	sw	a5,0(s0)
800057ea:	4422                	lw	s0,8(sp)
800057ec:	4492                	lw	s1,4(sp)
800057ee:	0141                	add	sp,sp,16
800057f0:	8082                	ret

800057f2 <__swsetup_r>:
800057f2:	0001a783          	lw	a5,0(gp) # 800f49e0 <_impure_ptr>
800057f6:	1141                	add	sp,sp,-16
800057f8:	c422                	sw	s0,8(sp)
800057fa:	c226                	sw	s1,4(sp)
800057fc:	c606                	sw	ra,12(sp)
800057fe:	84aa                	mv	s1,a0
80005800:	842e                	mv	s0,a1
80005802:	c399                	beqz	a5,80005808 <__swsetup_r+0x16>
80005804:	5f98                	lw	a4,56(a5)
80005806:	cb29                	beqz	a4,80005858 <__swsetup_r+0x66>
80005808:	00c41783          	lh	a5,12(s0)
8000580c:	0087f713          	and	a4,a5,8
80005810:	cf21                	beqz	a4,80005868 <__swsetup_r+0x76>
80005812:	4818                	lw	a4,16(s0)
80005814:	c735                	beqz	a4,80005880 <__swsetup_r+0x8e>
80005816:	0017f693          	and	a3,a5,1
8000581a:	ce91                	beqz	a3,80005836 <__swsetup_r+0x44>
8000581c:	4854                	lw	a3,20(s0)
8000581e:	00042423          	sw	zero,8(s0)
80005822:	4501                	li	a0,0
80005824:	40d006b3          	neg	a3,a3
80005828:	cc14                	sw	a3,24(s0)
8000582a:	cf11                	beqz	a4,80005846 <__swsetup_r+0x54>
8000582c:	40b2                	lw	ra,12(sp)
8000582e:	4422                	lw	s0,8(sp)
80005830:	4492                	lw	s1,4(sp)
80005832:	0141                	add	sp,sp,16
80005834:	8082                	ret
80005836:	0027f693          	and	a3,a5,2
8000583a:	4601                	li	a2,0
8000583c:	e291                	bnez	a3,80005840 <__swsetup_r+0x4e>
8000583e:	4850                	lw	a2,20(s0)
80005840:	c410                	sw	a2,8(s0)
80005842:	4501                	li	a0,0
80005844:	f765                	bnez	a4,8000582c <__swsetup_r+0x3a>
80005846:	0807f713          	and	a4,a5,128
8000584a:	d36d                	beqz	a4,8000582c <__swsetup_r+0x3a>
8000584c:	0407e793          	or	a5,a5,64
80005850:	00f41623          	sh	a5,12(s0)
80005854:	557d                	li	a0,-1
80005856:	bfd9                	j	8000582c <__swsetup_r+0x3a>
80005858:	853e                	mv	a0,a5
8000585a:	9dcff0ef          	jal	80004a36 <__sinit>
8000585e:	00c41783          	lh	a5,12(s0)
80005862:	0087f713          	and	a4,a5,8
80005866:	f755                	bnez	a4,80005812 <__swsetup_r+0x20>
80005868:	0107f713          	and	a4,a5,16
8000586c:	cb39                	beqz	a4,800058c2 <__swsetup_r+0xd0>
8000586e:	0047f713          	and	a4,a5,4
80005872:	e705                	bnez	a4,8000589a <__swsetup_r+0xa8>
80005874:	4818                	lw	a4,16(s0)
80005876:	0087e793          	or	a5,a5,8
8000587a:	00f41623          	sh	a5,12(s0)
8000587e:	ff41                	bnez	a4,80005816 <__swsetup_r+0x24>
80005880:	2807f693          	and	a3,a5,640
80005884:	20000613          	li	a2,512
80005888:	f8c687e3          	beq	a3,a2,80005816 <__swsetup_r+0x24>
8000588c:	85a2                	mv	a1,s0
8000588e:	8526                	mv	a0,s1
80005890:	2ab1                	jal	800059ec <__smakebuf_r>
80005892:	00c41783          	lh	a5,12(s0)
80005896:	4818                	lw	a4,16(s0)
80005898:	bfbd                	j	80005816 <__swsetup_r+0x24>
8000589a:	580c                	lw	a1,48(s0)
8000589c:	cd81                	beqz	a1,800058b4 <__swsetup_r+0xc2>
8000589e:	04040713          	add	a4,s0,64
800058a2:	00e58763          	beq	a1,a4,800058b0 <__swsetup_r+0xbe>
800058a6:	8526                	mv	a0,s1
800058a8:	aa4ff0ef          	jal	80004b4c <_free_r>
800058ac:	00c41783          	lh	a5,12(s0)
800058b0:	02042823          	sw	zero,48(s0)
800058b4:	4818                	lw	a4,16(s0)
800058b6:	fdb7f793          	and	a5,a5,-37
800058ba:	00042223          	sw	zero,4(s0)
800058be:	c018                	sw	a4,0(s0)
800058c0:	bf5d                	j	80005876 <__swsetup_r+0x84>
800058c2:	4725                	li	a4,9
800058c4:	c098                	sw	a4,0(s1)
800058c6:	0407e793          	or	a5,a5,64
800058ca:	b759                	j	80005850 <__swsetup_r+0x5e>

800058cc <_close_r>:
800058cc:	1141                	add	sp,sp,-16
800058ce:	c422                	sw	s0,8(sp)
800058d0:	c226                	sw	s1,4(sp)
800058d2:	842a                	mv	s0,a0
800058d4:	852e                	mv	a0,a1
800058d6:	c606                	sw	ra,12(sp)
800058d8:	0401a223          	sw	zero,68(gp) # 800f4a24 <errno>
800058dc:	a41fc0ef          	jal	8000231c <_close>
800058e0:	57fd                	li	a5,-1
800058e2:	00f50763          	beq	a0,a5,800058f0 <_close_r+0x24>
800058e6:	40b2                	lw	ra,12(sp)
800058e8:	4422                	lw	s0,8(sp)
800058ea:	4492                	lw	s1,4(sp)
800058ec:	0141                	add	sp,sp,16
800058ee:	8082                	ret
800058f0:	0441a783          	lw	a5,68(gp) # 800f4a24 <errno>
800058f4:	dbed                	beqz	a5,800058e6 <_close_r+0x1a>
800058f6:	40b2                	lw	ra,12(sp)
800058f8:	c01c                	sw	a5,0(s0)
800058fa:	4422                	lw	s0,8(sp)
800058fc:	4492                	lw	s1,4(sp)
800058fe:	0141                	add	sp,sp,16
80005900:	8082                	ret

80005902 <_fclose_r>:
80005902:	1141                	add	sp,sp,-16
80005904:	c606                	sw	ra,12(sp)
80005906:	c422                	sw	s0,8(sp)
80005908:	c226                	sw	s1,4(sp)
8000590a:	c04a                	sw	s2,0(sp)
8000590c:	c989                	beqz	a1,8000591e <_fclose_r+0x1c>
8000590e:	842e                	mv	s0,a1
80005910:	84aa                	mv	s1,a0
80005912:	c119                	beqz	a0,80005918 <_fclose_r+0x16>
80005914:	5d1c                	lw	a5,56(a0)
80005916:	cfa5                	beqz	a5,8000598e <_fclose_r+0x8c>
80005918:	00c41783          	lh	a5,12(s0)
8000591c:	eb89                	bnez	a5,8000592e <_fclose_r+0x2c>
8000591e:	40b2                	lw	ra,12(sp)
80005920:	4422                	lw	s0,8(sp)
80005922:	4901                	li	s2,0
80005924:	4492                	lw	s1,4(sp)
80005926:	854a                	mv	a0,s2
80005928:	4902                	lw	s2,0(sp)
8000592a:	0141                	add	sp,sp,16
8000592c:	8082                	ret
8000592e:	85a2                	mv	a1,s0
80005930:	8526                	mv	a0,s1
80005932:	e13fe0ef          	jal	80004744 <__sflush_r>
80005936:	545c                	lw	a5,44(s0)
80005938:	892a                	mv	s2,a0
8000593a:	c791                	beqz	a5,80005946 <_fclose_r+0x44>
8000593c:	4c4c                	lw	a1,28(s0)
8000593e:	8526                	mv	a0,s1
80005940:	9782                	jalr	a5
80005942:	04054c63          	bltz	a0,8000599a <_fclose_r+0x98>
80005946:	00c45783          	lhu	a5,12(s0)
8000594a:	0807f793          	and	a5,a5,128
8000594e:	efa1                	bnez	a5,800059a6 <_fclose_r+0xa4>
80005950:	580c                	lw	a1,48(s0)
80005952:	c991                	beqz	a1,80005966 <_fclose_r+0x64>
80005954:	04040793          	add	a5,s0,64
80005958:	00f58563          	beq	a1,a5,80005962 <_fclose_r+0x60>
8000595c:	8526                	mv	a0,s1
8000595e:	9eeff0ef          	jal	80004b4c <_free_r>
80005962:	02042823          	sw	zero,48(s0)
80005966:	406c                	lw	a1,68(s0)
80005968:	c591                	beqz	a1,80005974 <_fclose_r+0x72>
8000596a:	8526                	mv	a0,s1
8000596c:	9e0ff0ef          	jal	80004b4c <_free_r>
80005970:	04042223          	sw	zero,68(s0)
80005974:	8caff0ef          	jal	80004a3e <__sfp_lock_acquire>
80005978:	00041623          	sh	zero,12(s0)
8000597c:	8c4ff0ef          	jal	80004a40 <__sfp_lock_release>
80005980:	40b2                	lw	ra,12(sp)
80005982:	4422                	lw	s0,8(sp)
80005984:	4492                	lw	s1,4(sp)
80005986:	854a                	mv	a0,s2
80005988:	4902                	lw	s2,0(sp)
8000598a:	0141                	add	sp,sp,16
8000598c:	8082                	ret
8000598e:	8a8ff0ef          	jal	80004a36 <__sinit>
80005992:	00c41783          	lh	a5,12(s0)
80005996:	d7c1                	beqz	a5,8000591e <_fclose_r+0x1c>
80005998:	bf59                	j	8000592e <_fclose_r+0x2c>
8000599a:	00c45783          	lhu	a5,12(s0)
8000599e:	597d                	li	s2,-1
800059a0:	0807f793          	and	a5,a5,128
800059a4:	d7d5                	beqz	a5,80005950 <_fclose_r+0x4e>
800059a6:	480c                	lw	a1,16(s0)
800059a8:	8526                	mv	a0,s1
800059aa:	9a2ff0ef          	jal	80004b4c <_free_r>
800059ae:	b74d                	j	80005950 <_fclose_r+0x4e>

800059b0 <_lseek_r>:
800059b0:	1141                	add	sp,sp,-16
800059b2:	872e                	mv	a4,a1
800059b4:	c422                	sw	s0,8(sp)
800059b6:	c226                	sw	s1,4(sp)
800059b8:	85b2                	mv	a1,a2
800059ba:	842a                	mv	s0,a0
800059bc:	8636                	mv	a2,a3
800059be:	853a                	mv	a0,a4
800059c0:	c606                	sw	ra,12(sp)
800059c2:	0401a223          	sw	zero,68(gp) # 800f4a24 <errno>
800059c6:	9a7fc0ef          	jal	8000236c <_lseek>
800059ca:	57fd                	li	a5,-1
800059cc:	00f50763          	beq	a0,a5,800059da <_lseek_r+0x2a>
800059d0:	40b2                	lw	ra,12(sp)
800059d2:	4422                	lw	s0,8(sp)
800059d4:	4492                	lw	s1,4(sp)
800059d6:	0141                	add	sp,sp,16
800059d8:	8082                	ret
800059da:	0441a783          	lw	a5,68(gp) # 800f4a24 <errno>
800059de:	dbed                	beqz	a5,800059d0 <_lseek_r+0x20>
800059e0:	40b2                	lw	ra,12(sp)
800059e2:	c01c                	sw	a5,0(s0)
800059e4:	4422                	lw	s0,8(sp)
800059e6:	4492                	lw	s1,4(sp)
800059e8:	0141                	add	sp,sp,16
800059ea:	8082                	ret

800059ec <__smakebuf_r>:
800059ec:	00c59783          	lh	a5,12(a1)
800059f0:	7119                	add	sp,sp,-128
800059f2:	dca2                	sw	s0,120(sp)
800059f4:	de86                	sw	ra,124(sp)
800059f6:	daa6                	sw	s1,116(sp)
800059f8:	d8ca                	sw	s2,112(sp)
800059fa:	d6ce                	sw	s3,108(sp)
800059fc:	d4d2                	sw	s4,104(sp)
800059fe:	0027f713          	and	a4,a5,2
80005a02:	842e                	mv	s0,a1
80005a04:	cf19                	beqz	a4,80005a22 <__smakebuf_r+0x36>
80005a06:	04358793          	add	a5,a1,67
80005a0a:	c19c                	sw	a5,0(a1)
80005a0c:	c99c                	sw	a5,16(a1)
80005a0e:	4785                	li	a5,1
80005a10:	c9dc                	sw	a5,20(a1)
80005a12:	50f6                	lw	ra,124(sp)
80005a14:	5466                	lw	s0,120(sp)
80005a16:	54d6                	lw	s1,116(sp)
80005a18:	5946                	lw	s2,112(sp)
80005a1a:	59b6                	lw	s3,108(sp)
80005a1c:	5a26                	lw	s4,104(sp)
80005a1e:	6109                	add	sp,sp,128
80005a20:	8082                	ret
80005a22:	00e59583          	lh	a1,14(a1)
80005a26:	84aa                	mv	s1,a0
80005a28:	0605c763          	bltz	a1,80005a96 <__smakebuf_r+0xaa>
80005a2c:	0030                	add	a2,sp,8
80005a2e:	2219                	jal	80005b34 <_fstat_r>
80005a30:	06054163          	bltz	a0,80005a92 <__smakebuf_r+0xa6>
80005a34:	47b2                	lw	a5,12(sp)
80005a36:	693d                	lui	s2,0xf
80005a38:	6985                	lui	s3,0x1
80005a3a:	00f97933          	and	s2,s2,a5
80005a3e:	77f9                	lui	a5,0xffffe
80005a40:	993e                	add	s2,s2,a5
80005a42:	00193913          	seqz	s2,s2
80005a46:	40000a13          	li	s4,1024
80005a4a:	80098993          	add	s3,s3,-2048 # 800 <_reset_entry-0x7ffff800>
80005a4e:	85d2                	mv	a1,s4
80005a50:	8526                	mv	a0,s1
80005a52:	b9aff0ef          	jal	80004dec <_malloc_r>
80005a56:	00c41783          	lh	a5,12(s0)
80005a5a:	cd21                	beqz	a0,80005ab2 <__smakebuf_r+0xc6>
80005a5c:	80005737          	lui	a4,0x80005
80005a60:	8f870713          	add	a4,a4,-1800 # 800048f8 <_cleanup_r>
80005a64:	dcd8                	sw	a4,60(s1)
80005a66:	0807e793          	or	a5,a5,128
80005a6a:	00f41623          	sh	a5,12(s0)
80005a6e:	c008                	sw	a0,0(s0)
80005a70:	c808                	sw	a0,16(s0)
80005a72:	01442a23          	sw	s4,20(s0)
80005a76:	06091163          	bnez	s2,80005ad8 <__smakebuf_r+0xec>
80005a7a:	0137e7b3          	or	a5,a5,s3
80005a7e:	50f6                	lw	ra,124(sp)
80005a80:	00f41623          	sh	a5,12(s0)
80005a84:	5466                	lw	s0,120(sp)
80005a86:	54d6                	lw	s1,116(sp)
80005a88:	5946                	lw	s2,112(sp)
80005a8a:	59b6                	lw	s3,108(sp)
80005a8c:	5a26                	lw	s4,104(sp)
80005a8e:	6109                	add	sp,sp,128
80005a90:	8082                	ret
80005a92:	00c41783          	lh	a5,12(s0)
80005a96:	0807f793          	and	a5,a5,128
80005a9a:	4901                	li	s2,0
80005a9c:	cb95                	beqz	a5,80005ad0 <__smakebuf_r+0xe4>
80005a9e:	04000a13          	li	s4,64
80005aa2:	85d2                	mv	a1,s4
80005aa4:	8526                	mv	a0,s1
80005aa6:	b46ff0ef          	jal	80004dec <_malloc_r>
80005aaa:	00c41783          	lh	a5,12(s0)
80005aae:	4981                	li	s3,0
80005ab0:	f555                	bnez	a0,80005a5c <__smakebuf_r+0x70>
80005ab2:	2007f713          	and	a4,a5,512
80005ab6:	ff31                	bnez	a4,80005a12 <__smakebuf_r+0x26>
80005ab8:	9bf1                	and	a5,a5,-4
80005aba:	0027e793          	or	a5,a5,2
80005abe:	04340713          	add	a4,s0,67
80005ac2:	00f41623          	sh	a5,12(s0)
80005ac6:	4785                	li	a5,1
80005ac8:	c018                	sw	a4,0(s0)
80005aca:	c818                	sw	a4,16(s0)
80005acc:	c85c                	sw	a5,20(s0)
80005ace:	b791                	j	80005a12 <__smakebuf_r+0x26>
80005ad0:	40000a13          	li	s4,1024
80005ad4:	4981                	li	s3,0
80005ad6:	bfa5                	j	80005a4e <__smakebuf_r+0x62>
80005ad8:	00e41583          	lh	a1,14(s0)
80005adc:	8526                	mv	a0,s1
80005ade:	2841                	jal	80005b6e <_isatty_r>
80005ae0:	e501                	bnez	a0,80005ae8 <__smakebuf_r+0xfc>
80005ae2:	00c41783          	lh	a5,12(s0)
80005ae6:	bf51                	j	80005a7a <__smakebuf_r+0x8e>
80005ae8:	00c45783          	lhu	a5,12(s0)
80005aec:	9bf1                	and	a5,a5,-4
80005aee:	0017e793          	or	a5,a5,1
80005af2:	07c2                	sll	a5,a5,0x10
80005af4:	87c1                	sra	a5,a5,0x10
80005af6:	b751                	j	80005a7a <__smakebuf_r+0x8e>

80005af8 <_read_r>:
80005af8:	1141                	add	sp,sp,-16
80005afa:	872e                	mv	a4,a1
80005afc:	c422                	sw	s0,8(sp)
80005afe:	c226                	sw	s1,4(sp)
80005b00:	85b2                	mv	a1,a2
80005b02:	842a                	mv	s0,a0
80005b04:	8636                	mv	a2,a3
80005b06:	853a                	mv	a0,a4
80005b08:	c606                	sw	ra,12(sp)
80005b0a:	0401a223          	sw	zero,68(gp) # 800f4a24 <errno>
80005b0e:	883fc0ef          	jal	80002390 <_read>
80005b12:	57fd                	li	a5,-1
80005b14:	00f50763          	beq	a0,a5,80005b22 <_read_r+0x2a>
80005b18:	40b2                	lw	ra,12(sp)
80005b1a:	4422                	lw	s0,8(sp)
80005b1c:	4492                	lw	s1,4(sp)
80005b1e:	0141                	add	sp,sp,16
80005b20:	8082                	ret
80005b22:	0441a783          	lw	a5,68(gp) # 800f4a24 <errno>
80005b26:	dbed                	beqz	a5,80005b18 <_read_r+0x20>
80005b28:	40b2                	lw	ra,12(sp)
80005b2a:	c01c                	sw	a5,0(s0)
80005b2c:	4422                	lw	s0,8(sp)
80005b2e:	4492                	lw	s1,4(sp)
80005b30:	0141                	add	sp,sp,16
80005b32:	8082                	ret

80005b34 <_fstat_r>:
80005b34:	1141                	add	sp,sp,-16
80005b36:	872e                	mv	a4,a1
80005b38:	c422                	sw	s0,8(sp)
80005b3a:	c226                	sw	s1,4(sp)
80005b3c:	842a                	mv	s0,a0
80005b3e:	85b2                	mv	a1,a2
80005b40:	853a                	mv	a0,a4
80005b42:	c606                	sw	ra,12(sp)
80005b44:	0401a223          	sw	zero,68(gp) # 800f4a24 <errno>
80005b48:	fdcfc0ef          	jal	80002324 <_fstat>
80005b4c:	57fd                	li	a5,-1
80005b4e:	00f50763          	beq	a0,a5,80005b5c <_fstat_r+0x28>
80005b52:	40b2                	lw	ra,12(sp)
80005b54:	4422                	lw	s0,8(sp)
80005b56:	4492                	lw	s1,4(sp)
80005b58:	0141                	add	sp,sp,16
80005b5a:	8082                	ret
80005b5c:	0441a783          	lw	a5,68(gp) # 800f4a24 <errno>
80005b60:	dbed                	beqz	a5,80005b52 <_fstat_r+0x1e>
80005b62:	40b2                	lw	ra,12(sp)
80005b64:	c01c                	sw	a5,0(s0)
80005b66:	4422                	lw	s0,8(sp)
80005b68:	4492                	lw	s1,4(sp)
80005b6a:	0141                	add	sp,sp,16
80005b6c:	8082                	ret

80005b6e <_isatty_r>:
80005b6e:	1141                	add	sp,sp,-16
80005b70:	c422                	sw	s0,8(sp)
80005b72:	c226                	sw	s1,4(sp)
80005b74:	842a                	mv	s0,a0
80005b76:	852e                	mv	a0,a1
80005b78:	c606                	sw	ra,12(sp)
80005b7a:	0401a223          	sw	zero,68(gp) # 800f4a24 <errno>
80005b7e:	fcefc0ef          	jal	8000234c <_isatty>
80005b82:	57fd                	li	a5,-1
80005b84:	00f50763          	beq	a0,a5,80005b92 <_isatty_r+0x24>
80005b88:	40b2                	lw	ra,12(sp)
80005b8a:	4422                	lw	s0,8(sp)
80005b8c:	4492                	lw	s1,4(sp)
80005b8e:	0141                	add	sp,sp,16
80005b90:	8082                	ret
80005b92:	0441a783          	lw	a5,68(gp) # 800f4a24 <errno>
80005b96:	dbed                	beqz	a5,80005b88 <_isatty_r+0x1a>
80005b98:	40b2                	lw	ra,12(sp)
80005b9a:	c01c                	sw	a5,0(s0)
80005b9c:	4422                	lw	s0,8(sp)
80005b9e:	4492                	lw	s1,4(sp)
80005ba0:	0141                	add	sp,sp,16
80005ba2:	8082                	ret
