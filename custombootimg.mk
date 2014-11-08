MKBOOTIMG_BIN := out/host/linux-x86/bin/mkbootimg
MKBOOTFS := out/host/linux-x86/bin/mkbootfs

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) \
		$(recovery_ramdisk) \
		$(recovery_kernel)
	@echo ----- Creating ramdisk ------
	rm out/target/product/volantis/recovery/root/init
	cp device/nvidia/volantis/recovery/init out/target/product/volantis/recovery/root/init
	chmod 644 out/target/product/volantis/recovery/root/init
	$(MKBOOTFS) $(TARGET_RECOVERY_ROOT_OUT) > $@ 
	$(MINIGZIP) < $(recovery_uncompressed_ramdisk) > $@
	@echo ----- Making recovery image ------
	$(MKBOOTIMG_BIN) --kernel $(TARGET_PREBUILT_KERNEL) --ramdisk $(recovery_ramdisk) --base $(BOARD_KERNEL_BASE) --pagesize $(BOARD_KERNEL_PAGESIZE) $(BOARD_MKBOOTIMG_ARGS) --output $@
	@echo ----- Made recovery image -------- $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)


$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES)
	$(call pretty,"Target boot image: $@")
	$(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) --output $@
	#$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
