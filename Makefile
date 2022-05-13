CC65 = cc65
CA65 = ca65
LD65 = ld65
NAME = game
CFG = nrom_32k_vert.cfg
BUILD_DIR = build

.PHONY: default clean

default: $(NAME).nes

$(NAME).nes: $(NAME).o crt0.o $(CFG)
	$(LD65) -C $(CFG) -o $(BUILD_DIR)/$(NAME).nes crt0.o $(NAME).o nes.lib -Ln $(BUILD_DIR)/labels.txt --dbgfile $(BUILD_DIR)/dbg.txt
	rm *.o
	@echo $(BUILD_DIR)/$(NAME).nes created

crt0.o: crt0.s Alpha.chr
	$(CA65) crt0.s

$(NAME).o: $(NAME).s
	$(CA65) $(NAME).s -g
	rm $(NAME).s

$(NAME).s: $(NAME).c
	$(CC65) -Oirs $(NAME).c --add-source

clean:
	rm $(BUILD_DIR)/*
	rm *.o > /dev/null
