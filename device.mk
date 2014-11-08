DEVICE_PACKAGE_OVERLAYS += device/nvidia/volantis/overlay

LOCAL_PATH := device/nvidia/volantis
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernAl
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/selinux/file_contexts:recovery/root/prebuilt_file_contexts \
	$(LOCAL_PATH)/twrp.fstab:recovery/root/etc/twrp.fstab \
	$(LOCAL_PATH)/init.recovery.flounder.rc:root/init.recovery.flounder.rc

$(call inherit-product, build/target/product/full.mk)

PRODUCT_NAME := nvidia_volantis
PRODUCT_BRAND := Nvidia

include $(CLEAR_VARS)
LOCAL_MODULE := init2
LOCAL_OVERRIDE_PACKAGES := init
