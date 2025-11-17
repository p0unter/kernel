# kernel
My own experimental kernel. [i386 architecture]

Compile Object Files :
```
make kernel.o
make loader.o
make mykernel.bin
make install # load /boot/mykernel.bin
```

/boot/grub/grub.cfg :
```
menuenty 'Pounter Kernel' {
    multiboot /boot/mykernel.bin
    boot
}
```
