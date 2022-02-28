kernel_source_files := $(shell find src/kernel -name *.c)
kernel_object_files := $(patsubst src/kernel/%.c, build/kernel/%.o, $(kernel_source_files))

x86_64_c_source_files := $(shell find src/x86_64 -name *.c)
x86_64_c_object_files := $(patsubst src/x86_64/%.c, build/x86_64/%.o, $(x86_64_c_source_files))

x86_64_asm_source_files := $(shell find src/x86_64 -name *.asm)
x86_64_asm_object_files := $(patsubst src/x86_64%.asm, build/x86_64/%.o, $(x86_64_asm_source_files))

x86_64_object_files := $(x86_64_c_object_files) $(x86_64_asm_object_files)

$(kernel_object_files): build/kernel/%.o : src/kernel/%.c
	mkdir -p $(dir $@) && \
	x86_64-elf-gcc -c -I include -ffreestanding $(patsubst build/kernel/%.o, src/kernel/%.c, $@) -o $@

$(x86_64_c_object_files): build/x86_64/%.o : src/x86_64/%.c
	mkdir -p $(dir $@) && \
	x86_64-elf-gcc -c -I include -ffreestanding $(patsubst build/x86_64/%.o, src/x86_64/%.c, $@) -o $@

$(x86_64_asm_object_files): build/x86_64/%.o : src/x86_64/%.asm
	mkdir -p $(dir $@) && \
	nasm -f elf64 $(patsubst build/x86_64/%.o, src/x86_64/%.asm, $@) -o $@

.PHONY: build-x86_64
build-x86_64: $(kernel_object_files) $(x86_64_object_files)
	mkdir -p dist/x86_64 && \
	x86_64-elf-ld -n -o dist/x86_64/kernel.bin -T targets/x86_64/linker.ld $(kernel_object_files) $(x86_64_object_files) && \
	cp dist/x86_64/kernel.bin targets/x86_64/iso/boot/kernel.bin && \
	grub-mkrescue /usr/lib/grub/i386-pc -o dist/x86_64/kernel.iso targets/x86_64/iso