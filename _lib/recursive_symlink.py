from __future__ import annotations

from .node import Node, LinkPathState

import re
from typing import Union, Callable, Optional
from pathlib import Path


def normalize_path(path: Union[Path, str]) -> Path:
    path = Path(path)
    if path.is_symlink():
        return path.expanduser()
    else:
        return path.expanduser().resolve()


def recursive_symlink(
    *,
    link_path: Union[Path, str],
    link_target: Union[Path, str],
    clobberable: Optional[Callable[[Path], bool]] = None,
) -> Node:
    """Symlink all files in the target path to the same relative location in the link path."""
    link_path = normalize_path(link_path)
    link_target = normalize_path(link_target)
    if clobberable is None:
        clobberable = lambda _: False

    children = []
    if link_target.is_dir():
        if link_path.is_dir():
            link_path_state = LinkPathState.EXISTING_DIR_NO_CONFLICT
        else:
            link_path.mkdir()
            link_path_state = LinkPathState.CREATED
        for target_child in link_target.iterdir():
            relative_child_path = target_child.relative_to(link_target)
            path_child = link_path / relative_child_path

            children.append(
                recursive_symlink(
                    link_path=path_child,
                    link_target=target_child,
                    clobberable=clobberable,
                )
            )
    elif link_path.is_symlink():
        link_path_state = LinkPathState.EXISTING_FILE_NO_CONFLICT
    elif link_path.is_file():
        if clobberable(link_path):
            link_path.unlink()
            link_path.symlink_to(link_target)
            link_path_state = LinkPathState.CLOBBERED
        else:
            link_path_state = LinkPathState.EXISTING_FILE_CONFLICT
    else:
        link_path.symlink_to(link_target)
        link_path_state = LinkPathState.CREATED

    return Node(
        link_path=link_path,
        link_target=link_target,
        link_path_state=link_path_state,
        children=children,
    )
