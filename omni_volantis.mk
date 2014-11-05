# Release name
PRODUCT_RELEASE_NAME := volantis

# Inherit device configuration
$(call inherit-product, device/nvidia/volantis/device.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := volantis
PRODUCT_NAME := omni_volantis
PRODUCT_BRAND := nvidia
PRODUCT_MODEL := volantis
PRODUCT_MANUFACTURER := nvidia
