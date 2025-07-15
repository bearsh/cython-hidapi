from libc.stdint cimport intptr_t
from chidapi cimport hid_device

cdef extern from "<hidapi_libusb.h>":
    hid_device* hid_libusb_wrap_sys_device(intptr_t sys_dev, int interface_num)
