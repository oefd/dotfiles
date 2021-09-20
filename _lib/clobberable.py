from __future__ import annotations

import re
from pathlib import Path
from typing import Callable


def path_matches_any(regexes: list[str]) -> Callable[[Path], bool]:
    """Create function to determine if a path matches any of a given list of regexes."""
    patterns = [re.compile(regex) for regex in regexes]

    def inner(path: Path) -> bool:
        """Determine if a path matches any of the closed-over regexes."""
        for pattern in patterns:
            if pattern.fullmatch(path.name):
                return True
        return False

    return inner
