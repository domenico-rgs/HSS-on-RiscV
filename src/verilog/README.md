## Instructions to build the project on Vivado
1. Create a new empty project.
2. Add the constraints xdc file in the constraints/ folder (Nexys4 DDR or Nexys Video) or adapt your similarly to the former.
3. Add the IPs within their respective folders to the project, eventually upgrading them (sources properties) according to your board.
4. Add all the .v files in the src/ and sim/ directories, the latter have to be moved to simulation by selecting them within the project and then by right-clicking.

The files within the data_files/ directory contain all the coefficients, for the filters and other modules.

(! when adding files to the project, deselect the option to make a copy in the project directory)