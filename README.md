# Obsidian Navigator

Transforms Neovim into a seamless interface for browsing and editing your Obsidian vault—no more context-switching or reaching for the mouse.

With this plugin, you can:

- Navigate your Obsidian notes directly from Neovim
- Create, open, and search notes without leaving the terminal
- Use Obsidian as a live previewer alongside your editor

By focusing on core navigation and note-taking features, Obsidian Navigator lets you stay in your Neovim workflow while leveraging Obsidian’s powerful preview capabilities.

## Pre-requisites

- [curl](https://curl.se/): for sending HTTP requests to the REST API
- [obsidian-navigator-api](https://github.com/wilsonangara/obsidian-navigator-api): install and enable the companion API plugin in Obsidian

## Motivation

I’m developing **obsidian-navigator.nvim**, a Neovim plugin inspired by [oflisback/obsidian-bridge.nvim](https://github.com/oflisback/obsidian-bridge.nvim). My goal is to learn Neovim plugin development and navigate Obsidian entirely from the terminal.

In parallel, I’ve created **obsidian-navigator-api**, a companion REST-API plugin for Obsidian inspired by [coddingtonbear/obsidian-local-rest-api](https://github.com/coddingtonbear/obsidian-local-rest-api). While both projects are highly extensible, building these tools from the ground up lets me fully grasp their inner workings and experiment with custom features.

## ⚠️ Project Status

> Under private development; open source release planned at v1.0.0.
> Not accepting external contributions yet.

## Credits & Inspiration

- **oflisback/obsidian-bridge.nvim** – for its seamless Obsidian-to-Neovim integration
- **coddingtonbear/obsidian-local-rest-api** – for its powerful local REST API interface

I wholeheartedly recommend exploring both projects for anyone interested in this space.
