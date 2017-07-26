all: iso

/usr/share/archiso/configs/releng/build.sh:
	sudo pacman -S archiso

releng/build.sh: /usr/share/archiso/configs/releng/build.sh
	cp -r /usr/share/archiso/configs/releng ./

clean:
	rm -rf releng

iso: releng/build.sh
	cp -r config/* releng/ ; cd releng ; su -c './build.sh -v' ; cd -
