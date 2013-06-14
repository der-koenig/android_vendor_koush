# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := Superuser_koush_prebuilt
LOCAL_MODULE_STEM := Superuser
LOCAL_SRC_FILES := prebuilt/Superuser.apk
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .apk
LOCAL_MODULE_CLASS := APPS
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)

LOCAL_MODULE := su_koush_prebuilt
LOCAL_MODULE_STEM := su
ifeq ($(TARGET_ARCH),arm)
    LOCAL_SRC_FILES := prebuilt/armeabi/su
endif
ifeq ($(TARGET_ARCH),x86)
    LOCAL_SRC_FILES := prebuilt/x86/su
endif
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)

COMMANDS := su
SYMLINKS := $(addprefix $(TARGET_OUT_EXECUTABLES)/,$(COMMANDS))
$(SYMLINKS): SU_BINARY := /system/xbin/su
$(SYMLINKS): $(LOCAL_INSTALLED_MODULE) $(LOCAL_PATH)/Android.mk
	@echo "Symlink: $@ -> $(SU_BINARY)"
	@mkdir -p $(dir $@)
	$(hide) ln -sf $(SU_BINARY) $@

ALL_DEFAULT_INSTALLED_MODULES += $(SYMLINKS)
include $(BUILD_PREBUILT)
