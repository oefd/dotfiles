from __future__ import annotations

import io
from dataclasses import dataclass, field
from enum import Enum
from pathlib import Path

from .style import Style

TREE_INDENT_SIZE = 3


class LinkPathState(Enum):
    CREATED = 1
    CLOBBERED = 2
    EXISTING_FILE_CONFLICT = 3
    EXISTING_FILE_NO_CONFLICT = 4
    EXISTING_DIR_NO_CONFLICT = 5


@dataclass
class Node:
    """Node in the filesystem tree for a recursive symlink.

    Each node corrosponds to a 'real' path, and the target path in the repository. Children
    of the node are tracked instead of just walking directories on the filesystem so we can
    ignore files/directories in the real path that already exist and don't corrospond to a
    file/directory in the target path.
    """

    link_path: Path
    link_target: Path
    link_path_state: LinkPathState
    children: list[Node] = field(default_factory=list)

    def __str__(self) -> str:
        tree = io.StringIO()
        self.styled_str(
            tree=tree,
            parent=self.link_path,
            indent_by=0,
        )
        tree.seek(0)
        return tree.read()

    def styled_str(self, *, tree: io.StringIO, parent: Path, indent_by: int = 0):
        if len(self.children) > 0:
            assert self.link_path.is_dir()

        indent = " " * (TREE_INDENT_SIZE * indent_by)

        if self.link_path.is_dir():
            icon = f"{Style.BOLD}"
        elif self.link_path.is_symlink():
            icon = f"{Style.BOLD}{Style.BLUE}"
        else:
            icon = f"{Style.BOLD}{Style.PURPLE}"

        if indent_by == 0:
            tree.write(f"{indent}{icon} {self.link_path}")
        else:
            tree.write(f"{indent}{icon} {self.link_path.relative_to(parent)}")

        tree.write(f"{Style.RESET}")

        if self.link_path_state == LinkPathState.CLOBBERED:
            tree.write(f" {Style.BOLD}{Style.YELLOW}⚠ clobbered ⚠{Style.RESET}")
        elif self.link_path_state == LinkPathState.EXISTING_FILE_CONFLICT:
            tree.write(f" {Style.BOLD}{Style.RED}✗ cannot clobber ✗{Style.RESET}")

        tree.write("\n")

        for child in self.children:
            child.styled_str(
                tree=tree,
                parent=self.link_path,
                indent_by=indent_by + 1,
            )

    def has_unclobberable_conflicts(self) -> bool:
        if self.link_path_state == LinkPathState.EXISTING_FILE_CONFLICT:
            return True
        else:
            return any([child.has_unclobberable_conflicts() for child in self.children])


