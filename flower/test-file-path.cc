#include "file-path.hh"
#include "file-name.hh"

#include <limits.h>
#include <unistd.h>

#include "yaffut.hh"
#include "config.hh"

TEST (File_path, Find)
{
  char const *extensions[] = {"ly", "", 0};
  string file = "init";
  if (get_working_directory().empty())
    {
      cerr << "Could not get current work directory\n";
      exit (1);
    }
  string ly_dir = string (getenv ("top-src-dir")) + "/ly";
  parse_path (string (1, PATHSEP) + ly_dir);
  string file_name = find (file, extensions);
  EQUAL (file_name.substr (file_name.rfind ('/')), "/init.ly");
  file = "init.ly";
  file_name = find (file, extensions);
  EQUAL (file_name, ly_dir + "/init.ly");
}
