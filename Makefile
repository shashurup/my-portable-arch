SOURCES = $(shell find config)
ISO = releng/out/archlinux*.iso

all: $(ISO)

/usr/share/archiso/configs/releng/build.sh:
	pacman -S archiso

releng/build.sh: /usr/share/archiso/configs/releng/build.sh
	cp -r /usr/share/archiso/configs/releng ./

clean:
	rm -rf releng

$(ISO): $(SOURCES) releng/build.sh
	cp -r config/* releng/ ; cd releng ; rm -f work/build.make_* ; ./build.sh -v ; cd -

print:
	echo $(ISO) $(SOURCES)
