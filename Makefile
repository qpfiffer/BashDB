SOURCE_DIR=./src/
SOURCE_FILES=$(ls ./src/*.sh | grep -v main.sh | grep -v header.sh)
OUTPUT=./bashdb
INSTALLDEST=/usr/local/bin


all: bashdb

install: all
	install $(OUTPUT) /usr/local/bin/$(OUTPUT)

uninstall:
	rm /usr/local/bin/$(OUTPUT)

clean:
	rm ./*.o
	rm $(OUTPUT)

%.o: $(SOURCE_DIR)%.sh
	@echo "bcc -O2 $<"
	@cp $< $@

bashdb: utils.o set.o get.o usage.o
	@cat $(SOURCE_DIR)header.sh $^ $(SOURCE_DIR)main.sh > $(OUTPUT)
	@chmod +x $(OUTPUT)
	@echo "[ ----- Hold onto your pants ----- ]"
