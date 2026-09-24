#!/usr/bin/env python3

import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from hypr_ipc import hyprctl_json
from navigate_windows import (
    get_monitor_center,
    get_window_center,
    is_protected,
    pan_to_window,
)


def main():
    reverse = len(sys.argv) > 1 and sys.argv[1] == "prev"

    ws = hyprctl_json(["activeworkspace"])
    if not ws:
        return

    workspace_id = ws["id"]

    clients = hyprctl_json(["clients"]) or []
    floating = [
        w for w in clients
        if w.get("workspace", {}).get("id") == workspace_id
        and w.get("floating")
    ]

    if len(floating) <= 1:
        return

    center_x, center_y = get_monitor_center()

    # Sort windows in a stable order.
    floating.sort(
        key=lambda w: (
            w["at"][1],
            w["at"][0],
            w["address"],
        )
    )

    focused = hyprctl_json(["activewindow"])
    current_addr = focused.get("address") if focused else None

    # Find the currently visible/centered window.
    current_index = next(
        (
            i for i, w in enumerate(floating)
            if w["address"] == current_addr
        ),
        None,
    )

    if current_index is None:
        current_index = min(
            range(len(floating)),
            key=lambda i: (
                (get_window_center(floating[i])[0] - center_x) ** 2
                + (get_window_center(floating[i])[1] - center_y) ** 2
            ),
        )

    step = -1 if reverse else 1
    target = floating[(current_index + step) % len(floating)]

    pan_to_window(
        floating,
        target["address"],
        center_x,
        center_y,
    )


if __name__ == "__main__":
    main()
