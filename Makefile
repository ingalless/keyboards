USER = ingalless
KEYBOARDS = ferris

# keyboard name
NAME_v60_type_r = v60_type_r
NAME_ferris = ferris

all: $(KEYBOARDS)

.PHONY: $(KEYBOARDS)
$(KEYBOARDS):
	# init submodule
	git submodule update --init --recursive
	git submodule update --remote
	# git submodule foreach make git-submodule 

	# cleanup old symlinks
	rm -rf qmk_firmware/keyboards/ferris/keymaps/$(USER)


	# add new symlinks
	ln -s $(shell pwd)/ferris qmk_firmware/keyboards/ferris/keymaps/$(USER)
	ls qmk_firmware/keyboards/ferris/keymaps/$(USER)

	# Compile firmware
	# cd qmk_firmware && qmk compile $(shell pwd)/qmk_firmware/keyboards/ferris/keymaps/keymap.json

	# run lint check
	# cd qmk_firmware; qmk lint -km $(USER) -kb $(NAME_$@)

	# run build
	make BUILD_DIR=$(shell pwd)/build -j1 -C qmk_firmware $(NAME_$@):$(USER)

	# cleanup symlinks
	rm -rf qmk_firmware/keyboards/ferris/keymaps/$(USER)

clean:
	rm -rf qmk_firmware/keyboards/ferris/keymaps/$(USER)
	rm -rf qmk_firmware/users/$(USER)
	rm -rf ./build/
	rm -rf ./qmk-config-totem/
	rm -rf ./qmk_firmware/
