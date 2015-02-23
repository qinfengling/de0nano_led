DESIGN_NAME=basics

all: build pgm 

build: output_files/$(DESIGN_NAME).sof

pgm: output_files/$(DESIGN_NAME).sof
	quartus_pgm --mode=jtag -o p\;output_files/$(DESIGN_NAME).sof

sta: asm
	quartus_sta $(DESIGN_NAME)

output_files/$(DESIGN_NAME).sof: output_files/$(DESIGN_NAME).fit.rpt
	quartus_asm $(DESIGN_NAME)

output_files/$(DESIGN_NAME).fit.rpt: output_files/$(DESIGN_NAME).map.rpt
	quartus_fit $(DESIGN_NAME)

output_files/$(DESIGN_NAME).map.rpt: $(DESIGN_NAME).qpf
	quartus_map $(DESIGN_NAME)

$(DESIGN_NAME).qpf: basics.tcl basics.v
	quartus_sh -t basics.tcl

clean:
	@rm -rf db incremental_db output_files
	@rm -rf *.qpf *.qsf *.summary *.rpt *.qdf
