from sys import stderr
from platform import system
from chid import __version__ as _version
from chid import *

__all__ = ["enumerate", "version_str", "device"]
__version__ = _version

if system() == "Linux":
    import importlib.util

    hidraw_spec = importlib.util.find_spec("chidraw")
    if hidraw_spec is not None:
        try:
            from hid_linux import *
        except ImportError:
            print("hidapi: libusb does not provide hid_libusb_wrap_sys_device() function", file=stderr)

elif system() == "Darwin":
    from hid_darwin import *

    __all__.append("darwin_set_open_exclusive")
    __all__.append("darwin_get_open_exclusive")

elif system() == "Windows":
    from hid_windows import *
