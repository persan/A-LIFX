import os
import glob
import re
from os.path import *
import sys


def getNames():
    matcher_1 = re.compile(r"\s+type\s+(\S+?)_Message\s+is\s+new\s+Message\s*.*", re.I)
    matcher_2 = re.compile(r"^\s*package\s+(\S+)\s+.*", re.I)
    names = []
    for i in glob.glob(join(dirname(__file__), "src/lifx-messages-*.ads")):
        with file(i) as inf:
            for line in inf:
                matches = matcher_2.match(line)
                if matches:
                    pkg = matches.group(1)

                matches = matcher_1.match(line)
                if matches:
                    names.append({"pkg": pkg, "name": matches.group(1)})
    return names


def ada2file(s):
    return s.replace(".", "-").lower()


def printSpec(Unitname, names):
    with file(join(dirname(__file__), "src", ada2file(Unitname))+".ads", "w") as outf:
        with file("LICENSE") as inf:
			outf.write(inf.read())
        outf.write("--  ---------------------------------------------------------------\n")
        outf.write("--  This package is automaticly generated do not edit by hand\n")
        outf.write("--  ---------------------------------------------------------------\n\n")

        for name in names:
            outf.write("with %(pkg)s;\n" % name)
        outf.write("package %(name)s is\n" % {"name": Unitname})
        outf.write("   type Message_Handler is limited interface;\n\n")
        for name in names:
            outf.write("   procedure On_%(name)s\n"
                       "     (Handler : in out Message_Handler;\n"
                       "      message : %(pkg)s.%(name)s_Message)"
                       " is null;\n\n" % name)
        outf.write("   procedure Dispatch_Message\n"
                   "      (Handler : in out Message_Handler'Class;\n"
                   "       Message : LIFX.Messages.Message'Class);\n\n")
        outf.write("end %(name)s;\n" % {"name": Unitname})


def printBody(Unitname, names):
    with file(join(dirname(__file__), "src", ada2file(Unitname))+".adb", "w") as outf:
        with file("LICENSE") as inf:
			outf.write(inf.read())
        outf.write("--  ---------------------------------------------------------------\n")
        outf.write("--  This paclage is automaticly generated do not edit by hand\n")
        outf.write("--  ---------------------------------------------------------------\n\n")
        outf.write("package body %(name)s is\n\n" % {"name": Unitname})
        outf.write("   use all type Ada.Tags.Tag;\n\n")
        outf.write("   procedure Dispatch_Message\n"
                   "      (Handler : in out Message_Handler'Class;\n"
                   "       Message : LIFX.Messages.Message'Class) is\n")
        outf.write("   begin\n")
        outf.write("      if Message'Tag = %(pkg)s.%(name)s_Message'Tag then\n"  % names[0])
        outf.write("         Handler.On_%(name)s (%(pkg)s.%(name)s_Message (Message));\n" % names[0])
        for name in names[1:]:
            outf.write("      elsif Message'Tag = %(pkg)s.%(name)s_Message'Tag then\n" % name)
            outf.write("         Handler.On_%(name)s (%(pkg)s.%(name)s_Message (Message));\n" % name)

        outf.write("      else\n")
        outf.write("         null;\n")
        outf.write("      end if;\n\n")
        outf.write("   end Dispatch_Message;\n")

        outf.write("end %(name)s;\n" % {"name": Unitname})


names = getNames()
names.sort()
l = []
for i in names:
    l.append(i["pkg"])
l.sort()
print "\n".join(l)

printSpec("LIFX.Messages.Dispatchers", names)
printBody("LIFX.Messages.Dispatchers", names)
