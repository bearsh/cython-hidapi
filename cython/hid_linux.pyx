import weakref

cimport chid

cdef class device(chid.device):
    def libusb_wrap_sys_device(self, sys_dev, interface_num):
        """Open connection by path.

        :param path: Path to device
        :type path: bytes
        :raises IOError:
        """
        if self._c_hid != NULL:
            raise RuntimeError('already open')
        self._c_hid = hid_libusb_wrap_sys_device(sys_dev, interface_num)
        if self._c_hid == NULL:
            raise IOError('open failed')
        self._close = weakref.finalize(self, chid._closer.wrap(self._c_hid).close)
