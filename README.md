### asm shit

experiments with asm and elf64 format
requires linux, nasm and feh image viewer

build with gnu as (minimum binary size 752 bytes on my machine):

```
bash$ as main.s -o main1.o -no-pad-sections --strip-local-absolute && ld main1.o -o h -s -N -z max-page-size=1024 && ./h && feh --auto-zoom a.ppm
```

build & run (nasm): 

```
bash$ nasm -felf64 main.asm && ld main.o  &&./a.out && feh i.ppm
```

