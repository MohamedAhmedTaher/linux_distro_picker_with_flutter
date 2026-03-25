import 'package:flutter/material.dart';
import 'models.dart';

// ── Questions ─────────────────────────────────────────────────────────────────

const questions = <QuizQuestion>[
  QuizQuestion(
    'How comfortable are you with the terminal?',
    [
      '😰  Terminal? No thanks.',
      '🙂  I use it occasionally.',
      '😎  I live in it.',
      '🧠  I write my own shell scripts.',
    ],
  ),
  QuizQuestion(
    'What\'s your primary use case?',
    [
      '🎮  Gaming',
      '💻  Development / Programming',
      '🌐  Browsing & everyday tasks',
      '🔐  Privacy & security',
    ],
  ),
  QuizQuestion(
    'How do you feel about tweaking your system?',
    [
      '🙈  I want it to just work.',
      '🔧  A little tinkering is fine.',
      '⚙️   I want full control.',
      '🎨  I love ricing everything.',
    ],
  ),
  QuizQuestion(
    'Which release model suits you?',
    [
      '🏛️   Stable & battle-tested',
      '🌊  Rolling release — always latest',
      '🪨  LTS — set it and forget it',
      '🤷  I have no idea, surprise me.',
    ],
  ),
  QuizQuestion(
    'What desktop vibe are you after?',
    [
      '🍎  Clean & polished (macOS-like)',
      '🪟  Familiar & traditional (Windows-like)',
      '🪶  Lightweight & minimal',
      '🧩  Fully custom / tiling WM',
    ],
  ),
];

// ── Distros ───────────────────────────────────────────────────────────────────
// Order: Ubuntu · Fedora · Arch · Debian · Pop!_OS · Manjaro · Mint · NixOS

const distroNames = [
  'Ubuntu', 'Fedora', 'Arch Linux', 'Debian',
  'Pop!_OS', 'Manjaro', 'Linux Mint', 'NixOS',
];

const distroEmojis = ['🟠', '🎩', '⚙️', '🌀', '🚀', '🍃', '🌿', '❄️'];

const distroDescriptions = [
  'The friendly giant. Massive community, excellent hardware support, and thousands of tutorials. Perfect for anyone starting their Linux journey.',
  'Developer-first. Ships cutting-edge packages on a stable base, with Flatpaks baked in. Loved by engineers who want modern without chaos.',
  'Total freedom. Rolling release, the legendary AUR, and a community-written wiki that\'s the envy of every other distro. You earn it.',
  'Bedrock. Stable for years, trusted on servers worldwide, and deeply principled about free software. Old-school cool that never expires.',
  'Ubuntu\'s cooler sibling. Polished GNOME, excellent gaming support via GPU drivers out of the box, and a thoughtful tiling window manager.',
  'The Arch gateway drug. Rolling release with a friendly installer and a GUI to manage the AUR. Best of both worlds.',
  'Homecoming. The most Windows-like Linux experience. Comfortable, welcoming, and a fantastic first step into the Linux world.',
  'Reproducible everything. Your entire OS declared in a config file. Infinitely powerful, occasionally baffling — the thinking person\'s distro.',
];

const distroColors = <Color>[
  Color(0xFFE95420), // Ubuntu orange
  Color(0xFF294172), // Fedora blue
  Color(0xFF1793D1), // Arch blue
  Color(0xFFA80030), // Debian red
  Color(0xFF48B9C7), // Pop teal
  Color(0xFF35BF5C), // Manjaro green
  Color(0xFF86BE43), // Mint green
  Color(0xFF5277C3), // NixOS blue
];

// ── Scoring matrix ────────────────────────────────────────────────────────────
// _scores[question][answer][distroIndex]

const scores = <List<List<int>>>[
  // Q1 – terminal comfort
  [
    [3, 0, 0, 2, 2, 1, 3, 0], // no thanks
    [1, 2, 0, 1, 2, 2, 1, 0], // occasionally
    [0, 1, 3, 1, 0, 1, 0, 2], // live in it
    [0, 0, 3, 0, 0, 0, 0, 3], // shell scripts
  ],
  // Q2 – use case
  [
    [1, 1, 0, 0, 3, 2, 1, 0], // gaming
    [1, 3, 2, 1, 2, 1, 0, 3], // dev
    [2, 1, 0, 2, 1, 2, 3, 0], // browsing
    [0, 1, 1, 3, 0, 0, 0, 2], // privacy
  ],
  // Q3 – tweaking appetite
  [
    [3, 2, 0, 2, 3, 2, 3, 0], // just work
    [1, 2, 1, 1, 2, 3, 1, 1], // some tinkering
    [0, 1, 3, 1, 0, 1, 0, 2], // full control
    [0, 0, 3, 0, 0, 2, 0, 3], // ricing
  ],
  // Q4 – release model
  [
    [2, 2, 0, 3, 2, 1, 2, 1], // stable
    [0, 1, 3, 0, 0, 3, 0, 2], // rolling
    [1, 0, 0, 3, 1, 0, 3, 0], // LTS
    [3, 1, 0, 2, 2, 2, 3, 0], // no idea
  ],
  // Q5 – desktop vibe
  [
    [1, 2, 0, 0, 3, 1, 0, 0], // mac-like
    [2, 2, 0, 1, 1, 2, 3, 0], // windows-like
    [0, 1, 2, 2, 0, 2, 1, 1], // minimal
    [0, 0, 3, 0, 0, 1, 0, 3], // tiling WM
  ],
];