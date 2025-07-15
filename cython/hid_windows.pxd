from libc.stddef cimport size_t
from chidapi cimport hid_device

cdef extern from "<guiddef.h>":
    ctypedef struct GUID:
        unsigned long  Data1
        unsigned short Data2
        unsigned short Data3
        unsigned char  Data4[8]

cdef extern from "<hidapi_winapi.h>":
    int hid_winapi_get_container_id(hid_device *dev, GUID *container_id) nogil
    int hid_winapi_descriptor_reconstruct_pp_data(void *hidp_preparsed_data, unsigned char *buf, size_t buf_size)
    void hid_winapi_set_write_timeout(hid_device *dev, unsigned long timeout)
