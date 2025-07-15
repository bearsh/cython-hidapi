cimport chid

def darwin_set_open_exclusive(int open_exclusive=1):
    """Set open exclusive on macOS.

    :param open_exclusive: When set to 0 - all further devices will be opened
                           in non-exclusive mode. Otherwise - all further devices
                           will be opened in exclusive mode. Default = 1
    """

    cdef int exclusive = open_exclusive
    hid_darwin_set_open_exclusive(exclusive)

def darwin_get_open_exclusive():
    """Get open exclusive on macOS.

    :return: 1 if all further devices will be opened in exclusive mode.
    :rtype: int
    """
    return hid_darwin_get_open_exclusive()

cdef class device(chid.device):
    def darwin_get_location_id(self):
        """Return location id on macOS.

        :return:
        :rtype: int
        :raises ValueError: If connection is not opened.
        :raises IOError:
        """
        if self._c_hid == NULL:
            raise ValueError('not open')
        cdef unsigned int location_id
        cdef int r = hid_darwin_get_location_id(self._c_hid, &location_id)
        if r < 0:
            raise IOError('get darwin location id error')
        return location_id

    def darwin_is_device_open_exclusive(self):
        """Check if the given device is opened in exclusive mode on macOS.

        :param dev: Device class
        :return: 1 if the device is opened in exclusive mode, 0 - opened in non-exclusive,
                -1 - if dev is invalid.
        :rtype: int
        :raises ValueError: If connection is not opened.
        """
        if self._c_hid == NULL:
            raise ValueError('not open')
        return hid_darwin_is_device_open_exclusive(self._c_hid)
