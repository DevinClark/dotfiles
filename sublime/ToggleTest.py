import sublime, sublime_plugin, os.path
from pathlib import Path

def searchFile(fileName):
  path = Path(fileName)
  searchdirs = [path.absolute(), path.parent.absolute()]

  for d in searchdirs:
    for root, dirs, files in os.walk(os.path.dirname(d)):
      for Files in files:
        try:
          found = Files.find(os.path.basename(fileName))
          if found != -1:
            return os.path.join(root, Files)
        except:
          continue

  return -1


class ToggleTestCommand(sublime_plugin.TextCommand):
  def run(self, edit):
    test_file_patterns = sublime.load_settings('ToggleTest.sublime-settings').get('test_file_patterns', [])
    desiredfile = ""
    searchdirs = ['.', '..']
    currentfile = self.view.file_name()

    for f in test_file_patterns:
      ext = currentfile.split('.')[-1]
      ext = '.' + ext

      if currentfile.endswith(f):
        # current file is the test file
        desiredfile = currentfile.replace(f, '') + ext
      else:
        # current file is the source file
        desiredfile = currentfile.replace(ext, f)

      foundfile = searchFile(desiredfile)

      if foundfile != -1 and os.path.isfile(foundfile):
        sublime.active_window().open_file(foundfile)
        break
