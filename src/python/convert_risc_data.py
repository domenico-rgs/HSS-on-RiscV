import struct

# Definisci le dimensioni della matrice e del blocco di lettura
ROW_SIZE = 512
MATRIX_ROWS = 64
MATRIX_COLS = 4

# Apri il file in lettura binaria
with open("res_risc.bin", "rb") as file:
    # Apri il file in scrittura
    with open("output_risc.txt", "w") as output_file:
        # Leggi il file a blocchi da 512 byte
        while True:
            row = file.read(ROW_SIZE)
            if not row:
                break
            
            # Converte i valori int16 e li memorizza nella matrice
            matrix = []
            for i in range(MATRIX_ROWS):
                row_start = i * MATRIX_COLS * 2
                row_end = row_start + MATRIX_COLS * 2
                row_values = struct.unpack("<" + "h" * MATRIX_COLS, row[row_start:row_end])
                matrix.append(list(row_values))
                
            # Scrivi la matrice su file
            for row in matrix:
                output_file.write(" ".join(str(value) for value in row))
                output_file.write("\n")
