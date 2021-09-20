from __future__ import annotations

import os
import subprocess
from contextlib import contextmanager, ExitStack, suppress
from tempfile import TemporaryDirectory
from pathlib import Path

NEOVIM_URL = "https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"


@contextmanager
def cd(path: str):
    cwd = os.getcwdb()
    os.chdir(path)
    yield
    os.chdir(cwd)


def ensure_local_bin():
    with suppress(FileExistsError):
        os.mkdir(Path("~/.local/bin").expanduser())


def install_neovim():
    ensure_local_bin()

    nvim_path = str(Path("~/.local/bin/nvim").expanduser())
    curl = subprocess.run(["curl", "--location", NEOVIM_URL, "-o", nvim_path], capture_output=True)
    curl.check_returncode()
