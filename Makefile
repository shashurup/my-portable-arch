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
	cp -r config/* releng/
	cp /etc/pacman.conf releng/
	echo 'MODULES=(i915 amdgpu nouveau)' >> releng/mkinitcpio.conf
	rm -f releng/work/build.make_*
	cd releng ; ./build.sh -v ; cd -

usbstick: $(ISO)
	mkdir -p usbstick/arch/boot ; \
	cp -r releng/work/iso/arch/x86_64 usbstick/arch/ ; \
	cp -r releng/work/iso/arch/boot/x86_64 usbstick/arch/boot/
