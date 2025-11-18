# kernel
My own experimental kernel. [i386 architecture]

Iso Compile Depencies
```
sudo pacman -S mtools
sudo pacman -S extra/libisoburn
```

VirtualBox Kernel Modules Setup
```
sudo pacman -S linux-headers linux612-headers linux612-virtualbox-host-modules 
sudo /sbin/vboxconfig
sudo modprobe vboxdrv
sudo usermod -aG vboxusers $(whoami)
```

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
