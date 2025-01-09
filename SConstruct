import os
import sys

env = DefaultEnvironment()

# SCons configures gfortran by default, tell it where it is.
if sys.platform == "win32":
    env.PrependENVPath(
        "PATH", os.path.join("C:", os.path.sep, "ANSYSDev", "MinGW", "bin")
    )
elif sys.platform == "linux":
    env.PrependENVPath("PATH", os.path.join(os.path.sep, "opt", "anss", "bin"))

env.Export("env")

module_name = "TestSConscript"
sconscript = os.path.join(module_name, "SConscript")
env.SConscript(sconscript)
