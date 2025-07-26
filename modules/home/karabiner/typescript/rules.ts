// @ts-ignore
import fs from "fs";
import {KarabinerRules} from "./types";
import {createHyperSubLayers, app, open, window } from "./utils";

const KARABINER_FILENAME = "../src/karabiner.json";

const rules: KarabinerRules[] = [
  {
    "description": "Capslock -> esc & ctrl",
    "manipulators": [
      {
        "from": {
          "key_code": "caps_lock",
          "modifiers": { "optional": ["any"] }
        },
        "to": [{ "key_code": "left_control" }],
        "to_if_alone": [{ "key_code": "escape" }],
        "type": "basic"
      }
    ]
  },
  {
    description: "Hyper Key (⌃⌥⇧⌘)",
    manipulators: [
      {
        description: "Right Command Key -> Hyper Key",
        from: {
          key_code: "right_command",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            set_variable: {
              name: "hyper",
              value: 1,
            },
          },
        ],
        to_after_key_up: [
          {
            set_variable: {
              name: "hyper",
              value: 0,
            },
          },
        ],
        // to_if_alone: [
        //   {
        //     key_code: "escape",
        //   },
        // ],
        type: "basic",
      },
    ],
  },
  ...createHyperSubLayers({
    // Browse
    b: {
      c: open("https://calendar.google.com"),
      m: open("https://mail.google.com"),
      r: open("https://www.reddit.com"),
      t: open("https://app.todoist.com/app/inbox"),
      y: open("https://wwww.yputube.com"),
    },
    // Open applications
    o: {
      1: app("1Password"),
      d: app("Discord"),
      f: app("Finder"),
      g: app("Google Chrome"),
      m: app("Spotify"),
      n: app("Obsidian"),
      r: app("Rider"),
      s: app("Slack"),
      t: app("iTerm"),
      w: app("Teams"),
    },

    // Window managment
    w: {
      h: window("left-half"),
      j: window("bottom-half"),
      k: window("top-half"),
      l: window("right-half"),
      y: window("previous-display"),
      o: window("next-display"),
      f: window("maximize"),
      m: {
        description: "Window: Hide",
        to: [{key_code: "h", modifiers: ["right_command"]}],
      },
      n: {
        description: "Window: Next Window",
        to: [{key_code: "grave_accent_and_tilde", modifiers: ["right_command"]},
        ],
      },
    },

    // s = "System"
    s: {
      u: {to: [{key_code: "volume_increment"}]},
      j: {to: [{key_code: "volume_decrement"}]},
      i: {to: [{key_code: "display_brightness_increment"}]},
      k: {to: [{key_code: "display_brightness_decrement"}]},
      l: {to: [{key_code: "q", modifiers: ["right_control", "right_command"]}]},
      p: {to: [{key_code: "play_or_pause"}]},
      semicolon: {to: [{key_code: "fastforward"}]},
      // "D"o not disturb toggle
      d: open(`raycast://extensions/yakitrak/do-not-disturb/toggle?launchType=background`),
    },

    // v = Arrows
    v: {
      h: {to: [{key_code: "left_arrow"}]},
      j: {to: [{key_code: "down_arrow"}]},
      k: {to: [{key_code: "up_arrow"}]},
      l: {to: [{key_code: "right_arrow"}]},
    },

    // c = Music
    c: {
      p: {to: [{key_code: "play_or_pause"}]},
      n: {to: [{key_code: "fastforward"}]},
      b: {to: [{key_code: "rewind"}]},
    },

    // r = "Raycast"
    r: {
      c: open("raycast://extensions/thomas/color-picker/pick-color"),
      n: open("raycast://script-commands/dismiss-notifications"),
      e: open("raycast://extensions/raycast/emoji-symbols/search-emoji-symbols"),
      p: open("raycast://extensions/raycast/raycast/confetti"),
      h: open("raycast://extensions/raycast/clipboard-history/clipboard-history"),
      x: open("raycast://extensions/raycast/raycast-settings/extensions"),
    }
  }),
];

const global = {show_in_menu_bar: false};

const defaultProfile = {
  name: "Default profile",
  selected: true,
  complex_modifications: {rules},
  virtual_hid_keyboard: {
    country_code: 0,
    keyboard_type_v2: "iso"
  }
};

const profiles = [defaultProfile];
const settings = {global, profiles}

fs.writeFileSync(
  KARABINER_FILENAME,
  JSON.stringify(settings, null, 2)
);
