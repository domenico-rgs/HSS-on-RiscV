import serial
import signal
import sys

ser = serial.Serial('/dev/ttyUSB1', 9600, bytesize=serial.EIGHTBITS, stopbits=serial.STOPBITS_ONE, parity=serial.PARITY_EVEN, timeout=15) # specificare la porta seriale e il baudrate
batch_size = 512 # dimensione del batch in bytes
#file = open("res_risc.bin", "wb")

try:
    print("Streaming...")

    with open('test_data.bin', 'rb') as f:
        while True: #i<5
            data = f.read(batch_size) # leggere i dati dal file a blocchi di 512 byte
            if not data: # uscire dal ciclo se non ci sono più dati da leggere dal file
                break
            ser.write(data) # inviare i dati sulla porta seriale

            #data=ser.read(4*64*2)
            #file.write(data)
            data = ser.readline().decode('utf-8') #legge stringa con tempo di esecuzione
            print(data,end='')

            signal = ser.read() # attendere un segnale dal consumatore
            while signal != b'\x01': # se il segnale non è valido, attendere fino a quando non si riceve il segnale corretto
                signal = ser.read()

except KeyboardInterrupt:
    print('\nProgram interrupted, closure in progress (waiting for last data)...\n') # Interruzione del programma con CTRL+C
    data = ser.readline().decode('utf-8') #legge stringa con tempo di esecuzione
    if data:
        print(data,end='')
finally:
    ser.close()
    #file.close()

