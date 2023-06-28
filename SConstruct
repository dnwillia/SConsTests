# This works with the site_scons modifications to the gfortran tool
# Passing --warning=all produces the following warning:
#  scons: warning: Cannot find target TestSConscript/module_two.mod after building
# If I add this change to the gfortran tool the warning is gone:
#   env["FORTRANMODDIR"] = "${TARGET.dir}"
import os

module_name = "TestSConscript"
sconscript = os.path.join(module_name, "SConscript")
SConscript(sconscript)
