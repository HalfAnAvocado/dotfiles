from ranger.api.commands import *

class fixname(Command):
    """:fixname

    Fixes the name of the selected file.
    """

    def execute(self):
        import re
        from datetime import date
        import shutil
        import os

        REGEX_PATTERN_HYPHEN = re.compile(r'\-\-+')

        translation = str.maketrans(' !"#$%&\'()*+,:;<=>?@[\\^_`{|}~', \
                '-----------------------------')

        for thisfile in self.fm.thistab.get_selection():
            old_filename = thisfile.basename
            directory = os.path.dirname(thisfile.path)

            clean_filename = old_filename.lower().strip()
            clean_filename = clean_filename.translate(translation)
            clean_filename = re.sub(REGEX_PATTERN_HYPHEN, '-', clean_filename)
            clean_filename = clean_filename.replace('-.', '.')
            clean_filename = clean_filename.replace('.jpeg', '.jpg')
            clean_filename = clean_filename.replace('ä', 'ae')
            clean_filename = clean_filename.replace('ö', 'oe')
            clean_filename = clean_filename.replace('ü', 'ue')
            clean_filename = clean_filename.replace('ß', 'ss')

            if clean_filename[0] == '-':
                clean_filename = clean_filename[1:]

            if clean_filename[-1] == '-':
                clean_filename = clean_filename[:-1]

            # clean_filename = date.today().isoformat() + '-' + clean_filename

            shutil.move(thisfile.path, directory + '/' + clean_filename)
            self.fm.notify("Renamed " + old_filename + " to " + clean_filename)


class extract_here(Command):
    """:extract_here

    extract selected files to current directory.
    """

    def execute(self):
        import os
        from ranger.core.loader import CommandLoader

        cwd = self.fm.thisdir
        marked_files = tuple(cwd.get_selection())

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        one_file = marked_files[0]
        cwd = self.fm.thisdir
        original_path = cwd.path
        au_flags = ['-x', cwd.path]
        au_flags += self.line.split()[1:]
        au_flags += ['-e']

        self.fm.copy_buffer.clear()
        self.fm.cut_buffer = False
        if len(marked_files) == 1:
            descr = "extracting: " + os.path.basename(one_file.path)
        else:
            descr = "extracting files from: " + os.path.basename(
                one_file.dirname)
        obj = CommandLoader(args=['aunpack'] + au_flags
                            + [f.path for f in marked_files], descr=descr,
                            read=True)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)


class compress(Command):
    """:compress

    Compress marked files to current directory.
    """

    def execute(self):
        import os
        from ranger.core.loader import CommandLoader

        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        original_path = cwd.path
        parts = self.line.split()
        au_flags = parts[1:]

        descr = "compressing files in: " + os.path.basename(parts[1])
        obj = CommandLoader(args=['apack'] + au_flags + \
                [os.path.relpath(f.path, cwd.path) for f in marked_files], descr=descr, read=True)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

    def tab(self, tabnum):
        """ Complete with current folder name """

        extension = ['.zip', '.tar.gz', '.rar', '.7z']
        return ['compress ' + os.path.basename(self.fm.thisdir.path) + ext for ext in extension]


class fzf_select(Command):
    """:fzf_select

    Find a file using fzf.
    With a prefix argument to select only directories.

    See: https://github.com/junegunn/fzf
    """

    def execute(self):
        import subprocess
        import os
        from ranger.ext.get_executables import get_executables

        if 'fzf' not in get_executables():
            self.fm.notify('Could not find fzf in the PATH.', bad=True)
            return

        fd = None
        if 'fdfind' in get_executables():
            fd = 'fdfind'
        elif 'fd' in get_executables():
            fd = 'fd'

        if fd is not None:
            hidden = ('--hidden' if self.fm.settings.show_hidden else '')
            exclude = "--no-ignore-vcs --exclude '.git' --exclude '*.py[co]' --exclude '__pycache__'"
            only_directories = ('--type directory' if self.quantifier else '')
            fzf_default_command = '{} --follow {} {} {} --color=always'.format(
                fd, hidden, exclude, only_directories
            )
        else:
            hidden = ('-false' if self.fm.settings.show_hidden else r"-path '*/\.*' -prune")
            exclude = r"\( -name '\.git' -o -iname '\.*py[co]' -o -fstype 'dev' -o -fstype 'proc' \) -prune"
            only_directories = ('-type d' if self.quantifier else '')
            fzf_default_command = 'find -L . -mindepth 1 {} -o {} -o {} -print | cut -b3-'.format(
                hidden, exclude, only_directories
            )

        env = os.environ.copy()
        env['FZF_DEFAULT_COMMAND'] = fzf_default_command
        env['FZF_DEFAULT_OPTS'] = '--height=40% --layout=reverse --ansi --preview="{}"'.format('''
            (
                batcat --color=always {} ||
                bat --color=always {} ||
                cat {} ||
                tree -ahpCL 3 -I '.git' -I '*.py[co]' -I '__pycache__' {}
            ) 2>/dev/null | head -n 100
        ''')

        fzf = self.fm.execute_command('fzf --no-multi', env=env,
                                      universal_newlines=True, stdout=subprocess.PIPE)
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            selected = os.path.abspath(stdout.strip())
            if os.path.isdir(selected):
                self.fm.cd(selected)
            else:
                self.fm.select_file(selected)
