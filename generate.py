import os
import glob
import re
from os.path import *
import sys

templates = {"t_with": "with %(pkg)s;\n",
             "t_proc": """   procedure On_%(name)s
     (Handler : in out Message_Handler;
       message : %(pkg)s.%(name)s_Message) is null;

""",
             "t_spec": """--  begin read only
%(license)s
--  ---------------------------------------------------------------
--  This package is automaticly generated do not edit by hand
--  ---------------------------------------------------------------

%(withs)s
package %(dispatcher_name)s is

   type Message_Handler is limited interface;

%(procs)s   procedure Dispatch_Message
      (Handler : in out Message_Handler'Class;
       Message : LIFX.Messages.Message'Class);

end %(dispatcher_name)s;
--  end read only
""",

             "t_if": """if Message'Tag = %(pkg)s.%(name)s_Message'Tag then
         Handler.On_%(name)s (%(pkg)s.%(name)s_Message (Message));

      els""",

             "t_body": """--  begin read only
%(license)s
--  ---------------------------------------------------------------
--  This package is automaticly generated do not edit by hand
--  ---------------------------------------------------------------

package body %(dispatcher_name)s is

   use all type Ada.Tags.Tag;

   procedure Dispatch_Message
      (Handler : in out Message_Handler'Class;
       Message : LIFX.Messages.Message'Class) is
   begin
      %(ifs)se
         null;
      end if;
   end Dispatch_Message;

end %(dispatcher_name)s;
--  end read only
"""}

generic_templates = {
    "t_with": "with %(pkg)s;\n",

    "t_proc": """   procedure On_%(name)s
     (Handler : in out Message_Handler;
      Message : %(pkg)s.%(name)s_Message;
      Parameter : not null access Parameter_Type) is null;

""",

    "t_spec" : """--  begin read only
%(license)s
--  ---------------------------------------------------------------
--  This package is automaticly generated do not edit by hand
--  ---------------------------------------------------------------

%(withs)s
generic
   type Parameter_Type is limited private;
package %(dispatcher_name)s is

   type Message_Handler is limited interface;

%(procs)s   procedure Dispatch_Message
      (Handler   : in out Message_Handler'Class;
       Message   : LIFX.Messages.Message'Class;
       Parameter : not null access Parameter_Type);

end %(dispatcher_name)s;
--  end read only
""",

    "t_if": """if Message'Tag = %(pkg)s.%(name)s_Message'Tag then
         Handler.On_%(name)s (%(pkg)s.%(name)s_Message (Message), Parameter);

      els""",

    "t_body": """--  begin read only
%(license)s
--  ---------------------------------------------------------------
--  This package is automaticly generated do not edit by hand
--  ---------------------------------------------------------------

package body %(dispatcher_name)s is

   use all type Ada.Tags.Tag;

   procedure Dispatch_Message
      (Handler : in out Message_Handler'Class;
       Message : LIFX.Messages.Message'Class;
       Parameter : not null access Parameter_Type) is
   begin
      %(ifs)se
         null;
      end if;
   end Dispatch_Message;

end %(dispatcher_name)s;
--  end read only
"""}


def ada2file(s):
    return s.replace(".", "-").lower()


class DispatcherGenerator:

    def __init__(self, srcdir, rootpackage):
        self.srcdir = srcdir
        self.rootpackage = rootpackage
        self.getNames()
        self.dict = {}
        licensePath = join(dirname(__file__), "LICENSE")
        if exists(licensePath):
            with open(licensePath) as inf:
                self.dict["license"] = inf.read()
        else:
            self.dict["license"] = ""

    def getNames(self):
        self.names = []
        matcher_1 = re.compile(r"\s+type\s+(\S+?)_Message\s+is\s+new\s+Message\s*.*", re.I)
        matcher_2 = re.compile(r"^\s*package\s+(\S+)\s+.*", re.I)
        names = join(self.srcdir, ada2file(self.rootpackage) + "*_messages.ads")
        for i in glob.glob(names):
            with file(i) as inf:
                for line in inf:
                    matches = matcher_2.match(line)
                    if matches:
                        pkg = matches.group(1)
                    matches = matcher_1.match(line)
                    if matches:
                        self.names.append({"pkg": pkg, "name": matches.group(1)})

    def __str__(self):
        ret = []
        for i in self.names:
            ret.append(str(i))
        return "\n".join(ret)

    def generate(self, templates, dispatcher_name):
        self.dict["dispatcher_name"] = self.rootpackage + "." + dispatcher_name
        self.basename = ada2file(self.dict["dispatcher_name"])

        ifs = []
        withs = []
        procs = []
        for i in self.names:
            ifs.append(templates["t_if"] % i)
            withs.append(templates["t_with"] % i)
            procs.append(templates["t_proc"] % i)
        self.dict["ifs"] = "".join(ifs)
        self.dict["withs"] = "".join(withs)
        self.dict["procs"] = "".join(procs)

        with open(join(self.srcdir, self.basename + ".ads"), "w") as outf:
                outf.write(templates["t_spec"] % self.dict)
        with open(join(self.srcdir, self.basename + ".adb"), "w") as outf:
                outf.write(templates["t_body"] % self.dict)


generator = DispatcherGenerator(srcdir=join(dirname(__file__), "src"),
                                rootpackage="LIFX.Messages")

generator.generate(templates, "Dispatchers")
generator.generate(generic_templates, "Generic_Dispatchers")
