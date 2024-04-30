USER = ingalless
KEYBOARDS = v60_type_r

# keyboard name
NAME_v60_type_r = v60_type_r

all: $(KEYBOARDS)

.PHONY: $(KEYBOARDS)
$(KEYBOARDS):
	# init submodule
	git submodule update --init --recursive
	git submodule update --remote
	# git submodule foreach make git-submodule 

	# cleanup old symlinks
	rm -rf qmk_firmware/keyboards/v60_type_r/keymaps/$(USER)

	# add new symlinks
	ln -s $(shell pwd)/v60_type_r qmk_firmware/keyboards/v60_type_r/keymaps/$(USER)

	# run lint check
	# cd qmk_firmware; qmk lint -km $(USER) -kb $(NAME_$@)

	# run build
	make BUILD_DIR=$(shell pwd)/build -j1 -C qmk_firmware $(NAME_$@):$(USER)

	# cleanup symlinks
	rm -rf qmk_firmware/keyboards/v60_type_r/keymaps/$(USER)

clean:
	rm -rf qmk_firmware/keyboards/v60_type_r/keymaps/$(USER)
	rm -rf qmk_firmware/users/$(USER)
	rm -rf ./build/
	rm -rf ./qmk-config-totem/
	rm -rf ./qmk_firmware/
