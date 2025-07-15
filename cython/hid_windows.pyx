cimport chid
import uuid

cdef class device(chid.device):
    def winapi_get_container_id(self):
        if self._c_hid == NULL:
            raise ValueError('not open')
        cdef int r
        cdef GUID id
        with nogil:
            r = hid_winapi_get_container_id(self._c_hid, &id)
        if r < 0:
            raise IOError('get container id')
        buf = bytearray(16)
        buf[0] = id.Data1 >> 24
        buf[1] = id.Data1 >> 16
        buf[2] = id.Data1 >> 8
        buf[3] = id.Data1 >> 0
        buf[4] = id.Data2 >> 8
        buf[5] = id.Data2 >> 0
        buf[6] = id.Data3 >> 8
        buf[7] = id.Data3 >> 0
        for i in range(8):
            buf[8 + i] = id.Data4[i]
        return uuid.UUID(bytes=buf)

    def winapi_set_write_timeout(self, timeout):
        hid_winapi_set_write_timeout(self._c_hid, timeout)
