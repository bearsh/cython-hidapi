from chidapi cimport hid_device

cdef extern from "<hidapi_darwin.h>":
    int hid_darwin_get_location_id (hid_device *dev, unsigned *location_id)
    void hid_darwin_set_open_exclusive(int open_exclusive)
    int hid_darwin_get_open_exclusive()
    int hid_darwin_is_device_open_exclusive(hid_device *dev)
