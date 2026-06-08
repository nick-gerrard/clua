# clua

A Neovim plugin for inspecting the structure of JSON responses from third-party APIs. Give it a URL, get back a clean view of every key path and its type.

## Install

Using lazy.nvim:

```lua
{ "nick-gerrard/clua" }
```

## Usage

Press `<leader>cc` to open the URL prompt, paste or type a URL, and hit enter. The key structure opens in a floating window. Press `q` to close.

You can also use the command directly:

```
:Clua https://example.com/api/endpoint
```

## Output

Each line is a fully-qualified key path with its value type:

```
user.name (string)
user.age (number)
user.address.city (string)
active (boolean)
```
