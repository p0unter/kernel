GPPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore -fno-stack-protector
ASPARAMS = --32
LDPARAMS = -melf_i386

objects = loader.o gdt.o kernel.o

all: mykernel.bin

loader.o: loader.s
	as $(ASPARAMS) -o loader.o loader.s

gdt.o: gdt.cpp
	g++ $(GPPPARAMS) -o gdt.o -c gdt.cpp

kernel.o: kernel.cpp
	g++ $(GPPPARAMS) -o kernel.o -c kernel.cpp

mykernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T linker.ld -o mykernel.bin $(objects)

install: mykernel.bin
	sudo cp mykernel.bin /boot/mykernel.bin

mykernel.iso: mykernel.bin
	mkdir -p iso/boot/grub
	cp mykernel.bin iso/boot/
	echo 'set timeout=0' > iso/boot/grub/grub.cfg
	echo 'set default=0' >> iso/boot/grub/grub.cfg
	echo '' >> iso/boot/grub/grub.cfg
	echo 'menuentry "My Experimental Kernel" {' >> iso/boot/grub/grub.cfg
	echo '  multiboot /boot/mykernel.bin' >> iso/boot/grub/grub.cfg
	echo '  boot' >> iso/boot/grub/grub.cfg
	echo '}' >> iso/boot/grub/grub.cfg
	grub-mkrescue --output=mykernel.iso iso
	rm -rf iso

run: mykernel.iso
	(killall VirtualBox && sleep 1) || true
	VirtualBoxVM --startvm "kernel" &

clean:
	rm -f $(objects) mykernel.bin mykernel.iso

.PHONY: all install run clean
