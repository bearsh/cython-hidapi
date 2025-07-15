from chidapi cimport *

cdef class device:
    cdef hid_device *_c_hid
    cdef object __weakref__  # enable weak-reference support
    cdef object _close

cdef class _closer:
    cdef hid_device *_ptr

    @staticmethod
    cdef wrap(hid_device *ptr)
